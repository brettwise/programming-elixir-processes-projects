defmodule TwoPs do
  def run do
    create_process("fred")
    send_messages("betty")
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

  def send_messages(p, message) do
    send(p, message)
  end
end
