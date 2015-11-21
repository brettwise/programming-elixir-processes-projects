defmodule TwoPs do
  def run do
    create_process("fred")
    create_process("betty")
  end

  def process_bouncer(client) do
    IO.puts "Bouncing back the message just received #{inspect client}"
    receive do
      message ->
        send(client, message)
    end
  end

  def create_process(message) do
    IO.puts "Generating process bouncer."
    p = spawn(TwoPs, :process_bouncer, [self])
    IO.puts "About to send message to just created process"
    receive do
      response -> IO.puts inspect response
    end
  end
end
