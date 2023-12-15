<<<<<<< HEAD
function saveDarkModePreference(mode) {
	    localStorage.setItem('darkMode', mode);
		}
		
		function loadDarkModePreference() {
		    return localStorage.getItem('darkMode');
		}

	//다크모드 버튼
	function darkMode() {
    let mode = $('html').attr("data-bs-theme");

    if (mode == 'dark') {
        $('html').attr("data-bs-theme", "light");
        $('.mode-change-btn').html('다크 모드');
        saveDarkModePreference('light');
    } else {
        $('html').attr("data-bs-theme", "dark");
        $('.mode-change-btn').html('라이트 모드');
        saveDarkModePreference('dark');
    }            
	} //다크모드 버튼 끝
	
	
	$(document).ready(function(){
		//다크 모드
	    let savedMode = loadDarkModePreference();
        if (savedMode === 'dark') {
            $('html').attr("data-bs-theme", "dark");
            $('.mode-change-btn').html('라이트 모드');
        } else {
            $('html').attr("data-bs-theme", "light");
            $('.mode-change-btn').html('다크 모드');
        }
	});
=======
function saveDarkModePreference(mode) {
        localStorage.setItem('darkMode', mode);
        }

        function loadDarkModePreference() {
            return localStorage.getItem('darkMode');
        }

    //다크모드 버튼
    function darkMode() {
    let mode = $('html').attr("data-bs-theme");

    if (mode == 'dark') {
        $('html').attr("data-bs-theme", "light");
        $('.mode-change-btn').html('다크 모드');
        saveDarkModePreference('light');
    } else {
        $('html').attr("data-bs-theme", "dark");
        $('.mode-change-btn').html('라이트 모드');
        saveDarkModePreference('dark');
    }
    } //다크모드 버튼 끝


    $(document).ready(function(){
        //다크 모드
        let savedMode = loadDarkModePreference();
        if (savedMode === 'dark') {
            $('html').attr("data-bs-theme", "dark");
            $('.mode-change-btn').html('라이트 모드');
        } else {
            $('html').attr("data-bs-theme", "light");
            $('.mode-change-btn').html('다크 모드');
        }
    });
>>>>>>> branch 'main' of https://github.com/YJY1129/Nongdam.git
