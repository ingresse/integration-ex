defmodule IntegrationEx.Middleware.XML do
  @behaviour Tesla.Middleware

  @moduledoc """
  Send request body as text/xml
  """
  def call(env, next, _opts) do
    with {:ok, env} <- encode(env),
         {:ok, env} <- Tesla.run(env, next) do
      with true <- decodable_body?(env) do
        decode(env)
      else
        false -> {:error, env}
      end
    else
      {:error, env} -> {:error, env}
    end
  end

  def encode(env) do
    {:ok, Tesla.put_headers(env, [{"Content-Type", "text/xml;charset=\"utf-8\""}])}
  end

  @doc """
  Decode XML string
  """
  def decode(env) do
    {:ok, %{env | body: Exml.parse(env.body)}}
  catch
    :exit, _error ->
      {:error, %{reason: :parse_error}}
  end

  defp decodable_body?(env) do
    is_binary(env.body) && env.body != ""
  end
end
