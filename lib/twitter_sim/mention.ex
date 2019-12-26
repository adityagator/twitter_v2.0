defmodule TwitterSim.Mention do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mentions" do
    field :mention, :string
    field :tweet, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(mention, attrs) do
    mention
    |> cast(attrs, [:user, :mention, :tweet])
    # |> validate_required([:user, :mention, :tweet])
  end
end
