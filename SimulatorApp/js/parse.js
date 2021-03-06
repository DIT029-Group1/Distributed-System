﻿function updateInfo(fileName, port) {

	var oReq = new XMLHttpRequest();

	var nodes = [];

	oReq.open("GET", fileName, false);
	oReq.send();


	var json = JSON.parse(oReq.responseText);
	var pObj = json[0]; //Load the sequence diagram info
	var pObj2 = json[1]; //Load the class diagram info
	var pObj3 = json[2]; //Load the deployment diagram info

	document.getElementById("nCount").innerHTML = "Name of Nodes";

	for (var i = 1; i < pObj.processes.length; i++) {
		document.getElementById("nCount").innerHTML += "<br><span>" + pObj.processes[i].name + ":" + pObj.processes[i].class + "</span>";
		nodes.push({ name: pObj.processes[i].name, class: pObj.processes[i].class });
	}

	document.getElementById("nCount").innerHTML += "<br><span>" + pObj.processes[0].name + ":" + pObj.processes[0].class + "</span>";
	nodes.push({ name: pObj.processes[0].name, class: pObj.processes[0].class });

	var seqCount = 0;
	var nodeCount = 0;

	document.getElementById("mCount").innerHTML = "";


	for (i3 in pObj.diagram.content) {
		var msgCount = 0;
		seqCount++;

		for (i2 in pObj.diagram.content[i3].content) {

			msgCount++;
			nodeCount++;

		}

		var seqhtml = "<div class='content1'>" + pObj.diagram.content[i3].node + seqCount + "<br><span>Total Messages: " + msgCount + "</span></div>";

		document.getElementById("mCount").innerHTML += seqhtml;
	}

	updateCanvas(port, nodes, msgCount, nodeCount, seqCount, pObj, pObj2, pObj3);
}