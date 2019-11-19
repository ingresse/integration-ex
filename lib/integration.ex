defmodule IntegrationEx do
  @moduledoc """
  IntegrationEx module
  """
  @version IntegrationEx.Mixfile.project[:version]

  alias IntegrationEx.Middleware.{Timeout, XML}
  alias Tesla.Middleware.{
    FollowRedirects,
    JOSN,
    KeepRequest,
    Logger
  }

  @doc false
  def api do
    quote do
      use Tesla

      plug KeepRequest
      plug JSON, engine: Poison, encode_content_type: "application/json; charset=UTF-8"
      plug FollowRedirects
      plug Timeout, timeout: 25_000

      if Mix.env == :dev do
        plug Logger
      end
    end
  end

  @doc false
  def xml_api do
    quote do
      use Tesla

      plug KeepRequest
      plug XML
      plug FollowRedirects
      plug Timeout, timeout: 25_000

      if Mix.env == :dev do
        plug Logger
      end
    end
  end

  @doc """
  Format integer amount to string with decimals
  """
  def format_amount(amount, decimals \\ 2) do
    amount
    |> Kernel./(100)
    |> :erlang.float_to_binary(decimals: decimals)
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
