defmodule HotwirePhoenixDemoChatWeb.RoomChannel do
  use HotwirePhoenixDemoChatWeb, :channel

  alias HotwirePhoenixDemoChatWeb.MessageHTML

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
  def handle_info({:message_created, message}, socket) do
    stream = render_to_string(MessageHTML, "create_turbo_stream", "turbo_stream", message: message)
    broadcast_turbo_stream_from(socket, stream)
    {:noreply, socket}
  end

  def handle_info({:message_deleted, message}, socket) do
    stream = render_to_string(MessageHTML, "delete_turbo_stream", "turbo_stream", message: message)
    broadcast_turbo_stream_from(socket, stream)
    {:noreply, socket}
  end

  defp broadcast_turbo_stream_from(socket, stream) do
    broadcast_from(socket, "turbo-stream-message", %{ stream: stream })
  end
end
