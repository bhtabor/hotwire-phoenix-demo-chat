defmodule HotwirePhoenixDemoChatWeb.MessageController do
  use HotwirePhoenixDemoChatWeb, :controller
  plug :accepts, ["html", "turbo_stream"] when action in [:create]

  alias HotwirePhoenixDemoChat.Chat
  alias HotwirePhoenixDemoChat.Chat.Message

  def new(conn, %{"room_id" => room_id}) do
    changeset = Chat.change_message(%Message{}, %{"room_id" => room_id})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"room_id" => room_id, "message" => message_params}) do
    case Chat.create_and_broadcast_message(Map.merge(message_params, %{"room_id" => room_id})) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message created successfully.")
        |> redirect(to: ~p"/rooms/#{message.room_id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        case get_format(conn) do
          "turbo_stream" ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(:new_turbo_stream, changeset: changeset)

          _ ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(:new, changeset: changeset)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Chat.get_message!(id)
    {:ok, _message} = Chat.delete_and_broadcast_message(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: ~p"/rooms/#{message.room_id}")
  end
end
