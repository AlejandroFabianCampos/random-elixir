defmodule Lists do
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def double([]), do: 0
  def double([element]), do: element * 2
  def double([head | tail]), do: [head * 2 | double(tail)]
end
