defmodule SmartCity.TestDataGenerator do
  @moduledoc """
  Module that generates test data for Smart City project.
  """

  alias SmartCity.TestDataGenerator.Payload

  defp generate_title do
    random = generate_random_characters(5)
    fancy_color = Faker.Color.fancy_name()
    color = Faker.Color.En.name()

    "#{fancy_color}_#{color}_#{random}"
  end

  defp generate_random_characters(size) do
    alphabet = String.split("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "", trim: true)
    Enum.reduce(1..size, [], fn _, acc -> [Enum.random(alphabet) | acc] end)
  end

  defp dataset_example do
    title = generate_title()
    org = "#{Faker.Color.It.name()}_#{Faker.Cat.name()}"

    schema = Payload.get_schema(:test)

    %{
      id: Faker.UUID.v4(),
      business: %{
        benefitRating: Faker.Util.pick([0.0, 0.5, 1.0]),
        dataTitle: title,
        description: Faker.Lorem.Shakespeare.hamlet(),
        modifiedDate: Faker.DateTime.backward(360) |> DateTime.to_iso8601(),
        orgTitle: org,
        contactName: Faker.Name.name(),
        contactEmail: Faker.Internet.email(),
        license: Faker.Util.pick(["https://creativecommons.org/licenses/by/4.0/", "https://creativecommons.org/licenses/by-nd/4.0/"]),
        keywords: Faker.Util.list(5, &Faker.Company.buzzword/0),
        rights: Faker.Lorem.Shakespeare.as_you_like_it(),
        homepage: Faker.Internet.domain_name(),
        issuedDate: Faker.DateTime.backward(360) |> DateTime.to_iso8601(),
        publishFrequency:
          Faker.Util.pick(["Monthly", "Weekly", "Daily", "Every Hour", "Every Minute"]),
        riskRating: Faker.Util.pick([0.0, 0.5, 1.0])
      },
      technical: %{
        dataName: title,
        orgName: org,
        orgId: Faker.UUID.v4(),
        stream: false,
        schema: schema,
        sourceUrl: Faker.Internet.domain_name(),
        sourceFormat:
          Faker.Util.pick(["application/gtfs+protobuf", "text/csv", "application/json"]),
        cadence: Faker.Util.pick(["once", "* * * * *", "0 0 * * *", "never"]),
        queryParams: %{apiKey: Faker.UUID.v4()},
        transformations: ["trim", "aggregate", "rename_field"],
        validations: ["matches_schema", "no_nulls"],
        headers: %{accepts: "application/json"},
        sourceType: "ingest",
        private: false
      }
    }
  end

  @doc """
  Creates and returns a new `SmartCity.Dataset` example
  """
  @spec create_dataset(
          %{
            optional(:id) => String.t(),
            optional(:business) => SmartCity.Dataset.Business,
            optional(:technical) => SmartCity.Dataset.Technical
          }
          | Enumerable.t()
        ) :: SmartCity.Dataset
  def create_dataset(%{} = overrides) when overrides == %{} do
    {:ok, dataset} =
      dataset_example()
      |> add_system_name()
      |> (fn map -> apply(SmartCity.Dataset, :new, [map]) end).()

    dataset
  end

  def create_dataset(%{} = overrides) do
    {:ok, dataset} =
      dataset_example()
      |> SmartCity.Helpers.deep_merge(overrides)
      |> add_system_name()
      |> (fn map -> apply(SmartCity.Dataset, :new, [map]) end).()

    dataset
  end

  def create_dataset(term) do
    create_dataset(Map.new(term))
  end

  def add_system_name(%{technical: %{systemName: _}} = dataset_map), do: dataset_map

  def add_system_name(dataset_map) do
    put_in(
      dataset_map,
      [:technical, :systemName],
      "#{dataset_map.technical.orgName}__#{dataset_map.technical.dataName}"
    )
  end

  defp organization_example do
    org = "#{Faker.Color.It.name()}_#{Faker.Cat.name()}"

    %{
      id: Faker.UUID.v4(),
      orgTitle: org,
      orgName: String.downcase(org),
      description: Faker.Lorem.Shakespeare.hamlet(),
      logoUrl: Faker.Internet.image_url(),
      homepage: Faker.Internet.domain_name(),
      dn: Faker.Internet.domain_name(),
      dataJsonUrl: nil
    }
  end

  @doc """
  Creates and returns a new `SmartCity.Organization` example
  """
  @spec create_organization(
          %{
            optional(:description) => String.t(),
            optional(:homepage) => String.t(),
            optional(:id) => String.t(),
            optional(:logoUrl) => String.t(),
            optional(:orgName) => String.t(),
            optional(:orgTitle) => String.t(),
            optional(:dn) => String.t()
          }
          | Enumerable.t()
        ) :: SmartCity.Organization
  def create_organization(%{} = overrides) when overrides == %{} do
    {:ok, organization} =
      organization_example()
      |> (fn map -> apply(SmartCity.Organization, :new, [map]) end).()

    organization
  end

  def create_organization(%{} = overrides) do
    {:ok, organization} =
      organization_example()
      |> SmartCity.Helpers.deep_merge(overrides)
      |> (fn map -> apply(SmartCity.Organization, :new, [map]) end).()

    organization
  end

  def create_organization(term) do
    create_organization(Map.new(term))
  end

  defp data_example do
    start_time = DateTime.utc_now() |> DateTime.to_iso8601()
    end_time = DateTime.utc_now() |> DateTime.add(:rand.uniform(5_000)) |> DateTime.to_iso8601()
    payload = Payload.create_payload(:test)

    %{
      dataset_id: Faker.UUID.v4(),
      payload: payload,
      _metadata: %{org: Faker.Company.name(), name: Faker.Team.name()},
      operational: %{
        timing: [
          %{
            app: "reaper",
            label: "json_decode",
            start_time: start_time,
            end_time: end_time
          }
        ]
      }
    }
  end

  @doc """
  Creates and returns a new `SmartCity.Data` example
  """
  @spec create_data(
          %{
            optional(:dataset_id) => String.t(),
            optional(:_metadata) => map(),
            optional(:operational) => map(),
            optional(:payload) => map()
          }
          | Enumerable.t()
        ) :: SmartCity.Data
  def create_data(%{} = overrides) do
    {:ok, data} =
      data_example()
      |> Map.merge(overrides)
      |> (fn map -> apply(SmartCity.Data, :new, [map]) end).()

    data
  end

  def create_data(term) do
    create_data(Map.new(term))
  end

  @doc """
  Creates and returns a predefined number of `SmartCity.Data` examples
  """
  @spec create_data(
          %{
            optional(:dataset_id) => String.t(),
            optional(:_metadata) => map(),
            optional(:operational) => map(),
            optional(:payload) => map()
          }
          | Enumerable.t(),
          integer()
        ) :: SmartCity.Data
  def create_data(overrides, number) do
    1..number
    |> Enum.map(fn _index -> create_data(overrides) end)
  end
end
