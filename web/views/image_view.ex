defmodule Versioning.ImageView do
  use Versioning.Web, :view

  def render("index.json", %{images: images}) do
    %{data: render_many(images, Versioning.ImageView, "image.json")}
  end

  def render("show.json", %{image: image}) do
    %{data: render_one(image, Versioning.ImageView, "image.json")}
  end

  def render("image.json", %{image: image}) do
    %{image_url: image.image_url}
  end
end
