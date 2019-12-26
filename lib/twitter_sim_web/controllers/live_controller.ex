defmodule TwitterSimWeb.LiveController do
    use TwitterSimWeb, :controller
  
    def index(conn, _params) do
      render(conn, "index.html")
    end
  end