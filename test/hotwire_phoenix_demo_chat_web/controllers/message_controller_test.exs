defmodule HotwirePhoenixDemoChatWeb.MessageControllerTest do
  use HotwirePhoenixDemoChatWeb.ConnCase

  import HotwirePhoenixDemoChat.ChatFixtures

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  describe "new message" do
    setup [:create_room]

    test "renders form", %{conn: conn, room: room} do
      conn = get(conn, ~p"/rooms/#{room.id}/messages/new")
      assert html_response(conn, 200) =~ "New Message"
    end
  end

  describe "create message" do
    setup [:create_room]

    test "redirects to show when data is valid", %{conn: conn, room: room} do
      conn = post(conn, ~p"/rooms/#{room.id}/messages", message: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/messages/#{id}"

      conn = get(conn, ~p"/messages/#{id}")
      assert html_response(conn, 200) =~ "Message #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn, room: room} do
      conn = post(conn, ~p"/rooms/#{room.id}/messages", message: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Message"
    end
  end

  describe "edit message" do
    setup [:create_message]

    test "renders form for editing chosen message", %{conn: conn, message: message} do
      conn = get(conn, ~p"/messages/#{message}/edit")
      assert html_response(conn, 200) =~ "Edit Message"
    end
  end

  describe "update message" do
    setup [:create_message]

    test "redirects when data is valid", %{conn: conn, message: message} do
      conn = put(conn, ~p"/messages/#{message}", message: @update_attrs)
      assert redirected_to(conn) == ~p"/messages/#{message}"

      conn = get(conn, ~p"/messages/#{message}")
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, message: message} do
      conn = put(conn, ~p"/messages/#{message}", message: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Message"
    end
  end

  describe "delete message" do
    setup [:create_message]

    test "deletes chosen message", %{conn: conn, message: message} do
      conn = delete(conn, ~p"/messages/#{message}")
      assert redirected_to(conn) == ~p"/rooms/#{message.room_id}"

      assert_error_sent 404, fn ->
        get(conn, ~p"/messages/#{message}")
      end
    end
  end

  defp create_room(_) do
    room = room_fixture()
    %{room: room}
  end

  defp create_message(_) do
    message = message_fixture()
    %{message: message}
  end
end
