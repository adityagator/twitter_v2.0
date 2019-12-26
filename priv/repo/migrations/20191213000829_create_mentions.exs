defmodule TwitterSim.Repo.Migrations.CreateMentions do
  use Ecto.Migration

  def change do
    create table(:mentions) do
      add :user, :string
      add :mention, :string
      add :tweet, :string

      timestamps()
    end

  end
end
