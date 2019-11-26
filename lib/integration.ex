defmodule IntegrationEx do
  @moduledoc """
  IntegrationEx module
  """
  @version IntegrationEx.MixProject.project()[:version]

  alias IntegrationEx.Middleware.{
    Timeout,
    XML
  }

  alias Tesla.Middleware.{
    FollowRedirects,
    JOSN,
    KeepRequest
  }

  @application_json "application/json; charset=UTF-8"
  @default_timeout 25_000

  @doc """
  JSON API
  """
  def api do
    quote do
      use Tesla

      plug(KeepRequest)
      plug(JSON, engine: Poison, encode_content_type: @application_json)
      plug(FollowRedirects)
      plug(Timeout, timeout: @default_timeout)
    end
  end

  @doc """
  XML API
  """
  def xml_api do
    quote do
      use Tesla

      plug(KeepRequest)
      plug(XML)
      plug(FollowRedirects)
      plug(Timeout, timeout: @default_timeout)
    end
  end

  @doc """
  Get UserAgent
  """
  def user_agent, do: "Ingresse-Integration/#{@version}"

  @doc false
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
