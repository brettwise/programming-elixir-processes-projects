defmodule Monitor1 do
  import :timer, only: [sleep: 1]

  def sad_method(self) do
    send(self, "what what in the what")
    sleep 500
    raise(ArgumentError, message: "some kind of error, wha?")
    exit(:boom)
  end

  def receive_msgs do
    receive do
      msg ->
        IO.puts "Message received: #{inspect msg}"
      after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end

  def run do
    spawn_monitor(Monitor1, :sad_method, [self])
    receive_msgs
  end

end

Monitor1.run
