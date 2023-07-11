window.addEventListener('load', function(){
    var httpRequest;
    const form = document.querySelector('#join-form');
    
    form.addEventListener('submit', (e) => {
        e.preventDefault();
        var payload = new FormData(form);
        console.log([...payload])
    });

    // join.init();
});

// var join = {
    
//     // 초기화 메소드
//     init: function() {
//         var _this = this;

//         const joinBtn = document.querySelector('#join');
//         joinBtn.addEventListener('click', _this.send);
//     },
//     send: function() {
//       // form 데이터를 JSON으로 만듦
//       var data = {
//         id: document.querySelector('#article-title').value,
//         content: document.querySelector('#article-content').value,
//       }

//     }

// }
