defmodule Versioning.Project do
  use Versioning.Web, :model

  schema "projects" do
    field :user_id, :integer
    field :project_id, :integer
    has_many :images, Versioning.Images
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :project_id])
    |> validate_required([:user_id, :project_id])
  end
end
