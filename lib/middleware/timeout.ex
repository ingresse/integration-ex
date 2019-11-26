defmodule IntegrationEx.Middleware.Timeout do
  @behaviour Tesla.Middleware

  @moduledoc """
  Add timeout option to the requests
  """
  def call(env, next, opts \\ [timeout: 20_000]) do
    env
    |> Tesla.put_opt(:adapter, timeout: opts[:timeout])
    |> Tesla.put_opt(:adapter, connect_timeout: opts[:timeout])
    |> Tesla.put_opt(:adapter, recv_timeout: opts[:timeout])
    |> Tesla.run(next)
  end
end
