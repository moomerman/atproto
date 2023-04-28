defmodule ATProto.BSky.ProfileViewDetailed do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :did, :string
    field :handle, :string
    field :display_name, :string
    field :description, :string
    field :avatar, :string
    field :banner, :string
    field :followers_count, :integer
    field :follows_count, :integer
    field :posts_count, :integer
    field :indexed_at, :utc_datetime
    embeds_one :viewer, ATProto.BSky.ProfileViewerState
    embeds_many :labels, ATProto.Label
  end

  defp changeset(attrs) do
    attrs = underscore_keys(attrs)

    %__MODULE__{}
    |> cast(attrs, [
      :did,
      :handle,
      :display_name,
      :description,
      :avatar,
      :banner,
      :followers_count,
      :follows_count,
      :posts_count,
      :indexed_at
    ])
    |> cast_embed(:viewer)
    |> validate_required([:did, :handle])
  end

  def new(params) do
    case changeset(params) do
      %Ecto.Changeset{valid?: false} = changeset ->
        {:error, changeset}

      %Ecto.Changeset{valid?: true} = changeset ->
        {:ok, apply_changes(changeset)}
    end
  end

  defp underscore_keys(map) do
    for {key, val} <- map, into: %{} do
      {Macro.underscore(key), val}
    end
  end
end
