defmodule EnlatadoraApi.Repo do
  use Ecto.Repo,
    otp_app: :enlatadora_api,
    adapter: Ecto.Adapters.Tds
end
