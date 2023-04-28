defmodule ATProto.Label do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :src, :string
    field :uri, :string
    field :cid, :string
    field :val, :string
    field :neg, :boolean
    field :cts, :string
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:src, :uri, :cid, :val, :neg, :cts])
    |> validate_required([:src, :uri, :val, :cts])
  end
end
