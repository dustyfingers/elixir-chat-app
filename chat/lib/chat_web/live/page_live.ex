defmodule ChatWeb.PageLive do
  use ChatWeb, :live_view

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def handle_event("random-room", _params, socket) do
    # <> concatenates in elixir
    random_slug = "/" <> MnemonicSlugs.generate_slug(4)
    Logger.info(random_slug)
    # dont reply to sender of message, eg front end
    {:noreply, push_redirect(socket, to: random_slug)}
  end
end