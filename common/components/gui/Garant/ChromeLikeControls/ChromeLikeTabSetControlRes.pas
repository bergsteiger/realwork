unit ChromeLikeTabSetControlRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeTabSetControlRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeTabSet::ChromeLikeTabSetControlRes
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
  { Локализуемые строки ChromeLikeTabSetControllConst }
 str_NewTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NewTab'; rValue : 'Новая вкладка');
  { 'Новая вкладка' }
 str_MakeClone : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MakeClone'; rValue : 'Дублировать');
  { 'Дублировать' }
 str_CloseTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseTab'; rValue : 'Закрыть вкладку');
  { 'Закрыть вкладку' }
 str_CloseOtherTabs : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseOtherTabs'; rValue : 'Закрыть другие вкладки');
  { 'Закрыть другие вкладки' }
 str_CloseRightTabs : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseRightTabs'; rValue : 'Закрыть вкладки справа');
  { 'Закрыть вкладки справа' }
 str_ReopenClosedTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ReopenClosedTab'; rValue : 'Открыть закрытую вкладку');
  { 'Открыть закрытую вкладку' }
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_NewTab
 str_NewTab.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_MakeClone
 str_MakeClone.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_CloseTab
 str_CloseTab.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_CloseOtherTabs
 str_CloseOtherTabs.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_CloseRightTabs
 str_CloseRightTabs.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_ReopenClosedTab
 str_ReopenClosedTab.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.