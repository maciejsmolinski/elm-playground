WEBPACK := webpack
WEBPACK_DEV_SERVER := webpack-dev-server


setupglobals: $(WEBPACK) $(WEBPACK_DEV_SERVER)

npm-todo: setupglobals
		cd todo && npm install --no-progress

npm-randomuser: setupglobals
		cd randomuser && npm install --no-progress

npm-matchevents: setupglobals
		cd match-events && npm install --no-progress

todo: npm-todo
	cd todo/ && $(WEBPACK_DEV_SERVER) --port 8765

randomuser: npm-randomuser
	cd randomuser/ && $(WEBPACK_DEV_SERVER) --port 8765

matchevents: npm-matchevents
	cd match-events/ && $(WEBPACK_DEV_SERVER) --port 8765

$(WEBPACK):
		npm install --no-progress -g webpack-dev-server

$(WEBPACK_DEV_SERVER):
		npm install --no-progress -g webpack

.PHONY: npm-todo npm-randomuser npm-matchevents todo randomuser matchevents
