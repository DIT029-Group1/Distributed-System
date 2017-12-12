/*
@author Yazan Alsahhar
A code which is responsible for popping up the send's window 
*/
function popUp(url) {
	var width = 600;
	var height = 300;
	var left = (screen.width - width) / 2;
	var top = (screen.height - height) / 2;
	var params = 'width=' + width + ', height=' + height;
	params += ', top=' + top + ', left=' + left;
	params += ', toolbar=no';
	params += ', menubar=no';
	params += ', resizable=yes';
	params += ', directories=no';
	params += ', scrollbars=no';
	params += ', status=no';
	params += ', location=no';
	newWindow = window.open(url, 'd', params);
	if (window.focus) {
		newWindow.focus()
	}
	return false;

}