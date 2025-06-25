defmodule JobHuntWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: JobHuntWeb
      import Plug.Conn
      alias JobHuntWeb.Router.Helpers, as: Routes
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
        root: "lib/job_hunt_web/templates",
        namespace: JobHuntWeb
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
