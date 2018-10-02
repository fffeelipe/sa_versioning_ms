defmodule Versioning.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :image_url, :string
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end
    create index(:images, [:project_id])

  end
end
