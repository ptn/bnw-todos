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

  var toggleSubmitBtn = function(ctrl) {
    var submit_btn = $(":submit", $(ctrl.form));
    if ($(ctrl).val() == "")
      submit_btn.attr("disabled", "1");
    else
      submit_btn.removeAttr("disabled");
  }

  window.clearNewTodoForm = function(form) {
    $(":input", form).each(function() {
      if (this.type != "hidden" && this.type != "submit") {
        $(this).val('');
        if (this.type == "select-one") {
          var def = $("[selected='selected']", $(this)).val();
          $(this).val(def);
        }
      }
    });
    toggleSubmitBtn($(":input", form));
  };


  window.bindList = function(list) {
    $(".toggle-done", list).click(function() {
      toggleSection(this, $(this).next("ul"), "Show", "Hide");
    });

    $(".toggle-add", list).click(function() {
      var form_div = $(".new-todo-form", $(this).parents(".list"));
      form_div.show();
      $(".task :text", form_div).focus();
      $(this).hide();
    });

    $(".cancel-add-todo", list).click(function() {
      var form_div = $(this).parents(".new-todo-form");
      form_div.hide();
      clearNewTodoForm($(" > form", form_div));
      $(".toggle-add", form_div.parents(".list")).show();
    });

    $(".new-todo-form .task :text", list).keyup(function() {
      toggleSubmitBtn(this);
    });

    //$(".due-date :text", list).datepicker();
  };

  $(".list").each(function(idx, list) { bindList($(list)); });


  window.bindTodo = function(todo) {
    todo.hover(function() {
      if (!$(this).hasClass("editing")) {
        $(" > .todo-controls-left", $(this)).show();
        $(" > .todo-controls-done", $(this)).show();
      }
    }, function() {
      $(" > .todo-controls-left", $(this)).hide();
      $(" > .todo-controls-done", $(this)).hide();
    });

    $(".start-edit-todo", todo).click(function() {
      var edit_form = $(".edit-todo-form", $(this).parents(".todo"));
      var toggle_form = $(".toggle-todo-form", $(this).parents(".todo"));
      var todo = $(this).parents(".todo");
      toggle_form.hide();
      edit_form.show();
      $(".task :text", edit_form).focus();
      todo.addClass("editing");
      $(" > .todo-controls-left", todo).hide();
      $(" > .todo-controls-done", todo).hide();
    });

    $(".cancel-edit-todo", todo).click(function() {
      $(this).parents(".edit-todo-form").hide();
      var todo = $(this).parents(".todo");
      var toggle_form = $(".toggle-todo-form", todo);
      toggle_form.show();
      todo.removeClass("editing");
    });

    //$(".due-date :text", todo).datepicker();
  };

  $(".todo").each(function(idx, todo) { bindTodo($(todo)); });


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
