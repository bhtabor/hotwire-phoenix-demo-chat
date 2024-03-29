defmodule HotwirePhoenixDemoChatWeb.TurboComponents do
  use Phoenix.Component

  attr :id, :string, required: true
  attr :src, :string
  attr :loading, :string, values: ["eager", "lazy"]
  attr :disabled, :boolean
  attr :target, :string
  attr :autoscroll, :boolean
  attr :"data-autoscroll-block", :string, values: ["end", "start", "center", "nearest"]
  attr :"data-autoscroll-behavior", :string, values: ["auto", "smooth"]
  slot :inner_block

  def turbo_frame(assigns) do
    extra = assigns_to_attributes(assigns, [:id])
    assigns = assign(assigns, :extra, extra)

    ~H"""
    <turbo-frame
      id={@id}
      {@extra}
    >
      <%= render_slot(@inner_block) %>
    </turbo-frame>
    """
  end

  attr :action, :string, values: ["redirect", "refresh", "append", "prepend", "replace", "update", "remove", "before", "after"], required: true
  attr :target, :string
  attr :targets, :string
  slot :inner_block

  def turbo_stream(assigns) do
    extra = assigns_to_attributes(assigns, [:action])
    assigns = assign(assigns, :extra, extra)

    ~H"""
    <turbo-stream
      action={@action}
      {@extra}
    >
      <template>
        <%= render_slot(@inner_block) %>
      </template>
    </turbo-stream>
    """
  end

  alias HotwirePhoenixDemoChatWeb.{Channel, Endpoint}

  attr :channel, :string, required: true

  def turbo_channel_stream_source(assigns) do
    ~H"""
    <turbo-channel-stream-source channel={@channel} signed-channel={signed_channel(@channel)} />
    """
  end

  defp signed_channel(channel) do
    Channel.sign(Endpoint, channel)
  end
end
