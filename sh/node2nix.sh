JQ_EXPR='del(.dependencies["elm-format", "elm-test", "elmi-to-json", "elm-verify-examples"])'


jq "$JQ_EXPR" package.json > tmp-package.json
jq "$JQ_EXPR" package-lock.json > tmp-package-lock.json


node2nix --nodejs-10 \
	 --lock tmp-package-lock.json \
	 --input tmp-package.json \
         --composition nix/node2nix/default.nix \
         --output nix/node2nix/node-packages.nix \
         --node-env nix/node2nix/node-env.nix


rm tmp-package.json tmp-package-lock.json
