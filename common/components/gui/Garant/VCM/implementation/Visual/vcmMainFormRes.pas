unit vcmMainFormRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmMainFormRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual::vcmMainFormRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3StringIDEx,
  l3MessageID
  ;

var
  { Локализуемые строки Local }
 str_TooManyWindowsOpened : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened'; rValue : 'Открыто максимальное количество окон системы ГАРАНТ. Закройте ненужные окна или продолжайте работу в текущем окне');
  { 'Открыто максимальное количество окон системы ГАРАНТ. Закройте ненужные окна или продолжайте работу в текущем окне' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  ;

var
  { Варианты выбора для диалога TooManyWindowsOpened }
 str_TooManyWindowsOpened_Choice_First : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_First'; rValue : 'Открыть в текущем окне');
  { 'Открыть в текущем окне' }
 str_TooManyWindowsOpened_Choice_Second : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_Second'; rValue : 'Отмена');
  { 'Отмена' }

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// Инициализация str_TooManyWindowsOpened_Choice_First
 str_TooManyWindowsOpened_Choice_First.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_TooManyWindowsOpened_Choice_Second
 str_TooManyWindowsOpened_Choice_Second.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_TooManyWindowsOpened
 str_TooManyWindowsOpened.Init;
 str_TooManyWindowsOpened.AddChoice(str_TooManyWindowsOpened_Choice_First);
 str_TooManyWindowsOpened.AddChoice(str_TooManyWindowsOpened_Choice_Second);
 str_TooManyWindowsOpened.AddCustomChoice(str_TooManyWindowsOpened_Choice_Second);
 str_TooManyWindowsOpened.AddDefaultChoice(str_TooManyWindowsOpened_Choice_First);
 str_TooManyWindowsOpened.SetDlgType(mtConfirmation);
{$IfEnd} //not NoVCM

end.