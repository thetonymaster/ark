defmodule Ark.SessionController do
  use ArkWeb, :controller

  def new(conn, _) do
    render conn, "new.html"
  end
end
