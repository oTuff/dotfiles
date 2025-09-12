help:
	@echo "Available targets:"
	@grep '^[^ ]*:.*#' Makefile | awk -F'[:#]' '{printf "  %-20s %s\n", $$1, $$3}'
.PHONY: help

switch: # Apply configuration
	home-manager switch --flake . --impure
.PHONY: switch

update: # Update flake
	nix flake update
	$(MAKE) switch
.PHONY: update

clean: # Clean the nix store
	nix-store --gc
.PHONY: clean
