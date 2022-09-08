collection = $(shell pwd)/lint_vs_molecule
cache_base = $(shell pwd)/cache

venv: requirements.txt
	python3 -m venv venv
	venv/bin/python -m pip install -r requirements.txt
	@echo
	@echo You can now activate the virtual environment by running
	@echo ". venv/bin/activate"

molecule_then_lint: export override XDG_CACHE_HOME = $(cache_base)/molecule-then-lint
molecule_then_lint:
	cd $(collection); \
		molecule test; \
		ansible-lint

lint_then_molecule: export override XDG_CACHE_HOME = $(cache_base)/lint-then-molecule
lint_then_molecule:
	cd $(collection); \
		ansible-lint; \
		molecule test

.PHONY: molecule_then_lint lint_then_molecule
