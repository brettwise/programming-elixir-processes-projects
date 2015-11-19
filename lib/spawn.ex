defmodule Spawn3 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello, from one asshole to another #{msg}"}
    end
  end
end

# here's a client
pid = spawn(Spawn3, :greet, [])

send pid, {self, "asshole!"}
receive do
  {:ok, message} ->
    IO.puts message
end

send pid, {self, "ass... I mean good guy."}
receive do
  {:ok, message} ->
    IO.puts message

  after 500 ->
    IO.puts "The greeter has gone away."
end
