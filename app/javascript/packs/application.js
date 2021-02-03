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

  $multiSelectButton.click(submitAnswers);

  $("#answers.unanswered li").click(function () {
    $(this).toggleClass("selected");
    if (isMultiSelect) {
      $multiSelectButton.fadeIn();
    } else {
      submitAnswers();
    }
  });

  function submitAnswers() {
    $multiSelectButton.hide();
    $("#answers li").unbind("click");
    sendAnswersToServer(function(response) {
      $("#explanation").fadeIn(250);
      $("#answers").addClass("answered");
    });
  }

  function sendAnswersToServer(success) {
    answer_ids = $(".selected").map(function (i, li) {
      return $(li).data("answer-id");
    }).toArray();
    question_id = $("#answers").data("question-id");
    data = {answer_ids: answer_ids};
    $.post("/public/answer/" + question_id, data, success);
  };
});
