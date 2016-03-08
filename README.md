# Elm Playground

[Elm Language](http://elm-lang.org/) playground repository is supposed to consist of tiny projects that are easy to scan and reason about so that everybody can learn the language quickly by example. More about the project [at the bottom of this readme](#explanation).

## How to set things up

* First, make sure you install [elm-lang](http://elm-lang.org/) and [node.js](https://nodejs.org/en/)
* Second, enter project directory, e.g. `cd randomuser`
* Third, run `npm run setup` so that all dependencies are installed
* Last:
    * Run `npm run dev` so that you can preview the app in developer mode under http://localhost:8765 and http://localhost:8765/webpack-dev-server/ urls
    * Run `npm run prod` so you compile elm code for production use - can be previewed once you open `index.html` file in your browser

## Projects Listing:

### Random User API Integration

* Directory: `randomuser`
* Setup & Run Dev: `cd randomuser && npm run setup && npm run dev`
* Open Dev Preview: `npm run opendev`
* Project:

![](http://g.recordit.co/94PCJSeeES.gif)

### Simple Todo List

* Directory: `todo/`
* Setup & Run Dev: `cd todo && npm run setup && npm run dev`
* Open Dev Preview: `npm run opendev`
* Project:

![](http://g.recordit.co/fzYv2K9WMG.gif)

## Explanation

This repository is meant to be a playground so that everybody can learn the language, break things, change things or even improve them.

Feel free to create pull requests if you find these examples useful. Also, please let me know if you find them too easy or too complex or not interesting at all.

Thanks for the interest and taking your time to visit the repository!
