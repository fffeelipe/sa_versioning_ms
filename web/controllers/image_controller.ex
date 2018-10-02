import Ecto.Query
defmodule Versioning.ImageController do
  use Versioning.Web, :controller

  alias Versioning.Image

  def index(conn, %{"project_id" => project_id}) do
    images = Image |> where([p], p.project_id in [^project_id])
    |>  Repo.all
    render(conn, "index.json", images: images)
  end

  def create(conn, %{"image" => image_params}) do
    changeset = Image.changeset(%Image{}, image_params)

    case Repo.insert(changeset) do
      {:ok, image} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", image_path(conn, :show, image))
        |> render("show.json", image: image)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Versioning.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"project_id" => project_id}) do
    images = Image |> where([p], p.project_id in [^project_id])
    |>  Repo.all
    render(conn, "index.json", images: images)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Repo.get!(Image, id)
    changeset = Image.changeset(image, image_params)

    case Repo.update(changeset) do
      {:ok, image} ->
        render(conn, "show.json", image: image)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Versioning.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Repo.get!(Image, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(image)

    send_resp(conn, :no_content, "")
  end
end
