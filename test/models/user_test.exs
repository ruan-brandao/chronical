defmodule Chronical.UserTest do
  use Chronical.ModelCase, async: true
  alias Chronical.User

  @valid_attrs %{name: "foo", username: "bar", password: "secret"}
  @invalid_attrs %{}

  test "changeset is valid with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset is not valid with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset requires a name" do
    attrs = Map.put(@valid_attrs, :name, nil)
    assert [name: "can't be blank"] == errors_on(%User{}, attrs)
  end

  test "changeset is not valid with username above 20 characters" do
    attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 30))
    assert [username: "should be at most 20 character(s)"] ==
      errors_on(%User{}, attrs)
  end

  test "registration_changeset password must be at least 6 chars long" do
    attrs = Map.put(@valid_attrs, :password, "12345")
    changeset = User.registration_changeset(%User{}, attrs)
    assert {:password, {"should be at least %{count} character(s)", count: 6}}
      in changeset.errors
  end

  test "registration_changeset with valid attributes hashes password" do
    attrs = Map.put(@valid_attrs, :password, "123456")
    changeset = User.registration_changeset(%User{}, attrs)
    %{password: pass, password_hash: pass_hash} = changeset.changes

    assert changeset.valid?
    assert pass_hash
    assert Comeonin.Bcrypt.checkpw(pass, pass_hash)
  end
end
