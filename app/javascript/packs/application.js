// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')

$(document).on("turbolinks:load", function () {
  console.log("LOAD");
  $("#answers li").click(function () {
    $("#answers").addClass("answered");
    $("#explanation").fadeIn(250);
    $(this).addClass("selected");
    console.log("incorrect!");
  });
  $("#correct").click(function () {
    $("#answers").addClass("answered");
    $("#explanation").fadeIn(250);
    console.log("correct!");
  });
});
