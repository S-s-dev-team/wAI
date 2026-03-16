.PHONY: wire build

wire:
	wire ./registry/

build: wire
	go build -o server ./cmd/server/
