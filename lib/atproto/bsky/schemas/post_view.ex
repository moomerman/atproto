defmodule ATProto.BSky.PostView do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :uri, :string
    field :cid, :string
    field :record, :map
    field :embed, :map
    field :reply_count, :integer
    field :repost_count, :integer
    field :like_count, :integer
    field :indexed_at, :utc_datetime
    embeds_one :author, ATProto.BSky.ProfileViewBasic
    embeds_one :viewer, ATProto.BSky.FeedViewerState
    embeds_many :labels, ATProto.Label
  end

  def changeset(schema, attrs) do
    attrs = underscore_keys(attrs)

    schema
    |> cast(attrs, [
      :uri,
      :cid,
      :record,
      :embed,
      :reply_count,
      :repost_count,
      :like_count,
      :indexed_at
    ])
    |> cast_embed(:author)
    |> cast_embed(:viewer)
    |> cast_embed(:labels)
    |> validate_required([:uri, :cid, :author, :record, :indexed_at])
  end

  defp underscore_keys(map) do
    for {key, val} <- map, into: %{} do
      {Macro.underscore(key), val}
    end
  end
end
