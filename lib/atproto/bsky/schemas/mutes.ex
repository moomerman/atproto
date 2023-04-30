defmodule ATProto.BSky.Mutes do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :cursor, :string
    embeds_many :mutes, ATProto.BSky.ProfileView
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:cursor])
    |> cast_embed(:mutes)
  end

  def new(params) do
    case changeset(params) do
      %Ecto.Changeset{valid?: false} = changeset ->
        {:error, changeset}

      %Ecto.Changeset{valid?: true} = changeset ->
        {:ok, apply_changes(changeset)}
    end
  end
end
