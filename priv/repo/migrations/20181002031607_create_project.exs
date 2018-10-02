defmodule Versioning.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :user_id, :integer
      add :project_id, :integer

      timestamps()
    end

  end
end
