defmodule Justelixir.GifsRouter do
  use Plug.Router

  plug :match
  plug :dispatch

  @url "http://api.giphy.com/v1/gifs/"
  @api_key "dc6zaTOxFJmzC"

  get "/" do
    {:ok, body} = requestGiphyAPI
    send_resp(conn, 200, HTTPotion.get(body["data"]["image_original_url"]).body)
  end

  get "/:tag" do
    {:ok, body} = requestGiphyAPI(tag)
    send_resp(conn, 200, HTTPotion.get(body["data"]["image_original_url"]).body)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp requestGiphyAPI(tag \\ "") do
    HTTPotion.get("#{@url}random?api_key=#{@api_key}&tag=#{tag}")
    |> Map.get(:body)
    |> Poison.decode
  end
end
