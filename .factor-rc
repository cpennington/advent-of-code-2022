USING: parser vocabs vocabs.loader sequences namespaces tools.scaffold
environment ;
vocab-roots [ "." suffix ] change
{ "sequences.extras" "assocs.extras" "grouping.extras"
  "advent" } [ require ] each
"AUTHOR" os-env developer-name set-global
auto-use
