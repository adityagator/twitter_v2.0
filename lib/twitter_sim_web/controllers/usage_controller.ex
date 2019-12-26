defmodule TwitterSimWeb.UsageController do
  use TwitterSimWeb, :controller

  alias TwitterSim.Tweeter
  alias TwitterSim.Repo

  def new(conn, _) do
    render(conn, "new.html")
  end

  def delete(conn, _) do
    redirect(log_out(conn), to: Routes.usage_path(conn, :new))
  end

  # def create(conn, %{"usage" => %{"handle" => handle, "crypto_pass" => pwd}}) do
  def create(conn, %{"handle" => handle, "crypto_pass" => pwd}) do
    case authenticate(handle, pwd) do
      {:ok, tweeter} ->
        put_session(conn, :current_user_id, tweeter.id)
        |> put_flash(:info, "Welcome")
        |> redirect(to: Routes.tweet_path(conn, :index))
        {:fail, _} ->
          conn
          |> put_flash(:error, "Oops! Try again")
          |> render("new.html")
    end
  end

  def authenticate(handle, pwd) do
    tweeter = Repo.get_by(Tweeter, handle: handle)
     if tweeter && tweeter.crypto_pass == pwd, do: {:ok, tweeter}, else: {:fail, :unauthorized}
  end

  def log_out(conn) do
    Plug.Conn.configure_session(conn, drop: true)
  end

end
