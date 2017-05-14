defmodule ExRBC.CasoController do
  use ExRBC.Web, :controller

  alias ExRBC.Caso

  def index(conn, _params) do
    casos = Repo.all(Caso)
    render(conn, "index.html", casos: casos)
  end

  def new(conn, _params) do
    changeset = Caso.changeset(%Caso{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"caso" => caso_params}) do
    changeset = Caso.changeset(%Caso{}, caso_params)

    case Repo.insert(changeset) do
      {:ok, _caso} ->
        conn
        |> put_flash(:info, "Caso created successfully.")
        |> redirect(to: caso_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    caso = Repo.get!(Caso, id)
    render(conn, "show.html", caso: caso)
  end

  def edit(conn, %{"id" => id}) do
    caso = Repo.get!(Caso, id)
    changeset = Caso.changeset(caso)
    render(conn, "edit.html", caso: caso, changeset: changeset)
  end

  def update(conn, %{"id" => id, "caso" => caso_params}) do
    caso_params = Map.put_new(caso_params, "casos", nil)
    caso = Repo.get!(Caso, id)
    changeset = Caso.changeset(caso, caso_params)

    case Repo.update(changeset) do
      {:ok, caso} ->
        conn
        |> put_flash(:info, "Caso updated successfully.")
        |> redirect(to: caso_path(conn, :show, caso))
      {:error, changeset} ->
        render(conn, "edit.html", caso: caso, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    caso = Repo.get!(Caso, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(caso)

    conn
    |> put_flash(:info, "Caso deleted successfully.")
    |> redirect(to: caso_path(conn, :index))
  end
end
