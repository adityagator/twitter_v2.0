defmodule TwitterSim.Hashtag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hashtags" do
    field :hash, :string
    field :tweet, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(hashtag, attrs) do
    hashtag
    |> cast(attrs, [:user, :hash, :tweet])
    # |> validate_required([:user, :hash, :tweet])
  end
end
