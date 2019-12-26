defmodule TwitterSimWeb.SubscribeController do
    use TwitterSimWeb, :controller
    import Ecto.Query, warn: false
    alias TwitterSim.Subscription
  alias TwitterSim.Repo
  alias TwitterSim.Usage
  alias TwitterSim.Tweeter

    def index(conn, _params) do
      render(conn, "index.html")
    end

    def new(conn, _) do
      render(conn, "index.html")
    end

    def create(conn, sub) do
      id = conn.assigns.active.id
      handle = Repo.get(Tweeter, id)
      tweeter_1 = handle|> Map.values()
       handle = tweeter_1 |> Enum.at(3) 
      subs = sub["sub"]
      IO.inspect subs
      IO.inspect handle
      {status, _} = %Subscription{} |> Subscription.changeset(%{user: handle, subscribed_to: subs, subscribe_by: "j" }) |> Repo.insert()
      IO.inspect status
      if status == :ok, do: conn |> put_flash(:info, "You have successfully subscribed") |> redirect(to: Routes.tweet_path(conn, :index))
      #, else: conn |> put_flash(:error, "Subscription failed") |> redirect(to: Routes.tweet_path(conn, :index))
    end
  end