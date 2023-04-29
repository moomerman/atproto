defmodule ATProto.BSky.Reply do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_one :root, ATProto.BSky.PostView
    embeds_one :parent, ATProto.BSky.PostView
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [])
    |> cast_embed(:root)
    |> cast_embed(:parent)
  end
end
