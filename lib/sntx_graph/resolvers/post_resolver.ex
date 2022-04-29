defmodule SntxGraph.PostResolver do
  import SntxWeb.Payload

  alias Sntx.Repo
  alias Sntx.Models.Post.Post

  def get_post(%{id: id}, _), do: {:ok, Repo.get(Post, id)}

  def all_posts(_, _), do: {:ok, Repo.all(Post)}

  def create(%{input: input}, %{context: ctx}) do
    input = Map.put(input, :author_id, ctx.user.id)
    case Post.create(input)  do
      {:ok, post} ->
        {:ok, post}

      error ->
        mutation_error_payload(error)
    end
  end

  def update(%{input: %{id: id} = input}, %{context: ctx}) do
    with(
      {:ok, post} <- Post.get(id),
      true <- post.author_id == ctx.user.id,
      input <- Map.delete(input, :id),
      {:ok, updated_post} <- Post.update(post, input)
    ) do
      {:ok, updated_post}
    else
      false ->
        {:error, default_error(:invalid_post)}

      error ->
        mutation_error_payload(error)
    end
  end

  def delete(%{id: id}, %{context: ctx}) do
    with(
      {:ok, post} <- Post.get(id),
      true <- post.author_id == ctx.user.id,
      {:ok, deleted_post} <- Post.delete(post)
    ) do
      {:ok, deleted_post}
    else
      false ->
        {:error, default_error(:invalid_post)}

      error ->
        mutation_error_payload(error)
    end
  end
end
