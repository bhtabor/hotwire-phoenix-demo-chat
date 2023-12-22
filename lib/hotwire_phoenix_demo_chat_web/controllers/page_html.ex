defmodule HotwirePhoenixDemoChatWeb.PageHTML do
  use HotwirePhoenixDemoChatWeb, :html

  embed_templates "page_html/*"
  embed_templates "page_html/*.turbo_stream", suffix: "_turbo_stream"
end
