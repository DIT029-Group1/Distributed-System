
var canvas = document.getElementById('SDCanvas');

// get div elements from simulator page
var div = document.getElementById('left').getElementsByTagName('div');
var childDiv = [];

// put all children of the div which is belong to id "left" into the array

for(var i = 0; i < div.length; i++) {
    childDiv.push(div[i]);
}

// gets all nodes
var nodes = childDiv[childDiv.length-1].getElementsByTagName('span');

// gets all msg properties
var totalMsg = Number(childDiv[0].getElementsByClassName('dNumber').item(0).textContent) +
    Number(childDiv[1].getElementsByClassName('dNumber').item(0).textContent);

//------------------- CANVAS -------------------

canvas.width = (200 * nodes.length) + 200;;
canvas.height = (totalMsg * 100) + 400;

var c = canvas.getContext('2d');

c.fillStyle = "black";
c.strokeStyle = 'black';
c.font = "14pt sans-serif";

//--------------------- END ---------------------

//------------------- DIAGRAM -------------------

// get diagrams name
var name1 = childDiv[0].getElementsByClassName('dName').item(0).textContent;
var name2 = childDiv[1].getElementsByClassName('dName').item(0).textContent;

// system boundary
c.strokeRect(20,20, (200 * nodes.length) + 150, (totalMsg * 100) + 350);
c.fillText(name1, 30, 50);

//par
c.strokeRect(70,200,(200 * nodes.length), (totalMsg * 100));
c.fillText(name2, 80, 230);

c.beginPath();
c.setLineDash([5]);
c.moveTo(70,(totalMsg * 100) + 50);
c.lineTo((200 * nodes.length) + 70, (totalMsg * 100) + 50);
c.stroke();

// diagram names boundary
// Messaging SD and par

c.setLineDash([]);
c.beginPath();
c.moveTo(20,70);
c.lineTo(name1.length * 20, 70);
c.lineTo(name1.length * 20 + 25, 35);
c.lineTo(name1.length * 20 + 25, 20);

c.moveTo(70,250);
c.lineTo(name2.length * 20, 250);
c.lineTo(name2.length * 20 + 25, 215);
c.lineTo(name2.length * 20 + 25, 200);

c.stroke();

//--------------------- END ---------------------

//-------------------- NODES --------------------
// creates nodes
var Dx = 0;

// save node name and x coordinate for messages
var nodePosX = [];

for (var i = 0; i < nodes.length; i++) {
    c.fillText(nodes[i].textContent, 175 + Dx, 150);
    c.strokeRect(150 + Dx, 120, 100, 50);
    c.fillRect(200 + Dx, 170, 2, 100 * totalMsg + 70);
    Dx += 200;
    nodePosX.push({name: nodes[i].textContent, x: Dx});
    c.stroke();
}

//--------------------- END ---------------------

//------------------- ANIMATE -------------------

function animate() {
    requestAnimationFrame(animate)

    //------------------- MESSAGES ------------------

    var msgs = document.getElementById('target').getElementsByTagName('span');
    var Dy = 250;
    for(var i = 0; i < msgs.length; i++) {
        var element = msgs[i].textContent.split(', ');
        var msg = msgs[i].textContent;
        var from = 0;
        var to = 0;

        for(var j = 0; j < nodePosX.length; j++) {
            if(element[0] == nodePosX[j].name) {
                from = nodePosX[j].x;
            }
        }

        for(var k = 0; k < nodePosX.length; k++) {
            if(element[2] == nodePosX[k].name) {
                to = nodePosX[k].x;
            }
        }
        c.fillText(msg.substr(msg.indexOf(', ') + 2), (from + to)/2 - 50, Dy - 10);

        c.beginPath();
        c.lineWidth="5";
        if(i == msgs.length - 1) {c.strokeStyle="rgb(57,255,20";}
        else {c.strokeStyle="black";}

        c.moveTo(from, Dy);
        c.lineTo(to, Dy);

        if(from < to){
            c.lineTo(to - 15, Dy - 15);
            c.arcTo(to, Dy, to - 35, Dy + 35, 25);
            c.lineTo(to, Dy);
        }
        else if(from > to) {
            c.lineTo(to + 15, Dy + 15);
            c.arcTo(to, Dy, Dy + 15, to - 35, 25);
            c.lineTo(to, Dy);
        }
        else {
            c.beginPath();
            c.moveTo(from, Dy);
            c.lineTo(to + 100, Dy);
            Dy += 100;
            c.lineTo(to + 100, Dy);
            c.lineTo(to, Dy);
            c.lineTo(to + 15, Dy + 15);
            c.arcTo(to, Dy, to + 35, Dy - 35, 25);
            c.lineTo(to, Dy);

        }
        c.stroke();
        Dy += 100;
        //--------------------- END ---------------------
    }

    //--------------------- END ---------------------
}

animate();