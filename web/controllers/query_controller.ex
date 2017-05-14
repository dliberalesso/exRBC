defmodule ExRBC.QueryController do
  use ExRBC.Web, :controller

  alias ExRBC.Caso
  alias ExRBC.Repo

  def index(conn, _params) do
    changeset = Caso.changeset(%Caso{})
    render(conn, "index.html", changeset: changeset)
  end

  def search(conn, %{"caso" => params}) do
    resultado = processa(params)
    ids = Enum.flat_map(resultado, fn([_ | t]) -> t end)
    pesos = Enum.map(resultado, fn([h | _]) -> h end)
    casos = Enum.map(ids, &Repo.get(Caso, &1))
    valor = media(casos, pesos)
    caso = Map.put(params, "salario", :erlang.float_to_binary(valor, decimals: 2))
    changeset = Caso.changeset(%Caso{}, caso)
    render(conn, "resultados.html", query: params, changeset: changeset, casos: casos)
  end

  defp media(casos, pesos) do
    total = Enum.sum(pesos)
    soma = Enum.map(casos, fn(caso) -> caso.salario end)
        |> Enum.zip(pesos)
        |> Enum.map(&Tuple.to_list/1)
        |> Enum.reduce(0, fn([a, b], acc) -> acc + (a * b) end)
    (soma / total)
  end

  defp processa(params) do
    Repo.all(Caso)
    |> Enum.map(&dist_euclidiana(&1, params))
    |> Enum.sort
    |> Enum.take(4)
  end

  def dist_euclidiana(c, p) do
    d1 = dist_string(c.universidade, p["universidade"])
    d2 = dist(c.graduacao, String.to_integer(p["graduacao"]))
    d3 = dist(c.tempo_exp, String.to_integer(p["tempo_exp"]))
    d4 = dist(c.tempo_total, String.to_integer(p["tempo_total"]))
    d5 = dist_list(c.especialidades, p["especialidades"])

    [:math.sqrt(d1 + d2 + d3 + d4 + d5), c.id]
  end

  defp dist(c, q), do: (c - q)/5 |> abs |> :math.pow(2)

  defp dist_string(c, q), do: (1 - String.jaro_distance(c, q))

  defp dist_list([], _), do: 1

  defp dist_list(c, q) do
    intersection = length(Set.to_list(Set.intersection(Enum.into(c, HashSet.new), Enum.into(q, HashSet.new))))
    length1 = length(c)
    length2 = length(q)
    case intersection do
      0 -> 1
      _ -> 1 - (intersection / (:math.sqrt(length1) * :math.sqrt(length2)))
    end
  end
end
