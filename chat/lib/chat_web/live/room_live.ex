defmodule ChatWeb.RoomLive do
  use ChatWeb, :live_view

  require Logger

  @impl true
  # grab id from url params
  def mount(%{"id" => room_id}, _session, socket) do
    {:ok, socket}
  end
end