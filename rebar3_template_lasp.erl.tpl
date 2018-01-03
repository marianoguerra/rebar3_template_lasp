-module({{name}}).

-export([ping/1]).

ping(NodeName) ->
    partisan_peer_service:forward_message(NodeName, {{name}}_handler, ping).
