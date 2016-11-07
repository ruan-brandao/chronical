defmodule Chronical.UserTest do
  use Chronical.ConnCase
  alias Chronical.User

  test "changeset is not valid without name" do
    changeset = User.changeset(%User{}, %{username: "foo"})
    refute changeset.valid?
  end

  test "changeset is not valid with username above 20 characters" do
    changeset = User.changeset(%User{}, %{name: "Test User", username: "really-long-test-username"})
    refute changeset.valid?
  end

  test "is valid with proper name and username" do
    changeset = User.changeset(%User{}, %{name: "foo", username: "bar"})
    assert changeset.valid?
  end
end
