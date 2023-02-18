202206151027
Status: #idea

Tags: [[Elixir]] - [[OTP]]

# Supervisor

Supervisors in Elixir/Erlang are what keeps track of and keeps an eye on processes running in the wild. A supervisor can also look after another supervisor, thus creating what is known as a [[Supervisor Tree]].

Booting up a Supervisor requires two parameters; 

- children - i.e. the processes and/or supervisors it's supposed to monitor in a list
- options - mainly the name, and what strategy to employ if the process it's supervising blows the F up.

```elixir
defmodule Dictionary.Runtime.Application do
  alias Dictionary.Runtime.Server
  use Application

  def start(_type, _args) do
    children = [
      {Server, []}
    ]

    options = [
      name: Dictionary.Runtime.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end
end

```

---
# references