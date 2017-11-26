function updateCanvas(nodes, msgCount, nodeCount, seqCount, pObj, pObj2, pObj3) {
	var canvas = document.getElementById('SDCanvas');


	//------------------- CANVAS -------------------
	var height = (msgCount + nodeCount) * 50;
	canvas.width = 200 * nodes.length + 200;
	canvas.height = height * 3;

	var c = canvas.getContext('2d');

	c.fillStyle = "white";
	c.strokeStyle = 'white';
	c.font = "14pt sans-serif";

	//--------------------- END ---------------------

	//------------------- DIAGRAM -------------------

	var name1 = "Messaging SD";
	var name2 = pObj.diagram.node;

	// system boundary
	c.strokeRect(0, 0, 200 * nodes.length + 150, height + 350);
	c.fillText(name1, 10, 30);

	// diagram par
	c.strokeRect(50, 180, 200 * nodes.length, height);
	c.fillText(name2, 60, 210);

	// status
	c.beginPath();
	c.setLineDash([5]);
	c.moveTo(50, height + 30);
	c.lineTo(200 * nodes.length + 50, height + 30);
	c.stroke();

	// diagram names boundary
	// Messaging SD and par

	c.setLineDash([]);
	c.beginPath();
	c.moveTo(0, 50);
	c.lineTo(name1.length * 12, 50);
	c.lineTo(name1.length * 12 + 25, 15);
	c.lineTo(name1.length * 12 + 25, 0);

	c.moveTo(50, 230);
	c.lineTo(name2.length * 30, 230);
	c.lineTo(name2.length * 30 + 25, 195);
	c.lineTo(name2.length * 30 + 25, 180);

	c.stroke();

	//--------------------- END ---------------------

    //---------- Deployment & Class Diagram ---------

    c.strokeRect(0, height + 355, 200 * nodes.length + 150, (height));
    c.fillText("Class diagram", 10, height + 380);


    var xLoc = 10;
    var classLocsX = [];

    //Draw every class
    for (var i = 0; i < pObj2.classes.length; i++) {
        c.fillStyle = "white";
        if (i == 0) {
            //Draw the first class on the top
            c.fillRect(70 * pObj2.classes.length, height + 420, 200, 100);
            c.fillStyle = "black";
            c.fillText(pObj2.classes[i].name, 70 * pObj2.classes.length + 10, height + 440);
        } else {
            c.fillRect(xLoc, height + 580, 200, 100);
            c.fillStyle = "black";
            c.fillText(pObj2.classes[i].name, xLoc + 10, height + 600);
            classLocsX[i] = (xLoc - 100);
        }

        //Draw the fields of the class
        var yLoc = height + 620;

        for (var f = 0; f < pObj2.classes[i].fields.length; f++) {

            if (i == 0) {
                c.fillText(pObj2.classes[i].fields[f].name + " : " + pObj2.classes[i].fields[f].type, 70 * pObj2.classes.length + 10, height + 470);
            } else {
                c.fillText(pObj2.classes[i].fields[f].name + " : " + pObj2.classes[i].fields[f].type, xLoc + 10, yLoc);
            }

            yLoc += 20;
        }

        if (i != 0) {
            xLoc += 270;
        }
    }

    //Draw the inheritence
    //First we loop through all the relationships
    for (var h = 0; h < pObj2.relationships.length; h++) {

        var tmpSuperClass = pObj2.relationships[h].superclass;
        var tmpSubClass = pObj2.relationships[h].subclass;

        var xFrom = 0;
        var yFrom = 0;
        var xTo = 0;
        var yTo = 0;

        //Then we store the location of each class that has a relationship
        for (var i = 0; i < pObj2.classes.length; i++) {
            if (pObj2.classes[i].name == tmpSuperClass) {
                if (i == 0) {
                    xFrom = (70 * pObj2.classes.length + 100);
                    yFrom = height + 520;
                } else {
                    xFrom = classLocsX[i] + 200;
                    yFrom = height + 580;
                }
            } else if (pObj2.classes[i].name == tmpSubClass) {
                if (i == 0) {
                    xTo = (70 * pObj2.classes.length + 100);
                    yTo = height + 520;
                } else {
                    xTo = classLocsX[i] + 200;
                    yTo = height + 580;
                }
            }
        }

        c.strokeStyle = "black";

        //Draw arrow head

        c.beginPath();

        c.moveTo(xFrom, yFrom);
        c.lineTo(xFrom + 10, yFrom + 10);
        c.moveTo(xFrom, yFrom);
        c.lineTo(xFrom - 10, yFrom + 10);
        c.moveTo(xFrom - 10, yFrom + 10);
        c.lineTo(xFrom + 10, yFrom + 10);
        
        //Draw arrow body
        
        switch (pObj2.relationships[h].type) {
            case "inheritance":
                c.setLineDash([]);
                break;
            case "realization":
                c.setLineDash([3]);
                break;

            //TODO: Add more relationship types of arrows
        }

        c.moveTo(xFrom, yFrom + 10);
        c.lineTo(xTo, yTo);

        c.stroke();
    }

    //--------------------- END ---------------------

	//-------------------- NODES --------------------

	var Dx = 0;

	// save node name and x coordinate for messages
	var nodePosX = [];

	c.strokeStyle;

	for (var i = 0; i < nodes.length; i++) {
		c.fillStyle = "rgb(140, 205, 241)";
		c.fillRect(130 + Dx, 100, nodes[i].length * 15, 50);
		c.fillRect(180 + Dx, 150, 10, height + 70);
		c.fillStyle = "white";
		c.fillText(nodes[i], 155 + Dx, 130);
		Dx += 180;
		nodePosX.push({ name: nodes[i].split(':')[0], x: Dx });
		c.stroke();
	}


	//--------------------- END ---------------------

	//------------------- ANIMATE -------------------

	function animate() {
		requestAnimationFrame(animate);

		//------------------- MESSAGES ------------------
		var Dy = 230;
		var tmpDy = height + 80;
		var msgs = [],
			url = "http://192.168.0.104:8080";

		var xhr = new XMLHttpRequest();

		xhr.open('GET', url, true);
		xhr.onreadystatechange = function () {
			if (xhr.readyState === 4) {
				var status = xhr.status;
				if (status >= 200 && status < 300 || status === 304) {
					var doc = xhr.responseText;

					msgs = doc.split('<br>');

					if (msgs.length > nodeCount) {
						msgs = msgs.slice(0, nodeCount + 1);
					}

					for (var i = 1; i < msgs.length; i++) {
						var element = msgs[i].split(', ');
						var msg = msgs[i];
						var from = 0;
						var to = 0;

						for (var j = 0; j < nodePosX.length; j++) {
							if (element[0] === "par") {
								if (element[1] === nodePosX[j].name) {
									from = nodePosX[j].x;
								}
							} else {
								if (element[0] === nodePosX[j].name) {
									from = nodePosX[j].x;
								}
							}
						}

						for (var k = 0; k < nodePosX.length; k++) {
							if (element[0] === "par") {
								if (element[2] === nodePosX[k].name) {
									to = nodePosX[k].x;
								}
							} else {
								if (element[1] === nodePosX[k].name) {
									to = nodePosX[k].x;
								}
							}
						}

						if (element[0] !== "par") {
							c.fillText((element[2] + ", " + element[3] + ", " + element[4]), (from + to) / 2 - 50, Dy - 10);
						} else {
							c.fillText(element[3], (from + to) / 2, tmpDy - 10);
						}

						c.beginPath();
						c.lineWidth = "5";
						if (i === msgs.length - 1) { c.strokeStyle = "rgb(57,255,20)"; }
						else { c.strokeStyle = "white"; }

						if (from < to) {
							if (element[0] === "par") {
								c.moveTo(from + 10, tmpDy);
								c.lineTo(to - 5, tmpDy);
								c.lineTo(to - 20, tmpDy - 15);
								c.arcTo(to - 5, tmpDy, to - 30, tmpDy + 25, 25);
								c.lineTo(to - 5, tmpDy);
							}
							else {
								c.moveTo(from + 10, Dy);
								c.lineTo(to - 5, Dy);
								c.lineTo(to - 20, Dy - 15);
								c.arcTo(to - 5, Dy, to - 30, Dy + 25, 25);
								c.lineTo(to - 5, Dy);
							}
						}
						else if (from > to) {
							if (element[0] === "par") {
								c.moveTo(from, tmpDy);
								c.lineTo(to + 15, tmpDy);
								c.lineTo(to + 30, tmpDy - 15);
								c.arcTo(to + 15, tmpDy, to + 45, tmpDy + 30, 25);
								c.lineTo(to + 15, tmpDy);
							} else {
								c.moveTo(from, Dy);
								c.lineTo(to + 15, Dy);
								c.lineTo(to + 30, Dy - 15);
								c.arcTo(to + 15, Dy, to + 45, Dy + 30, 25);
								c.lineTo(to + 15, Dy);
							}
						}
						else {
							if (element[0] === "par") {
								c.beginPath();
								c.moveTo(from + 10, tmpDy);
								c.lineTo(to + 100, tmpDy);
								tmpDy += 50;
								c.lineTo(to + 100, tmpDy);
								c.lineTo(to + 15, tmpDy);
								c.lineTo(to + 30, tmpDy + 15);
								c.arcTo(to + 15, tmpDy, to + 45, tmpDy - 30, 25);
								c.lineTo(to + 15, tmpDy);
							} else {
								c.beginPath();
								c.moveTo(from + 10, Dy);
								c.lineTo(to + 100, Dy);
								Dy += 50;
								c.lineTo(to + 100, Dy);
								c.lineTo(to + 15, Dy);
								c.lineTo(to + 30, Dy + 15);
								c.arcTo(to + 15, Dy, to + 45, Dy - 30, 25);
								c.lineTo(to + 15, Dy);
							}
						}
						c.stroke();

						if (element[0] === "par") {
							tmpDy += 50;
						} else {
							Dy += 50;
						}
						//--------------------- END ---------------------

					}
				} else {
					console.log('connection error');
				}
			}
		};
		xhr.send();

		//--------------------- END ---------------------
	}

	animate();
}