window.addEventListener('load', function(){

    const loginBtn = document.querySelector('.login-btn');
    const logoutBtn = document.querySelector('.logout-btn');
    const exitBtn = document.querySelector('.exit-btn');
    const modal = document.querySelector('#login');

    loginBtn.onclick = function () {
        if(modal.classList.contains('hidden'))
            modal.classList.remove('hidden')
        else
            modal.classList.add('hidden')
    }

    exitBtn.onclick = function () {
        modal.classList.add('hidden')
    }

    logoutBtn.onclick = function () {
        location.href = "logout.jsp"
    }

    // includeHTML();

    // form json 형식으로 받기
    // const form = document.querySelector('#join-form');
    
    // form.addEventListener('submit', (e) => {
    //     e.preventDefault();
    //     var payload = new FormData(form);
    //     var formArr = [...payload];
        
    // });

});

function open() {

}


function includeHTML(callback) {
    var z, i, elmnt, file, xhr;
    /*loop through a collection of all HTML elements:*/
    z = document.getElementsByTagName("*");
    for (i = 0; i < z.length; i++) {
      elmnt = z[i];
      /*search for elements with a certain atrribute:*/
      file = elmnt.getAttribute("include-html");
      //console.log(file);
      if (file) {
        /*make an HTTP request using the attribute value as the file name:*/
        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
          if (this.readyState == 4) {
            if (this.status == 200) {
              elmnt.innerHTML = this.responseText;
            }
            if (this.status == 404) {
              elmnt.innerHTML = "Page not found.";
            }
            /*remove the attribute, and call this function once more:*/
            elmnt.removeAttribute("include-html");
            includeHTML(callback);
          }
        };
        xhr.open("GET", file, true);
        xhr.send();
        /*exit the function:*/
        return;
      }
    }
    setTimeout(function() {
      callback();
    }, 0);
  }