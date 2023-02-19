#!/bin/bash

npx redoc-cli build api-spec.json
mv redoc-static.html index.html

# Might make the favicon work
sed -i '7 i \ \ <link rel="icon" type="image/png" href="/img/favicon.png"/>' index.html
