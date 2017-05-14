# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ExRBC.Repo.insert!(%ExRBC.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ExRBC.Repo
alias ExRBC.Caso

especialidades = ["Java", "C", "C++", "Elixir", "Ruby", "Javascript", "Rails", "Phoenix"]
universidades = ["URI", "IESA", "IFF"]

Enum.each(0..200, fn(_) ->
  tempo = Enum.random(0..20)
  Repo.insert! %Caso{
    universidade: Enum.random(universidades),
    graduacao: Enum.random(1..5),
    tempo_exp: tempo,
    tempo_total: Enum.random(tempo..40),
    especialidades: Enum.sort(Enum.take_random(especialidades, Enum.random(0..8))),
    salario: (Enum.random(50000..1000000) / 100)
  }
end)
