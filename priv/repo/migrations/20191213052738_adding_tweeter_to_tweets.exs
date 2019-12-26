defmodule TwitterSim.Repo.Migrations.AddingTweeterToTweets do
  use Ecto.Migration

  # def change do
  #   alter table(:tweets) do
  #     delete :from
  #   end
  # end

  def change do
    alter table(:tweets) do
      add :tweeter_id, references(:tweeters)
    end
  end
end
