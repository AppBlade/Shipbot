/*!
 * jQuery.sexyPost v1.0.0
 * http://github.com/jurisgalang/jquery-sexypost
 *
 * Copyright 2010 - 2011, Juris Galang
 * Dual licensed under the MIT or GPL Version 2 licenses.
 *
 * Date: Sat June 26 14:20:01 2010 -0800
 */
(function($){
  $.fn.sexyPost = function(options) {
    var events = [ "start", "progress", "complete", "error", "abort", "filestart", "filecomplete" ];
    var config = {
      // options
      async        : true,                                     // set to true to submit the form asynchronously
      autoclear    : false,                                    // automatically clear the form on successful post
      requestHeader: null,                                     // additional request headers to send

      // events
      start   : function(event) { },                           // triggered right before the form is submitted
      progress: function(event, completed, loaded, total) { }, // repeatedly triggered while the form is being submitted
      complete: function(event, responseText) { },             // triggered after the form has been fully submitted
      error   : function(event) { },                           // triggered if an error occurs during submission
      abort   : function(event) { }                            // triggered if an abort() signal is received
    };

    if (options) $.extend(config, options);

    this.each(function(){
      for (event in events) {
        if (config[events[event]]) {
          $(this).bind("sexyPost." + events[event], config[events[event]]);
        }
      }

      // override default submit event for the form to use the plugins own post function.
      var form = $(this);

      form.submit(function(){
        var action = $(this).prop("action");
        var method = $(this).prop("method");
        send(this, action, method, config.async);
        return false;
      });

      // controls may trigger form submission if tagged with the submit-trigger class
      $(".submit-trigger", form).not(":button")
        .bind("change", function(){ form.trigger("submit"); });

      $(".submit-trigger", form).not(":input")
        .bind("click", function(){ form.trigger("submit"); });

      // create request object and configure event handlers
      var xhr = new XMLHttpRequest();

      xhr.onloadstart = function(event) {
        form.trigger("sexyPost.start");
      }

      xhr.onload = function(event) {
        if (config.autoclear && (xhr.status >= 200) && (xhr.status <= 204)) clearFields(form);
        form.trigger("sexyPost.complete", [xhr.responseText, xhr.status]);
      }

      xhr.onerror = function(event) {
        form.trigger("sexyPost.error");
      }

      xhr.onabort = function(event) {
        form.trigger("sexyPost.abort");
      }

      xhr.upload["onprogress"] = function(event) {
        var completed = event.loaded / event.total;
        form.trigger("sexyPost.progress", [completed, event.loaded, event.total]);
      }

      // this function will clear all the fields in a form
      function clearFields(form) {
        $(":input", form)
          .not(":button, :submit, :reset, :hidden")
          .removeAttr("checked").removeAttr("selected").val("");
      }

      // this function will POST the contents of the selected form via XmlHttpRequest.
      function send(form, action, method, async) {
        var data = new FormData();

        var fields = $(form).serializeArray();
        $.each(fields, function(index, field){
          data.append(field.name, field.value)
        });

        $("input:file", form).each(function(){
          var files = this.files;
          for (i=0; i<files.length; i++) data.append($(this).prop("name"), files[i]);
        });

        // configure the request headers
        xhr.open(method, action, async);
        if (config.requestHeader) {
          for (var key in config.requestHeader) {
             xhr.setRequestHeader(key, config.requestHeader[key]);
          }
        }
        xhr.setRequestHeader("Cache-Control", "no-cache");
        xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

        // send the serialized fields over
        xhr.send(data);
      }
    });

    return this;
  }
})(jQuery);
