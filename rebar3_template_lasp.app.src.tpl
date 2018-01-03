%% -*- erlang -*-
{application, {{ name }},
 [
  {description, "A Lasp Application"},
  {vsn, "1"},
  {registered, []},
  {applications, [
                  kernel,
                  stdlib,
                  sasl,
                  lasp
                 ]},
  {mod, { {{ name }}_app, []}},
  {env, []}
 ]}.
