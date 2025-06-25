defmodule PosterBoardWeb.AuthControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias PosterBoard.Repo
  alias PosterBoardWeb.Router

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "POST /api/register creates a user" do
    conn =
      conn(:post, "/api/register", Jason.encode!(%{email: "test@example.com", password: "secret"}))
      |> put_req_header("content-type", "application/json")

    conn = Router.call(conn, Router.init([]))
    assert conn.status == 200
    assert Repo.get_by(PosterBoard.Users.User, email: "test@example.com")
  end

  test "POST /api/login returns a token" do
    {:ok, _} = PosterBoard.Users.create_user(%{"email" => "a@b.com", "password" => "pw"})

    conn =
      conn(:post, "/api/login", Jason.encode!(%{email: "a@b.com", password: "pw"}))
      |> put_req_header("content-type", "application/json")

    conn = Router.call(conn, Router.init([]))
    assert conn.status == 200
    body = Jason.decode!(conn.resp_body)
    assert Map.has_key?(body, "token")
  end
end
