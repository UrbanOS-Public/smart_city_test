defmodule SmartCityTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :smart_city_test,
      version: "0.2.4",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package(),
      source_url: "https//www.github.com/SmartColumbusOS"
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
      {:smart_city, "~> 2.1", organization: "smartcolumbus_os"},
      {:smart_city_data, "~> 2.0", organization: "smartcolumbus_os", only: [:test]},
      {:smart_city_registry, "~> 2.6", organization: "smartcolumbus_os", only: [:test]},
      {:faker, "~> 0.12.0"},
      {:ex_doc, "~> 0.19.3"},
      {:credo, "~> 1.0", only: [:dev, :test, :integration], runtime: false}
    ]
  end

  defp package do
    [
      organization: "smartcolumbus_os",
      licenses: ["AllRightsReserved"],
      links: %{"GitHub" => "https://www.github.com/SmartColumbusOS/smart_city_test"}
    ]
  end
end
