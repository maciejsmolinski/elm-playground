# Elm Playground

[Elm Language](http://elm-lang.org/) playground repository is supposed to consist of tiny projects that are easy to scan and reason about so that everybody can learn the language quickly by example. More about the project [at the bottom of this readme](#explanation).

Demos: http://elm-playground.maciejsmolinski.com/

## Projects Listing:

Please note [elm-lang](http://elm-lang.org/) and [node.js](https://nodejs.org/en/) must be present on your machine to play around with the projects.

### Spotify Mini

* Demo: http://elm-playground.maciejsmolinski.com/spotify-mini/
* Clone the repo `git clone https://github.com/maciejsmolinski/elm-playground.git && cd elm-playground`
* Install all dependencies, compile and run server: `make spotifymini` (or if already installed `make serve-spotifymini`)
* View the project [http://localhost:8765/webpack-dev-server/](http://localhost:8765/webpack-dev-server/) in browser

![](https://placehold.it/300x200?text=Spotify+Mini)

### Match Events (WebWorkers and EventSource integration)

* Demo: http://elm-playground.maciejsmolinski.com/match-events/
* Clone the repo `git clone https://github.com/maciejsmolinski/elm-playground.git && cd elm-playground`
* Install all dependencies, compile and run server: `make matchevents` (or if already installed `make serve-matchevents`)
* View the project [http://localhost:8765/webpack-dev-server/](http://localhost:8765/webpack-dev-server/) in browser
* If you want to use `EventSource`, run node.js server that serves match events in a separate terminal window `cd match-events && node server.js` and uncomment `sse = new Worker('js/sse.js');` in `js/index.js` file to use Server Sent Events by the application

![](https://cdn.pbrd.co/images/2jOEmm9Z.gif)

### Random User API Integration

* Demo: http://elm-playground.maciejsmolinski.com/randomuser/
* Clone the repo `git clone https://github.com/maciejsmolinski/elm-playground.git && cd elm-playground`
* Install all dependencies, compile and run server: `make randomuser` (or if already installed `make serve-randomuser`)
* View the project [http://localhost:8765/webpack-dev-server/](http://localhost:8765/webpack-dev-server/) in browser

![](https://cdn.pbrd.co/images/2dcPR5Z8.gif)

### Simple Todo List

* Demo: http://elm-playground.maciejsmolinski.com/todo/
* Clone the repo `git clone https://github.com/maciejsmolinski/elm-playground.git && cd elm-playground`
* Install all dependencies, compile and run server: `make todo` (or if already installed `make serve-todo`)
* View the project [http://localhost:8765/webpack-dev-server/](http://localhost:8765/webpack-dev-server/) in browser

![](https://cdn.pbrd.co/images/2deeSDdY.gif)

## Explanation

This repository is meant to be a playground so that everybody can learn the language, break things, change things or even improve them.

Feel free to create pull requests if you find these examples useful. Also, please let me know if you find them too easy or too complex or not interesting at all.

Thanks for the interest and taking your time to visit the repository!

## Stay in Touch

Have questions? Raise an [issue](https://github.com/maciejsmolinski/elm-playground/issues) or contact me on twitter: [@maciejsmolinski](https://twitter.com/maciejsmolinski)
