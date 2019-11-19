defmodule IntegrationEx.Middleware.QueryParam do
  @behaviour Tesla.Middleware

  @moduledoc """
  Add extra query strings in all requests
  """
  def call(env, next, opts) do
    env
    |> Map.update!(:query, fn query -> query ++ opts[:query] end)
    |> Tesla.run(next)
  end
end
