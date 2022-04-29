defmodule Sntx.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true, default: fragment("gen_random_uuid()")

      add :title, :string
      add :body, :text
      add :author_id, references(:user_accounts, type: :binary_id, on_delete: :delete_all, column: :id), null: false

      timestamps()
    end

    create_if_not_exists index(:posts, [:author_id])
  end
end
