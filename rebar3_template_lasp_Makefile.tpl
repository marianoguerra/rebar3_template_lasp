BASEDIR = $(shell pwd)
REBAR = rebar3
RELPATH = _build/default/rel/{{ name }}
PRODRELPATH = _build/prod/rel/{{ name }}
APPNAME = {{ name }}
SHELL = /bin/bash

release:
	$(REBAR) release

console:
	cd $(RELPATH) && ./bin/{{ name }} console

prod-release:
	$(REBAR) as prod release
	mkdir -p $(PRODRELPATH)/../{{ name }}_config
	[ -f $(PRODRELPATH)/../{{ name }}_config/{{ name }}.conf ] || cp $(PRODRELPATH)/etc/{{ name }}.conf  $(PRODRELPATH)/../{{ name }}_config/{{ name }}.conf
	[ -f $(PRODRELPATH)/../{{ name }}_config/advanced.config ] || cp $(PRODRELPATH)/etc/advanced.config  $(PRODRELPATH)/../{{ name }}_config/advanced.config

prod-console:
	cd $(PRODRELPATH) && ./bin/{{ name }} console

compile:
	$(REBAR) compile

clean:
	$(REBAR) clean

test:
	$(REBAR) ct

devrel1:
	$(REBAR) as dev1 release

devrel2:
	$(REBAR) as dev2 release

devrel3:
	$(REBAR) as dev3 release

devrel: devrel1 devrel2 devrel3

dev1-console:
	$(BASEDIR)/_build/dev1/rel/{{ name }}/bin/$(APPNAME) console

dev2-console:
	$(BASEDIR)/_build/dev2/rel/{{ name }}/bin/$(APPNAME) console

dev3-console:
	$(BASEDIR)/_build/dev3/rel/{{ name }}/bin/$(APPNAME) console

devrel-start:
	for d in $(BASEDIR)/_build/dev*; do $$d/rel/{{ name }}/bin/$(APPNAME) start; done

devrel-status:
	for d in $(BASEDIR)/_build/dev*; do $$d/rel/{{ name }}/bin/$(APPNAME)-admin cluster members; done

devrel-join:
	for d in $(BASEDIR)/_build/dev{2,3}; do $$d/rel/{{ name }}/bin/$(APPNAME)-admin cluster join {{ name }}1@127.0.0.1; done
	for d in $(BASEDIR)/_build/dev{1,3}; do $$d/rel/{{ name }}/bin/$(APPNAME)-admin cluster join {{ name }}2@127.0.0.1; done
	for d in $(BASEDIR)/_build/dev{1,2}; do $$d/rel/{{ name }}/bin/$(APPNAME)-admin cluster join {{ name }}3@127.0.0.1; done

devrel-ping:
	for d in $(BASEDIR)/_build/dev*; do $$d/rel/{{ name }}/bin/$(APPNAME) ping; done

devrel-stop:
	for d in $(BASEDIR)/_build/dev*; do $$d/rel/{{ name }}/bin/$(APPNAME) stop; done

start:
	$(BASEDIR)/$(RELPATH)/bin/$(APPNAME) start

stop:
	$(BASEDIR)/$(RELPATH)/bin/$(APPNAME) stop

attach:
	$(BASEDIR)/$(RELPATH)/bin/$(APPNAME) attach

