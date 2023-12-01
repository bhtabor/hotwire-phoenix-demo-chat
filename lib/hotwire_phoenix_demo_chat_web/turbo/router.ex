defmodule HotwirePhoenixDemoChatWeb.Turbo.Router do
  import Plug.Conn
  import Phoenix.Controller

  def remove_turbo_frame_layouts(conn, _opts) do
    case get_req_header(conn, "turbo-frame") do
      [] -> conn
      _ -> conn |> put_layout(false) |> put_root_layout(false)
    end
  end
end
