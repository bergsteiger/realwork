<?php
require_once "V:\usr\local\php5\PEAR\lib\php-webdriver\__init__.php";
include "V:\usr\local\php5\PEAR\common\common.php ";
$browser;//0-ff, 1-ie

class WebdriverTest extends PHPUnit_Framework_TestCase
{
    /** 
    * @var WebDriverSession	
    */	
    protected $_session;
	

    public function setUp()
    {
        parent::setUp();
        $web_driver = new WebDriver();
		$GLOBALS['browser']= 1;
		//$GLOBALS['browser'] = rand(0,1);	
		echo  'Brows='.$GLOBALS['browser'].'.';
        if ($GLOBALS['browser'] ==0) $this->_session = $web_driver->session('firefox');
		if ($GLOBALS['browser'] ==1)$this->_session = $web_driver->session('internet explorer');		
		echo  'Session='.$this->_session.'.';
    }

    public function tearDown()
    {
        $this->_session->close();
        unset($this->_session);
        parent::tearDown();
    }

    public function test_mytest()
    {	
		//print_r($_SERVER);		
		$isGuest = rand(0,1);
		//$isGuest = 0;
		if  ($isGuest==0) {
			$login = explode('session/',$this->_session);
			$login = $login[1];
			if ($GLOBALS['browser'] ==0) $login = 'ff_'.$login;
			if ($GLOBALS['browser'] ==1) $login = 'ie_'.$login;				
			echo 'Login='.$login.'.';
			$resLogin = LoginAnyHow($this->_session, $login);
		} else	
			$resLogin = GuestLogin($this->_session);
		if ($resLogin == true) {			
			for ( $i=0; $i<=1; $i++) {
				GoToMainMenu($this->_session);
				$array_contexts = file('V:\usr\local\php5\PEAR\common\_words.txt');			
				$context = rtrim($array_contexts[rand(1,90)]);
				$j = rand(0,9); 
				//$j = 9;
				switch ($j) {
					case 0:
					case 1:
					case 2:
					case 3:
					case 4: $type = 'Все документы'; break;
					case 5: $type = 'Правовой консалтинг'; break;
					case 6: $type = 'Акты органов власти';break;
					case 7: $type = 'Судебная практика';break;
					case 8: $type = 'Формы документов';break;
					case 9: $type = 'Комментарии';break;
				}
				
				if (BaseSearch($this->_session, $context, $type)== true) {
					echo 'SEARCH DONE!';					
					if (ClickDocumentOnList($this->_session, rand(1,3)) == true){					
						echo 'CLICK DOCUMENT DONE!';
						if  ($isGuest==0) SaveBookmark($this->_session,$GLOBALS['browser']);
						
						for ( $j=0; $j<=2; $j++) GoNextDocumentInList($this->_session);
						GoPreviousDocumentInList($this->_session);
						
						$j=0; $res = true;						
						while (($res) AND($j<3)) {
							$res = OpenDocumentFromLink($this->_session);
							$j++;
						}
						
						for ( $j=0; $j<=3; $j++) GoByHistory($this->_session, 'BACK');
						GoByHistory($this->_session, 'FORWARD');
					}
				} else {
					echo ('SEARCH NOT DONE!');//Скорее всего "Документов не найдено"					
				}					
			}//for
		ExitIntranet($this->_session);
		}
		//$this->assertSame('http://b-supermobile.garant.ru/SESSION/PILOT/main.htm',  $this->_session->url() );		
	
	/*
	GuestLogin($this->_session);
	//if (BaseSearch($this->_session, 'путин', 'Бухгалтерские проводки', 2) == false) echo('!!!!!!!!!');
	if (BaseSearch($this->_session, 'путин', 'Нормативно-техническая документация', 2) == false) echo('!!!!!!!!!');	
	//if (OpenDocumentFromList($this->_session, 10900200) == true	) echo ('!!!!!!!!!!!!!!');		
	//if (OpenDocumentFromLink($this->_session, 0, true) == true	) echo ('------------------');	
	*/
	
	
	
    }
} 
?>