defmodule ATProto.BSky.FeedViewPost do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :reason, :map
    embeds_one :post, ATProto.BSky.PostView
    embeds_one :reply, ATProto.BSky.Reply
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:reason])
    |> cast_embed(:post)
    |> cast_embed(:reply)
    |> validate_required([:post])
  end
end
