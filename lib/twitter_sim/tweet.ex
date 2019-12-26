defmodule TwitterSim.Tweet do
  use Ecto.Schema
  import Ecto.Changeset
  alias TwitterSim.Tweeter
  alias TwitterSim.Tweet
  alias TwitterSim.Repo

  schema "tweets" do
    # field :from, :string
    # field :hashtags, :string
    # field :mentions, :string
    field :tweet, :string
    belongs_to :tweeter, Tweeter
    timestamps()
  end

  @doc false
  def changeset(%Tweet{} = tweet, attrs) do
    tweet
    |> cast(attrs, [:tweet])
    #|> cast(attrs, [:from, :tweet, :mentions, :hashtags])
    |> validate_length(:tweet, max: 255)
  end

  def create_tweet(tweet) do
    %Tweet{}
    |> Tweet.changeset(tweet)
    |> Repo.insert()
  end

end
