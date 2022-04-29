defmodule SntxGraph.PostTypes do
  use Absinthe.Schema.Notation

  import AbsintheErrorPayload.Payload

  payload_object(:post_payload, :post)

  input_object :post_create_input do
    field :title, non_null(:string)
    field :body, non_null(:string)
  end

  input_object :post_update_input do
    field :id, non_null(:uuid4)
    field :title, :string
    field :body, :string
  end

  object :post do
    field :id, :uuid4
    field :title, :string
    field :body, :string
    field :author_id, :uuid4
  end
end
