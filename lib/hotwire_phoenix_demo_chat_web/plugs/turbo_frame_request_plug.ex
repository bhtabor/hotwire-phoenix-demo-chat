defmodule HotwirePhoenixDemoChatWeb.TurboFrameRequestPlug do
  require Logger
  alias Plug.Conn
  alias Phoenix.Controller
  @behaviour Plug

  @impl true
  def init(opts) do
    {
      Keyword.get(opts, :http_header, "turbo-frame"),
      Keyword.get(opts, :assign_as)
    }
  end

  @impl true
  def call(conn, {header, assign_as}) do
    turbo_frame = get_turbo_frame(conn, header)
    Logger.metadata(turbo_frame: turbo_frame)

    turbo_frame_request = turbo_frame != nil
    conn = if assign_as, do: Conn.assign(conn, assign_as, turbo_frame_request), else: conn

    if turbo_frame_request, do: Controller.put_layout(conn, false), else: conn
  end

  defp get_turbo_frame(conn, header) do
    conn
    |> Conn.get_req_header(header)
    |> List.first()
  end
end
