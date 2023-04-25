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
           type: "integer",
           ingestion_field_selector: "id"
         },
         %{
           name: "name",
           type: "string",
           ingestion_field_selector: "name"
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
           type: "string",
           ingestion_field_selector: "big"
         },
         %{
           name: "bigbig",
           type: "integer",
           ingestion_field_selector: "bigbig"
         },
         %{
           name: "data",
           type: "float",
           ingestion_field_selector: "data"
         },
         %{
           name: "bigger_data",
           type: "date",
           format: "{ISO:Extended:Z}",
           ingestion_field_selector: "bigger_data"
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
           type: "integer",
           ingestion_field_selector: "go"
         },
         %{
           name: "fund",
           type: "string",
           ingestion_field_selector: "fund"
         },
         %{
           name: "yourself",
           type: "string",
           ingestion_field_selector: "yourself"
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
           type: "integer",
           ingestion_field_selector: "my_int"
         },
         %{
           name: "my_string",
           type: "string",
           ingestion_field_selector: "my_string"
         },
         %{
           name: "my_date",
           type: "date",
           format: "{ISO:Extended:Z}",
           ingestion_field_selector: "my_date"
         },
         %{
           name: "my_float",
           type: "float",
           ingestion_field_selector: "my_float"
         },
         %{
           name: "my_boolean",
           type: "boolean",
           ingestion_field_selector: "my_boolean"
         }
       ]
     }}
  end

  def get(_) do
    {:error, "Schema not found"}
  end
end
