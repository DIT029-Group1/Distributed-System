function UploadFile(fileUpload) {
	if (fileUpload.value != '') {
		document.getElementById("<%=UploadButton.ClientID %>").click();
	}
}