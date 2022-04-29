defmodule SntxGraph.PostMutations do
  use Absinthe.Schema.Notation

  alias SntxGraph.Middleware.Authorize
  alias SntxGraph.PostResolver

  object :post_mutations do
    field :post_create, :post_payload do
      arg :input, non_null(:post_create_input)

      middleware(Authorize)
      resolve(&PostResolver.create/2)
    end

    field :post_update, :post_payload do
      arg :input, non_null(:post_update_input)

      middleware(Authorize)
      resolve(&PostResolver.update/2)
    end

    field :post_delete, :post_payload do
      arg :id, non_null(:uuid4)

      middleware(Authorize)
      resolve(&PostResolver.delete/2)
    end
  end
end
