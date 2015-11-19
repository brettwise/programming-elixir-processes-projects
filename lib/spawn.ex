defmodule Spawn2 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello, from one asshole to another #{msg}"}
    end
  end
end
# here's a client
pid = spawn(Spawn2, :greet, [])
send pid, {self, "asshole!"}
receive do
  {:ok, message} ->
    IO.puts message
end
send pid, {self, "ass... I mean good guy."}
receive do
  {:ok, message} ->
    IO.puts message
end
