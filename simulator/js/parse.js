var oReq = new XMLHttpRequest();
oReq.open("GET", "data.json");

oReq.onreadystatechange = function(){
    if(oReq.readyState == 4){
        if (oReq.status == 200 || oReq.status == 0){
            var json = oReq.responseText;
            
            var pObj = JSON.parse(json);

            var Users = [];
            var Gateway = [];

            //var table = document.getElementById("info");

            for (i in pObj.processes){
                console.log(pObj.processes[i].name + " is a " + pObj.processes[i].class);
            
                /**var row = table.insertRow(2);
                var u = row.insertCell(0);
                var g = row.insertCell(1);**/

                if (pObj.processes[i].class == "User"){

                    //u.innerHTML = pObj.processes[i].name;
                    
                    Users.push(pObj.processes[i].name);
                }else if(pObj.processes[i].class == "Gateway"){

                    //g.innerHTML = pObj.processes[i].name;

                    Gateway.push(pObj.processes[i].name);
                }
            }

            var seqCount = 0;
            var nodeCount = 0;

            for (i3 in pObj.diagram.content){
                seqCount++;
                document.getElementById("alog").innerHTML += pObj.diagram.content[i3].node  + seqCount + "<br>";
                for (i2 in pObj.diagram.content[i3].content){

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

                    document.getElementById("alog").innerHTML += pObj.diagram.content[i3].content[i2].from + " " + m + " is trying to " + pObj.diagram.content[i3].content[i2].node + " to the " + n + " " + pObj.diagram.content[i3].content[i2].to + "<br>" + "Message: " + pObj.diagram.content[i3].content[i2].message + "<br>";
                }
            }

            document.getElementById("ucount").innerHTML = Users.length;
            document.getElementById("unodes").innerHTML = nodeCount;
            document.getElementById("useq").innerHTML = seqCount;
            //console.log("There are " + Users.length + " users.");
        }
    }
}

oReq.send();

