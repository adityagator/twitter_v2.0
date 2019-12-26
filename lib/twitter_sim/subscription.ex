defmodule TwitterSim.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscriptions" do
    field :subscribed_by, :string
    field :subscribed_to, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:user, :subscribed_to, :subscribed_by])
   # |> validate_required([:user, :subscribed_to, :subscribed_by])
  end
end
