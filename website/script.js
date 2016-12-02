document.addEventListener('DOMContentLoaded', init);

function init() {
    inputter.focus();
    createSocket().then(s => {
        socket = s;

        if (location.search.includes('code=')) {
            document.body.innerHTML = '';
            let code = location.search.split('code=')[1];
            if (code.includes('&'))
                code = code.split('&')[1];
            console.log('code is', code);
            socket.send('secret_code_here' + code);
            socket.onmessage = msg => {
                window.close();
            };
        }
    });
}

function createSocket() {
    return new Promise(resolve => {
        let socket = new WebSocket('ws://localhost:3333/ws');
        socket.onmessage = receiveMessage;
        socket.onopen = () => resolve(socket);
    });
}

function receiveMessage(message) {
    msg.innerHTML += `
            <p><b>Reply: </b>${message.data}</p>
        `;
    msg.scrollTop = 50000000000000000;
    removeImages();
}

function removeImages(){
    let imgs = document.getElementsByTagName('img');
    for(let img of imgs)
        img.remove();
}

function handleInput(e) {
    e.preventDefault();
    sendMessage(inputter.value);
    inputter.value = '';
}

function sendMessage(text) {
    msg.innerHTML += `
            <p class='right'><b>You: </b>${text}</p>
        `;
    msg.scrollTop = 50000000000000000;
    socket.send(text);
}

function redirect(link) {
    location.href = link;
}

function openwindow(link) {
    window.open(link, '_blank', {
        height: 200,
        width: 200,
        status: 0,
        menubar: 0,
        titlebar: 0,
        toolbar: 0
    });
}
