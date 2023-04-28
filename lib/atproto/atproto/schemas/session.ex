defmodule ATProto.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :access_jwt, :string
    field :refresh_jwt, :string
    field :handle, :string
    field :did, :string
    field :email, :string
  end

  defp changeset(attrs) do
    attrs = underscore_keys(attrs)

    %__MODULE__{}
    |> cast(attrs, [:access_jwt, :refresh_jwt, :handle, :did, :email])
    |> validate_required([:access_jwt, :refresh_jwt, :handle, :did])
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
