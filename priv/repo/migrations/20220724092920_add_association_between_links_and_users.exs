defmodule Shortr.Repo.Migrations.AddAssociationBetweenLinksAndUsers do
  use Ecto.Migration

  def change do
    alter table(:links) do
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
