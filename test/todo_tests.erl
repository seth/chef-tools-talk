-module(todo_tests).

-include_lib("eunit/include/eunit.hrl").

todo_test_() ->
    {setup,
     fun() ->
             ok
     end,
     fun(_) ->
             ok
     end,
     [
      {"todo is alive",
       fun() ->
               %% format is always: expected, actual
               ?assertEqual(howdy, todo:hello())
       end}
      ]}.

