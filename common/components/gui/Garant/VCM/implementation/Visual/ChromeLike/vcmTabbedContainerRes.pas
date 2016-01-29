unit vcmTabbedContainerRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmTabbedContainerRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmTabbedContainerRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3StringIDEx,
  l3MessageID
  ;

var
  { Локализуемые строки vcmTabbedContainerConsts }
 str_TooManyTabsOpened : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'TooManyTabsOpened'; rValue : 'Открыто максимальное количество вкладок, закройте ненужные или продолжайте работать в текущей вкладке.');
  { 'Открыто максимальное количество вкладок, закройте ненужные или продолжайте работать в текущей вкладке.' }
 str_pui_MainWindowTabs : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pui_MainWindowTabs'; rValue : 'Вкладки Основного окна');
  { 'Вкладки Основного окна' }
 str_pi_UseTabs : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_UseTabs'; rValue : 'Использовать вкладки');
  { 'Использовать вкладки' }
 str_pi_OpenDocumentsFromList : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_OpenDocumentsFromList'; rValue : 'Открывать документы из списков');
  { 'Открывать документы из списков' }
 str_pi_OpenLinksFromDocument : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_OpenLinksFromDocument'; rValue : 'Открывать ссылки из документов');
  { 'Открывать ссылки из документов' }
 str_pi_InCurrentTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InCurrentTab'; rValue : 'В текущей вкладке');
  { 'В текущей вкладке' }
 str_pi_InNewTab : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InNewTab'; rValue : 'В новой вкладке');
  { 'В новой вкладке' }
 str_pi_InNewWindow : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InNewWindow'; rValue : 'В новом окне');
  { 'В новом окне' }
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  ;

var
  { Варианты выбора для диалога TooManyTabsOpened }
 str_TooManyTabsOpened_Choice_First : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyTabsOpened_Choice_First'; rValue : 'Продолжить работу в текущей вкладке');
  { 'Продолжить работу в текущей вкладке' }

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_TooManyTabsOpened_Choice_First
 str_TooManyTabsOpened_Choice_First.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_TooManyTabsOpened
 str_TooManyTabsOpened.Init;
 str_TooManyTabsOpened.AddChoice(str_TooManyTabsOpened_Choice_First);
 str_TooManyTabsOpened.AddDefaultChoice(str_TooManyTabsOpened_Choice_First);
 str_TooManyTabsOpened.SetDlgType(mtConfirmation);
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_pui_MainWindowTabs
 str_pui_MainWindowTabs.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_pi_UseTabs
 str_pi_UseTabs.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_pi_OpenDocumentsFromList
 str_pi_OpenDocumentsFromList.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_pi_OpenLinksFromDocument
 str_pi_OpenLinksFromDocument.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_pi_InCurrentTab
 str_pi_InCurrentTab.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_pi_InNewTab
 str_pi_InNewTab.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Инициализация str_pi_InNewWindow
 str_pi_InNewWindow.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.