// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  var toggleSection = function(link, target, show_text, hide_text) {
    target.toggle();
    if (target.css("display") == "none")
      $(link).text(show_text);
    else
      $(link).text(hide_text);
  };

  $(".list .toggle-done").click(function() {
    toggleSection(this, $(this).next("ul"), "Show", "Hide");
  });

  $(".new-todo-form .field :text").keyup(function() {
    var submit_btn = $(":submit", $(this.form));
    if ($(this).val() == "")
      submit_btn.attr("disabled", "1");
    else
      submit_btn.removeAttr("disabled");
  });

  $(".list .toggle-add").click(function() {
    // Refactor: this JS function knows too much about the DOM structure, should decouple.
    var form_div = $(this).parent().next(".new-todo-form");
    toggleSection(this, form_div, "Add a todo", "Cancel");
    var task_field = $(".field :text", form_div);
    task_field.focus();
  });

  $(".list .cancel-add-todo").click(function() {
    var form_div = $(this).parents(".new-todo-form");
    form_div.hide();
    // Refactor: this JS function knows too much about the DOM structure, should decouple.
    form_div.prev(".list-utils").children(".toggle-add").text("Add a todo");
  });
});
