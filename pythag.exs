result = for a <- 1..100, b <- 1..100, c <- 1..100, a*a + b*b == c*c, do: {a, b,c}
IO.puts "Pythagorean triples: #{inspect result}, amount of triples: #{length result}"
