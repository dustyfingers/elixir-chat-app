defmodule ChatWeb.RoomLive do
  use ChatWeb, :live_view

  require Logger

  @impl true
  # grab id from url params
  def mount(%{"id" => room_id}, _session, socket) do
    topic = "room:" <> room_id
    ChatWeb.Endpoint.subscribe(topic)
    {:ok, assign(socket, room_id: room_id, topic: topic, messages: [])}
  end

  @impl true
  def handle_event("submit_message", %{"chat" => %{"message" => message}}, socket) do
    Logger.info(message: message)
    # broadcasts the message to the clients subscribed to the topic
    ChatWeb.Endpoint.broadcast(socket.assigns.topic, "new-message", message)
    {:noreply, socket}
  end

  # handle_info functions handle broadcasts by the server
  @impl true
  def handle_info(%{event: "new-message", payload: message}, socket) do
    Logger.info(payload: message)
    # [socket.assigns.messages | message] appends new message onto existing list
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end
end