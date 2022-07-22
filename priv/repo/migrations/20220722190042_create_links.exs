defmodule Shortr.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :hash, :string
      add :url, :string

      timestamps()
    end

    create unique_index(:links, [:url])
    create unique_index(:links, [:hash])
  end
end
