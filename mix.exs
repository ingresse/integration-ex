defmodule IntegrationEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :integration_ex,
      version: "1.0.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [
        :logger
      ]
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.1.0"},
      {:exml, "~> 0.1.1"}
    ]
  end
end
