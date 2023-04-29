defmodule ATProto.BSky.Feed do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :cursor, :string
    embeds_many :feed, ATProto.BSky.FeedViewPost
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:cursor])
    |> cast_embed(:feed)
  end

  def new(params) do
    IO.inspect(params)

    case changeset(params) do
      %Ecto.Changeset{valid?: false} = changeset ->
        {:error, changeset}

      %Ecto.Changeset{valid?: true} = changeset ->
        {:ok, apply_changes(changeset)}
    end
  end
end
