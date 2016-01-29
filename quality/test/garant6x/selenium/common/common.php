<?php
class Keys {
	const CANCEL = "\uE001";
	const HELP = "\uE002";
	const BACK_SPACE = "\uE003";
	const TAB = "\uE004";
	const CLEAR = "\uE005";
	const _RETURN = "\uE006";
	const ENTER = "\uE007";
	const SHIFT = "\uE008";
	const CONTROL = "\uE009";
	const ALT = "\uE00A";
	const PAUSE = "\uE00B";
	const ESCAPE = "\uE00C";
	const SPACE = "\uE00D";
	const PAGEUP = "\uE00E";
	const PAGEDOWN = "\uE00F";
	const END = "\uE010";
	const HOME = "\uE011";
	const LEFTARROW = "\uE012";
	const UPARROW = "\uE013";
	const RIGHTARROW = "\uE014";
	const DOWNARROW = "\uE015";
	const INSERT = "\uE016";
	const DELETE = "\uE017";
	const SEMICOLON = "\uE018";
	const EQUALS = "\uE019";
	const F1 = "\uE031";
	const F2 = "\uE032";
	const F3 = "\uE033";
	const F4 = "\uE034";
	const F5 = "\uE035";
	const F6 = "\uE036";
	const F7 = "\uE037";
	const F8 = "\uE038";
	const F9 = "\uE039";
	const F10 = "\uE03A";
	const F11 = "\uE03B";
	const F12 = "\uE03C";
	const _NULL = "\uE000";
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////  GET Objects                                                                            //////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TYPE: Ext
//DESC: Переключение в заданный фрейм
function SwitchToFrame(
		$session,
		$frame,
		$timeout = 10//таймаут, в течении которого пытаемся достучаться до фрейма
){
try{
	$res = true;
	$t=0;
	while ($res) {
		try {		
			if ($frame === null)
				 $session->frame(array($identElement=>null));
			else
				$session->frame(array('id'=>$frame));		
			$res = false;
			$result = true;
		} catch (Exception $e) {
			$res = ($t<$timeout);
			$t++;
			$result = false;
			sleep("1");
		}
	}	
	return $result;	
} catch (Exception $e) {
	echo "SwitchToFrame: ".$e."//Exception.";
	return false;
}
}

//TYPE: Ext
//DESC: Поиск объекта по заданным параметрам
//RESULT - element или false в случае ошибки 
function FindElementByParam(
	$session,
	$ident,//идентификатор, может быть id|xpath|class name|... (смотреть документацию по протоколу)
	$value,//значение идентификатора
	$timeout = 10,//таймаут, в течении которого ищем элемент
	$isEchoInLog = true 
){
	try{				
		$res = true;
		$t=0;
		while ($res) {
			try {			
				$element = $session->element($ident, $value);								
				$res = false;
				$result = true;
			} catch (Exception $e) {
				$res = ($t<$timeout);				
				$t++;
				$result = false;
				sleep("1");
			}
		}		
		if ($result) 
			$result = $element;
		else
			if ($isEchoInLog)
				echo ('Element: '.$ident.'='.$value.' is NOT Found!'."\n");
		return $result;
	} catch (Exception $e) {
		echo "FindElementByParam: ".$e."//Exception.";
		return false;
	}
}


//TYPE: Ext
//DESC: Search for multiple elements on the page
//RESULT - elements или false в случае ошибки
function FindElementsByParam(
		$session,
		$ident,//идентификатор, может быть id|xpath|... (смотреть документацию по протоколу)
		$value,//значение идентификатора
		$timeout = 10//таймаут, в течении которого ищем
){
	try{
		$res = true;
		$t=0;
		while ($res) {
			try {
				$elements = $session->elements($ident, $value);
				$res = false;
				$result = true;
			} catch (Exception $e) {
				$res = ($t<$timeout);
				$t++;
				$result = false;
				sleep("1");
			}
		}
		if ($result) $result = $elements;
		return $result;
	} catch (Exception $e) {
		echo "FindElementsByParam: ".$e."//Exception.";
		return false;
	}
}

//TYPE: Ext
//DESC: Посылаем нажатие клавиши
function PressKey(
		$session,
		$element,
		$key		
){
	try{		
		$command = '/value';
		$url = $session.'/element/'.$element->getID().$command;
		$curl = curl_init($url);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json;charset=UTF-8', 'Accept: application/json') );
		curl_setopt($curl, CURLOPT_POST, true);
		$postArgs = '{"value":["'.$key.'"]}';
		curl_setopt($curl, CURLOPT_POSTFIELDS, $postArgs);
		$raw_results = trim(WebDriverEnvironment::CurlExec($curl));
		curl_close($curl);		
		return true;
	} catch (Exception $e) {
		echo "PressKey: ".$e."//Exception.";
		return false;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////  EXTENDED functions                                                                    //////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TYPE: Ext
//DESC: Переходим в mainFrame
function _GoToMainFrame(
	$session	 
){
try{	
	for ( $i=0; $i<=5; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'utMainWindow';break;
			case 2: $frame = 'main_frame';break;
			case 3: $frame = 'main_frame';break;
			case 4: $frame = 'mainInfo';break;
			case 5: $frame = 'mainFrame';break;
		}
		$result = SwitchToFrame($session, $frame);			
		if (!$result) break;
	}	
	return $result;
} catch (Exception $e) {
	echo "_GoToMainFrame: ".$e."//Exception.";
	return false;
}
}
//TYPE: Ext
//DESC: Переходим во фрейм КЗ ППР
function _GoToPPRFrame($session){
try{
	_GoToMainFrame($session);
	$result = SwitchToFrame($session, 'cont_frame');	
	return $result;
} catch (Exception $e) {
	echo "_GoToPPRFrame: ".$e."//_GoToPPRFrame Exception.";
	return false;
}
}

//TYPE: Ext
//DESC: 
function _GoToAttributePPR_mainIfr_Frame($session){
try{
	for ( $i=0; $i<=2; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'forPopupFull5';break;
			case 2: $frame = 'mainIfr';break;			
		}
		$result = SwitchToFrame($session, $frame);
		if (!$result) break;
	}
	return $result;	
} catch (Exception $e) {
	echo "_GoToAttributePPR_mainIfr_Frame: ".$e."//_GoToAttributePPR_mainIfr_Frame.";
	return false;
}
}


//TYPE: Ext
//DESC: Переходим во фрейм диалога выбоа аттрибутов  КЗ ППР
function _GoToAttributePPRFrame($session){
try{
	_GoToAttributePPR_mainIfr_Frame($session);
	$result = SwitchToFrame($session, 'cont_itree');
	return $result;
} catch (Exception $e) {
	echo "_GoToAttributePPRFrame: ".$e."//_GoToAttributePPRFrame Exception.";
	return false;
}
}
						
//TYPE: Ext
//DESC: Переходим во фрейм документа
function _GoToDocFrame(
	$session
){
try{	
	_GoToMainFrame($session);
	//$session->frame(array('name'=>'doc_iframe'));
	$result = SwitchToFrame($session, 0);	
	return $result;	
} catch (Exception $e) {
	echo "_GoToDocFrame: ".$e."//_GoToDocFrame Exception.";
	return false;
}
}

//TYPE: Ext
//DESC: Переходим во фрейм выпадающей в IE кнопки "Установить закладку"
function _GoToPopupContextopAddBookmarkFrame($session){
try{
	for ( $i=0; $i<=1; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'forPopupContextopAddBookmark';break;
		}
		$result = SwitchToFrame($session, $frame);
		if (!$result) break;
	}
	return $result;
} catch (Exception $e) {
	echo "_GoToPopupContextopAddBookmarkFrame: ".$e."//_GoToPopupContextopAddBookmarkFrame Exception.";
	return false;
}
}

//TYPE: Ext
//DESC: Переходим в  фрейм выпадающего меню с выбором поиска посли клика на главном тулбаре "Поиск"
function _GoToForPopupContextopAllSearchFrame($session){
try{
	for ( $i=0; $i<=1; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'forPopupContextopAllSearch';break;
		}
		$result = SwitchToFrame($session, $frame);
		if (!$result) break;
	}
	return $result;
} catch (Exception $e) {
	echo "_GoToForPopupContextopAllSearchFrame: ".$e."//_GoToForPopupContextopAllSearchFrame Exception.";
	return false;
}
}
//TYPE: Ext
//DESC: Переходим в  фрейм выпадающего меню с выбором поиска посли клика на главном тулбаре "Моя информация"
function _GoToForPopupContextopMyInformation($session){
try{
	for ( $i=0; $i<=1; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'forPopupContextopMyInformation';break;			
		}
		$result = SwitchToFrame($session, $frame);
		if (!$result) break;
	}
	return $result;
} catch (Exception $e) {
	echo "_GoToForPopupContextopMyInformation: ".$e."//_GoToForPopupContextopMyInformation Exception.";
	return false;
}
}

//TYPE: Ext
//DESC: Переходим во фрейм прогресс индикатора после поиска
function _GoToProgressFrame(
	$session,
	$timeout
){
try{
	for ( $i=0; $i<=2; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'forPopupFullprogress';break;
			case 2: $frame = 'mainIfr';break;
		}
		$result = SwitchToFrame($session, $frame, $timeout);
		if (!$result) break;
	}
	return $result;
} catch (Exception $e) {
	echo "_GoToProgressFrame: ".$e."//_GoToProgressFrame Exception.";
	return false;
}
}

//TYPE: Ext
//DESC: Переходим в mainIfr , фрейм сохранения закладки
function _GoToMainIfrFrame($session){
try{
	for ( $i=0; $i<=2; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'forPopupFullDOC_BOOKMARK';break;
			case 2: $frame = 'mainIfr';break;
		}
		$result = SwitchToFrame($session, $frame);
		if (!$result) break;
	}
	return $result;
} catch (Exception $e) {
	echo "_GoToMainIfrFrame: ".$e."//_GoToMainIfrFrame Exception.";
	return false;
}
}

//TYPE: Ext
//DESC: 
function _GoToTabNavigatorFrame(
	$session	
){
try{
	for ( $i=0; $i<=6; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'utMainWindow';break;
			case 2: $frame = 'main_frame';break;
			case 3: $frame = 'main_frame';break;
			case 4: $frame = 'tab_frame';break;
			case 5: $frame = 'tab_manager';break;
			case 6: $frame = 'tab_navigator';break;
		}		
		$result = SwitchToFrame($session, $frame);			
		if (!$result) break;
	}
	return $result;	
} catch (Exception $e) {
	echo "_GoToTabNavigatorFrame: ".$e."//_GoToTabNavigatorFrame Exception.";
	return false;
}
}

//TYPE: Ext
//DESC:
function _GoToTabTaskPanelFrame($session){
	try{
		for ( $i=0; $i<=5; $i++) {
			switch ($i) {
				case 0: $frame = null;break;
				case 1: $frame = 'utMainWindow';break;
				case 2: $frame = 'main_frame';break;
				case 3: $frame = 'navigator_frame';break;
				case 4: $frame = 'tab_manager';break;
				case 5: $frame = 'tab_tasks_panel';break;				
			}
			$result = SwitchToFrame($session, $frame);
			if (!$result) break;
		}
		return $result;		
	} catch (Exception $e) {
		echo "_GoToTabTaskPanelFrame: ".$e."//_GoToTabTaskPanelFrame Exception.";
		return false;
	}
}
//TYPE: Ext
//DESC:
function _GoToTabDictionaryFrame($session){
	try{
		for ( $i=0; $i<=6; $i++) {
			switch ($i) {
				case 0: $frame = null;break;
				case 1: $frame = 'utMainWindow';break;
				case 2: $frame = 'main_frame';break;
				case 3: $frame = 'navigator_frame';break;
				case 4: $frame = 'tab_manager';break;
				case 5: $frame = 'tab_dictionary';break;
				case 6: $frame = 'dict_iframe';break;
			}			
			$result = SwitchToFrame($session, $frame);
			if (!$result) break;
		}
		return $result;
	} catch (Exception $e) {
		echo "_GoToTabDictionaryFrame: ".$e."//_GoToTabDictionaryFrame Exception.";
		return false;
	}
}
//TYPE: Ext
//DESC:
function _GoToDictionaryListTermins($session){
	try{
		_GoToTabDictionaryFrame($session);
		for ( $i=0; $i<=1; $i++) {
			switch ($i) {				
				case 0: $frame = 'tree_frameset';break;
				case 1: $frame = 'tree_frame';break;
				
			}						
			$result = SwitchToFrame($session, $frame);
			if (!$result) break;
		}
		return $result;
	} catch (Exception $e) {
		echo "_GoToDictionaryListTermins: ".$e."//_GoToDictionaryListTermins Exception.";
		return false;
	}
}

//TYPE: Ext
//DESC: 
function _GoToBaseSearchFrame($session){
try{
	_GoToMainFrame($session);		
	$result = SwitchToFrame($session, 0);		
	return $result;
} catch (Exception $e) {
	echo "__GoToBaseSearchFrame: ".$e."//__GoToBaseSearchFrame Exception.";
	return false;
}
}
//TYPE: Ext
//DESC: 
function _GoTbChildFrame($session){
try{
	for ( $i=0; $i<=2; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'utMainWindow';break;
			case 2: $frame = 'tb_child';break;
		}
		$result = SwitchToFrame($session, $frame);
		if (!$result) break;
	}
	return $result;	
} catch (Exception $e) {
	echo "__GoTbChildFrame: ".$e."//__GoTbChildFrame Exception.";
	return false;
}
}
//TYPE: Ext
//DESC: 
function _GoTbMainFrame(
	$session	
){
try{
	for ( $i=0; $i<=2; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'utMainWindow';break;
			case 2: $frame = 'tb_main';break;			
		}
		$result = SwitchToFrame($session, $frame);			
		if (!$result) break;
	}
	return $result;
} catch (Exception $e) {
	echo "__GoTbMainFrame: ".$e."//__GoTbMainFrame Exception.";
	return false;
}
}
//TYPE: Ext
//DESC: 
function _GoToTbNavigatorFrame($session){
try{
	for ( $i=0; $i<=4; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'utMainWindow';break;
			case 2: $frame = 'main_frame';break;
			case 3: $frame = 'navigator_frame';break;
			case 4: $frame = 'tab_toolbar';break;			
		}
		$result = SwitchToFrame($session, $frame);
		if (!$result) break;
	}
	return $result;	
} catch (Exception $e) {
	echo "__GoТoTbNavigatorFrame: ".$e."//__GoТoTbNavigatorFrame Exception.";
	return false;
}
}
//TYPE: Ext
//DESC: 
function _GoToNavigatorFrame($session){
try{
	for ( $i=0; $i<=5; $i++) {
		switch ($i) {
			case 0: $frame = null;break;
			case 1: $frame = 'utMainWindow';break;
			case 2: $frame = 'main_frame';break;
			case 3: $frame = 'navigator_frame';break;
			case 4: $frame = 'tab_manager';break;
			case 5: $frame = 'tab_menu';break;
		}
		$result = SwitchToFrame($session, $frame);
		if (!$result) break;
	}
	return $result;	
} catch (Exception $e) {
	echo "__GoToNavigatorFrame: ".$e."//__GoToNavigatorFrame Exception.";
	return false;
}
}

//TYPE: Ext
//DESC:
function _GoToPageControlNavigatorFrame($session){
	try{
		for ( $i=0; $i<=5; $i++) {
			switch ($i) {
				case 0: $frame = null;break;
				case 1: $frame = 'utMainWindow';break;
				case 2: $frame = 'main_frame';break;
				case 3: $frame = 'navigator_frame';break;
				case 4: $frame = 'tab_manager';break;
				case 5: $frame = 'tab_navigator';break;
			}
			$result = SwitchToFrame($session, $frame);
			if (!$result) break;
		}
		return $result;		
	} catch (Exception $e) {
		echo "__GoToPageControlNavigatorFrame: ".$e."//__GoToPageControlNavigatorFrame Exception.";
		return false;
	}
}

//TYPE: Ext
//DESC: Переходим в карточку отправки консультации
function _GoToSendConsultationFrame(
		$session
){
	try{
		_GoToMainFrame($session);
		$result = SwitchToFrame($session, 'cont_frame');
		return $result;
	} catch (Exception $e) {
		echo "_GoToSendConsultationFrame: ".$e."//_GoToSendConsultationFrame Exception.";
		return false;
	}
}

//TYPE: Ext
//DESC:
function _GoToFulleditionPickerFrame($session){
	try{
		for ( $i=0; $i<=2; $i++) {
			switch ($i) {
				case 0: $frame = null;break;
				case 1: $frame = 'forPopupFulleditionPicker';break;
				case 2: $frame = 'mainIfr';break;				
			}
			$result = SwitchToFrame($session, $frame);
			if (!$result) break;
		}
		return $result;
	} catch (Exception $e) {
		echo "_GoToFulleditionPickerFrame: ".$e."//_GoToFulleditionPickerFrame Exception.";
		return false;
	}
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////                                                  LOGIN\LOGAUT functions                                                                                 //////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TYPE: Login\Logaut
//DESC: 
function StartBrowser(
	$session,
	$port=''
){	
try{
	$adress='http://rykov.garant.ru';
	if ($port=='')
		$session->open($adress);
	else
		$session->open($adress.':'.$port);
	return true;
} catch (Exception $e) {
	echo "StartBrowser: ".$e."//StartBrowser Exception.";
	return false;
}
}

//TYPE: Login\Logaut
//DESC: Логин гостём
function GuestLogin($session){	
try{
	StartBrowser($session);
	FindElementByParam($session, 'xpath','/html/body/table/tbody/tr/td/table/tbody/tr/td[2]/form/fieldset/legend/a')->click();	
	sleep("5");
	$result = _GoToBaseSearchFrame($session);
	//$session->window($hahdle)->postSize(array('width' => 300, 'height' => 300));
	$session->window()->maximize();
	return $result;
} catch (Exception $e) {
	echo "GuestLogin: ".$e."//GuestLogin Exception.";
	return false;
}
}
//TYPE: Login\Logaut
//DESC: Логин существующим пользователем
function LoginExistingUser(
	$session,
	$login,
	$pwd='',
	$timeout=30
){
try{
	$result = true;
	StartBrowser($session);
	FindElementByParam($session, 'id','l')->value(array('value' => array($login)));
	FindElementByParam($session, 'id','p')->value(array('value' => array($pwd)));
	FindElementByParam($session, 'id','submitB')->click();	
	try{		
		sleep('2');
		$session->accept_alert();		
		echo ('Close Alert LoginExistingUser!');//Неверное имя пользователя или неправильный пароль!
		$result = false;
	} catch (Exception $e) {//NO Alert LoginExistingUser
		//WAITE MainFrame
		$t=0;
		$res = true;		
		while ($res){				
			$result = _GoToBaseSearchFrame($session);//Main Frame Loading
			if ($result) break;
			$res = ($t<$timeout) ;
			echo "MAINFRAME_TIMEOUT=".$t;
			$t++;
			sleep("1");							
		}// while: END WAITE MainFrame
	}	
	//CLOSE HELP WND
	$hahdle = $session->window_handles();	
	if (sizeof($hahdle) == 2) {//если есть второе окно, считаем его Help-ом и закрываем
		$session->focusWindow($hahdle[1]);
		$session->deleteWindow();
		$session->focusWindow($hahdle[0]);
		$session->window()->maximize();
	}
	return $result;		
} catch (Exception $e) {
	echo "LoginExistingUser: ".$e."//LoginExistingUser Exception!";
	return false;
}
}
//TYPE: Login\Logaut
//DESC: Логин новым пользователем
function LoginNewUser(
	$session, 
	$login, 
	$pwd='',
	$isAutoLogin=false,
	$timeout=30
){	
try{
	$result = true;
	StartBrowser($session);
	FindElementByParam($session, 'id','regSwitch')->click();	
	FindElementByParam($session, 'id','new_login')->value(array('value' => array($login)));
	FindElementByParam($session, 'id','new_pass')->value(array('value' => array($pwd)));
	FindElementByParam($session, 'id','rep_pass')->value(array('value' => array($pwd)));
	FindElementByParam($session, 'id','fio')->value(array('value' => array($login)));	
	if ($isAutoLogin == false) {
		FindElementByParam($session, 'id','automatic_login_field_new_user')->click();
	};		
	FindElementByParam($session, 'id','submitNewUser')->click();	
	try {
		FindElementByParam($session, 'id','regcompl')->click();
		$result = true;
	} catch(Exception $e) {		
		$result = false;//Если regcompl не появилась, считаем что пользователь с указанным логином уже зарегистрирован
		echo ('No Existing regcompl!');
	}
	if ($result==true){
		//WAITE MainFrame
		$t=0;
		$res = true;
		while ($res){				
			$result = _GoToBaseSearchFrame($session);//Main Frame Loading
			if ($result) break;
			$res = ($t<$timeout) ;
			echo "MAINFRAME_TIMEOUT=".$t;
			$t++;
			sleep("1");							
		}// while: END WAITE MainFrame
		//CLOSE HELP WND
		$hahdle = $session->window_handles();	
		if (sizeof($hahdle) == 2) {//если есть второе окно, считаем его Help-ом и закрываем
			$session->focusWindow($hahdle[1]);
			$session->deleteWindow();
			$session->focusWindow($hahdle[0]);
			$session->window()->maximize();
		}
	}
	return $result;		
} catch (Exception $e) {
	echo "LoginNewUser: ".$e."//LoginNewUser Exception.";
	return false;
}
}

//TYPE: Login\Logaut
//DESC: Логин 
function LoginAnyHow(
	$session,
	$login,
	$pwd='',
	$attempt=50
	){	
try{	
	if (LoginExistingUser($session,$login,$pwd) !=true) {
		$res = false;
		$i=0;
		while ((!$res)AND(i<$attempt)) {//Пытаемся N раз зарегистрироваться под логином $login.$i
			if ($i>0) {
				$res = LoginExistingUser($session,$login,$pwd);
				if ($res==false) $res = LoginNewUser($session,$login,$pwd);
			} else {
				$res = LoginNewUser($session,$login,$pwd);
			}
			$login = $login.$i;
			$i++;			
		}
	};	
	return true;
} catch (Exception $e) {
	echo "LoginAnyHow: ".$e."//LoginAnyHow Exception.";
	return false;
}
}

//TYPE: Login\Logaut
//DESC: Логаут
function ExitIntranet($session){
try{
	_GoTbMainFrame($session);
	sleep("2");
	FindElementByParam($session, 'id', 'opExit')->click();	
	return true;
} catch (Exception $e) {
	echo "ExitIntranet: ".$e."//ExitIntranet Exception.";
	return false;
}		
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////                                                  SEARCH functions                                                                                               //////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function CS_____SEARCH(){};
//TYPE: Search
//DESC: Ожидаем список после поиска
function WaiteList(
	$session,
	$timeout
){
//WAITE LIST
	$t=0;
	$res = true;
	while ($res){		
		_GoToMainFrame($session);
		$element = FindElementByParam($session,'xpath', '/html/body/div[2]/table/tbody/tr/td/table/tbody/tr/td/table/tbody/tr/td[3]', 0, false);
		if ($element!=false) {
			$res = false;//Search is Done
			$result = true;
			echo "SEARCH_DONE"."\n";
		} else {
			$res = ($t<$timeout);
			if ($t==0)echo "SEARCH_TIMEOUT=".$t.'% '; else echo $t.'% ';
			$t++;
			sleep("1");
			$result = false;
			// Если в прогресс индикаторе появилась кнопка "Закрыть" нажимаем её и считаем, что документов не найдено			
			_GoToProgressFrame($session, 0);
			$close_but = FindElementByParam($session, 'id', 'close_but', 0, false);
			try {
				if (($close_but!=false) AND ($close_but->attribute('id') == 'close_but')) {
					$close_but->click();
					echo 'SEARCH NOT FOUND.';
					break;
				}
				} catch (Exception $e) {						
				if ($res == false) {// таймаут  закончился, И  Кнопки "Закрыть" нет, значит видимо поиск завис, пытаемся нажать "Прервать"
					FindElementByParam($session, 'id', 'formButton')->click();
					echo 'SEARCH IS BREAK AFTER EXPIRED TIMEOUT.';
				};
			}		
		}				
	}// while: END WAITE LIST
	return $result;
}
//TYPE: Search
//DESC: Базовй поиск
function BaseSearch(
	$session, 
	$context, 
	$informationType='Все документы',
	$timeout=5
) {
try{
	_GoToMainFrame($session);		
	if (SwitchToFrame($session, 0, 1)== false)//если формы базового поиска нет, тогда переходим в ОМ что бы она появилась	
		GoToMainMenu($session);
	
	_GoToBaseSearchFrame($session);
	FindElementByParam($session, 'id', 'searchContext')->value(array('value' => array($context)));
	//select InformationType
	switch ($informationType) {		
		case 'Все документы':
			$informationType='Все документы';
			break;		
		case 'Акты органов власти':
			$informationType='Акты органов власти';
			break;		
		case 'Судебная практика':
			$informationType='Судебная практика';
			break;
		case 'Формы документов':
			$informationType='Формы документов';
			break;
		case 'Комментарии':
			$informationType='Комментарии';
			break;
		case 'Правовой консалтинг':
			$informationType='Правовой консалтинг';
			break;
		case 'Бухгалтерские проводки':
			$informationType='Бухгалтерские проводки';
			break;		
		case 'Региональные акты':
			$informationType='Региональные акты';
			break;		
		case 'Международные договоры':
			$informationType='Международные договоры';
			break;		
		case 'Проекты законов':
			$informationType='Проекты законов';
			break;		
		case 'Нормативно-техническая документация':
			$informationType='Нормативно-техническая документация';
			break;		
		case 'Документы ОАО "Газпром"':
			$informationType='Документы ОАО "Газпром"';
			break;			
	}
	
	$searchTypeList = FindElementByParam($session, 'id', 'searchTypeList');
	$allInformationTypes = FindElementsByParam($searchTypeList, 'tag name', 'span');
	$isSearchStart = false;
	foreach ($allInformationTypes as $i=>$currentInformationType){
		if ($informationType == $currentInformationType->text()) {
			//нашли нужный тип информации, кликаем
			$currentInformationType->click();
			//Нажимаем "Найти"
			try { FindElementByParam($session, 'id', 'searchStart')->click(); } catch (Exception $e) { echo'Seach already started!';};	
			$isSearchStart = true;
			break;
		}		
	}
	if ($isSearchStart==false) {// В зоне видимости не нашли нужный тип, разворачиваем остальные типы кликом по "Еще" и уже в выпадающем окне ищем нужный тип
		foreach ($allInformationTypes as $i=>$currentInformationType){
			if ('Еще' == $currentInformationType->text()) {
				$currentInformationType->click();
				break;
			}
		}		
		SwitchToFrame($session, null);				
		$element = FindElementByParam($session, 'xpath', '/html/body/div[16]');		
		if ( strpos($element->attribute('class'), 'select-listContainer') === false) { //если div[16] не тот DIV, видимо не прогрузился сплеш, и берём div[15]
			$element = FindElementByParam($session, 'xpath', '/html/body/div[15]');
		}		
		$allInformationTypes = FindElementsByParam($element, 'tag name', 'span');		
		//print_r($allInformationTypes);
		$isSearchStart = false;
		foreach ($allInformationTypes as $i=>$currentInformationType){
			//echo $i.'_______'.$currentInformationType->text();
			if ($informationType == $currentInformationType->text()) {
				//нашли нужный тип информации, кликаем
				$currentInformationType->click();
				$isSearchStart = true;
				break;
			}
		}
		if ($isSearchStart==false) {//если даже в выпвдвющем списке не нашли нужный тип информации, тогда просто нажимаем "Найти"
			_GoToBaseSearchFrame($session);
			FindElementByParam($session, 'id', 'searchStart')->click();
		}		
	}
	//Если есть сообщение "Документов Указанного вида правовой информации не найдено...", гасим его  и выходим с result=false
	try{		
		sleep('1');
		$session->dismiss_alert();
		$result = false;
		$searchDone = true;
		echo ('Close : Documents of the specified type information if NOT found!');//Документов указанного вида правовой информации не найдено		
	} catch (Exception $e) {//NO Alert  SaveBookmark
		$searchDone = false;
	}	
	if (!$searchDone) {
		$result = WaiteList($session, $timeout);
	}
	return $result;
} catch (Exception $e) {
	echo "BaseSearch: ".$e."//BaseSearch Exception.";
	return false;
}
}
//TYPE: Search
//DESC: Выбираем аттрибут в диалоге выбора аттрибутов 
function SelectAttributeInPPR(
	$session,
	$attribute,
	$type = 'ИЛИ'	
){
try{	
	_GoToAttributePPRFrame($session);
	$subAttr = explode('\\', $attribute);
	if (count($subAttr)>1) {//есть разворачивание узлов?
		$isExpand=true;
	} else {
		$isExpand=false;
	}
	//print_r($subAttr);	
	foreach ($subAttr as $j=> $subItem){
		$start_time = microtime(true);
		//echo $j.'*'.$subItem."\n";
		if ($j == (count($subAttr)-1) ) {		
			$isExpendItem = false;
		} else {
			$isExpendItem = true;
		}		
		$elements = FindElementsByParam($session, 'class name', 'rowContainer');		
		foreach ($elements as $i=> $element){						
			$cur_element = FindElementByParam($element, 'class name','text', 5);
			
			if ($cur_element!=false)
				try{		
					$text = $cur_element->text();
				} catch (Exception $e) {
					$text = '';
					echo 'SelectAttributeInPPR: error get TEXT element!';
				}
			else {
				$text = '';
				echo 'SelectAttributeInPPR: error get element!';		
			} 
			if ($text == $subItem) {
				//echo $cur_element->text().'^^^^^^^^^^^^^'.$i."\n";
				if ($isExpendItem == false){// если кликаем, а не разворачиваем подуровень					
					$img = FindElementByParam($element, 'class name','attribute');	
					$type = trim($type);
					if ($type == 'ИЛИ') { $img->click(); };
					if ($type == 'И') { $img->click(); $img->click(); };
					if ($type == 'КРОМЕ') { $img->click();$img->click(); $img->click(); };					
					if ($isExpand==true) $parent_item->click();//сворачиваем родительский узел , если он был развернут, в начальное положение
				}else {//РАЗВОРАЧИВАЕМ УЗЕЛ
					echo '--'.$subItem;
					$item = FindElementByParam($element, 'class name','first');					
					$item = FindElementByParam($item, 'tag name','img');					
					if ($j==0) { //запоминаем родительский узел, что бы потом его свернуть в начальное положение
						$parent_item = $item; 						
					} 
					$item->click();
				}
				break;				
			}
		}
		$elements=null; //зануляем массив
		$exec_time = microtime(true) - $start_time;
		//echo "\n ТIME_".$subItem."=".$exec_time."\n";
	}

} catch (Exception $e) {
	echo "SelectAttributeInPPR: ".$e."//SelectAttributeInPPR Exception.";
	return false;
}
}

//TYPE: Search
//DESC: Заполняем  аттрибуты в диалоге выбора аттрибутов 
function FillAttributeInPPR(
	$session,
	$param,
	$link	
){
try{	
	$elements = FindElementsByParam($session, 'tag name', 'u');
	$res = false;	
	foreach ( $elements as $l=>$element){//перебираем все ссылки в КЗ и ищем нужную		
		if ($element->text() == $link) {			
			$element->click();//открываем диалог выбора аттрибутов			
			$res = true;
			break;
		}
	}
	if (!$res) 		
		echo ('In kz PPR attribute:'.$link.'NOT found');
	else {	
		_GoToAttributePPRFrame($session);
		preg_match('/^.*'.$atr.' - (.*)/', $param, $value);
		//добааляем в начало ИЛИ, если нет
		if ( (!(strpos($value[1], 'ИЛИ ') === 0) ) AND (!(strpos($value[1], 'И ') === 0)) AND (!(strpos($value[1], 'КРОМЕ ') === 0)) )
			$value[1] = 'ИЛИ '.$value[1];
		//echo '---'.$value[1];
		preg_match_all('/(ИЛИ |КРОМЕ |И | )(.+)( ИЛИ| КРОМЕ| И|$)/U', $value[1], $out);
		//print_r($out[1]);
		//print_r($out[2]);
		//print_r($out[3]);						
		foreach ( $out[2] as $k=>$attr){		
			if ($k==0 ) {								
				//echo '<<<<<<'.$attr.'>>>>';								
				//echo $out[1][0];
				SelectAttributeInPPR($session, $attr, $out[1][0]);
			} else {
				//echo '!!!!!!!!!!!!<<<<<<'.$attr.'>>>>';
				//echo $out[1][$k];
				SelectAttributeInPPR($session, $attr, $out[3][$k-1]);
			}
		}
		_GoToAttributePPR_mainIfr_Frame($session);
		FindElementByParam($session,'id', 'b_ok')->click();		
	}

} catch (Exception $e) {
	echo "FillAttributeInPPR: ".$e."//FillAttributeInPPR Exception.";
	return false;
}
}

//TYPE: Search
//DESC: Заполняем  аттрибуты, связанные с датами, в диалоге выбора аттрибутов 
function FillAttributeDateInPPR(
	$session,
	$param,
	$link	
){
try{	
	preg_match('/^.*'.$atr.' - (.*)/', $param, $value);
	//добааляем в конец пробел, что бы регулярное выражение корректно отрабатывало	
	$value[1] = $value[1].' ';
	//echo '---'.$value[1].')---';
	preg_match_all('/(с |по )(.*) /U', $value[1], $out);
	//print_r($out[1]);
	//print_r($out[2]);	
	foreach ( $out[2] as $k=>$attr){
		$pref = trim($out[1][$k]);
		//echo '111-'.$pref."\n";
		$date = trim($out[2][$k]);
		//echo '222-'.$date."\n";		
		if ($pref == 'с') {
			switch ($link) {
				case 'Дата':
					$element = FindElementByParam($session, 'id', 'from_AT_PUBLISHING_DATE');
					break;
				case 'Правовой календарь.Вступление в силу':
					$element = FindElementByParam($session, 'id', 'from_AT_LC_IN_DATE');
					break;
				case 'Правовой календарь.Утрата силы':
					$element = FindElementByParam($session, 'id', 'from_AT_LC_ABOLISHED_DATE');
					break;
				case 'Правовой календарь.Внесение изменений':
					$element = FindElementByParam($session, 'id', 'from_AT_LC_CHANGED_DATE');
					break;
				case 'ДАТА В МЮ':
					$element = FindElementByParam($session, 'id', 'from_AT_REG_DATE');
					break;
			}
		}
		if ($pref == 'по') {
			switch ($link) {
				case 'Дата':
					$element = FindElementByParam($session, 'id', 'to_AT_PUBLISHING_DATE');
					break;
				case 'Правовой календарь.Вступление в силу':
					$element = FindElementByParam($session, 'id', 'to_AT_LC_IN_DATE');
					break;
				case 'Правовой календарь.Утрата силы':
					$element = FindElementByParam($session, 'id', 'to_AT_LC_ABOLISHED_DATE');
					break;
				case 'Правовой календарь.Внесение изменений':
					$element = FindElementByParam($session, 'id', 'to_AT_LC_CHANGED_DATE');
					break;
				case 'ДАТА В МЮ':
					$element = FindElementByParam($session, 'id', 'to_AT_REG_DATE');
					break;
			}
		}		
		$element->clear();
		$element->value(array('value' => array($date)));
	}
} catch (Exception $e) {
	echo "FillAttributeDateInPPR: ".$e."//FillAttributeDateInPPR Exception.";
	return false;
}
}


//TYPE: Search
//DESC: Поиск по реквизитам 
function SearchInPPR(
	$session, 	
	$params='', // параметры, как в логе сервера
	$timeout=20
) {
try{
	_GoTbMainFrame($session);	
	FindElementByParam($session, 'id', 'opAllSearch')->click();
	sleep('2');
	_GoToForPopupContextopAllSearchFrame($session);	
	FindElementByParam($session, 'id', 'opAttributeSearch')->click();
	if (_GoToPPRFrame($session)) {
		if (params != '') { //если param='' тогда выполняем поиск по пустой КЗ		
			$params = explode('; ', $params);	
			$atribs = array(
				'СЛОВА В НАЗВАНИИ',
				'СЛОВА В ТЕКСТЕ',
				'СТАТУС',
				'СТАТУС В МЮ',
				'Дата',
				'ТИП',
				'ДАТА В МЮ',
				'НОМЕР В МЮ',
				'НОМЕР',
				'ВИД ИНФОРМАЦИИ',
				'ТЕРРИТОРИЯ',
				'ЗНАЧИМОСТЬ',
				'БЛОК',
				'ОРГАН',
				'РАЗДЕЛ',
				'Искать в недействующих редакциях',		
				'Правовой календарь.Вступление в силу',
				'Правовой календарь.Утрата силы',
				'Правовой календарь.Внесение изменений'
			);
			foreach ($params as $i=>$param) {		
				foreach ($atribs as $j=>$atr ) {				
					if (!(strpos($param, $atr.' -') === false) ){
						//echo '----------'.$param;					
						_GoToPPRFrame($session);						
						if ($i==0) sleep('1');
						switch ($atr) {
							case 'СЛОВА В НАЗВАНИИ':
								preg_match('/^.*'.$atr.' - (.*)/', $param, $value);
								$value = $value[1];						
								$element = FindElementByParam($session, 'id', 'AT_TEXT_NAME');
								sleep('1');
								$element->clear();
								$element->value(array('value' => array($value)));
								break;
							case 'СЛОВА В ТЕКСТЕ':
								preg_match('/^.*'.$atr.' - (.*)/', $param, $value);
								$value = $value[1];						
								$element = FindElementByParam($session, 'id', 'AT_TEXT_BODY');
								sleep('1');
								$element->clear();
								$element->value(array('value' => array($value)));
								break;
							case 'СТАТУС В МЮ':						
								FillAttributeInPPR($session, $param, 'Статус регистрации');
								break;
							case 'СТАТУС':						
								FillAttributeInPPR($session, $param, 'Статус');
								break;					
							case 'ТИП':
								FillAttributeInPPR($session, $param, 'Тип');
								break;
							case 'ДАТА В МЮ':
								FillAttributeDateInPPR($session, $param, $atr);
								break;
							case 'Дата':
								FillAttributeDateInPPR($session, $param, $atr);
								break;
							case 'НОМЕР В МЮ':						 
								FillAttributeInPPR($session, $param, 'Номер регистрации в МинЮсте');
								break;
							case 'НОМЕР':
								//с номерами есть несколько страниц, по хорошему надо искать на всех, а не только на первой
								FillAttributeInPPR($session, $param, 'Номер документа');
								break;
							case 'ВИД ИНФОРМАЦИИ':
								FillAttributeInPPR($session, $param, 'Вид правовой информации');
								break;
							case 'ТЕРРИТОРИЯ':
								FillAttributeInPPR($session, $param, 'Территория регулирования');						
								break;
							case 'ЗНАЧИМОСТЬ':
								FillAttributeInPPR($session, $param, 'Значимость');
								break;
							case 'БЛОК':
								FillAttributeInPPR($session, $param, 'Информационный блок');						
								break;
							case 'ОРГАН':
								FillAttributeInPPR($session, $param, 'Орган/Источник');
								break;
							case 'РАЗДЕЛ':
								FillAttributeInPPR($session, $param, 'Раздел/Тема');						 
								break;
							case 'Искать в недействующих редакциях':
								preg_match('/^.*'.$atr.' - (.*)/', $param, $value);
								$value = $value[1];
								if ($value != 'Нет') {
									$element = FindElementByParam($session, 'id', 'AT_EDITION');						
									$element->value(array('value' => array($value)));
								}						
								break;
							case 'Правовой календарь.Вступление в силу':
								FillAttributeDateInPPR($session, $param, $atr);
								break;
							case 'Правовой календарь.Утрата силы':
								FillAttributeDateInPPR($session, $param, $atr);
								break;
							case 'Правовой календарь.Внесение изменений':
								FillAttributeDateInPPR($session, $param, $atr);
								break;
						}					
								
					}
				}
			}
		
		}
		_GoToMainFrame($session);
		FindElementByParam($session, 'id', 'b_search')->click();
		$result = WaiteList($session, $timeout);
	} else {
		echo 'KZ PPR is NOT Open!';
		$result = false;	
	}	
	return $result;
} catch (Exception $e) {
	echo "SearchInPPR: ".$e."//SearchInPPR Exception.";
	return false;
}
}

//TYPE: Search
//DESC: Открываем новостную ленту
function OpenNewsLine(
	$session,	
	$timeout = 30
) {
try{
	_GoTbMainFrame($session);	
	FindElementByParam($session, 'id', 'opMyInformation')->click();	
	_GoToForPopupContextopMyInformation($session);	
	FindElementByParam($session,'id', 'opOpenNewsLine')->click();
	$result = WaiteNewsLine($session, $timeout);
	return $result;
} catch (Exception $e) {
	echo "OpenNewsLine: ".$e."//OpenNewsLine Exception.";
	return false;
}
}
//TYPE: Search
//DESC: Открываем Толковый словарь
function OpenDictionary(
		$session,
		$timeout = 30
) {
	try{		
		_GoTbMainFrame($session);
		FindElementByParam($session, 'id', 'opAllSearch')->click();
		sleep('2');
		_GoToForPopupContextopAllSearchFrame($session);
		FindElementByParam($session, 'id', 'opOpenDict')->click();
		$result = WaiteDictionary($session, $timeout);
		return $result;
	} catch (Exception $e) {
		echo "OpenNewsLine: ".$e."//OpenNewsLine Exception.";
		return false;
	}
}

//TYPE: Search
//DESC: Открываем нужный термин в ТС или же Пробегаемся по N терминам в ТС 
function OpenTerminsInDictionary(
		$session,
		$termin = '',// название термина(должно совпадать с названием в дереве терминов ТС), если не указано тогда просто открываем $count первых
		$count = 1//количество терминов, которое надо открыть, только в том случае если $termin = '' 
) {
	try{
		OpenDictionary($session);		
		$elements = FindElementsByParam($session, 'class name','line');
		if ($termin == '') { 
			$i = 0;
			foreach($elements as $i=>$element) {
				FindElementByParam($element, 'class name','text')->click();			
				$i++;
				if ($i == $count) break;			
			}
		} else {
			foreach($elements as $i=>$element) {
				$cur_element = FindElementByParam($element, 'class name','text');							
				if ($cur_element->text() == $termin) {
					$cur_element->click();
					break;
				}
			}
		}			
		$result = WaiteDictionary($session, $timeout);
		return $result;
	} catch (Exception $e) {
		echo "OpenTerminsInDictionary: ".$e."//OpenTerminsInDictionary Exception.";
		return false;
	}
}



//TYPE: Search
//DESC: Контекстный поиск в документе
function SearchInDocument(
		$session,
		$context
){
	try{
		$result = WaiteDoc($session, 2);
		//если документ не открыт, тогда ничего не делаем и выходим  
		if ($result) {
			_GoTbChildFrame($session);
			FindElementByParam($session, 'id', 'opFindContext')->click();			
			SwitchToFrame($session, null);
			SwitchToFrame($session, 'utMainWindow');
			SwitchToFrame($session, 'search');
			$element = FindElementByParam($session, 'id', 'searchContext');
			try {			 
				$element->value(array('value' => array($context)));
			} catch (Exception $e) {
				sleep('1');
				echo ('SearchInDocument: set value again.');
				$element->value(array('value' => array($context)));
			}
			FindElementByParam($session, 'id', 'searchNext')->click();
			//Проверяем что нет диалога "Поиск завержён" (ничего не найдено)
			try {
				sleep('1');
				$session->accept_alert();
				echo "\n"."SearchInDocument: Search NOT Found!";
				$result = false;
			} catch (Exception $e) {
				$result = true;
			}		
		} else {
			echo "\n"."SearchInDocument: Document NOT Found!";
		}
		return $result; 
	} catch (Exception $e) {
		echo "SearchInDocument: ".$e."//SearchInDocument Exception.";
		return false;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////                                                  LIST functions                                                                                                     //////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function CS_____LIST(){};
//TYPE: List
//DESC: Клик по документу в списке.  Можно указывать номер документа , по котором надо кликнуть
function ClickDocumentOnList(
	$session,
	$docNumberInList=1, //1-60
	$timeout=30
){		
try{
	if ($docNumberInList==0) $docNumberInList = 1;
	if ($docNumberInList==1) {
		$xpathDoc = '/html/body/div[2]/table/tbody/tr/td/table/tbody/tr/td/table/tbody/tr/td[3]';						 
	} else {
		$xpathDoc = '/html/body/div[2]/table/tbody/tr['.$docNumberInList.']/td/table/tbody/tr/td/table/tbody/tr/td[3]';		
	}
	//$src = $session->element('xpath', '/html/body/div[2]/table/tbody/tr/td/table/tbody/tr/td/table/tbody/tr/td[3]')->attribute('title');		
	_GoToMainFrame($session);
	$element = FindElementByParam($session, 'xpath', $xpathDoc);
	if ($element!=false) { 
		$element->click();
		if ($docNumberInList!=1) 
			$element->click();//Если не первый документ, то нужен второй клик, ибо первый только переводит фокус	
		$result = WaiteDoc($session, $timeout);
	} else {		
		$result= false;
		echo ('ClickDocumentOnList: document in List NOT Found!'."\n"); 
	}
	return $result;
} catch (Exception $e) {
	echo "ClickDocumentOnList: ".$e."//ClickDocumentOnList Exception.";
	return false;
}	
}

//TYPE: List
//DESC: Клик в статусбаре по следующему  документу в списке
function GoNextDocumentInList(
	$session
){		
try{
	$result = false;
	_GoToTabNavigatorFrame($session);
	sleep('2');
	try{
		$element = FindElementByParam($session, 'id', 'doclistItemNext');
		if ($element!=false) 
			$element->click();
		else {
			echo('GoNextDocumentInList: not click on doclistItemNext!');
			$result = false;
		}			
		$result = true;
	} catch (Exception $e) {
		echo ' DoclistItemNext NOT found!';
		$result = false;
	}		
	return $result;
} catch (Exception $e) {
	echo "GoNextDocumentInList: ".$e."//GoNextDocumentInList Exception.";
	return false;
}	
}
//TYPE: List
//DESC: Клик в статусбаре по предыдущему документу в списке
function GoPreviousDocumentInList(
	$session	
){		
try{
	$result = false;
	_GoToTabNavigatorFrame($session);
	sleep('2');
	try{		
		$element = FindElementByParam($session, 'id', 'doclistItemPrevious');
		if ($element!=false)
			$element->click();
		else {
			echo('GoNextDocumentInList: not click on doclistItemPrevious!');
			$result = false;
		}
		
		$result = true;
	} catch (Exception $e) {
		echo ' DoclistItemPrevious NOT found!';
		$result = false;
	}	
	return $result;
} catch (Exception $e) {
	echo "GoPreviousDocumentInList: ".$e."//GoPreviousDocumentInList Exception.";
	return false;
}	
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////                                                  DOCUMENT functions                                                                                             //////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function CS_____DOCUMENT(){};

//TYPE: Document
//DESC: Ожидаем документ
function WaiteDoc(
		$session,
		$timeout=30
){
//WAITE Document
	$t=0;
	$res = true;
	$result = false;
	while ($res){
		try {
			_GoToMainFrame($session);
			sleep('1');
			$session->frame(array('id'=>0));
			$element= $session->element('id', 'list');//если документа ещё нет, будет исключение
			$res = false;
			$result = true;
			echo "OPEN_DOC_DONE"."\n";
		} catch (Exception $e) {
			$res = ($t<$timeout);
			if ($t==0)echo "WAITE_DOC_TIMEOUT=".$t.'% '; else echo $t."% ";
			$t++;
			sleep("1");
		}
	}// while: END WAITE DOCUMENT	
	return $result;
}
//TYPE: Document
//DESC: Ожидаем сравнение редакций
function WaiteCompareRedaction(
		$session,
		$timeout=30
){
	//WAITE Document
	$t=0;
	$res = true;
	$result = false;
	while ($res){
		try {
			_GoToMainFrame($session);
			sleep('1');
			$session->frame(array('id'=>0));
			//$element= $session->element('class name', 'blockChangesInfoContainerOpened');//если документа ещё нет, будет исключение
			$element= $session->element('class name', 'focused');			
			$res = false;
			$result = true;
			echo "OPEN_COMPARE_REDACTION_DONE"."\n";
		} catch (Exception $e) {
			$res = ($t<$timeout);
			if ($t==0)echo "WAITE_COMPARE_REDACTION__TIMEOUT=".$t.'% '; else echo $t."% ";
			$t++;
			sleep("1");
		}
	}// while: END WAITE DOCUMENT
	return $result;
}

//TYPE: Document
//DESC: Ожидаем Новостную ленту
function WaiteNewsLine(
		$session,
		$timeout=30
){
	//WAITE 
	$t=0;
	$res = true;
	$result = false;
	while ($res){
		try {
			_GoToMainFrame($session);			
			$element= $session->element('tag name', 'p');//если документа ещё нет, будет исключение			 
			if (strpos($element->text(), 'новостная лента') != false ){// если действительно новостная лента, выходим
				$res = false;
				$result = true;
			}			
		} catch (Exception $e) {
			$res = ($t<$timeout);
			echo "OPEN_NEWSLINE_TIMEOUT=".$t;
			$t++;
			sleep("1");
		}
	}// while: END WAITE 
	return $result;
}
//TYPE: Document
//DESC: Ожидаем Новостную ленту
function WaiteDictionary(
		$session,
		$timeout=30
){
	//WAITE
	$t=0;
	$res = true;
	$result = false;
	while ($res){
		try {
			_GoToDictionaryListTermins($session);
			$element= $session->element('class name', 'line');			
			$res = false;
			$result = true;			
		} catch (Exception $e) {
			$res = ($t<$timeout);
			echo "OPEN_DICTIONARY_TIMEOUT=".$t;
			$t++;
			sleep("1");
		}
	}// while: END WAITE
	return $result;
}

//TYPE: Document
//DESC: Открытие справки
function OpenRelatedInDocument(
		$session,
		$isCheckDoc = true//надо ли проверять перед открытием справки документ на валидность
){
try{
	if ($isCheckDoc) 
		$result = WaiteDoc($session, 1); 	//если документ не открыт, тогда ничего не делаем и выходим	 
	else 
		$result = true;
	if ($result) {
		_GoToTabNavigatorFrame($session);
		try{
			$element = FindElementByParam($session, 'id', 'b_spravka');
			if ($element!=false){
				$element->click();
				$result = true;
			} else {
				echo ('OpenRelatedInDocument: spravka is not found.');
				$result = false;
			}					
		} catch (Exception $e) {
			echo 'Spravka NOT found!';
			$result = false;
		}	
	}
	return $result;
} catch (Exception $e) {
	echo "OpenRelatedInDocument: ".$e."//OpenRelatedInDocument Exception.";
	return false;
}
}
//TYPE: Document
//DESC: Открытие документа по номеру
function OpenDocumentByNumber(
		$session,		
		$number,
		$timeout = 20
){
	try{
		//получаем кнопку ОМ, что бы на ней вызвать хоткей методом value, так как value должен вызывать на контроле
		//кнопка ОМ на главном тулбаре должна быть доступна в любом состоянии оболочки	
		_GoTbMainFrame($session);
		$element = FindElementByParam($session, 'id','OpenMainMenuNew');
		PressKey($session, $element, Keys::ALT.'N');
		sleep('1');
		//заполняем номер
		$command = '/alert_text';		
		$url = $session.$command;
		$curl = curl_init($url);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json;charset=UTF-8', 'Accept: application/json') );
		curl_setopt($curl, CURLOPT_POST, true);
		$postArgs = $postArgs = '{"text":"'.$number.'"}';	
		curl_setopt($curl, CURLOPT_POSTFIELDS, $postArgs);
		$raw_results = trim(WebDriverEnvironment::CurlExec($curl));
		curl_close($curl);	
		sleep('1');
		//жмём ОК в диалоге открытия по ALT+N
		$session->accept_alert();
		//ждём документ
		$result = WaiteDoc($session, 10);		
		return $result;
	} catch (Exception $e) {
		echo "OpenDocumentByNumber: ".$e."//OpenDocumentByNumber Exception.";
		return false;
	}
}
//TYPE: Document
//DESC: Открытие списка корреспондентов
function OpenCorrespondentList(
		$session,
		$type = ''
){
	try{
		$result = WaiteDoc($session, 2);
		//если документ не открыт, тогда ничего не делаем и выходим
		if ($result) {
			//открываем ПЗ
			_GoTbMainFrame($session);
			FindElementByParam($session, 'id','opTasksPanel')->click();
			sleep('1');
			_GoToTabTaskPanelFrame($session);
			FindElementByParam($session, 'id','opGetCorrespondentListExFrmAct')->click();			
			//Кликаем по нужному типу СКР
			try{
				SwitchToFrame($session, null);
				SwitchToFrame($session, 'forPopupContextCORESPONDENTS');
				$elements = FindElementsByParam($session, 'tag name','td');				
				foreach($elements as $i=>$element) {
					if ( !(strpos($element->text(), 'Все документы') === false)){
						$element->click();
						break;
					}
				}
			} catch (Exception $e) {
				echo ('forPopupContextCORESPONDENTS NOT Found!');
				$result = false; 
			}
			
			/*
			_GoToTabNavigatorFrame($session);
			$element = $session->element('class name', 'div_hidden_h')->element('tag name', 'table');			
			$elements = $element->elements('tag name', 'div');
			foreach($elements as $i=>$element) {				
				if ( strpos($element->text(), 'Комментарии') != false){								
					$element->click();					
				}
			}			
			$result = true;
			*/
			$result = true;
		}
		return $result;
	} catch (Exception $e) {
		echo "OpenCorrespondentList: ".$e."//OpenCorrespondentList Exception.";
		return false;
	}
}

//TYPE: Document
//DESC: Открытие списка респондентов
function OpenRespondentList(
		$session,
		$type = ''
){
	try{
		$result = WaiteDoc($session, 2);
		//если документ не открыт, тогда ничего не делаем и выходим
		if ($result) {
			//открываем ПЗ
			_GoTbMainFrame($session);
			FindElementByParam($session, 'id', 'opTasksPanel')->click();
			sleep('1');
			_GoToTabTaskPanelFrame($session);
			FindElementByParam($session, 'id', 'opGetRespondentListExFrmAct')-> click();			
			//Кликаем по нужному типу СКР
			try{
				SwitchToFrame($session, null);
				SwitchToFrame($session, 'forPopupContextRESPONDENTS');
				$elements = FindElementsByParam($session, 'tag name','td');				
				foreach($elements as $i=>$element) {
					if ( !(strpos($element->text(), 'Все документы') === false)){
						$element->click();
						break;
					}
				}
			} catch (Exception $e) {
				echo ('forPopupContextRESPONDENTS NOT Found!');
				$result = false;
			}
				
			$result = true;
		}
		return $result;
	} catch (Exception $e) {
		echo "OpenRespondentList: ".$e."//OpenRespondentList Exception.";
		return false;
	}
}


//TYPE: Document
//DESC: Скролл в документе за счёт нажатия HOME\END\UP\DOWN 
function ScrollInDocument(
	$session,
	$direction = 'END' 
){		
try{
	$result = WaiteDoc($session, 2);
	//если документ не открыт, тогда ничего не делаем и выходим
	if ($result) { 
		_GoToMainFrame($session);
		sleep('1');
		$session->frame(array('id'=>0));
		$doc= $session->element('id', 'list');//если документа ещё нет, будет исключение
		switch ($direction) {
			case 'END':
				$key = Keys::END;
				break;
			case 'HOME':
				$key = Keys::HOME;
				break;
			case 'UP':
				$key = Keys::UPARROW;
				break;
			case 'DOWN':
				$key = Keys::DOWNARROW;
				break;
		}
		PressKey($session, $doc, $key);
		$result = true;
	}		
	return $result;
} catch (Exception $e) {
	echo "ScrollDocument: ".$e."//ScrollDocument Exception.";
	return false;
}	
}

//TYPE: Docuent
//DESC: Открываем документ из списка по id
function OpenDocumentFromList(
	$session,
	$pid,
	$counDocumentInList=60,
	$timeout=30
){		
try{
	$result=false;
	_GoToMainFrame($session);
	$i=1;
	while (!$result) {
		if ($i==1) {
			$xpathDoc = '/html/body/div[2]/table/tbody/tr/td/table/tbody/tr/td/table/tbody/tr/td[3]';						 
		} else {
			try {
				$xpathDoc = '/html/body/div[2]/table/tbody/tr['.$i.']/td/table/tbody/tr/td/table/tbody/tr/td[3]';
			}  catch (Exception $e) { //если список закончился, просто выходим			
				break;
			}	
		};
		$currentPid = FindElementByParam($session, 'xpath', $xpathDoc)->attribute('pid');
		if ($currentPid == $pid) {
			echo 'Open Document '.$currentPid.' in list.';
			FindElementByParam($session, 'xpath', $xpathDoc)->click();
			try{//Если 1-й документ в списке, то он уже после 1-го клика открывается , а второй даёт исключение
				FindElementByParam($session, 'xpath', $xpathDoc)->click();
			}  catch (Exception $e) { }			
			$result=true;
		};
		$i++;
	}	
	//WAITE Document
	if ($result==true) {
		$result = WaiteDoc($session, $timeout);
	}	
	return $result;
} catch (Exception $e) {
	echo "OpenDocumentFromList: ".$e."//OpenDocumentFromList Exception.";
	return false;
}	
}

//TYPE: Document
//DESC: Открываем документ переходя по ссылке в документе
function OpenDocumentFromLink(
	$session,
	$pid=0,
	$isFirstLink=true,// открываем самую первую ссылку, иначе по pid
	$timeout = 10
){		
try{	
	$result = false;
	_GoToDocFrame($session);	
	//$document = $session->element('id', 'list')->attribute('name');
	$res = true;
	$t = 0;
	while ($res) {
		try {
			$elements = FindElementsByParam($session, 'tag name', 'span');
			$res = false;			
		} catch (Exception $e) {
			$res = ($t<$timeout);
			echo "ClickDocumentOnList:TIMEOUT=".$t;
			$t++;
			sleep("1");	
		}
	}	
	foreach($elements as $i=>$element) {		
		if ($element->attribute('params') !='') {			
			$currentPid = explode(',',$element->attribute('params'));
			$currentPid = $currentPid[1];			
			//echo $i.'-'.$currentPid.'-'.$element->text().'| ';
			
			if (!$isFirstLink) {
				if ( ($currentPid == $pid) AND ($element->text()!= '' ) ){
					echo 'OPEN_DOC_FROM_LINK:'.$currentPid;			
					$element->click();
					//WAITE
					sleep('2');
					$result = true;
					break;
				}
			} else {
				if ($element->text()!= '' ){
					echo 'OPEN_FIRST_DOC_FROM_LINK:'.$currentPid;			
					$element->click();
					//WAITE
					sleep('2');
					$result = true;
					break;
				}
			}
		}		
	}	
	return $result;
} catch (Exception $e) {
	echo "OpenDocumentFromLink: ".$e."//OpenDocumentFromLink Exception.";
	return false;
}	
}

//TYPE: Document
//DESC: Сохранение закладки
function SaveBookmark(
	$session,
	$isIE = 0,//Если браузер IE, то сначала разварачиваем кнопку Установить закладку, появляются 2 кнопки :"Установить закладку" и "Сохранить в избранное", затем кликаем по "Установить закладку"
	$name='',
	$note='',
	$isAlreadyOpenSaveDialog = false
){		
try{	
	if ($isAlreadyOpenSaveDialog == false) {
		_GoTbChildFrame($session);	
		FindElementByParam($session, 'id', 'opAddBookmark')->click();
		if ($isIE==1) {
			sleep('1');
			_GoToPopupContextopAddBookmarkFrame($session);
			FindElementByParam($session, 'id', 'opAddBookmark')->click();
		}
	}
	_GoToMainIfrFrame($session);
	SwitchToFrame($session, 'folder_tab_frame');
	SwitchToFrame($session, 'tab_manager');
	SwitchToFrame($session, 'prop');	
	
	if ($name!='') {
		FindElementByParam($session, 'id', 'item_mane')->clear();
		FindElementByParam($session, 'id', 'item_mane')->value(array('value' => array($name)));
	}
	if ($note!='') {
		FindElementByParam($session, 'id', 'item_comm')->clear();
		FindElementByParam($session, 'id', 'item_comm')->value(array('value' => array($note)));
	}
	_GoToMainIfrFrame($session);
	SwitchToFrame($session, 'folder_toolbar_child');		
	FindElementByParam($session, 'id', 'bSave')->click();	
	//Если закладка с таким именем уже есть, то обрабатываем данную ситуацию
	try{		
		sleep('1');
		$session->accept_alert();		
		echo ('Close Alert SaveBookmark!');//Закладка существует
		$name = rand(0,10000000).'__'.rand(0,10000000).'___'.rand(0,10000000);
		SaveBookmark($session, $isIE, $name, $note, true);
		
	} catch (Exception $e) {//NO Alert  SaveBookmark
	}
} catch (Exception $e) {
	echo "SaveBookmark: ".$e."//SaveBookmark Exception!";
	return false;
}	
}

//TYPE: Document
//DESC: Экспорт в Word / cохранение в RTF без указания имени файла и без закрытия диалога сохранения файла
function ExportToWord(
	$session
){		
try{	
	_GoTbChildFrame($session);	
	FindElementByParam($session, 'id', 'opToMSWord')->click();
	_GoToDocFrame($session);
	$result = WaiteDoc($session);
	//закрываем диалог открытия rtf файла, это браузерный диалог, но к нему доступа програмно нет, поэтому по Esc 
			
	return $result; 
} catch (Exception $e) {
	echo "ExportToWord: ".$e."//ExportToWord Exception!";
	return false;
}	
}

//TYPE: Document
//DESC: Переход к следующей/предыдущей/первой/последней страницы документа
function GoToDocPage(
	$session,
	$jump_type, // см. ниже
	$count=1 // сколько раз делаем переход
){		
try{
	switch (strtoupper($jump_type))	{
		case 'NEXT': $jump_type_str = 'nextpage'; break;
		case 'PREV': $jump_type_str = 'prevpage'; break;	
		case 'FIRST': $jump_type_str = 'firstpage'; break;
		case 'LAST': $jump_type_str = 'lastpage'; break;
		default: throw new Exception('Unknown "'.$jump_type.'" value!');
	}

	for ($i=0; $i<$count; $i++) {
		_GoToDocFrame($session);
		if (!WaiteDoc($session))
			throw new Exception('Document not found!');
		$element = FindElementByParam($session, 'xpath','//img[contains(@src,"'.$jump_type_str.'")]'); //FindElementByParam($session, 'xpath','//img[@src="/img/toolbar/small/nextpage.gif"]')
		if (!$element)
			throw new Exception($jump_type_str.' button not found!');
		$element->click();
	}

	echo "GoToDocPage: Jump with type ".$jump_type_str." and ".$i." count DONE! \n";
	return WaiteDoc($session);
} catch (Exception $e) {
	echo "GoToDocPage: ".$e." //GoToDocPage Exception, jump type: ".$jump_type_str.", count=".$i."\n";
	return false;
}	
}

//TYPE: Document
//DESC: Открывается сравнение редакций, если доступна соответствующая операция
function OpenCompareRedaction(
		$session
){
	try{
		$result = WaiteDoc($session, 2);
		//если документ не открыт, тогда ничего не делаем и выходим  
		if ($result) {
			_GoTbChildFrame($session);
			FindElementByParam($session, 'id', 'opChangesButton')->click();
			SwitchToFrame($session, null);
			SwitchToFrame($session, 'forPopupContextopChangesButton');			
			$element = FindElementByParam($session, 'id', 'opCompareEditions', '2');
			//если операция "Сравнение редакций" доступна, кликаем и ждём сравнение редакций 
			if ($element != false) { 
				$element->click();
				$result = WaiteCompareRedaction($session);
			} else { 
				//если операция "Сравнение редакций" недоступна, тогда схлопываем контекстное меню "Изменения в документе"
				_GoTbChildFrame($session);
				PressKey($session, FindElementByParam($session, 'id', 'opChangesButton'), Keys::ESCAPE);				
				$result = false;
			}
					
		} else {
			echo "\n"."OpenCompareRedaction: Document NOT Found!";
		}
		return $result;
	} catch (Exception $e) {
		echo "OpenCompareRedaction: ".$e."//OpenCompareRedaction Exception!";
		return false;
	}
}

//TYPE: Document
//DESC: Открывается сравнение редакций, и актуальная редакция по очереди сравнивается со всеми остальными
function CompareAllRedactions(
		$session
){
	try{
		$result = OpenCompareRedaction($session);
		//если документ не смогли открыть сравнение редакций, тогда ничего не делаем и выходим
		if ($result) {			
		//открываем список доступных редакций и считаем сколько редакций
			_GoToMainFrame($session);
			FindElementByParam($session, 'class name', 'goAnotherEditions')->click();
			_GoToFulleditionPickerFrame($session);			 
			$countEditions = count(FindElementsByParam($session, 'tag name', 'li'));
			FindElementByParam($session, 'class name', 'buttonCompareEditions')->click();
			WaiteCompareRedaction($session);
						
			for ($i=0; $i<$countEditions; $i++){							
				_GoToMainFrame($session);				
				FindElementByParam($session, 'class name', 'goAnotherEditions')->click();
				_GoToFulleditionPickerFrame($session);
				$items = FindElementsByParam(FindElementByParam($session, 'tag name', 'dl'), 'tag name', 'li');			
				//Снимаем галки со всех чекбоксов								
				foreach ($items as $j=>$activeItem){
					if (strpos($activeItem->attribute('class'), 'checked') != false ) {
						FindElementByParam($activeItem, 'class name', 'checkbox')->click();
						//echo $i.':'.$item->attribute('class').'|';
					}
				}
				//ставим одну галку на актуальной редакции
				$activeEditionWrapper = FindElementByParam(FindElementByParam($session, 'tag name', 'dl'), 'class name', 'active');
				FindElementByParam($activeEditionWrapper, 'class name', 'checkbox')->click();
				//ставим 2-ю галку на $i-ю редакцию, если она уже не проставлена(так на актуальную уже проставлена)
				_GoToFulleditionPickerFrame($session);
				$items = FindElementsByParam(FindElementByParam($session, 'tag name', 'dl'), 'tag name', 'li');
				foreach ($items as $j=>$curItem){
					if ($i==$j){
						if (strpos($curItem->attribute('class'), 'checked') == false ) {
							FindElementByParam($curItem, 'class name', 'checkbox')->click();
							//Нажимаем "Сравнить"
							FindElementByParam($session, 'class name', 'buttonCompareEditions')->click();
							$result = true;
						}
					}				
				}
			}				
			//Возвращаемся в документ
			_GoToMainFrame($session);
			FindElementByParam($session, 'class name', 'goDocument')->click();
		} else {
			echo "\n"."CompareAllRedactions: OpenCompareRedaction get FALSE!!";
		}
		return $result;
	} catch (Exception $e) {
		echo "CompareAllRedactions: ".$e."//CompareAllRedactions Exception!";
		return false;
	}
}
//TYPE: Document
//DESC: 
function OpenForm(
		$session
){
	try{
		
		return true;
	} catch (Exception $e) {
		echo "OpenForm: ".$e."//OpenForm Exception.";
		return false;
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////                                                  HISTORY functions                                                                                             //////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TYPE: History
//DESC: Клик в статусбаре по предыдущему документу в списке
function GoByHistory(
	$session,
	$direction = 'BACK'
){		
try{	
	_GoTbMainFrame($session);	
	switch ($direction) {
		case 'BACK':
			FindElementByParam($session, 'id', 'opBack')->click();
			break;		
		case 'FORWARD':
			FindElementByParam($session, 'id', 'opForward')->click();			
			break;		
	}	
	return true;
} catch (Exception $e) {
	echo "GoByHistory: ".$e."//GoByHistory Exception.";
	return false;
}	
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////                                                  MAIN_MENU functions                                                                                      //////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TYPE: Menu
//DESC: Клик в статусбаре по предыдущему документу в списке
function GoToMainMenu(
	$session	
){		
try{	
	_GoTbMainFrame($session);
	$element = FindElementByParam($session, 'id', 'OpenMainMenuNew');
	if ($element != false){ 
		$element->click();
		$result = true;
	}	else {	
		$result = false;
		echo ('GoToMainMenu: ERROR!');
	}
	return $result;
} catch (Exception $e) {
	echo "GoToMainMenu: ".$e."//GoToMainMenu Exception.";
	return false;
}	
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////                                                  NAVIGATOR functions                                                                                      //////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TYPE: Navigator
//DESC: Разварачиваем навигатор
function ShowNavigator(
	$session	
){		
try{	
	_GoToTbNavigatorFrame($session);		
	try {
		FindElementByParam($session, 'id', 'showNavigator')->click();
	} catch (Exception $e) {
		echo ('Navigator already open');
	}
	return true;
} catch (Exception $e) {
	echo "ShowNavigator: ".$e."//ShowNavigator Exception.";
	return false;
}	
}	

//TYPE: Navigator
//DESC: В навигаторе активируем вкладку "Меню"
function OpenMenuInNavigator(
		$session
){
	try{
		_GoToPageControlNavigatorFrame($session);		
		try {
			FindElementByParam($session, 'id', 'img_tab_menu')->click();
		} catch (Exception $e) {
			echo ('Error click on Menu sheet in Navigator');
		}
		return true;
	} catch (Exception $e) {
		echo "OpenMenuInNavigator: ".$e."//OpenMenuInNavigator Exception.";
		return false;
	}
}

//TYPE: Navigator
//DESC: Открываем элемент из навигатора
function OpenByPathInNavigator(
	$session,
	$path 
){		
try{	
	ShowNavigator($session);
	OpenMenuInNavigator($session);	
	_GoToNavigatorFrame($session);	
	$pathArray = explode('\\', $path);	
	$i=0;
	foreach ($pathArray  as $i=>$curPath){
		$result = false;
		if ($i<2) {// по первым двум элементам кликаем в навигаторе
			$itemLists = FindElementsByParam($session, 'class name', 'text');
			if ($itemLists!=false) {
				foreach ($itemLists as $j=>$td){
					try{
						$text = $td->text();
					} catch (Exception $e) {
						sleep('1');
						echo ('OpenByPathInNavigator: GetText Again.');
						$text = $td->text();					
					}
					if ($curPath == $text) {					
						$td->click();
						$result = true;
						break;
					}
				}
			} else {
				echo ('OpenByPathInNavigator: $itemLists is null!');
				$result = false;
				break;
			}	
		} else {
			_GoToMainFrame($session); //остальные(от 3-го элемента) открываем в рубрикаторе
			$itemLists = FindElementsByParam($session, 'class name', 'alink');
			if ($itemLists!=false) { 
				foreach ($itemLists as $j=>$span){				
					try{
						$text = $span->text();
					} catch (Exception $e) {
						sleep('1');
						echo ('OpenByPathInNavigator: GetTextSpan Again.');
						$text = $span->text();
					}				
					if ($curPath == $text){
						$span->click();
						$result = true;
						break;
					}
				}
			} else {
				echo ('OpenByPathInNavigator: $itemLists is null!');
				$result = false;
				break;
			}
		}		
		$i++;
	}	
	return $result;
} catch (Exception $e) {
	echo "OpenByPathInNavigator: ".$e."//OpenByPathInNavigator Exception.";
	return false;
}	
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////                                                  CONSULTATION functions                                                                                      //////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TYPE: Consultations
//DESC: Отправить консультацию
function SendConsultation(
		$session,
		$text,
		$userName = 'qc',
		$сityCode = '495',
		$phone = '22222',
		$email = 'qc@garant.ru'
){
	try{		
		GoToMainMenu($session);
		_GoToMainFrame($session);
		FindElementByParam($session, 'class name', 'blockConsultationOnline')->element('class name', 'button')->click();
		sleep('1');
		_GoToSendConsultationFrame($session);		
		FindElementByParam($session, 'id', 'AT_USER_NAME')->clear();
		FindElementByParam($session, 'id', 'AT_USER_NAME')->value(array('value' => array($userName)));
		FindElementByParam($session, 'id', 'code_AT_USER_PHONE')->clear();
		FindElementByParam($session, 'id', 'code_AT_USER_PHONE')->value(array('value' => array($сityCode)));
		FindElementByParam($session, 'id', 'phone_AT_USER_PHONE')->clear();
		FindElementByParam($session, 'id', 'phone_AT_USER_PHONE')->value(array('value' => array($phone)));
		FindElementByParam($session, 'id', 'AT_EMAIL')->clear();
		FindElementByParam($session, 'id', 'AT_EMAIL')->value(array('value' => array($email)));
		FindElementByParam($session, 'id', 'AT_LAW_SUPPORT_TEXT')->clear();
		FindElementByParam($session, 'id', 'AT_LAW_SUPPORT_TEXT')->value(array('value' => array($text)));
		_GoToMainFrame($session);
		FindElementByParam($session, 'id', 'b_search')->click();
		sleep('2');
		$session->accept_alert();
		return true;
	} catch (Exception $e) {
		echo "ShowNavigator: ".$e."//ShowNavigator Exception.";
		return false;
	}
}



?>