[![smart_city_test](https://github.com/UrbanOS-Public/smart_city_test/actions/workflows/smart_city_test.yml/badge.svg)](https://github.com/UrbanOS-Public/smart_city_test/actions/workflows/smart_city_test.yml)
[![Hex.pm Version](http://img.shields.io/hexpm/v/smart_city_test.svg?style=flat)](https://hex.pm/packages/smart_city_test)

# SmartCityTest

This module defines test utilities for SmartCity libraries. These utilities take the form of a fake data generator to simulate
real data messages of different schemas that may be passed between microservices.

For more information about the `SmartCity.TestDataGenerator`, please see [https://hexdocs.pm/smart_city_test/api-reference.html](https://hexdocs.pm/smart_city_test/api-reference.html)

## Installation

```elixir
def deps do
  [
    {:smart_city_test, "~> 0.5.0"}
  ]
end
```

## Releases

New versions are [published here](https://hexdocs.pm/smart_city_test/readme.html) whenever a Github release is cut. 
The version # of `smart_city_test` is expected to sync with [`smart_city`](https://github.com/UrbanOS-Public/smart_city). 
When cutting a release in either package, the other should also receive an update so that it utilizes the new package version.

Ex: After updating the `smart_city_test` version by changing the version in `mix.exs`, merging, and cutting a release, `smart_city` should receive an 
update PR as well. That `smart_city` PR should update the version of `smart_city_test` in the `mix.exs` file, and a release of `smart_city` should 
be made.

It's expected that the version of `smart_city` and `smart_city_test` always match in their `mix.exs` file and their github releases.

## License

SmartCity is released under the Apache 2.0 license - see the license at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
