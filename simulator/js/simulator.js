
var canvas = document.getElementById('SDCanvas');

// get div elements from simulator page
//var div = document.getElementById('left').getElementsByTagName('div');
//var childDiv = [];

// put all children of the div which is belong to id "left" into the array

//for(var i = 0; i < div.length; i++) {
//    childDiv.push(div[i]);
//}

// gets all nodes
// = childDiv[childDiv.length-1].getElementsByTagName('span');

// gets all msg properties
//var totalMsg = Number(childDiv[0].getElementsByClassName('dNumber').item(0).textContent) +
//    Number(childDiv[1].getElementsByClassName('dNumber').item(0).textContent);

//------------------- CANVAS -------------------

canvas.width = (200 * nodes.length) + 200;
canvas.height = ((msgCount+nodeCount) * 50) + 400;

var c = canvas.getContext('2d');

c.fillStyle = "black";
c.strokeStyle = 'black';
c.font = "14pt sans-serif";

//--------------------- END ---------------------

//------------------- DIAGRAM -------------------

// get diagrams name
//var name1 = childDiv[0].getElementsByClassName('dName').item(0).textContent;
//var name2 = childDiv[1].getElementsByClassName('dName').item(0).textContent;

var name1 = "Messaging SD";
var name2 = pObj.diagram.node;

// system boundary
c.strokeRect(0,0, (200 * nodes.length) + 150, ((msgCount+nodeCount) * 50) + 350);
c.fillText(name1, 10, 30);

// diagram par
c.strokeRect(50,180,(200 * nodes.length), ((msgCount+nodeCount) * 50));
c.fillText(name2, 60, 210);

// status
c.beginPath();
c.setLineDash([5]);
c.moveTo(50,((msgCount+nodeCount) * 50) + 30);
c.lineTo((200 * nodes.length) + 50, ((msgCount+nodeCount) * 50) + 30);
c.stroke();

// diagram names boundary
// Messaging SD and par

c.setLineDash([]);
c.beginPath();
c.moveTo(0,50);
c.lineTo(name1.length * 12, 50);
c.lineTo(name1.length * 12 + 25, 15);
c.lineTo(name1.length * 12 + 25, 0);

c.moveTo(50,230);
c.lineTo(name2.length * 30, 230);
c.lineTo(name2.length * 30 + 25, 195);
c.lineTo(name2.length * 30 + 25, 180);

c.stroke();

//--------------------- END ---------------------

//-------------------- NODES --------------------

var Dx = 0;

// save node name and x coordinate for messages
var nodePosX = [];

c.strokeStyle

for (var i = 0; i < nodes.length; i++) {
    c.fillStyle = "rgb(140, 205, 241)";
    c.fillRect(130 + Dx, 100, nodes[i].length * 15, 50);
    c.fillRect(180 + Dx, 150, 10, 50 * (msgCount+nodeCount) + 70);
    c.fillStyle = "black";
    c.fillText(nodes[i], 155 + Dx, 130);
    Dx += 180;
    nodePosX.push({name: nodes[i].split(':')[0], x: Dx});
    c.stroke();
}


//--------------------- END ---------------------

//------------------- ANIMATE -------------------

function animate() {
    requestAnimationFrame(animate)

    //------------------- MESSAGES ------------------

    var msgs = [],
        url = "http://localhost:8080/";

    var xhr = new XMLHttpRequest();

    xhr.open('GET', url, true);
    xhr.onreadystatechange = function () {
        if(xhr.readyState === 4) {
            var status = xhr.status;
            if((status >= 200 && status < 300) || status === 304) {
                var doc = xhr.responseText;
                msgs = doc.split('<br>');

                // var msgs = document.getElementById('target').getElementsByTagName('span');
                var Dy = 230;
                for(var i = 1; i < msgs.length; i++) {
                    var element = msgs[i].split(', ');
                    var msg = msgs[i];
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

                    if(from < to){
                        c.moveTo(from + 10, Dy);
                        c.lineTo(to - 5, Dy);
                        c.lineTo(to - 20, Dy - 15);
                        c.arcTo(to - 5, Dy, to - 30, Dy + 25, 25);
                        c.lineTo(to - 5, Dy);
                    }
                    else if(from > to) {
                        c.moveTo(from, Dy);
                        c.lineTo(to + 15, Dy);
                        c.lineTo(to + 30, Dy - 15);
                        c.arcTo(to + 15, Dy, to + 45, Dy + 30, 25);
                        c.lineTo(to + 15, Dy);
                    }
                    else {
                        c.beginPath();
                        c.moveTo(from + 10 , Dy);
                        c.lineTo(to + 100, Dy);
                        Dy += 50;
                        c.lineTo(to + 100, Dy);
                        c.lineTo(to + 15, Dy);
                        c.lineTo(to + 30, Dy + 15);
                        c.arcTo(to + 15, Dy, to + 45, Dy - 30, 25);
                        c.lineTo(to + 15, Dy);

                    }
                    c.stroke();
                    if (i === seqCount + msgCount) {
                        Dy += 100;
                    } else {
                        Dy += 50;
                    }

                    //--------------------- END ---------------------
                }



            } else {
                console.log('connection error');
            }
        }
    }
    xhr.send();


    //--------------------- END ---------------------
}

animate();