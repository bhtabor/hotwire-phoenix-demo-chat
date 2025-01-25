defmodule HotwirePhoenixDemoChatWeb.Turbo.TurboStream do
  use HotwirePhoenixDemoChatWeb, :html

  def refresh(assigns) do
    ~H"""
    <.turbo_stream action="refresh" request_id={@request_id} />
    """
  end
end
