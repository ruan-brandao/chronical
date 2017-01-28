defmodule Chronical.Repo.Migrations.CreateStory do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :title, :string
      add :content, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:stories, [:user_id])

  end
end