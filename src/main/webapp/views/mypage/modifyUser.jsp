<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="auth.dto.UsersDTO"%>
<%
// 세션에서 로그인 사용자 정보 가져오기
UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");

// 로그인하지 않은 경우
if (loginUser == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TechX Games - 회원정보 수정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
	background-color: black;
	margin: 0;
	height: 100vh;
	display: flex;
	flex-direction: column; /* 세로 정렬 */
	align-items: center; /* 가로 가운데 정렬 */
	justify-content: flex-start; /* 위쪽 정렬 */
	font-family: "Noto Sans KR", serif;
}

.wrapper {
	display: flex;
	flex-direction: column; /* 세로로 정렬 */
	align-items: center; /* 가로 가운데 정렬 */
	width: 100%;
}

.logo {
	width: 400px;
	height: 130px;
	margin-top: 20px; /* 상단 여백 */
	cursor: pointer;
}

.logo img {
	width: 100%;
	height: 100%;
}

.container {
	width: 500px;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 10px;
	box-shadow: 5px 5px 10px rgba(255, 255, 255, 0.3);
	color: black;
	background-color: white;
	margin-top: 20px; /* 로고와 컨테이너 간의 간격 */
}

h2 {
	text-align: center;
}

.form-group {
	margin-bottom: 15px;
}

label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

input[type="text"], input[type="password"], input[type="email"] {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	border: 1px solid #ddd;
	border-radius: 5px;
}

button {
	width: 100%;
	padding: 10px;
	background-color: #868789;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 10px;
}

button:hover {
	background-color: #000;
}

.error-msg {
	color: red;
	font-size: 0.9em;
	margin-top: 5px;
	display: none;
}

.success-msg {
	color: green;
	font-size: 0.9em;
	margin-top: 5px;
	display: none;
}

.error {
	color: red;
	margin-top: 10px;
}

.success {
	color: green;
	margin-top: 10px;
}

.check-button {
	background-color: #000;
	color: white;
	border: none;
	border-radius: 4px;
	padding: 8px 15px;
	cursor: pointer;
	margin-top: 5px;
	font-size: 14px;
}

.check-button:hover {
	background-color: #868789;
}

.nickname-container {
	display: flex;
	align-items: center;
}

.nickname-container input {
	flex: 1;
}

.nickname-container button {
	width: auto;
	margin-left: 10px;
	margin-top: 0;
}

#withdraw-btn {
	position: absolute;
	width: 80px;
	top: 850px;
	left: 1500px;
	background-color: #868789;
}

@media screen and (max-width: 768px) {
	.container {
		width: 90%;
	}
	#withdraw-btn {
		position: relative;
		top: auto;
		left: auto;
	}
}

.email-container {
	display: flex;
	align-items: center;
}

.email-container input {
	flex: 1;
}

.email-container button {
	width: auto;
	margin-left: 10px;
	margin-top: 0;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="logo">
			<a href="/"> <img class="logo-img" src="/assets/img/logoW.png"
				alt="TechX Logo" />
			</a>
		</div>
		<div class="container">
			<h2>회원정보 수정</h2>
			<form id="modifyForm" action="/info.mypage">
				<div class="form-group">
					<label for="userId">아이디</label> <input type="text" id="userId"
						name="userId" value="<%=loginUser.getId()%>" readonly>
				</div>
				<div class="form-group">
					<label for="userName">이름</label> <input type="text" id="userName"
						name="userName" value="<%=loginUser.getName()%>">
					<div id="userNameError" class="error-msg"></div>
				</div>
				<div class="form-group">
					<label for="userNickname">닉네임</label>
					<div class="nickname-container">
						<input type="text" id="userNickname" name="userNickname"
							value="<%=loginUser.getNickname()%>">
						<button type="button" id="checkNickname" class="check-button">중복확인</button>
					</div>
					<div id="userNicknameError" class="error-msg"></div>
					<div id="userNicknameSuccess" class="success-msg"></div>
				</div>
				<div class="form-group">
					<label for="userEmail">이메일</label>
					<div class="email-container">
						<input type="email" id="userEmail" name="userEmail"
							value="<%=loginUser.getEmail()%>">
						<%
						if (!loginUser.getId().startsWith("google_")) {
						%>
						<button type="button" id="checkEmail" class="check-button">중복확인</button>
						<%
						}
						%>
					</div>
					<div id="userEmailError" class="error-msg"></div>
					<div id="userEmailSuccess" class="success-msg"></div>
				</div>
				<div class="form-group">
					<label for="userPhone">핸드폰 번호</label> <input type="text"
						id="userPhone" name="userPhone" value="<%=loginUser.getPhone()%>">
					<div id="userPhoneError" class="error-msg"></div>
				</div>
				<div class="form-group">
					<label for="userRnum">생년월일</label> <input type="text" id="userRnum"
						name="userRnum" value="<%=loginUser.getRnum()%>">
					<div id="userRnumError" class="error-msg"></div>
				</div>
				<button type="submit" class="modify-btn">수정하기</button>
				<button type="button" class="mypage"
					onclick="location.href='/info.mypage'">마이페이지로</button>
			</form>
			<form id="withdraw-frm" action="/withdraw.users" method="post">
				<input type="hidden" name="withdrawId" id="hiddenWithdrawId"
					value="<%=loginUser.getId()%>" />
				<button type="button" id="withdraw-btn" onclick="confirmWithdraw()">탈퇴하기</button>
			</form>

			<p class="error" id="errorMsg"></p>
			<p class="success" id="successMsg"></p>
		</div>
	</div>

	<script>
	
	$(document).ready(function () {
	    // 정규식 설정
	    const idRegex = /^(?!google_)[a-zA-Z][a-zA-Z0-9]{5,14}$/;
	    const pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$/;
	    const nameRegex = /^[가-힣]{2,5}$/;
	    const nicknameRegex = /^[\w가-힣]{1,9}$/;
	    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	    const phoneRegex = /^01[0|1|6|7|8|9][- ]?\d{3,4}[- ]?\d{4}$/;
	    const rnumRegex = /^\d{6}$/;

	    // 각 필드의 유효성 상태를 저장할 객체
	    const validationState = {
	        userName: true,
	        userNickname: true,
	        userEmail: true,
	        userPhone: true,
	        userRnum: true,
	        nicknameChecked: false, // 닉네임 중복 검사 여부
	        emailChecked: false // 이메일 중복 검사 여부
	    };

	    // 구글 로그인 사용자인지 확인
	    const isGoogleUser = $("#userId").val().startsWith("google_");
	    
	    // 구글 로그인 사용자일 경우 이메일 필드 읽기 전용으로 설정
	    if (isGoogleUser) {
	        $("#userEmail").prop("readonly", true);
	        $("<div class='info-msg'>구글 계정으로 로그인한 경우 이메일을 변경할 수 없습니다.</div>")
	            .insertAfter("#userEmailError");
	        validationState.emailChecked = true; // 구글 사용자는 이메일 중복 검사 필요 없음
	    }

	 // 수정된 유효성 검사 함수
	    function validateInput(field, validator, defaultErrorMsg) {
	        const $input = $(field);
	        const $errorDiv = $(`#${field.slice(1)}Error`);
	        
	        $input.on("input", function () {
	            const value = $(this).val().trim();
	            
	            // validator가 함수인 경우 실행 결과를 얻음
	            let validationResult;
	            if (typeof validator === 'function') {
	                validationResult = validator(value);
	                // 함수가 객체를 반환하는 경우와 불리언을 반환하는 경우 처리
	                if (typeof validationResult === 'object') {
	                    if (validationResult.isValid) {
	                        $errorDiv.removeClass("error-msg").addClass("success-msg").text(validationResult.message || "올바른 형식입니다.").show();
	                        validationState[field.slice(1)] = true;
	                    } else {
	                        $errorDiv.removeClass("success-msg").addClass("error-msg").text(validationResult.message || defaultErrorMsg).show();
	                        validationState[field.slice(1)] = false;
	                    }
	                } else {
	                    if (validationResult) {
	                        $errorDiv.removeClass("error-msg").addClass("success-msg").text("올바른 형식입니다.").show();
	                        validationState[field.slice(1)] = true;
	                    } else {
	                        // 빈 값인 경우 특별 처리
	                        if (value === "" && field === "#userRnum") {
	                            $errorDiv.removeClass("success-msg").addClass("error-msg").text("생년월일은 필수 입력 항목입니다.").show();
	                        } else {
	                            $errorDiv.removeClass("success-msg").addClass("error-msg").text(defaultErrorMsg).show();
	                        }
	                        validationState[field.slice(1)] = false;
	                    }
	                }
	            } else { // 정규식인 경우
	                if (value === "" && field === "#userRnum") {
	                    $errorDiv.removeClass("success-msg").addClass("error-msg").text("생년월일은 필수 입력 항목입니다.").show();
	                    validationState[field.slice(1)] = false;
	                } else if (value === "") {
	                    $errorDiv.hide();
	                    validationState[field.slice(1)] = true;
	                } else if (validator.test(value)) {
	                    $errorDiv.removeClass("error-msg").addClass("success-msg").text("올바른 형식입니다.").show();
	                    validationState[field.slice(1)] = true;
	                } else {
	                    $errorDiv.removeClass("success-msg").addClass("error-msg").text(defaultErrorMsg).show();
	                    validationState[field.slice(1)] = false;
	                }
	            }
	            
	            // 닉네임과 이메일에 대한 특별 처리 (기존 코드 유지)
	            if (field === "#userNickname") {
	                if (value !== "<%=loginUser.getNickname()%>") {
	                    validationState.nicknameChecked = false;
	                    $("#userNicknameSuccess").hide();
	                } else {
	                    validationState.nicknameChecked = true;
	                }
	            }
	            
	            if (field === "#userEmail") {
	                if (value !== "<%=loginUser.getEmail()%>") {
	                    validationState.emailChecked = false;
	                } else {
	                    validationState.emailChecked = true;
	                }
	            }
	        });

	        $input.trigger("input");
	    }

	    // 각 필드에 유효성 검사 적용
	    validateInput("#userName", nameRegex, "이름은 한글 2~5자여야 합니다.");
	    validateInput("#userNickname", nicknameRegex, "닉네임은 한글, 영문, 숫자로 1~9자여야 합니다.");
	    validateInput("#userEmail", emailRegex, "올바른 이메일 형식이 아닙니다.");
	    validateInput("#userPhone", phoneRegex, "전화번호 형식이 올바르지 않습니다.");
	 // 생년월일에 대한 수정된 유효성 검사
	    // 생년월일에 대한 수정된 유효성 검사
validateInput("#userRnum", function(value) {
    // 빈 값이면 유효하지 않음 (필수 필드)
    if (value === "") {
        return {
            isValid: false,
            message: "생년월일은 필수 입력 항목입니다."
        };
    }
    
    // 6자리 숫자인지 확인
    const rnumRegex = /^\d{6}$/;
    if (!rnumRegex.test(value)) {
        return {
            isValid: false,
            message: "생년월일은 6자리 숫자로 입력해주세요. (YYMMDD)"
        };
    }
    
    // 유효한 생년월일인지 추가 검사
    const year = parseInt(value.substring(0, 2));
    const month = parseInt(value.substring(2, 4));
    const day = parseInt(value.substring(4, 6));
    
    // 현재 날짜와 비교
    const currentDate = new Date();
    const currentYear = currentDate.getFullYear() % 100; // 현재 연도의 마지막 두 자리
    const currentMonth = currentDate.getMonth() + 1; // 0부터 시작하므로 +1
    const currentDay = currentDate.getDate();
    
    // 미래 날짜 체크
    if (year > currentYear || 
        (year === currentYear && month > currentMonth) || 
        (year === currentYear && month === currentMonth && day > currentDay)) {
        return {
            isValid: false,
            message: "생년월일은 미래 날짜가 될 수 없습니다."
        };
    }
    
    // 월 유효성 확인 (1-12)
    if (month < 1 || month > 12) {
        return {
            isValid: false,
            message: "생년월일의 월이 유효하지 않습니다."
        };
    }
    
    // 일 유효성 확인 (1-31, 월에 따라 다름)
    const daysInMonth = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; // 2월은 윤년 고려해서 최대 29일
    if (day < 1 || day > daysInMonth[month]) {
        return {
            isValid: false,
            message: "생년월일의 일이 유효하지 않습니다."
        };
    }
    
    return {
        isValid: true,
        message: "올바른 형식입니다."
    };
}, "생년월일 형식이 올바르지 않습니다. (YYMMDD)");

	    // 닉네임 중복 검사 버튼 이벤트
	    $("#checkNickname").click(function() {
	        const nickname = $("#userNickname").val().trim();
	        const $errorDiv = $("#userNicknameError");
	        const $successDiv = $("#userNicknameSuccess");

	        if (nickname === "") {
	            $errorDiv.removeClass("success-msg").addClass("error-msg").text("닉네임을 입력해주세요.").show();
	            $successDiv.hide();
	            return;
	        }

	        if (!nicknameRegex.test(nickname)) {
	            $errorDiv.removeClass("success-msg").addClass("error-msg").text("닉네임은 한글, 영문, 숫자로 1~9자여야 합니다.").show();
	            $successDiv.hide();
	            return;
	        }

	        if (nickname === "<%=loginUser.getNickname()%>") {
	            $successDiv.text("현재 사용 중인 닉네임입니다.").show();
	            $errorDiv.hide();
	            validationState.nicknameChecked = true;
	            return;
	        }

	        // AJAX로 닉네임 중복 검사
	        $.ajax({
	            type: "POST",
	            url: "/checkDuplicate.users",
	            data: { field: "NICKNAME", value: nickname },
	            success: function(response) {
	                if (response === "duplicate") {
	                    $errorDiv.removeClass("success-msg").addClass("error-msg").text("이미 사용 중인 닉네임입니다.").show();
	                    $successDiv.hide();
	                    validationState.nicknameChecked = false;
	                    validationState.userNickname = false;
	                } else {
	                    $successDiv.text("사용 가능한 닉네임입니다.").show();
	                    $errorDiv.hide();
	                    validationState.nicknameChecked = true;
	                    validationState.userNickname = true;
	                }
	            },
	            error: function() {
	                $errorDiv.removeClass("success-msg").addClass("error-msg").text("서버 오류가 발생했습니다. 다시 시도해주세요.").show();
	                $successDiv.hide();
	                validationState.nicknameChecked = false;
	            }
	        });
	    });

	    // 이메일 중복 검사 함수 
	    $("#checkEmail").click(function() {
    const email = $("#userEmail").val().trim();
    const $errorDiv = $("#userEmailError");
    const $successDiv = $("#userEmailSuccess");

    if (email === "") {
        $errorDiv.removeClass("success-msg").addClass("error-msg").text("이메일을 입력해주세요.").show();
        $successDiv.hide();
        return;
    }

    if (!emailRegex.test(email)) {
        $errorDiv.removeClass("success-msg").addClass("error-msg").text("올바른 이메일 형식이 아닙니다.").show();
        $successDiv.hide();
        return;
    }

    if (email === "<%=loginUser.getEmail()%>") {
        $successDiv.text("현재 사용 중인 이메일입니다.").show();
        $errorDiv.hide();
        validationState.emailChecked = true;
        return;
    }

    // AJAX로 이메일 중복 검사
    $.ajax({
        type: "POST",
        url: "/checkDuplicate.users",
        data: { field: "EMAIL", value: email },
        success: function(response) {
            if (response === "duplicate") {
                $errorDiv.removeClass("success-msg").addClass("error-msg").text("이미 사용 중인 이메일입니다.").show();
                $successDiv.hide();
                validationState.emailChecked = false;
                validationState.userEmail = false;
            } else {
                $successDiv.text("사용 가능한 이메일입니다.").show();
                $errorDiv.hide();
                validationState.emailChecked = true;
                validationState.userEmail = true;
            }
        },
        error: function() {
            $errorDiv.removeClass("success-msg").addClass("error-msg").text("서버 오류가 발생했습니다. 다시 시도해주세요.").show();
            $successDiv.hide();
            validationState.emailChecked = false;
        }
    });
});
	    
	    // 이메일 입력 필드에 포커스 아웃 이벤트 핸들러 추가
	    $("#userEmail").on("blur", function() {
	        if (!isGoogleUser) { // 구글 사용자가 아닌 경우에만 이메일 중복 검사
	            checkEmailDuplicate();
	        }
	    });

	    // 닉네임 변경 감지
	    $("#userNickname").on("input", function() {
	        const value = $(this).val().trim();
	        
	        if (value === "<%=loginUser.getNickname()%>") {
	            $("#userNicknameSuccess").text("현재 사용 중인 닉네임입니다.").show();
	            $("#userNicknameError").hide();
	            validationState.nicknameChecked = true;
	        } else {
	            $("#userNicknameSuccess").hide();
	            validationState.nicknameChecked = false;
	        }
	    });
	    
	    // 이메일 변경 감지
	    $("#userEmail").on("input", function() {
	        const value = $(this).val().trim();
	        
	        if (!isGoogleUser && value !== "<%=loginUser.getEmail()%>") {
	            validationState.emailChecked = false;
	        } else {
	            validationState.emailChecked = true;
	        }
	    });

	    // 페이지 로드 시 닉네임 초기 설정
	    if ($("#userNickname").val().trim() === "<%=loginUser.getNickname()%>") {
	        validationState.nicknameChecked = true;
	    }
	    
	    // 페이지 로드 시 이메일 초기 설정
	    if ($("#userEmail").val().trim() === "<%=loginUser.getEmail()%>" || isGoogleUser) {
	        validationState.emailChecked = true;
	    }

	    // 폼 제출 시 최종 유효성 검사
	    $("#modifyForm").submit(function (event) {
	        event.preventDefault();
	        $("#errorMsg").hide();
	        $("#successMsg").hide();
	        
	        if ($("#userRnum").val().trim() === "") {
	            $("#userRnumError").removeClass("success-msg").addClass("error-msg")
	                .text("생년월일은 필수 입력 항목입니다.").show();
	            $("#errorMsg").text("생년월일은 필수 입력 항목입니다.").show();
	            return;
	        }

	        // 닉네임 중복 검사 확인
	        if ($("#userNickname").val().trim() !== "<%=loginUser.getNickname()%>" && !validationState.nicknameChecked) {
	            $("#userNicknameError").removeClass("success-msg").addClass("error-msg")
	                .text("닉네임 중복 확인이 필요합니다.").show();
	            $("#userNicknameSuccess").hide();
	            $("#errorMsg").text("닉네임 중복 확인이 필요합니다.").show();
	            return;
	        }
	        
	        // 이메일 중복 검사 확인 (구글 사용자가 아닌 경우)
	        if (!isGoogleUser && $("#userEmail").val().trim() !== "<%=loginUser.getEmail()%>" && !validationState.emailChecked) {
	            $("#userEmailError").removeClass("success-msg").addClass("error-msg")
	                .text("이메일 중복 확인이 필요합니다.").show();
	            $("#errorMsg").text("이메일 중복 확인이 필요합니다.").show();
	            return;
	        }

	        // 구글 로그인 사용자와 일반 사용자에 따른 유효성 검사 분기
	        let isValid = true;

	        if (isGoogleUser) {
	            // 구글 로그인 사용자는 필수 필드만 검사
	            if (!validationState.userName || !validationState.userNickname) {
	                isValid = false;
	                $("#errorMsg").text("이름과 닉네임은 필수 입력값입니다.").show();
	                return;
	            }
	            
	            // 이메일은 변경하지 않도록 원래 값으로 복원
	            $("#userEmail").val("<%=loginUser.getEmail()%>");
	            
	            // 전화번호와 생년월일이 비어있으면 통과 (선택 필드로 처리)
	            if ($("#userPhone").val().trim() !== "" && !validationState.userPhone) {
	                isValid = false;
	                $("#errorMsg").text("전화번호 형식이 올바르지 않습니다.").show();
	                return;
	            }
	            
	            if ($("#userRnum").val().trim() !== "" && !validationState.userRnum) {
	                isValid = false;
	                $("#errorMsg").text("생년월일 형식이 올바르지 않습니다.").show();
	                return;
	            }
	        } else {
	            // 일반 사용자는 모든 필드 검사
	            for (let field in validationState) {
	                if (field === 'nicknameChecked' || field === 'emailChecked') continue;
	                if (!validationState[field]) {
	                    isValid = false;
	                    break;
	                }
	            }
	            
	            if (!isValid) {
	                $("#errorMsg").text("입력값을 다시 확인해주세요.").show();
	                return;
	            }
	        }

	        // 모든 검사 통과 후 AJAX 요청
	        $.ajax({
	            type: "POST",
	            url: "/views/mypage/updateUserAction.jsp",
	            data: $("#modifyForm").serialize() + "&isGoogleUser=" + isGoogleUser, // 구글 사용자 여부 전달
	            dataType: "json",
	            success: function (response) {
	                console.log("서버 응답:", response); // 디버깅용 로그
	                if (response.status === "success") {
	                    $("#successMsg").text("회원정보가 성공적으로 수정되었습니다.").show();
	                    $("#errorMsg").hide();
	                    setTimeout(() => window.location.href = "/info.mypage", 1500);
	                } else {
	                    $("#errorMsg").text(response.message || "회원정보 수정에 실패했습니다.").show();
	                }
	            },
	            error: function (xhr, status, error) {
	                console.error("AJAX 오류:", xhr.responseText); // 자세한 오류 정보
	                $("#errorMsg").text("서버 오류가 발생했습니다. 다시 시도해주세요.").show();
	            }
	        });
	    });
	});
	
	function confirmWithdraw() {
		  if(confirm("정말 탈퇴하시겠습니까?")) {
		    document.getElementById("withdraw-frm").submit();
		  }
		}
</script>

</body>
</html>