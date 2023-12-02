defmodule HotwirePhoenixDemoChatWeb.MessageHTML do
  use HotwirePhoenixDemoChatWeb, :html

  embed_templates "message_html/*.html"
  embed_templates "message_html/*.turbo_stream", suffix: "_turbo_stream"

  @doc """
  Renders a message form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def message_form(assigns)
end
