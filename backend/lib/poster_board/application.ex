defmodule PosterBoard.Application do
  @moduledoc """
  OTP application entry module.
  """
  use Application

  def start(_type, _args) do
    children = [
      PosterBoard.Repo,
      PosterBoardWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: PosterBoard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    PosterBoardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
