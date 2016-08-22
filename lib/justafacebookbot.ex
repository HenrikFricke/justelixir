defmodule Justafacebookbot do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Justafacebookbot.Worker.start_link(arg1, arg2, arg3)
      # worker(Justafacebookbot.Worker, [arg1, arg2, arg3]),
      worker(__MODULE__, [], function: :run)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Justafacebookbot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    { :ok, _ } = Plug.Adapters.Cowboy.http Justafacebookbot.Router, []
  end
end
