defmodule SmartCityTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :smart_city_test,
      version: "3.0.0",
      elixir: "~> 1.14.4",
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
      extra_applications: [:logger, :faker, :gettext]
    ]
  end

  def description() do
    "A library that contains test utilites used in the Smart City project"
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:brod, "~> 3.16.5"},
      {:smart_city, "~> 6.0"},
      {:faker, "~> 0.17"},
      {:ex_doc, "~> 0.29"},
      {:credo, "~> 1.7", only: [:dev, :test, :integration], runtime: false},
      {:patiently, "~> 0.2"},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:mock, "~> 0.3", only: [:test]},
      {:timex, "3.7.11"},
      {:gettext, "0.22.1"}
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
