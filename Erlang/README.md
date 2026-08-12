# Erlang

- _Practical Functional Programming for a Parallel World_
- _Let it Crash_
- Everything is a process
- Message passing is the only way for processes to interact

## Applications

- Telecommunications
- Concurrent Computing
- Distributed Computing
- Message Brokers
- Parallel Computing

## Hello World

```Erlang
-module(hello).
-export([hello_world/0]).

hello_world() ->
    io:format("Hello, World!~n", []).
```

## Related Languages

- Clojure
- [Elixir](../Elixir/README.md)
- Gleam
- Go
- Lisp
- Prolog
- [Rust](../Rust/README.md)
- Smalltalk

## References

- https://en.wikipedia.org/wiki/Erlang_(programming_language)
