defmodule ChatWeb.RoomLive do
  use ChatWeb, :live_view

  require Logger

  @impl true
  # grab id from url params
  def mount(%{"id" => room_id}, _session, socket) do
    {:ok, assign(socket, room_id: room_id)}
  end

  @impl true
  def handle_event("submit_message", %{"chat" => %{"message" => message}}, socket) do
    Logger.info(message: message)
    {:noreply, socket}
  end
end