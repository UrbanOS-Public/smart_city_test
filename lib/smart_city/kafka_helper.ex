defmodule SmartCity.KafkaHelper do
  @moduledoc false

  def stream_messages(messages, topic, chunk_size \\ 5) when is_list(messages) do
    messages
    |> Stream.cycle()
    |> Stream.chunk_every(chunk_size)
    |> Stream.map(&send_to_kafka(&1, topic))
    |> Stream.run()
  end

  def send_to_kafka(msg, topic) when is_list(msg) do
    msg
    |> Enum.map(&send_to_kafka(&1, topic))
    |> Enum.find(:ok, &(&1 != :ok))
  end

  def send_to_kafka(msg, topic) do
    json_msg = apply(Jason, :encode!, [msg])
    :brod.start_client(endpoint(), :test_data_client, [])
    :brod.start_producer(:test_data_client, topic, [])
    :brod.produce_sync(:test_data_client, topic, 0, "the_key", json_msg)
  end

  defp endpoint(), do: Application.get_env(:smart_city_test, :endpoint)
end
