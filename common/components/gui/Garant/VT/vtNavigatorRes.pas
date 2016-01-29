unit vtNavigatorRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$WithVCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VT/vtNavigatorRes.pas"
// Начат: 02.03.2010 17:58
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT$WithVCM::vtNavigator::vtNavigatorRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3StringIDEx
  ;

var
  { Локализуемые строки TvtNavigatorHints }
 str_vtAutoHideOffHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtAutoHideOffHint'; rValue : 'Зафиксировать панель навигации');
  { 'Зафиксировать панель навигации' }
 str_vtAutoHideOnHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtAutoHideOnHint'; rValue : 'Сворачивать панель навигации');
  { 'Сворачивать панель навигации' }
 str_vtMinimizedOnHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMinimizedOnHint'; rValue : 'Свернуть');
  { 'Свернуть' }
 str_vtMinimizedOffHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMinimizedOffHint'; rValue : 'Развернуть');
  { 'Развернуть' }
 str_vtBtnCloseHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtBtnCloseHint'; rValue : 'Прикрепить навигатор');
  { 'Прикрепить навигатор' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// Инициализация str_vtAutoHideOffHint
 str_vtAutoHideOffHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vtAutoHideOnHint
 str_vtAutoHideOnHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vtMinimizedOnHint
 str_vtMinimizedOnHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vtMinimizedOffHint
 str_vtMinimizedOffHint.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_vtBtnCloseHint
 str_vtBtnCloseHint.Init;
{$IfEnd} //not NoVCM

end.