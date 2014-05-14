-module(todo_tests).

-include_lib("eunit/include/eunit.hrl").

todo_test_() ->
    {setup,
     fun() ->
             %% application:set_env(sqerl, log_statements, true)
             error_logger:tty(false),
             todo_test_helper:setup_db()
     end,
     fun(_) ->
             todo_test_helper:stop_db()
     end,
     [
      {"todo_item basic db functions",
       fun() ->
               [] = sqerl_rec:fetch_all(todo_item),

               %% create a todo_item and insert it
               Item0 = todo_item:'#fromlist-todo_item'([{title, <<"write tests">>},
                                                        {priority, <<"hot">>},
                                                        {description, <<"lorup ipsum">>},
                                                        {created_by, <<"me">>}
                                                       ]),
               [Item1] = sqerl_rec:insert(Item0),

               %% we get the inserted object back and so have access
               %% to the synthetic ID created by the DB.
               ?assert(is_integer(todo_item:'#get-'(id, Item1))),

               %% update the description
               NewDesc0 = todo_item:'#set-'([{description, <<"use enit">>}], Item1),
               %% again we get the updated object back so db managed
               %% fields are correct, no extra round trip.
               [NewDesc] = sqerl_rec:update(NewDesc0),

               [NewDesc] = sqerl_rec:fetch(todo_item, title, <<"write tests">>),

               sqerl_rec:fetch_all(todo_item),
               sqerl_rec:delete(NewDesc, id),

               [] = sqerl_rec:fetch_all(todo_item)
       end}
      ]}.

