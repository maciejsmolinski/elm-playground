# Basic Usage:
#
# 1. Install dependencies
# > make install             # installs dependencies for all projects
# > make install-globals     # installs global dependencies such as webpack
# > make install-todo
# > make install-randomuser
# > make install-matchevents
# > make install-spotifymini
#
# 2. Compile projects
# > make compile             # Compiles all projects
# > make compile-todo				 # Compiles todo project
# > make compile-randomuser  # Compiles randomuser project
# > make compile-matchevents # Compiles matchevents project
# > make compile-spotifymini # Compiles spotifymini project
#
# 3. Serve given project
# > make serve-todo          # Serves todo project under http://localhost:8765/webpack-dev-server
# > make serve-randomuser    # Serves randomuser project under http://localhost:8765/webpack-dev-server
# > make serve-matchevents   # Serves matchevents project under http://localhost:8765/webpack-dev-server
# > make serve-spotifymini   # Serves spotifymini project under http://localhost:8765/webpack-dev-server
#
# 4. All in one (shortcut)
# > make todo                # Installs all dependencies, compiles and serves under under http://localhost:8765/webpack-dev-server
# > make randomuser          # Installs all dependencies, compiles and serves under under http://localhost:8765/webpack-dev-server
# > make matchevents         # Installs all dependencies, compiles and serves under under http://localhost:8765/webpack-dev-server
# > make spotifymini         # Installs all dependencies, compiles and serves under under http://localhost:8765/webpack-dev-server

WEBPACK := node_modules/.bin/webpack
WEBPACK_DEV_SERVER := node_modules/.bin/webpack-dev-server

install: install-globals install-todo install-randomuser install-matchevents install-spotifymini
compile: compile-todo compile-randomuser compile-matchevents compile-spotifymini


# Addresses both webpack and webpack-dev-server
$(WEBPACK):
	  npm install --no-progress

# Alias
install-globals: $(WEBPACK)


install-todo: install-globals
		cd todo && npm install --no-progress

install-randomuser: install-globals
		cd randomuser && npm install --no-progress && elm package install -y

install-matchevents: install-globals
		cd match-events && npm install --no-progress && elm package install -y

install-spotifymini: install-globals
		cd spotify-mini && npm install --no-progress && elm package install -y


compile-todo:
		cd todo && ../$(WEBPACK)

compile-randomuser:
		cd randomuser && ../$(WEBPACK)

compile-matchevents:
		cd match-events && ../$(WEBPACK)

compile-spotifymini:
		cd spotify-mini && ../$(WEBPACK)


serve-todo:
		cd todo && ../$(WEBPACK_DEV_SERVER) --port 8765

serve-randomuser:
		cd randomuser && ../$(WEBPACK_DEV_SERVER) --port 8765

serve-matchevents:
		cd match-events && ../$(WEBPACK_DEV_SERVER) --port 8765

serve-spotifymini:
		cd spotify-mini && ../$(WEBPACK_DEV_SERVER) --port 8765


todo: install-todo serve-todo

randomuser: install-randomuser serve-randomuser

matchevents: install-matchevents serve-matchevents

spotifymini: install-spotifymini serve-spotifymini

clean:
	rm -rf node_modules && \
	rm -rf todo/elm-stuff && \
	rm -rf todo/node_modules && \
	rm -rf todo/js/bundle.js && \
	rm -rf randomuser/elm-stuff && \
	rm -rf randomuser/node_modules && \
	rm -rf randomuser/js/bundle.js && \
	rm -rf match-events/elm-stuff && \
	rm -rf match-events/node_modules && \
	rm -rf match-events/js/bundle.js && \
	rm -rf spotify-mini/elm-stuff && \
	rm -rf spotify-mini/node_modules && \
	rm -rf spotify-mini/js/bundle.js \

# .PHONY: install install-todo install-randomuser install-matchevents todo randomuser matchevents
