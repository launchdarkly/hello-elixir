# HelloElixir

Example application using the Erlang server SDK in Elixir.

## Run

`mix deps.get`

`export LD_SDK_KEY=YOUR_SDK_KEY`

`mix compile`

`iex -S mix`

`iex> {:ok, pid} = HelloElixir.start`

`iex> LDApi.get(pid, "FLAG_KEY", FALLBACK_VALUE, "USER_KEY")`
