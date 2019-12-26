defmodule TwitterSimWeb.TweetController do
  use TwitterSimWeb, :controller
import Ecto.Query, warn: false
  plug :authorize when action in [:show, :create, :new, :delete, :index]
  plug :relation_user when action in [:delete]
  alias TwitterSim.Tweet
  alias TwitterSim.Repo
  alias TwitterSim.Hashtag
  alias TwitterSim.Mention
  alias TwitterSimWeb.UserSocket
  alias TwitterSim.Tweeter
  alias TwitterSim.Subscription

  def index(conn, _) do #%{"user" => user}

    id = conn.assigns.active.id
    IO.inspect id
    my_tweets = Enum.reverse(Tweet |> where(tweeter_id: ^id) |> Repo.all())
    IO.inspect my_tweets
   # changesetTweet = Tweet.changeset(%Tweet{}, %{})

    
    #my_tweets = Enum.reverse(Repo.all(Tweet))
    #my_tweets = Tweet |> where(from: ^user) |> Repo.all()
    
    tweeter = Tweeter |> where(id: ^id) |> Repo.all() 
    tweeter_1 = tweeter|> Enum.at(0) |> Map.values()
    handle = tweeter_1 |> Enum.at(3) 
    IO.inspect handle
    my_mentions = Mention |> where(id: ^id) |> Repo.all()
    #new_tweets =
    IO.inspect handle
    subscription = Subscription |> where(user: ^handle) |> Repo.all() |> Enum.map(fn x -> Map.values(x) end) |> Enum.map(fn x -> Enum.at(x, 5) end)
    users = for x <- subscription, do: Repo.get_by(Tweeter, handle: x)
    ids  = for x <- users do
       if x != nil do 
            #IO.inspect Map.values(x)
          Map.values(x) 
       end 
    end
    myids = ids |> Enum.reject(fn x -> x == nil end) |> Enum.uniq() |> Enum.map(fn x -> Enum.at(x, 4) end)
    IO.inspect myids 
    news = for x<- myids, do: Enum.reverse(Tweet |> where(tweeter_id: ^x) |> Repo.all()) 
    # IO.inspect news
    # newsfeed =  for x <- news do  
          
    # end 
    # IO.inspect newsfeed|> List.flatten()
    # newsfeed = for user<- newsfeed do
    #   for tweet <- user, do: Enum.at(tweet,4)  
    # end   
    # news2 = newsfeed |> List.flatten()
    render(conn, "index.html", my_tweets: my_tweets, my_mentions: my_mentions, news: news)#, changesetTweet: changesetTweet)#, user: user)
    #Process.sleep(1000)
    #index(conn, %{})
  end

  defp authorize(conn, _) do
    if !conn.assigns.is_active?, do: put_flash(conn, :error, "Nice try, You have to be logged in to do that.") 
    |> redirect(to: Routes.usage_path(conn, :new)) |> halt(),
  else: conn
  end

  def new(conn, _) do #%{"user" => user
    changesetTweet = Tweet.changeset(%Tweet{}, %{})
    render(conn, "new.html", changesetTweet: changesetTweet)#, user: user)
  end

  def create(conn, %{"tweet" => tweet_info}) do
  IO.puts "tweet_info : #{inspect(tweet_info)}"
  tweet = tweet_info["tweet"] 
  IO.puts "Printing access #{tweet}"
  hashtags = checkForHashtags(tweet)
  mentions = checkForMentions(tweet)
  if hashtags != [] do
    IO.inspect "Inserting hashtag"
    for tag <- hashtags, do: %Hashtag{} |> Hashtag.changeset(%{tweet: tweet, hash: tag, user: "jetst"}) |> Repo.insert()
  end
  if mentions != [], do: for men <- mentions, do: %Mention{} |> Mention.changeset(%{tweet: tweet, mention: men, user: "jfdlskjklgj"}) |> Repo.insert()
  IO.puts "printing retweet #{inspect(tweet_info)}"
{status, _} = conn.assigns.active |> Ecto.build_assoc(:tweets) |> Tweet.changeset(tweet_info) |> Repo.insert()

   # {status, _} = %Tweet{} |> Tweet.changeset(tweet_info) |> Repo.insert()

  if status == :ok, do: redirect(conn, to: Routes.tweet_path(conn, :index)), else: conn |> put_flash(:error, "Could not create tweet") |> redirect(to: Routes.tweet_path(conn, :index))
  end

  def retweet(conn, %{"tweet" => re_tweet}) do
    Repo.insert(%Tweet{tweet: re_tweet})
    #{status, _} = %Tweet{} |> Tweet.changeset(re_tweet) |> Repo.insert()
    #if status == :ok, do: redirect(conn, to: Routes.tweet_path(conn, :index)), else: conn |> put_flash(:error, "Could not re-tweet") |> redirect(to: Routes.tweet_path(conn, :index))
  end

  def show(conn, %{"id" => id}) do
    [ref_tweet] = Tweet |> where(id: ^id) |> Repo.all()
    #IO.inspect ref_tweet
    render(conn, "show.html", ref_tweet: ref_tweet)
  end

  def delete(conn, %{"id" => id}) do
  #  del_tweet = Repo.get!(Room, id)
    {status, _} = Repo.delete(Repo.get!(Tweet, id))
    #{status, _} = %Tweet{} |> Tweet.changeset(%{"id" => id}) |> Repo.delete()
    ##{status, _} = Repo.delete(tweet)
    if status == :ok, do: redirect(conn, to: Routes.tweet_path(conn, :index)), else: conn |> put_flash(:error, "Could not delete tweet") |> redirect(to: Routes.tweet_path(conn, :index))
  end

  defp relation_user(conn, _) do
    %{params: %{"id" => tweet_id}} = conn
    tweet =  Repo.get!(Tweet, tweet_id)
    IO.inspect conn.assigns.active.id
    IO.inspect tweet_id
    if conn.assigns.active.id != tweet.tweeter_id, do: put_flash(conn, :error, "Not authorized") |> redirect(to: Routes.tweet_path(conn, :index)) |> halt(),
  else: conn
  end

  defp checkForHashtags(text) do
     words = String.split(text, [" ", "&", "/"])
     hashes = Enum.filter(words, fn x -> String.at(x,0)=="#" end)

     a = if length(hashes) == 0 do
             []
           else
           #  IO.puts "Hashes identified #{inspect(hashes)}"
             hashes
         end
     a
  end

  defp checkForMentions(text) do
     words = String.split(text, [" ", "&", "/"])

     mentions = Enum.filter(words, fn x -> String.at(x,0)=="@" end)
     mentions = Enum.map(mentions, fn x -> String.slice(x,1..-1) end)

     a = if length(mentions) == 0 do
             []
           else

             mentions
         end
     a
  end
end
