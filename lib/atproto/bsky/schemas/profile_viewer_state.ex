defmodule ATProto.BSky.ProfileViewerState do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :muted, :boolean
    field :following, :string
    field :followed_by, :string
  end

  def changeset(schema, attrs) do
    attrs = underscore_keys(attrs)

    schema
    |> cast(attrs, [:muted, :following, :followed_by])
  end

  defp underscore_keys(map) do
    for {key, val} <- map, into: %{} do
      {Macro.underscore(key), val}
    end
  end
end
