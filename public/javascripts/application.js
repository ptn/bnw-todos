// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  var clearNewTodoForm = function(form) {
    $(":input", form).each(function() {
      if (this.type != "hidden" && this.type != "submit") {
        $(this).val('');
        if (this.type == "select-one") {
          var def = $("[selected='selected']", $(this)).val();
          $(this).val(def);
        }
      }
    });
  };

  var toggleSection = function(link, target, show_text, hide_text) {
    target.toggle();
    if (target.css("display") == "none")
      $(link).text(show_text);
    else
      $(link).text(hide_text);
  };

  var toggleSubmitBtn = function(ctrl) {
    var submit_btn = $(":submit", $(ctrl.form));
    if ($(ctrl).val() == "")
      submit_btn.attr("disabled", "1");
    else
      submit_btn.removeAttr("disabled");
  }

  $(".list .toggle-done").click(function() {
    toggleSection(this, $(this).next("ul"), "Show", "Hide");
  });

  $(".new-todo-form .field :text").keyup(function() {
    toggleSubmitBtn(this);
  });

  $(".list .toggle-add").click(function() {
    // Refactor: this JS function knows too much about the DOM structure, should decouple.
    var form_div = $(this).parent().next(".new-todo-form");
    toggleSection(this, form_div, "Add a todo", "Cancel");
    var task_field = $(".field :text", form_div);
    task_field.focus();
    clearNewTodoForm($("> form", form_div));
  });

  $(".list .cancel-add-todo").click(function() {
    var form_div = $(this).parents(".new-todo-form");
    form_div.hide();
    clearNewTodoForm($(" > form", form_div));
    // Refactor: this JS function knows too much about the DOM structure, should decouple.
    form_div.prev(".list-utils").children(".toggle-add").text("Add a todo");
  });

  $(".start-edit-todo").click(function() {
    var edit_form = $(".edit-todo-form", $(this).parents(".todo"));
    var toggle_form = $(".toggle-todo-form", $(this).parents(".todo"));
    var todo = $(this).parents(".todo");
    toggle_form.hide();
    edit_form.show();
    $(":text", edit_form).focus();
    todo.addClass("editing");
    $(" > .todo-controls-left", todo).hide();
    $(" > .todo-controls-done", todo).hide();
  });

  $(".cancel-edit-todo").click(function() {
    $(this).parent().hide();
    var toggle_form = $(".toggle-todo-form", $(this).parents(".todo"));
    var todo = $(this).parents(".todo");
    toggle_form.show();
    todo.removeClass("editing");
  });


  // Hover controls
  $(".todo").hover(function() {
    if (!$(this).hasClass("editing")) {
      $(" > .todo-controls-left", $(this)).show();
      $(" > .todo-controls-done", $(this)).show();
    }
  }, function() {
    $(" > .todo-controls-left", $(this)).hide();
    $(" > .todo-controls-done", $(this)).hide();
  });


  // New list form
  $("#create-list-btn").click(function() {
    $("#new-list-form").show();
    $("#new-list-form :text").focus();
    $(this).hide();
  });

  $(".cancel-create-list").click(function() {
    $("#new-list-form :text").val('');
    $("#new-list-form").hide();
    $("#create-list-btn").show();
  });

  $("#new-list-form :text").keyup(function() {
    toggleSubmitBtn(this);
  });
});
