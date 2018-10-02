defmodule Versioning.ProjectView do
  use Versioning.Web, :view

  def render("index.json", %{projects: projects}) do
    %{data: render_many(projects, Versioning.ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, Versioning.ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id,
      user_id: project.user_id,
      project_id: project.project_id,
      inserted_at: project.inserted_at
    }
  end
end
