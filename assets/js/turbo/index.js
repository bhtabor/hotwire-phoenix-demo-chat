import * as Turbo from "@hotwired/turbo"
import socket from "./socket"
import { createTurboStreamChannelSource } from "./turbo_stream_channel_source"

const TurboStreamChannelSource = createTurboStreamChannelSource(socket)

if (customElements.get("turbo-stream-channel-source") === undefined) {
  customElements.define("turbo-stream-channel-source", TurboStreamChannelSource)
}
