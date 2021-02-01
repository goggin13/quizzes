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
  $multiSelectButton = $("#multi-select-submit")
  isMultiSelect = $multiSelectButton.length;

  function submitAnswers() {
    $multiSelectButton.hide();
    $("#explanation").fadeIn(250);
    $("#answers li").addClass("answered");
  }

  $multiSelectButton.click(submitAnswers);

  $("#answers li").click(function () {
    $(this).toggleClass("selected");
    if (isMultiSelect) {
      $multiSelectButton.fadeIn();
    } else {
      submitAnswers();
    }
  });
});

function answeredCorrectly($li) {
  return ($li.hasClass("correct") && $li.hasClass("selected"))
    || (!$li.hasClass("correct") && !$li.hasClass("selected"));
}
