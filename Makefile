# Basic Usage:
#
# 1. Install dependencies
# > make install             # installs dependencies for all projects
# > make install-globals     # installs global dependencies such as webpack
# > make install-todo
# > make install-randomuser
# > make install-matchevents
#
# 2. Compile projects
# > make compile             # Compiles all projects
# > make compile-todo				 # Compiles todo project
# > make compile-randomuser  # Compiles randomuser project
# > make compile-matchevents # Compiles matchevents project
#
# 3. Serve given project
# > make serve-todo          # Serves todo project under http://localhost:8765/webpack-dev-server
# > make serve-randomuser    # Serves randomuser project under http://localhost:8765/webpack-dev-server
# > make serve-matchevents   # Serves matchevents project under http://localhost:8765/webpack-dev-server
#
# 4. All in one (shortcut)
# > make todo                # Installs all dependencies, compiles and serves under under http://localhost:8765/webpack-dev-server
# > make randomuser          # Installs all dependencies, compiles and serves under under http://localhost:8765/webpack-dev-server
# > make matchevents         # Installs all dependencies, compiles and serves under under http://localhost:8765/webpack-dev-server

WEBPACK := node_modules/.bin/webpack
WEBPACK_DEV_SERVER := node_modules/.bin/webpack-dev-server

install: install-globals install-todo install-randomuser install-matchevents
compile: compile-todo compile-randomuser compile-matchevents


# Addresses both webpack and webpack-dev-server
$(WEBPACK):
	  npm install --no-progress

# Alias
install-globals: $(WEBPACK)


install-todo: install-globals
		cd todo && npm install --no-progress

install-randomuser: install-globals
		cd randomuser && npm install --no-progress

install-matchevents: install-globals
		cd match-events && npm install --no-progress


compile-todo:
		cd todo && ../$(WEBPACK)

compile-randomuser:
		cd randomuser && ../$(WEBPACK)

compile-matchevents:
		cd match-events && ../$(WEBPACK)


serve-todo:
		cd todo && ../$(WEBPACK_DEV_SERVER) --port 8765

serve-randomuser:
		cd randomuser && ../$(WEBPACK_DEV_SERVER) --port 8765

serve-matchevents:
		cd match-events && ../$(WEBPACK_DEV_SERVER) --port 8765


todo: install-todo serve-todo

randomuser: install-randomuser serve-randomuser

matchevents: install-matchevents serve-matchevents


# .PHONY: install install-todo install-randomuser install-matchevents todo randomuser matchevents
