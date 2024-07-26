# Contributors to Reality API

## What you need to know?

You need at least AOS 2.0.0 rc1 - `npm i -g https://preview_ao.g8way.io`
You need the latest version of node v22.4

## Project Structure

The `src` folder contains all the code for the api, the code is separated by
domains, each domain starts with a `capital` letter. The main project file is `api.lua`.

The two current api domains are `world` and `agent`. 

## How to test

1. Bundle lua - `node bundle.js`
2. Create/Open aos process with sqlite - `aos test --sqlite`
3. `.load test.lua`

## How to publish

1. Bundle lua - `node bundle.js`
2. https://apm_betteridea.g8way.io
