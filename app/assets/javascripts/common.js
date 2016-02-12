// Initialize notie
var readyStateCheckInterval = setInterval(function() {
  if (document.readyState === "complete") {
      clearInterval(readyStateCheckInterval);
      window.notie = notieInit();
  }
}, 10);

// Promt when navigating away from page
// with un-saved form
$('form').areYouSure();
