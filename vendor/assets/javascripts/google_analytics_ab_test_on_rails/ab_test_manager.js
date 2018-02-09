document.addEventListener("DOMContentLoaded", function(){
  var ab_test_manager_toggle_btn = document.getElementById('js_ab_test_manager_toggle_btn');
  ab_test_manager_toggle_btn.addEventListener('click', function (e) {
    var ab_test_manager_main_window = document.getElementById('ab_test_manager_main_window');
    if(ab_test_manager_main_window.style.display == 'none'){
      ab_test_manager_main_window.style.display = 'block';
    }else{
      ab_test_manager_main_window.style.display = 'none';
    }

    var btn_text = ab_test_manager_toggle_btn.innerText
    if(btn_text.indexOf('▲') > 0){
      btn_text = btn_text.replace("▲", "▼");
    }else{
      btn_text = btn_text.replace("▼", "▲");
    }
    var html = '<div style="font-size: 0.7em; color: rgba(185,209,212,0.9); top: -16px; position: absolute;">' + btn_text + '</div>'
    ab_test_manager_toggle_btn.innerHTML = html;
  });
});
