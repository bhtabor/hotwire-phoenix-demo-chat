import { StreamSourceElement, connectStreamSource, disconnectStreamSource, renderStreamMessage } from "@hotwired/turbo";
import { Socket } from "phoenix";

class TurboChannelStreamSourceElement extends StreamSourceElement {
  constructor() {
    super();
    this.socket = null
    this.channel = null
  }

  connectedCallback() {
    super.connectedCallback();
    this.socket = new Socket("/socket");
    this.socket.connect();
    this.channel = this.socket.channel(this.getAttribute("channel"), {
      signed_channel: this.getAttribute("signed-channel"),
    });

    this.channel.on("turbo-stream-message", this.render.bind(this));
    this.channel.join();
  }

  disconnectedCallback() {
    super.connectedCallback();
    if (this.channel) this.channel.leave();
    if (this.socket) this.socket.disconnect();
  }

  render({ stream }) {
    renderStreamMessage(stream)
  }
}

customElements.define('turbo-channel-stream-source', TurboChannelStreamSourceElement);
