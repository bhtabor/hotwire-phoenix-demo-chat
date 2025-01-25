defmodule HotwirePhoenixDemoChatWeb.Turbo.TurboStreamChannel do
  use HotwirePhoenixDemoChatWeb, :channel
  require Logger

  alias HotwirePhoenixDemoChat.Token
  alias HotwirePhoenixDemoChatWeb.Turbo.TurboStream

  intercept ["refresh"]

  @impl true
  def join(topic = "turbo-stream:" <> _, %{"signed_topic" => signed_topic}, socket) do
    case Token.verify(socket, signed_topic) do
      {:ok, ^topic} ->
        {:ok, socket}
      _ ->
        Logger.error("#{__MODULE__} invalid signature for topic '#{topic}'")
        {:error, %{reason: "unauthorized"}}
    end
  end

  def join("turbo-stream:" <> turbo_stream_topic, _payload, _socket) do
    Logger.error("#{__MODULE__} signature is not provided for topic 'turbo-stream:#{turbo_stream_topic}'")
    {:error, %{reason: "unauthorized"}}
  end

  @impl true
  def handle_out("refresh", %{request_id: request_id}, socket) do
    stream = Phoenix.Template.render_to_string(TurboStream, "refresh", "turbo_stream", request_id: request_id)
    push(socket, "message", %{data: stream})
    {:noreply, socket}
  end
end
