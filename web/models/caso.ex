defmodule ExRBC.Caso do
  use ExRBC.Web, :model

  schema "casos" do
    field :universidade, :string
    field :graduacao, :integer
    field :tempo_exp, :integer
    field :tempo_total, :integer
    field :especialidades, {:array, :string}
    field :salario, :float

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:universidade, :graduacao, :tempo_exp, :tempo_total, :especialidades, :salario])
    |> validate_required([:universidade, :graduacao, :tempo_exp, :tempo_total, :especialidades, :salario])
  end
end
