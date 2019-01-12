""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Projectionist Heuristics
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:projectionist_heuristics = {
  \ "deps/&mix.exs": {
  \    "*/lib/*.ex": {
  \    "alternate": "*/test/{}_test.exs",
  \    "type": "source"
  \    },
  \    "test/*_test.exs": {
  \    "alternate": "lib/{}.ex",
  \    "type": "test"
  \     },
  \ },
  \ "src/&package.json": {
  \    "*/src/*.tsx": {
  \    "alternate": "*/src/{}.test.tsx",
  \    "type": "source"
  \    },
  \    "*/src/*.test.tsx": {
  \    "alternate": "*/src/{}.tsx",
  \    "type": "test"
  \     },
  \ },
  \ "Gemfile&test/": {
  \    "lib/*.rb": {
  \    "alternate": "test/{}_test.rb",
  \    "type": "source"
  \    },
  \    "test/*_test.rb": {
  \    "alternate": "lib/{}.rb",
  \    "type": "test"
  \     },
  \ },
  \ "Gemfile&spec/": {
  \    "lib/*.rb": {
  \    "alternate": "spec/{}_spec.rb",
  \    "type": "source"
  \    },
  \    "spec/*_spec.rb": {
  \    "alternate": "lib/{}.rb",
  \    "type": "test"
  \     },
  \ },
  \}

