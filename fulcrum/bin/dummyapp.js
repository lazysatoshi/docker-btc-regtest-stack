/*
  A dummy app for keeping a docker container running, so that I log into it
  and debug.
*/

"use strict"

setInterval(function() {
  const now = new Date()
  console.log(`Timestamp: ${now.toLocaleString()}`)
}, 60000)

