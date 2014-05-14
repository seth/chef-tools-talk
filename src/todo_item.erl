-module(todo_item).

-behaviour(sqerl_rec).

-export([
         '#insert_fields'/0,
         '#update_fields'/0,
         '#statements'/0
        ]).

-compile({parse_transform, exprecs}).
-export_records([todo_item]).

-record(todo_item, {
            id          :: integer()
          , title       :: binary()
          , description :: binary()
          , priority    :: integer()
          , created_at  :: binary()
          , created_by  :: binary()
         }).

'#insert_fields'() ->
    [title,
     description,
     priority,
     created_by
    ].

'#update_fields'() ->
    [title,
     description,
     priority].

'#statements'() ->
    [default,
     {fetch_by_title, sqerl_rec:gen_fetch(todo_item, title)},
     {fetch_page, sqerl_rec:gen_fetch_page(todo_item, title)},
     {fetch_all, sqerl_rec:gen_fetch_all(todo_item, title)}
    ].
