defmodule ExRBC.CasoTest do
  use ExRBC.ModelCase

  alias ExRBC.Caso

  @valid_attrs %{especialidades: [], graduacao: 42, salario: 42, tempo_exp: 42, tempo_total: 42, universidade: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Caso.changeset(%Caso{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Caso.changeset(%Caso{}, @invalid_attrs)
    refute changeset.valid?
  end
end
