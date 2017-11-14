function updateInfo(fileName) {
    var oReq = new XMLHttpRequest();

    var nodes = [];

    oReq.open("GET", fileName, false);
    oReq.send();


    var json = oReq.responseText;
    var pObj = JSON.parse(json);

    document.getElementById("nCount").innerHTML = "Name of Nodes";

    for (var i = 1; i < pObj.processes.length; i++) {
        document.getElementById("nCount").innerHTML += "<br><span>" + pObj.processes[i].name + ":" + pObj.processes[i].class + "</span>";
        nodes.push(pObj.processes[i].name + ":" + pObj.processes[i].class);
    }

    document.getElementById("nCount").innerHTML += "<br><span>" + pObj.processes[0].name + ":" + pObj.processes[0].class + "</span>";
    nodes.push(pObj.processes[0].name + ":" + pObj.processes[0].class);

    var seqCount = 0;
    var nodeCount = 0;

    for (i3 in pObj.diagram.content) {
        var msgCount = 0;
        seqCount++;

        for (i2 in pObj.diagram.content[i3].content) {

            msgCount++;
            nodeCount++;

        }
        document.getElementById("mCount" + seqCount).innerHTML = pObj.diagram.content[i3].node + seqCount;
        document.getElementById("mCount" + seqCount).innerHTML += "<br><span>Total Messages: " + msgCount + "</span>";
    }

    updateCanvas(nodes, msgCount, nodeCount, seqCount, pObj);
}


