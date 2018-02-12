document.addEventListener("DOMContentLoaded", function(){
  var js_ab_test_manager_close_btn = document.getElementById('js_ab_test_manager_close_btn');
  var js_ab_test_manager_open_btn  = document.getElementById('js_ab_test_manager_open_btn');
  js_ab_test_manager_close_btn.addEventListener('click', function (e) {
    var ab_test_manager_main_window = document.getElementById('ab_test_manager_main_window');
    ab_test_manager_main_window.style.display  = 'none';
    js_ab_test_manager_close_btn.style.display = 'none';
    js_ab_test_manager_open_btn.style.display  = 'block';
  });
  js_ab_test_manager_open_btn.addEventListener('click', function (e) {
    var ab_test_manager_main_window = document.getElementById('ab_test_manager_main_window');
    ab_test_manager_main_window.style.display  = 'block';
    js_ab_test_manager_close_btn.style.display = 'block';
    js_ab_test_manager_open_btn.style.display  = 'none';
  });
});
