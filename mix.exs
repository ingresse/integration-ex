defmodule IntegrationEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :integration_ex,
      version: "1.0.0",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

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
      {:poison, "~> 3.1", override: true},
      {:exml, "~> 0.1.1"}
    ]
  end
end
