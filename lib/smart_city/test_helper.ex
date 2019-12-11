defmodule SmartCity.TestHelper do
  @moduledoc """
  Common utilities for use in test cases
  """

  # no_return() is because eventually() catches ExUnit.AssertionError
  @type asserting_function :: (() -> no_return() | boolean())

  @doc """
  Helper function for asynchronous testing
  - Repeats the given block (zero-arity function) until a timeout occurs or it returns a truthy value.
  - Catches ExUnit assertions and continues to try the block
  - Re-runs block one last time if it times out so assertions are run and throw helpful diffs, etc.

  """
  @spec eventually(asserting_function(), integer, integer) :: :ok | none()
  def eventually(function, dwell \\ 2_000, max_tries \\ 5) do
    case Patiently.wait_for(
           wrap_assertions_as_falsey(function),
           dwell: dwell,
           max_tries: max_tries
         ) do
      :ok -> :ok
      _ ->
        case function.() do
          false -> raise ExUnit.AssertionError, "no assertion was made in the eventually block but the block evaluated as false"
          result -> result
        end

    end
  end

  defp wrap_assertions_as_falsey(function) do
    fn ->
      try do
        function.()
      rescue
        _e in [ExUnit.AssertionError, MatchError] ->
          false
      end
    end
  end
end
