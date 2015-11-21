defmodule Monitor do

  def notify_parent(parents_pid) do
    send(parents_pid, "WAT!")
    exit(:bow)
  end

  def run do
    spawn_monitor(Monitor, :notify_parent, [self])
    receive do
      msg ->
        IO.puts "Got it: #{inspect msg}"
    after 500 ->
      IO.puts "Never got anything. What's up?"
      exit :ok
    end
  end
end

Monitor.run
