defmodule ExRBC.Repo.Migrations.CreateCaso do
  use Ecto.Migration

  def change do
    create table(:casos) do
      add :universidade, :string
      add :graduacao, :integer
      add :tempo_exp, :integer
      add :tempo_total, :integer
      add :especialidades, {:array, :string}
      add :salario, :float

      timestamps()
    end

  end
end
