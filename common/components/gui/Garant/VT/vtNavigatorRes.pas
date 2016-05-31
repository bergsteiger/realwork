unit vtNavigatorRes;

// Модуль: "w:\common\components\gui\Garant\VT\vtNavigatorRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vtNavigatorRes" MUID: (4B8D2783018D)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки TvtNavigatorHints }
 str_vtAutoHideOffHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtAutoHideOffHint'; rValue : 'Зафиксировать панель навигации');
  {* 'Зафиксировать панель навигации' }
 str_vtAutoHideOnHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtAutoHideOnHint'; rValue : 'Сворачивать панель навигации');
  {* 'Сворачивать панель навигации' }
 str_vtMinimizedOnHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMinimizedOnHint'; rValue : 'Свернуть');
  {* 'Свернуть' }
 str_vtMinimizedOffHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMinimizedOffHint'; rValue : 'Развернуть');
  {* 'Развернуть' }
 str_vtBtnCloseHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtBtnCloseHint'; rValue : 'Прикрепить навигатор');
  {* 'Прикрепить навигатор' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

initialization
 str_vtAutoHideOffHint.Init;
 {* Инициализация str_vtAutoHideOffHint }
 str_vtAutoHideOnHint.Init;
 {* Инициализация str_vtAutoHideOnHint }
 str_vtMinimizedOnHint.Init;
 {* Инициализация str_vtMinimizedOnHint }
 str_vtMinimizedOffHint.Init;
 {* Инициализация str_vtMinimizedOffHint }
 str_vtBtnCloseHint.Init;
 {* Инициализация str_vtBtnCloseHint }
{$IfEnd} // NOT Defined(NoVCM)

end.
