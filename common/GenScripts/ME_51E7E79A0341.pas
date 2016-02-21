unit vcmMainFormRes;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainFormRes.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3MessageID
;

const
 {* Локализуемые строки Local }
 str_TooManyWindowsOpened: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened'; rValue : 'Открыто максимальное количество окон системы ГАРАНТ. Закройте ненужные окна или продолжайте работу в текущем окне');
  {* 'Открыто максимальное количество окон системы ГАРАНТ. Закройте ненужные окна или продолжайте работу в текущем окне' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 {* Варианты выбора для диалога TooManyWindowsOpened }
 str_TooManyWindowsOpened_Choice_First: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_First'; rValue : 'Открыть в текущем окне');
  {* 'Открыть в текущем окне' }
 str_TooManyWindowsOpened_Choice_Second: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_Second'; rValue : 'Отмена');
  {* 'Отмена' }

initialization
 str_TooManyWindowsOpened_Choice_First.Init;
 {* Инициализация str_TooManyWindowsOpened_Choice_First }
 str_TooManyWindowsOpened_Choice_Second.Init;
 {* Инициализация str_TooManyWindowsOpened_Choice_Second }
 str_TooManyWindowsOpened.Init;
!!! Lost Message ini !!!
 {* Инициализация str_TooManyWindowsOpened }
{$IfEnd} // NOT Defined(NoVCM)

end.
