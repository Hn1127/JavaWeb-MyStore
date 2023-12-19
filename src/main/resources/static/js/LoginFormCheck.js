// 1.声明变量
var usernameObj;
var usernameMsg;
var passwordObj;
var passwordMsg;

window.onload = function(){
	usernameObj = document.getElementById("username");
	usernameMsg = document.getElementById("usernameMsg");
	passwordObj = document.getElementById("password");
	passwordMsg = document.getElementById("passwordMsg");
}

function checkUsername(){
	if(usernameObj.value==""){
		usernameMsg.innerHTML="请输入用户名";
		// usernameObj.parentNode.parentNode.style.color="red";
		return false;
	}
	return true;
}

function checkPassword(){
	if(passwordObj.value==""){
		usernameMsg.innerHTML="请输入密码";
		// usernameObj.parentNode.parentNode.style.color="red";
		return false;
	}
	return true;
}

function checkFrom(){
	var res = checkUsername()&&checkPassword();
	return res;
}