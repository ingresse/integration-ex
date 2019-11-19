defmodule IntegrationEx.Middleware.Timeout do
  @behaviour Tesla.Middleware

  @moduledoc """
  Add certificates option to the requests
  """
  def call(env, next, opts \\ [timeout: 20_000]) do
    env
    |> Tesla.put_opt(:adapter, [
      timeout: opts[:timeout],
      connect_timeout: opts[:timeout],
      recv_timeout: opts[:timeout]
    ])
    |> Tesla.run(next)
  end
end
