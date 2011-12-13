%% -------------------------------------------------------------------
%%
%% Copyright (c) 2007-2011 Basho Technologies, Inc.  All Rights Reserved.
%%
%% -------------------------------------------------------------------

%% @doc Callbacks for the riak_moss application.

-module(riak_moss_app).

-behaviour(application).

%% application API
-export([start/2,
         stop/1]).


-type start_type() :: normal | {takeover, node()} | {failover, node()}.
-type start_args() :: term().

%% ===================================================================
%% Public API
%% ===================================================================

%% @doc application start callback for riak_moss.
-spec start(start_type(), start_args()) -> {ok, pid()} |
                                           {error, term()}.
start(_Type, _StartArgs) ->
    case riak_moss_utils:riak_connection() of
        {ok, _} ->
            riak_moss_sup:start_link();
        {error, Reason} ->
            lager:error("Couldn't connect to Riak: ~p", [Reason]),
            {error, Reason}
    end.

%% @doc application stop callback for riak_moss.
-spec stop(term()) -> ok.
stop(_State) ->
    ok.
