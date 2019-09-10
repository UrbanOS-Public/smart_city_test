defmodule SmartCityTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :smart_city_test,
      version: "0.5.1",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      docs: docs(),
      package: package(),
      source_url: "https//www.github.com/smartcitiesdata/smart_city_test"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :faker]
    ]
  end

  def description() do
    "A library that contains test utilites used in the Smart City project"
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:brod, "~> 3.8"},
      {:smart_city_data, "~> 3.0", only: [:test]},
      {:smart_city, "~> 2.6"},
      {:faker, "~> 0.12"},
      {:ex_doc, "~> 0.19"},
      {:credo, "~> 1.1", only: [:dev, :test, :integration], runtime: false},
      {:patiently, "~> 0.2"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:husky, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["smartcitiesdata"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://www.github.com/smartcitiesdata/smart_city_test"}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: "https://github.com/smartcitiesdata/smart_city_test",
      extras: [
        "README.md"
      ]
    ]
  end
end
