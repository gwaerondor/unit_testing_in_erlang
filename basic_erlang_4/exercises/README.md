# Exercises
This directory contains a separate project from the project at the top level of the repo.

When you do rebar3 eunit from .../exercises/ you will run only the test suite that is located in this project.

Someone has left the test suite in a very bad state. Tests are failing left and right, and they're taking forever. Some of the functionality under test isn't even fully implemented!

## Tasks
1. Implement the function in src/exercise_1.erl, but not before you fix the test that is supposed to test it. Since our eunit machine most likely isn't connected to other nodes, erlang:nodes() is just returning an empty list so we cannot test the functionality.
2. The remaining tests are doing exactly what they are supposed to, but they are failing because they are badly written or because they are missing something. Fix them according to the comments located near each test.

# Run tests
```bash
rebar3 eunit
```
