defmodule Fibonacci do
  alias Fibonacci.Cache

  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) do
    result_a = maybe_calculate(n-1, Cache.has_cache_entry?(n-1))
    result_b = maybe_calculate(n-2, Cache.has_cache_entry?(n-2))
    result = result_a + result_b
    Cache.push_calculation(n, result)
    result
  end

  defp maybe_calculate(n, _is_cached = true) do
    Cache.value(n)
  end

  defp maybe_calculate(n, _is_cached = false) do
    fib(n)
  end
end

defmodule Fibonacci.Cache do
  use Agent

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def value() do
    Agent.get(__MODULE__, fn value -> value end)
  end

  def value(n) do
    Agent.get(__MODULE__, fn value -> Map.get(value, n) end)
  end

  def push_calculation(number, result) do
    push_to_cache =
      fn current_cache ->
        Map.put(current_cache, number, result)
      end
    Agent.update(__MODULE__, push_to_cache)
  end

  def has_cache_entry?(number) do
    cache = value()
    Map.has_key?(cache, number)
  end
end
