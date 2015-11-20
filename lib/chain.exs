defmodule Chain do
  @doc """
  `counter` is the function that will be run in seperate processes.
  """
  def counter(next_pid) do
    receive do
      @doc """
      When a number is received it sends a message with the number incremented.
      """
      n ->
        send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self,
              fn (_, send_to) ->
                spawn(Chain, :counter, [send_to])
              end

    @doc """
    start the count by sending
    """
    send last, 0

    @doc """
    Waits for a result to come back to us
    """
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  @doc """
  `run(n)` is the entry point for the code above.
  You pass it a number. `IO.puts` prints to the terminal. Inspect formats the output. `:timer.tc` is an erlang function that returns the time ellapsed in milliseconds that the function that is passed into it takes to run. In this case we are passing a number and that number is the number of processes to spawn.
  """
  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end
