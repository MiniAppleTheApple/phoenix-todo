defmodule TodoApp.Repo do
  use Ecto.Repo,
    otp_app: :todo_app,
    adapter: Ecto.Adapters.SQLite3
end
