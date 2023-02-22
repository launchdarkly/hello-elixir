defmodule LDApi do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(server, key, fallback, context_key) do
    GenServer.call(server, {:get, key, fallback, context_key})
  end

  def init(:ok) do
    :ldclient.start_instance(
      String.to_charlist(Application.get_env(:hello_elixir, :sdk_key)),
      :default,
      %{
        :http_options => %{
          :tls_options => :ldclient_config.tls_basic_options()
        }
      }
    )

    {:ok, %{}}
  end

  def handle_call({:get, key, fallback, context_key}, _from, state) do
    {:reply, :ldclient.variation(key, :ldclient_context.new(context_key), fallback), state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
