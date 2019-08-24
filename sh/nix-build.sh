JQ_EXPR='del(.dependencies["elm-format", "elm-test", "elmi-to-json", "elm-verify-examples"])'

DIR=$(pwd)
TMP=$(mktemp -d)

cp -rT . $TMP

cd $TMP

jq "$JQ_EXPR" $DIR/package.json > $TMP/package.json
jq "$JQ_EXPR" $DIR/package-lock.json > $TMP/package-lock.json

nix-build nix/default.nix

mv result -t $DIR
