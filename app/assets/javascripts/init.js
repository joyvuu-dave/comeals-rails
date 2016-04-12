// Initialize notie
var readyStateCheckInterval = setInterval(function() {
  if (document.readyState === "complete") {
      clearInterval(readyStateCheckInterval)
      window.notie = notieInit()
  }
}, 10)


// Promt when navigating away from page
// with un-saved form
$('form').areYouSure();


// Add helper class to checkboxes that start out checked
$('input[type=checkbox]').each(function() {
  if(this.checked) {
    $(this).addClass("js-originally-checked")
  }
})


// Add stikethrough when a user de-selects a checkbox
$('input[type=checkbox]').on('click',
  function(e) {
    if(e.target.checked) {
      $(e.target).siblings().css("text-decoration", "none")
    }

    if(!e.target.checked && $(e.target).hasClass("js-originally-checked")) {
      $(e.target).siblings().css("text-decoration", "line-through")
    }
  }
)

$(function() {
  return $('.js-submit-meal').click(function(e) {
    var active_guests, guests, max, num_checked, re;

    e.preventDefault();
    e.stopPropagation();

    max = $('#meal_max').val().trim();
    re = /^[0-9]*$/;

    if (!(max.match(re) && max >= 0 && max <= 21474836)) {
      notie.alert(3, 'Invalid max', 2.5);
    }

    num_checked = 0;

    $('input[type=checkbox]').each(function() {
      if (this.checked) {
        return num_checked += 1;
      }
    });

    active_guests = 0;

    guests = $('.js-guest').each(function() {
      if ($(this).is(':visible')) {
        return active_guests += 1;
      }
    });

    if (max && (num_checked + active_guests) > max) {
      return notie.alert(3, 'Max number of people reached', 2.5);
    } else {
      return $('form').submit();
    }
  });
});
