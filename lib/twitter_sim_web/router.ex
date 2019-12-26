defmodule TwitterSimWeb.Router do
  use TwitterSimWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug TwitterSimWeb.Plugs.SetTweeter
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TwitterSimWeb do
    pipe_through :browser

    #get "/", TweetController, :index
    #resources "/:user", TweetController
    #resources "/:user/tweets", TweetController
  #  get "/landingpage",
    resources "/signup", SignupController
    resources "/session", UsageController
    resources "/tweets", TweetController
    delete "/log_out", UsageController, :delete
    put "/tweets/:id/retweet", TweetController, :retweet
    get "/tweets/:id/retweet", TweetController, :index
    resources "/live", LiveController
    resources "/subscribe", SubscribeController
    #get "/wtf/wtf/new", TweetController, :new
    #resources "/tweets", TweetController#, only: [:create, :show]
  #  resources "/home", HomeController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TwitterSimWeb do
  #   pipe_through :api
  # end
end
