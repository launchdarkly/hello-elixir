defmodule LDApi do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(server, key, fallback, user) do
  	GenServer.call(server, {:get, key, fallback, user})
  end

  def init(:ok) do
  	:ldclient.start_instance(String.to_charlist(Application.get_env(:hello_elixir, :sdk_key)))
    {:ok, %{}}
  end

  def handle_call({:get, key, fallback, user}, _from, state) do
    {:reply, :ldclient.variation(key, %{:key => user}, fallback), state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
