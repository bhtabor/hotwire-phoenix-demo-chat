defmodule HotwirePhoenixDemoChatWeb.Turbo.Components do
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
end
