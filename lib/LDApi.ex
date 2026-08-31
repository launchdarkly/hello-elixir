defmodule LDApi do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(server, key, fallback, context_key) do
    GenServer.call(server, {:get, key, fallback, context_key})
  end

  def init(:ok) do
    case Application.get_env(:hello_elixir, :sdk_key) do
      sdk_key when is_binary(sdk_key) and sdk_key != "" ->
        :ldclient.start_instance(
          String.to_charlist(sdk_key),
          :default,
          %{
            :http_options => %{
              :tls_options => :ldclient_config.tls_basic_options()
            }
          }
        )

        {:ok, %{}}

      _ ->
        {:stop, "LD_SDK_KEY is not set. Run: export LD_SDK_KEY=<your SDK key>"}
    end
  end

  def handle_call({:get, key, fallback, context_key}, _from, state) do
    {:reply, :ldclient.variation(key, :ldclient_context.new(context_key), fallback), state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
