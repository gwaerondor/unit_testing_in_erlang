# Basic Erlang part 4 - eunit and meck
This is the fourth part of the basic Erlang series.

We will look more at the functionality provided by eunit:
- Test modules and test functions (recap)
- Fixtures
- Macros

We will also look at [meck, a mocking library for Erlang](https://github.com/eproxus/meck).

## Build and test
```bash
rebar3 eunit
```

## Exercises
There is a directory called exercises, which is a separate rebar application. This means that if you enter the exercises directory, you can run the exercise tests with the same command as above, rebar3 eunit

More information about the exercises is available in that directory.