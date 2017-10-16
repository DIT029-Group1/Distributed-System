var oReq = new XMLHttpRequest();

oReq.open("GET", "data.json", true);

oReq.onreadystatechange = function(){
    if(oReq.readyState == 4){
        if (oReq.status == 200 || oReq.status == 0){
            var json = oReq.responseText;
            
            var pObj = JSON.parse(json);

            for(var e = 1; e < pObj.processes.length; e++){
                document.getElementById("nCount").innerHTML += "<br><span>" + pObj.processes[e].name + ":" + pObj.processes[e].class + "</span>";
            }

            document.getElementById("nCount").innerHTML += "<br><span>" + pObj.processes[0].name + ":" + pObj.processes[0].class + "</span>";

            var seqCount = 0;
            var nodeCount = 0;

            for (i3 in pObj.diagram.content){
                var msgCount = 0;
                seqCount++;
                
                for (i2 in pObj.diagram.content[i3].content){

                    msgCount++;
                    nodeCount++;

                }
                document.getElementById("mCount" + seqCount).innerHTML = pObj.diagram.content[i3].node  + seqCount;
                document.getElementById("mCount" + seqCount).innerHTML += "<br><span>Total messages: " + msgCount + "</span>";
            }
        }
    }
}

oReq.send();

