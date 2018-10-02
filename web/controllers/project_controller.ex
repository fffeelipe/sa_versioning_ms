import Ecto.Query
defmodule Versioning.ProjectController do
  use Versioning.Web, :controller

  alias Versioning.Project

  def index(conn, _params) do
    projects = Repo.all(Project)
    render(conn, "index.json", projects: projects)
  end

  def create(conn, %{"project" => project_params}) do
    changeset = Project.changeset(%Project{}, project_params)
    case Repo.insert(changeset) do
      {:ok, project} ->
        Enum.each(project_params["pages"], fn (x) -> 
          Repo.insert(%Versioning.Image{project_id: project.id, image_url: x}) end)
        #text conn, "Showing id #{project.id}"
        conn
        |> put_status(:created)
        |> put_resp_header("location", project_path(conn, :show, project))
        |> render("show.json", project: project)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Versioning.ChangesetView, "error.json", changeset: changeset)
    end
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    project = Repo.get!(Project, id)
    render(conn, "show.json", project: project)
  end

  def index_versions(conn, %{"user" => user_id, "project" => project_id}) do
    projects = Project |> where([p], p.user_id in [^user_id])
    |> where([p], p.project_id in [^project_id]) |>  Repo.all
    render(conn, "index.json", projects: projects)
  end
  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Repo.get!(Project, id)
    changeset = Project.changeset(project, project_params)

    case Repo.update(changeset) do
      {:ok, project} ->
        render(conn, "show.json", project: project)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Versioning.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Repo.get!(Project, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(project)

    send_resp(conn, :no_content, "")
  end
end
