defmodule SmartCity.TestHelperTest do
  @moduledoc """
  Pretty much the best test module name ever
  """
  use ExUnit.Case
  use Placebo

  import SmartCity.TestHelper

  setup do
    allow(Fake.do_thing_eventually(), loop: ["not thing", "not thing", "thing", "not thing"], meck_options: [:non_strict])

    :ok
  end

  describe "eventually/1" do
    test "does not bomb out when an assertion fails immediately" do
      eventually(fn ->
        assert Fake.do_thing_eventually() == "thing"
      end, 100)
    end

    test "does not bomb out when an match fails immediately" do
      eventually(fn ->
        expected = "thing"
        ^expected = Fake.do_thing_eventually()

        assert true
      end, 100)
    end

    test "fails when nothing is asserted but we ultimately exhaust the retries" do
      assert_raise(ExUnit.AssertionError, fn ->
        eventually(fn ->
          Fake.do_thing_eventually() == "stuff"
        end, 100)
      end)
    end

    test "fails with a HELPFUL (real AssertionError) message when assertion actually ultimately exhausts the retries" do
      assertion_message = """


      Assertion with == failed
      code:  assert Fake.do_thing_eventually() == "stuff"
      left:  "thing"
      right: "stuff"
      """

      assert_raise(ExUnit.AssertionError, assertion_message, fn ->
        eventually(fn ->
          assert Fake.do_thing_eventually() == "stuff"
        end, 100)
      end)
    end
  end
end
