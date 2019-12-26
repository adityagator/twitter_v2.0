defmodule TwitterSimWeb.SignupController do
  use TwitterSimWeb, :controller
import Ecto.Query, warn: false
  alias TwitterSim.Tweeter
  alias TwitterSim.Repo
  alias TwitterSim.Usage

  def index(conn, _) do
    render(conn, "signup.html")
  end

  def new(conn, _) do
    render(conn, "signup.html")
  end

  def create(conn, info) do#%{"handle" => handle, "crypto_pass" => crypto_pass}) do
    {status, _} = %Tweeter{} |> Tweeter.changeset(info) |> Repo.insert()
    if status == :ok, do: conn |> put_flash(:info, "You have successfully registered") |> redirect(to: Routes.tweet_path(conn, :index)),
    else: conn |> put_flash(:error, "Registration failed") |> redirect(to: Routes.signup_path(conn, :new))
  end
end
