defmodule ATProto.BSky.ProfileViewBasic do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :did, :string
    field :handle, :string
    field :display_name, :string
    field :avatar, :string
    embeds_one :viewer, ATProto.BSky.ProfileViewerState
    embeds_many :labels, ATProto.Label
  end

  def changeset(schema, attrs) do
    attrs = underscore_keys(attrs)

    schema
    |> cast(attrs, [:did, :handle, :display_name, :avatar])
    |> cast_embed(:viewer)
    |> cast_embed(:labels)
    |> validate_required([:did, :handle])
  end

  defp underscore_keys(map) do
    for {key, val} <- map, into: %{} do
      {Macro.underscore(key), val}
    end
  end
end
