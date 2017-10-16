var oReq = new XMLHttpRequest();

oReq.open("GET", "data.json", true);

oReq.onreadystatechange = function(){
    if(oReq.readyState == 4){
        if (oReq.status == 200 || oReq.status == 0){
            var json = oReq.responseText;
            
            var pObj = JSON.parse(json);

            var Users = [];
            var Gateway = [];

            for (i in pObj.processes){
                if (pObj.processes[i].class == "User"){
                    Users.push(pObj.processes[i].name);
                }else if(pObj.processes[i].class == "Gateway"){
                    Gateway.push(pObj.processes[i].name);
                }
                document.getElementById("nCount").innerHTML += "<br><span>" + pObj.processes[i].name + ":" + pObj.processes[i].class + "</span>"
            }

            var seqCount = 0;
            var nodeCount = 0;

            for (i3 in pObj.diagram.content){
                var msgCount = 0;
                seqCount++;
                //document.getElementById("alog").innerHTML += pObj.diagram.content[i3].node  + seqCount + "<br>";
                for (i2 in pObj.diagram.content[i3].content){

                    msgCount++;
                    nodeCount++;

                    var nF = pObj.diagram.content[i3].content[i2].from;
                    var nT = pObj.diagram.content[i3].content[i2].to;

                    var m, n;

                    if (Users.indexOf(nT) > -1){
                        n = "user";
                    }else if(Gateway.indexOf(nT) > -1){
                        n = "gateway";
                    }

                    if (Users.indexOf(nF) > -1){
                        m = "user";
                    }else if(Gateway.indexOf(nF) > -1){
                        m = "gateway";
                    }
                    //document.getElementById("alog").innerHTML += pObj.diagram.content[i3].content[i2].from + " " + m + " is trying to " + pObj.diagram.content[i3].content[i2].node + " to the " + n + " " + pObj.diagram.content[i3].content[i2].to + "<br>" + "Message: " + pObj.diagram.content[i3].content[i2].message + "<br>";
                    
                }
                document.getElementById("mCount" + seqCount).innerHTML += "<br><span>Total messages: " + msgCount + "</span>";
            }

            /**document.getElementById("ucount").innerHTML = Users.length;
            document.getElementById("unodes").innerHTML = nodeCount;
            document.getElementById("useq").innerHTML = seqCount;
            //console.log("There are " + Users.length + " users.");**/
        }
    }
}

oReq.send();

