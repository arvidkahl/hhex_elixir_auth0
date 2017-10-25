defmodule HhexWeb.JWTHelpers do
  import Joken, except: [verify: 1]

  def verify(jwt) do
    verify
    |> with_json_module(Poison)
    |> with_compact_token(jwt)
    |> Joken.verify

  end

  def verify do
    %Joken.Token{}
    |> with_json_module(Poison)
    |> with_signer(hs256(config[:app_secret]))
    |> with_validation("aud", &(&1 == config[:app_id]))
    |> with_validation("exp", &(&1 > current_time))
    |> with_validation("iat", &(&1 <= current_time))
    |> with_validation("iss", &(&1 == config[:app_baseurl]))
  end

  defp config, do: Application.get_env(:hhex, :auth0)

  def error(conn, msg) do
    {conn, %{:errors => %{:detail => "unauthorized"}}}
  end


end
