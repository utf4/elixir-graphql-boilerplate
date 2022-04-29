defmodule SntxGraph.PostQueries do
  use Absinthe.Schema.Notation

  alias SntxGraph.PostResolver

  object :post_queries do
    @desc "Post. Null"
    field :get_single_post, :post do
      arg :id, :uuid4

      resolve(&PostResolver.get_post/2)
    end

    field :posts_list, list_of(:post) do

      resolve(&PostResolver.all_posts/2)
    end
  end
end
