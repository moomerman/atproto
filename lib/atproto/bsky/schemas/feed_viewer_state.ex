defmodule ATProto.BSky.FeedViewerState do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :repost, :string
    field :like, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:repost, :like])
  end
end
