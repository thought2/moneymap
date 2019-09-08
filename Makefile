APP_ENTRY=html/index.html
PATH := $(PATH):node_modules/.bin

prettier := prettier $options --ignore-path .gitignore '**/*.+(json|ts|html)'
elm-format := elm-format $options --elm-version=0.19 elm/src elm/tests


# Production build
build:
	parcel build $(APP_ENTRY)

# Install dependencies
install:
	npm install

# Hot reloading development
dev:
	parcel $(APP_ENTRY)

# Serve module docs
docs:
	cd elm; \
	elm-doc-preview --no-browser;

# Generate tests from documentation examples
gen-example-tests:
	cd elm; \
	elm-verify-examples; \
	elm-format --yes tests/VerifyExamples;

# Run the test suite
test: test-ts test-elm

# Run the Elm test suite
test-elm:
	cd elm; elm-verify-examples
	cd elm; elm-test

# Run the TypeScript test suite
test-ts:
	npx mocha 'ts/tests/**' --require ts-node/register

# Scrape data from `opensecrets.org`
scrape:
	OUT_PATH=data/opensecrets.json ts-node ts/scr/Scraper/index.ts

# Run the test suite in watch mode
test-watch:
	watch 'make test' elm/src elm/tests/Tests

# Generate typescript types from elm ports
gen-ts:
	elm-typescript-interop

# Format code
format:
	$(elm-format:$options=--yes)
	$(prettier:$options=--write)

# Checks if code is formatted correctly
check-format:
	$(elm-format:$options=--validate)
	$(prettier:$options=--check)

# Clean dependency directories
clean:
	rm -rf node_modules
	rm -rf elm/elm-stuff

# Generate Nix expressions for CI and deployment
gen-nix: clean gen-example-tests
        # Unfortunately this hack is needed
	bash sh/node2nix.sh

        # Unfortunately `elm2nix` is not yet distributed via NPM
	cd elm; \
	elm2nix convert > elm-srcs.nix; \
	elm2nix snapshot > versions.dat; \
	mv elm-srcs.nix versions.dat --target ../nix/elm2nix

# Product build using Nix
build-nix:
	bash sh/nix-build.sh

# Checks format and tests
check: check-format test
