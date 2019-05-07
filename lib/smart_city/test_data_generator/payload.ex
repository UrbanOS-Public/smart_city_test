defmodule SmartCity.TestDataGenerator.Payload do
  @moduledoc """
  Module that generates payloads based on schema type.
  """
  require Logger
  alias SmartCity.TestDataGenerator.Schema

  @doc """
  Generates payload for requested schema type.
  """
  @spec create_payload(atom()) :: map()
  def create_payload(schema_type) do
    schema_type
    |> get_schema()
    |> generate_payload()
  end

  @doc """
  Returns a map containing schema for the requested schema type.
  """
  @spec get_schema(atom()) :: {:ok, map()} | :error
  def get_schema(schema_type) do
    case Schema.get(schema_type) do
      {:ok, schema} ->
        Map.get(schema, "schema")

      :error ->
        raise "Schema does not exist: #{schema_type}"
    end
  end

  defp generate_payload(columns) do
    Enum.reduce(columns, %{}, &generate_value/2)
  end

  defp generate_value(%{"name" => column, "type" => type}, acc) do
    Map.put(acc, column, generate_from_type({column, type}))
  end

  defp generate_from_type({column, "string"}) do
    # Deterministically generate a number based on the column name
    selector = column_hashed_selector(column)

    # Reset the seed to a random value for Faker
    :crypto.rand_seed()

    # Use generated number to pick a Faker generator
    cond do
      selector > 0.75 -> Faker.Commerce.product_name()
      selector > 0.50 -> Faker.Company.buzzword()
      selector > 0.25 -> Faker.Superhero.En.name()
      selector > 0.10 -> Faker.Pokemon.En.name()
      true -> Faker.Name.PtBr.name()
    end
  end

  defp generate_from_type({_column, "int"}) do
    :rand.uniform(999_999)
  end

  defp generate_from_type({_column, "date"}) do
    Faker.Date.backward(7)
  end

  defp generate_from_type({_column, "float"}) do
    :rand.uniform()
  end

  defp generate_from_type({_column, "boolean"}) do
    :rand.uniform() > 0.5
  end

  defp column_hashed_selector(column) do
    <<a::5, b::5, c::6, _::binary>> = :crypto.hash(:md5, column)
    :rand.seed(:exsplus, {a, b, c})
    :rand.uniform()
  end
end
