defmodule Chronical.StoryController do
  use Chronical.Web, :controller

  alias Chronical.Story

  def index(conn, _params, _user) do
    stories = Repo.all(Story)
    render(conn, "index.html", stories: stories)
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:stories)
      |> Story.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"story" => story_params}, user) do
    changeset =
      user
      |> build_assoc(:stories)
      |> Story.changeset(story_params)
    case Repo.insert(changeset) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story created successfully")
        |> redirect(to: story_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _user) do
    story = Repo.get!(Story, id)
    render(conn, "show.html", story: story)
  end

  def edit(conn, %{"id" => id}, user) do
    story = Repo.get!(user_stories(user), id)
    changeset = Story.changeset(story)
    render(conn, "edit.html", story: story, changeset: changeset)
  end

  def update(conn, %{"id" => id, "story" => story_params}, user) do
    story = Repo.get!(user_stories(user), id)
    changeset = Story.changeset(story, story_params)

    case Repo.update(changeset) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story updated successfully.")
        |> redirect(to: story_path(conn, :show, story))
      {:error, changeset} ->
        render(conn, "edit.html", story: story, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    story = Repo.get!(user_stories(user), id)
    Repo.delete!(story)

    conn
    |> put_flash(:info, "Story deleted successfully.")
    |> redirect(to: story_path(conn, :index))
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
          [conn, conn.params, conn.assigns.current_user])
  end

  defp user_stories(user) do
    assoc(user, :stories)
  end
end
