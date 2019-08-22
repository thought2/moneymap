ENTRY=html/index.html

# Install dependencies
install:
	npm install

# Production build
build:
	npx parcel build $(ENTRY)

# Hot reloading development
hot:
	npx parcel $(ENTRY) &

# Serve module docs
docs:
	npx -c 'cd elm; elm-doc-preview'

dev: hot docs

# Run the test suite
test:
	npx -c 'cd elm; elm-verify-examples'
	npx -c 'cd elm; elm-test'

# Generate typescript types from elm ports
gen-ts:
	npx elm-typescript-interop

format:
	npx prettier --write 'elm/**/*.json'
	npx prettier --write 'ts/**/*.+(json|ts)'
	npx prettier --write 'html/**/*.html'
