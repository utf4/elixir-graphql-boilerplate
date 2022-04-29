defmodule Sntx.Models.Post.Post do
  use Sntx.Models
  use Waffle.Ecto.Schema

  import Ecto.Changeset
  import SntxWeb.Gettext

  alias __MODULE__, as: Post
  alias Sntx.Repo

  schema "posts" do
    field :title, :string
    field :body, :string

    belongs_to :author, Sntx.Models.User.Account, foreign_key: :author_id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :author_id])
    |> validate_required([:title, :body, :author_id])
    |> validate_length(:title, min: 2, max: 255)
  end

  def create(attrs) do
    %Post{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def get(id) do
    case Repo.get_by(Post, id: id) do
      nil -> {:error, dgettext("global", "Post not found")}
      post -> {:ok, post}
    end
  end

  def update(post, attrs) do
    post
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete(post) do
    Repo.delete(post)
  end
end
