defmodule SmartCity.TestDataGenerator.Schema do
  @moduledoc """
  Module containing retrieval functions for schema definitions.
  """

  @doc """
  Returns a map containing schema based on requested type.
  """
  @spec get(atom()) :: map() | {:error, String.t()}
  def get(:basic) do
    {:ok,
     %{
       "schema" => [
         %{
           name: "id",
           type: "int"
         },
         %{
           name: "name",
           type: "string"
         }
       ]
     }}
  end

  def get(:big_data) do
    {:ok,
     %{
       "schema" => [
         %{
           name: "big",
           type: "string"
         },
         %{
           name: "bigbig",
           type: "int"
         },
         %{
           name: "data",
           type: "float"
         },
         %{
           name: "bigger_data",
           type: "date"
         }
       ]
     }}
  end

  def get(:pirate_dilemma) do
    {:ok,
     %{
       "schema" => [
         %{
           name: "go",
           type: "int"
         },
         %{
           name: "fund",
           type: "string"
         },
         %{
           name: "yourself",
           type: "string"
         }
       ]
     }}
  end

  def get(:test) do
    {:ok,
     %{
       "schema" => [
         %{
           name: "my_int",
           type: "int"
         },
         %{
           name: "my_string",
           type: "string"
         },
         %{
           name: "my_date",
           type: "date"
         },
         %{
           name: "my_float",
           type: "float"
         },
         %{
           name: "my_boolean",
           type: "boolean"
         }
       ]
     }}
  end

  def get(_) do
    {:error, "Schema not found"}
  end
end
