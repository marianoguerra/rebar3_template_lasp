rebar3 lasp template
=========================

A `rebar3 <http://rebar3.org>`_ template for lasp applications.

Setup
-----

`Install rebar3 <http://www.rebar3.org/docs/getting-started>`_ if you haven't already.

then install this template::

    mkdir -p ~/.config/rebar3/templates
    git clone https://github.com/marianoguerra/rebar3_template_lasp.git ~/.config/rebar3/templates/rebar3_template_lasp

Use
---

::

    rebar3 new rebar3_template_lasp  name=laspy
    cd laspy
    rebar3 release
    rebar3 run

Author
------

Mariano Guerra

License
-------

Apache 2.0
