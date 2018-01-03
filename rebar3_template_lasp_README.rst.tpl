{{ name }}
===========

A lasp application

Build
-----

::

    rebar3 release

Test
----

::

    rebar3 ct

Run
---

::

    rebar3 run

Clustering
----------

::

    make devrel

    # on 3 different shells
    make dev1-console
    make dev2-console
    make dev3-console

    # join all nodes:
    make devrel-join

    # check node members
    make devrel-status

    # join node1 to node2 manually:
    ./_build/dev1/rel/{{name}}/bin/{{name}}-admin cluster join {{name}}2@127.0.0.1

    # check node1 members
    ./_build/dev1/rel/{{name}}/bin/{{name}}-admin cluster members

    # check node1 connections
    ./_build/dev1/rel/{{name}}/bin/{{name}}-admin cluster connections

Ping node2 from node1 using partisan::

    1> {{name}}:ping('{{name}}2@127.0.0.1').
    ok

    % check logs/console on node2, you should see:
    got msg ping

Run some Lasp code:

On one of the nodes' shell run:

.. code-block:: erlang

    Key1 = <<"key1">>.
    Key2 = <<"key2">>.
    Timestamp = fun () -> erlang:unique_integer([monotonic, positive]) end.

    AwMapType = {state_awmap, [state_mvregister]}.
    AwMapVarName = <<"awmap">>.
    AwMapVal = #{what => i_am_an_awmap_value}.

    % declare the variable
    {ok, {AwMap, _, _, _}} = lasp:declare({AwMapVarName, AwMapType}, AwMapType).

    % update its content setting Key1 = AwMapVal
    {ok, {AwMap1, _, _, _}} = lasp:update(AwMap, {apply, Key1,
                                                  {set, Timestamp(), AwMapVal}},
                                          self()).
    % timestamp argument is not needed in mvregister, it's only for compatibility
    % with lwwregister
    {ok, _} = lasp:update(AwMap, {apply, Key1, {set, nil, AwMapVal}}, self()).

    % get the value
    {ok, AwMapRes} = lasp:query(AwMap1).

    AwMapRes.
    % {ok,[{<<"key1">>, {set, ...#{what => i_am_an_awmap_value} ... }}]}

    [{_, AwMapSet}] = AwMapRes.
    sets:to_list(AwMapSet).
    % [#{what => i_am_an_awmap_value}]

in another one run:

.. code-block:: erlang

    {ok, AwMapRes} = lasp:query({<<"awmap">>,{state_awmap,[state_mvregister]}}).

    AwMapRes.

    [{_, AwMapSet}] = AwMapRes.
    sets:to_list(AwMapSet).

You should get:

.. code-block:: erlang

    [#{what => i_am_an_awmap_value}]


Quit
----

::

    1> q().

TODO
----

* define license and create LICENSE file

License
-------

TODO
