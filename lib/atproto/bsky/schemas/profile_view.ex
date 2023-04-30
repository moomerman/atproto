defmodule ATProto.BSky.ProfileView do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :did, :string
    field :handle, :string
    field :display_name, :string
    field :description, :string
    field :avatar, :string
    field :indexed_at, :utc_datetime
    embeds_one :viewer, ATProto.BSky.ProfileViewerState
    embeds_many :labels, ATProto.Label
  end

  def changeset(schema, attrs) do
    attrs = underscore_keys(attrs)

    schema
    |> cast(attrs, [:did, :handle, :display_name, :description, :avatar, :indexed_at])
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
