defmodule Versioning.Image do
  use Versioning.Web, :model

  schema "images" do
    field :image_url, :string
    belongs_to :project, Versioning.Project

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:image_url])
    |> validate_required([:image_url])
  end
end
