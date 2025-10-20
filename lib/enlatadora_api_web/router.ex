defmodule EnlatadoraApiWeb.Router do
  use EnlatadoraApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EnlatadoraApiWeb do
    pipe_through :api

    ## --------- Catalogos ---------
    resources "/materias_primas", MateriaPrimaController, except: [:new, :edit]
    resources "/proveedores", ProveedorController, except: [:new, :edit]
    resources "/clientes", ClienteController, except: [:new, :edit]
    resources "/productos", ProductoController, except: [:new, :edit]

    ## --------- Compras ---------
    resources "/compras_materia_prima", CompraMateriaPrimaController, except: [:new, :edit]


  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:enlatadora_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: EnlatadoraApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
