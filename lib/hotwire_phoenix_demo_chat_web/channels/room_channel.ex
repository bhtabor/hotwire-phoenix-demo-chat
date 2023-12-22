defmodule HotwirePhoenixDemoChatWeb.RoomChannel do
  use HotwirePhoenixDemoChatWeb, :channel

  alias HotwirePhoenixDemoChatWeb.PageHTML

  @impl true
  def join(channel = "room:" <> _room_id, %{"signed_channel" => signed_channel}, socket) do
    case verify(socket, signed_channel) do
      {:ok, ^channel} ->
        {:ok, socket}
      _ ->
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("room:" <> _room_id, _payload, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  @impl true
  def handle_info({:message_created, _message}, socket) do
    broadcast_refresh_turbo_stream_from(socket)
    {:noreply, socket}
  end

  def handle_info({:message_deleted, _message}, socket) do
    broadcast_refresh_turbo_stream_from(socket)
    {:noreply, socket}
  end

  defp broadcast_refresh_turbo_stream_from(socket) do
    stream = render_to_string(PageHTML, "refresh_turbo_stream", "turbo_stream", [])
    broadcast_from(socket, "turbo-stream-message", %{ stream: stream })
  end
end
