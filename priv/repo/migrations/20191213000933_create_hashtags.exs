defmodule TwitterSim.Repo.Migrations.CreateHashtags do
  use Ecto.Migration

  def change do
    create table(:hashtags) do
      add :user, :string
      add :hash, :string
      add :tweet, :string

      timestamps()
    end

  end
end
