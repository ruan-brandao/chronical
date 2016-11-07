defmodule Chronical.Repo do
  # use Ecto.Repo, otp_app: :chronical

  def all(Chronical.User) do
    [%Chronical.User{id: "1", name: "Quéven", username: "mito", password: "mito"},
     %Chronical.User{id: "1", name: "Ruan", username: "patrao", password: "patrao"}]
  end
  def all(_module), do: []

  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end

  def get_by(module, params) do
    Enum.find all(module), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end
end
