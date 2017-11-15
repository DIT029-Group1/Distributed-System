var hidden = false;
	function show() {
		
		if(hidden == false) {
	 		document.getElementById('dragAndDrop').style.visibility = 'hidden';
	 		hidden = !hidden;
		} else {
			document.getElementById('dragAndDrop').style.visibility = 'visible';
			hidden = !hidden;
			
				}
	}					    