unit vcmTabbedContainerRes;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmTabbedContainerRes" MUID: (537AE06700E8)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3StringIDEx
 , l3MessageID
;

const
 {* Локализуемые строки vcmTabbedContainerConsts }
 str_pui_MainWindowTabs: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pui_MainWindowTabs'; rValue : 'Вкладки Основного окна');
  {* 'Вкладки Основного окна' }
 str_pi_UseTabs: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_UseTabs'; rValue : 'Использовать вкладки');
  {* 'Использовать вкладки' }
 str_pi_OpenDocumentsFromList: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_OpenDocumentsFromList'; rValue : 'Открывать документы из списков');
  {* 'Открывать документы из списков' }
 str_pi_OpenLinksFromDocument: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_OpenLinksFromDocument'; rValue : 'Открывать ссылки из документов');
  {* 'Открывать ссылки из документов' }
 str_pi_InCurrentTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InCurrentTab'; rValue : 'В текущей вкладке');
  {* 'В текущей вкладке' }
 str_pi_InNewTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InNewTab'; rValue : 'В новой вкладке');
  {* 'В новой вкладке' }
 str_pi_InNewWindow: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_InNewWindow'; rValue : 'В новом окне');
  {* 'В новом окне' }
 str_TooManyTabsOpened: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'TooManyTabsOpened'; rValue : 'Открыто максимальное количество вкладок, закройте ненужные или продолжайте работать в текущей вкладке.');
  {* 'Открыто максимальное количество вкладок, закройте ненужные или продолжайте работать в текущей вкладке.' }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *537AE06700E8impl_uses*
 //#UC END# *537AE06700E8impl_uses*
;

const
 {* Варианты выбора для диалога TooManyTabsOpened }
 str_TooManyTabsOpened_Choice_First: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyTabsOpened_Choice_First'; rValue : 'Продолжить работу в текущей вкладке');
  {* 'Продолжить работу в текущей вкладке' }

initialization
 str_pui_MainWindowTabs.Init;
 {* Инициализация str_pui_MainWindowTabs }
 str_pi_UseTabs.Init;
 {* Инициализация str_pi_UseTabs }
 str_pi_OpenDocumentsFromList.Init;
 {* Инициализация str_pi_OpenDocumentsFromList }
 str_pi_OpenLinksFromDocument.Init;
 {* Инициализация str_pi_OpenLinksFromDocument }
 str_pi_InCurrentTab.Init;
 {* Инициализация str_pi_InCurrentTab }
 str_pi_InNewTab.Init;
 {* Инициализация str_pi_InNewTab }
 str_pi_InNewWindow.Init;
 {* Инициализация str_pi_InNewWindow }
 str_TooManyTabsOpened.Init;
 str_TooManyTabsOpened.AddChoice(str_TooManyTabsOpened_Choice_First);
 str_TooManyTabsOpened.AddDefaultChoice(str_TooManyTabsOpened_Choice_First);
 str_TooManyTabsOpened.SetDlgType(mtConfirmation);
 {* Инициализация str_TooManyTabsOpened }
 str_TooManyTabsOpened_Choice_First.Init;
 {* Инициализация str_TooManyTabsOpened_Choice_First }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
