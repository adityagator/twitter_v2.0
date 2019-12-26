defmodule TwitterSim.Repo.Migrations.StreamlineTweets do
  use Ecto.Migration

  def change do
    alter table(:tweets) do
      remove :mentions,
      remove :hashtags
    end
  end
end
