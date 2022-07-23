defmodule Shortr.Repo.Migrations.CreateVisits do
  use Ecto.Migration

  def change do
    create table(:visits) do
      add :hash, references(:links, column: :hash, type: :string, on_delete: :delete_all)

      add :agent, :string
      add :ip, :string

      timestamps(updated_at: false)
    end
  end
end
