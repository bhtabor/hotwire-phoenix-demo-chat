defmodule HotwirePhoenixDemoChatWeb.MessageTURBO_STREAM do
  use HotwirePhoenixDemoChatWeb, :html
  import HotwirePhoenixDemoChatWeb.MessageHTML, only: [message_form: 1]

  embed_templates "message_turbo_stream/*"
end
