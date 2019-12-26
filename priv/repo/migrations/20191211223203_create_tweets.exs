defmodule TwitterSim.Repo.Migrations.CreateTweets do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :from, :string, size: 30
      add :tweet, :string, null: false, size: 255
      add :mentions, :string
      add :hashtags, :string

      timestamps()
    end

  end
end
