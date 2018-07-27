""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Projectionist Heuristics  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:projectionist_heuristics = {
  \ "lib/&deps/&mix.exs": {
  \    "lib/*.ex": {
  \    "alternate": "test/{}_test.exs",
  \    "type": "source"
  \    },
  \    "/test/*_test.exs": {
  \    "alternate": "lib/{}.ex",
  \    "type": "test"
  \     },
  \ }}

