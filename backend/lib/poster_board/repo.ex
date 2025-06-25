defmodule PosterBoard.Repo do
  use Ecto.Repo,
    otp_app: :poster_board,
    adapter: Ecto.Adapters.Postgres
end
