# defmodule TwitterSimWeb.TweetChannel do
#     use TwitterSimWeb, :channel

#     alias TwitterSim.Tweeter
#     alias TwitterSim.Repo

#     def join("tweet" <> userid, _, socket) do
#         {:ok, %{channel: "tweet:#{userid}"}, assign(socket, :user_id, userid)}
#     end

#     def handle_in("post:new", %{"message" => body}, socket) do
#         # tweeter = Repo.get(Tweeter, socket.assigns(:current_user_id))
#         # chat = %{body: body, tweeter: %{handle: tweeter.handle}}
#         user_id = socket.assigns(:user_id)
#         #add userid to tweet
#         broadcast!(socket, "tweet:#{user_id}:new_tweet", %{body: body})
#         {:reply, :ok, socket}
#     end
# end

defmodule TwitterSimWeb.TweetChannel do
    use TwitterSimWeb, :channel

    alias TwitterSim.Tweeter
    alias TwitterSim.Repo

    def join(cname, _, socket) do
        {:ok, %{channel: cname}, socket}
    end

    def handle_in("post:new", %{"message" => body}, socket) do
        # tweeter = Repo.get(Tweeter, socket.assigns(:current_user_id))
        # chat = %{body: body, tweeter: %{handle: tweeter.handle}}
        broadcast!(socket, "tweet:live", %{body: body})
        {:reply, :ok, socket}
    end
end