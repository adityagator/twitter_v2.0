defmodule TwitterSimWeb.Plugs.SetTweeter do
    import Plug.Conn

    alias TwitterSim.Tweeter
    alias TwitterSim.Repo

    def init(_) do end
    
    def call(conn, _) do
        tweeter_id = Plug.Conn.get_session(conn, :current_user_id)
        
        if active = tweeter_id && Repo.get(Tweeter, tweeter_id) do  
        assign(conn, :active, active) |> assign(:is_active?, true) |> assign(:user_token, tweeter_id)
        else 
            assign(conn, :active, nil) |> assign(:is_active?, false)
    end

    end
    
end