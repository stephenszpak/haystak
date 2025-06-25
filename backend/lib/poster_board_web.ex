defmodule PosterBoardWeb do
  @moduledoc """
  Entry point for web components such as controllers and views.
  """
  def controller do
    quote do
      use Phoenix.Controller, namespace: PosterBoardWeb
      import Plug.Conn
      alias PosterBoardWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/poster_board_web/templates",
        namespace: PosterBoardWeb
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
