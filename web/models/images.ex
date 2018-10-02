defmodule Versioning.Images do
  use Versioning.Web, :model

  schema "images" do
    belongs_to :project, Versioning.Project

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
