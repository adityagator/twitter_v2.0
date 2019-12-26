defmodule TwitterSim.Repo.Migrations.RemoveFromInTweets do
  use Ecto.Migration

 def change do
    alter table(:tweets) do
      remove :from
    end
  end
end
