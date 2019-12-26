defmodule TwitterSim.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :user, :string
      add :subscribed_to, :string
      add :subscribed_by, :string

      timestamps()
    end

  end
end
