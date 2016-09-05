unit vcmMainFormRes;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainFormRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmMainFormRes" MUID: (51E7E79A0341)

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
 //#UC START# *51E7E79A0341impl_uses*
 //#UC END# *51E7E79A0341impl_uses*
;

const
 {* Варианты выбора для диалога TooManyWindowsOpened }
 str_TooManyWindowsOpened_Choice_First: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_First'; rValue : 'Открыть в текущем окне');
  {* 'Открыть в текущем окне' }
 str_TooManyWindowsOpened_Choice_Second: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_Second'; rValue : 'Отмена');
  {* 'Отмена' }

initialization
 str_TooManyWindowsOpened.Init;
 str_TooManyWindowsOpened.AddChoice(str_TooManyWindowsOpened_Choice_First);
 str_TooManyWindowsOpened.AddChoice(str_TooManyWindowsOpened_Choice_Second);
 str_TooManyWindowsOpened.AddCustomChoice(str_TooManyWindowsOpened_Choice_Second);
 str_TooManyWindowsOpened.AddDefaultChoice(str_TooManyWindowsOpened_Choice_First);
 str_TooManyWindowsOpened.SetDlgType(mtConfirmation);
 {* Инициализация str_TooManyWindowsOpened }
 str_TooManyWindowsOpened_Choice_First.Init;
 {* Инициализация str_TooManyWindowsOpened_Choice_First }
 str_TooManyWindowsOpened_Choice_Second.Init;
 {* Инициализация str_TooManyWindowsOpened_Choice_Second }
{$IfEnd} // NOT Defined(NoVCM)

end.
