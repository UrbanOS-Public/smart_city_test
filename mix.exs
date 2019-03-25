defmodule SmartCityTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :smart_city_test,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      test_paths: test_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :faker]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:smart_city, "~> 2.1", organization: "smartcolumbus_os", override: true},
      {:smart_city_data, "~> 2.0", organization: "smartcolumbus_os", only: [:test]},
      {:smart_city_registry, "~> 2.3", organization: "smartcolumbus_os", only: [:test]},
      {:faker, "~> 0.12.0"},
      {:ex_doc, "~> 0.19.3"},
      {:credo, "~> 1.0"}
    ]
  end

  defp elixirc_paths(env) when env in [:test, :integration], do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp test_paths(:integration), do: ["test/integration"]
  defp test_paths(_), do: ["test/unit"]
end
