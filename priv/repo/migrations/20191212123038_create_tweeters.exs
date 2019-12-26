defmodule TwitterSim.Repo.Migrations.CreateTweeters do
  use Ecto.Migration

  def change do
    create table(:tweeters) do
      add :handle, :string
      add :crypto_pass, :string

      timestamps()
    end

    create unique_index(:tweeters, [:handle])
  end
end
