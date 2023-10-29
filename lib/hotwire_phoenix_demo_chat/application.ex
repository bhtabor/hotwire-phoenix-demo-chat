defmodule HotwirePhoenixDemoChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HotwirePhoenixDemoChatWeb.Telemetry,
      # Start the Ecto repository
      HotwirePhoenixDemoChat.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: HotwirePhoenixDemoChat.PubSub},
      # Start Finch
      {Finch, name: HotwirePhoenixDemoChat.Finch},
      # Start the Endpoint (http/https)
      HotwirePhoenixDemoChatWeb.Endpoint
      # Start a worker by calling: HotwirePhoenixDemoChat.Worker.start_link(arg)
      # {HotwirePhoenixDemoChat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HotwirePhoenixDemoChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HotwirePhoenixDemoChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
