unit ChromeLikeWindowCaptionButtonsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeWindowCaptionButtonsRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeWindowCaptionButtons::ChromeLikeWindowCaptionButtonsRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3StringIDEx
  ;

var
  { Локализуемые строки WindowCaptionButtonsHints }
 str_Close : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Close'; rValue : 'Закрыть');
  { 'Закрыть' }
 str_Minimize : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Minimize'; rValue : 'Свернуть');
  { 'Свернуть' }
 str_Restore : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Restore'; rValue : 'Свернуть в окно');
  { 'Свернуть в окно' }
 str_Maximize : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Maximize'; rValue : 'Развернуть');
  { 'Развернуть' }
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_Close
 str_Close.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_Minimize
 str_Minimize.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_Restore
 str_Restore.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_Maximize
 str_Maximize.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.