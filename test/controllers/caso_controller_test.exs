defmodule ExRBC.CasoControllerTest do
  use ExRBC.ConnCase

  alias ExRBC.Caso
  @valid_attrs %{especialidades: [], graduacao: 42, salario: 42, tempo_exp: 42, tempo_total: 42, universidade: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, caso_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing casos"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, caso_path(conn, :new)
    assert html_response(conn, 200) =~ "New caso"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, caso_path(conn, :create), caso: @valid_attrs
    assert redirected_to(conn) == caso_path(conn, :index)
    assert Repo.get_by(Caso, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, caso_path(conn, :create), caso: @invalid_attrs
    assert html_response(conn, 200) =~ "New caso"
  end

  test "shows chosen resource", %{conn: conn} do
    caso = Repo.insert! %Caso{}
    conn = get conn, caso_path(conn, :show, caso)
    assert html_response(conn, 200) =~ "Show caso"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, caso_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    caso = Repo.insert! %Caso{}
    conn = get conn, caso_path(conn, :edit, caso)
    assert html_response(conn, 200) =~ "Edit caso"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    caso = Repo.insert! %Caso{}
    conn = put conn, caso_path(conn, :update, caso), caso: @valid_attrs
    assert redirected_to(conn) == caso_path(conn, :show, caso)
    assert Repo.get_by(Caso, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    caso = Repo.insert! %Caso{}
    conn = put conn, caso_path(conn, :update, caso), caso: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit caso"
  end

  test "deletes chosen resource", %{conn: conn} do
    caso = Repo.insert! %Caso{}
    conn = delete conn, caso_path(conn, :delete, caso)
    assert redirected_to(conn) == caso_path(conn, :index)
    refute Repo.get(Caso, caso.id)
  end
end
