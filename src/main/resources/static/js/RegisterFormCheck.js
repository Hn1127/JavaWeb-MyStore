// 1.声明变量
var usernameObj;
var usernameMsg;
var passwordObj;
var passwordMsg;
var repasswordObj;
var repaswordMsg;
var emailObj;
var emailMsg;

window.onload = function() {
	usernameObj = document.getElementById("username");
	usernameMsg = document.getElementById("usernameMsg");
	passwordObj = document.getElementById("password");
	passwordMsg = document.getElementById("passwordMsg");
	repasswordObj = document.getElementById("repassword");
	emailObj = document.getElementById("email");
	emailMsg = document.getElementById("emailMsg");
}

function checkUsername() {
	// 要求用户名长度在6-15间，由大小写字符、数字、_字符组合成
	if(usernameObj.value==""){
		usernameMsg.innerHTML="请输入用户名";
		// usernameObj.parentNode.parentNode.style.color="red";
		return false;
	}
	usernameMsg.innerHTML="";
	return true;
	// usernameMsg.innerHTML = usernameObj.value;
	// usernameObj.parentNode.parentNode.style.color = "red";
}

function checkPassword() {
	// 要求密码在6-20之间，由大小写字符、数字、~!@#$%^&*_+字符组合成
	if(passwordObj.value==""){
		passwordMsg.innerHTML="请输入密码";
		// usernameObj.parentNode.parentNode.style.color="red";
		return false;
	}
	passwordMsg.innerHTML="";
	return true;
}

function checkEmail() {
	return true;
}

function checkFrom() {
	return checkUsername()&&checkPassword()&&checkEmail();
}