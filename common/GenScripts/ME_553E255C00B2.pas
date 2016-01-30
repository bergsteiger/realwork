unit ChromeLikeTabSetControlRes;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetControlRes.pas"
// Стереотип: "UtilityPack"

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ChromeLikeTabSetControllConst }
 str_NewTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NewTab'; rValue : 'Новая вкладка');
  {* 'Новая вкладка' }
 str_MakeClone: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MakeClone'; rValue : 'Дублировать');
  {* 'Дублировать' }
 str_CloseTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseTab'; rValue : 'Закрыть вкладку');
  {* 'Закрыть вкладку' }
 str_CloseOtherTabs: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseOtherTabs'; rValue : 'Закрыть другие вкладки');
  {* 'Закрыть другие вкладки' }
 str_CloseRightTabs: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CloseRightTabs'; rValue : 'Закрыть вкладки справа');
  {* 'Закрыть вкладки справа' }
 str_ReopenClosedTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ReopenClosedTab'; rValue : 'Открыть закрытую вкладку');
  {* 'Открыть закрытую вкладку' }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_NewTab.Init;
 {* Инициализация str_NewTab }
 str_MakeClone.Init;
 {* Инициализация str_MakeClone }
 str_CloseTab.Init;
 {* Инициализация str_CloseTab }
 str_CloseOtherTabs.Init;
 {* Инициализация str_CloseOtherTabs }
 str_CloseRightTabs.Init;
 {* Инициализация str_CloseRightTabs }
 str_ReopenClosedTab.Init;
 {* Инициализация str_ReopenClosedTab }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
