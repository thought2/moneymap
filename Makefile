ENTRY=html/index.html

# Install dependencies
install:
	npm install

# Production build
build:
        # Because elm-typescript-interop installs elm 18 and `parcel` uses it then
	rm -rf node_modules/elm

	npx parcel build $(ENTRY)

# Hot reloading development
dev:
	npx parcel $(ENTRY)

docs:
	npx -c 'cd elm; elm-doc-preview -n'

# Run the test suite
test:
	npx elm-test

# Generate typescript types from elm ports
gen-ts:
	npx elm-typescript-interop
