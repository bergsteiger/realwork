unit NOT_FINISHED_l3LocaleInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Морозов М.А.
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3LocaleInfo.pas"
// Начат: 27.06.2005 14.30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3LocaleInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3ProtoObject
  ;

type
 Tl3BaseLocaleInfo = class(Tl3ProtoObject, Il3LocaleInfo)
 protected
 // realized methods
   function pm_GetId: LCID;
   function pm_GetLanguage: AnsiString;
   function pm_GetSubLanguage: AnsiString;
   function pm_GetName: AnsiString;
 end;//Tl3BaseLocaleInfo

 Tl3UnixLocaleInfo = class(Tl3BaseLocaleInfo)
 end;//Tl3UnixLocaleInfo

implementation

uses
  l3Base
  ;

// start class Tl3BaseLocaleInfo

function Tl3BaseLocaleInfo.pm_GetId: LCID;
//#UC START# *46A44E1C003B_478778770380get_var*
//#UC END# *46A44E1C003B_478778770380get_var*
begin
//#UC START# *46A44E1C003B_478778770380get_impl*
 assert(false, 'Tl3BaseLocaleInfo.pm_GetId not implemented');
//#UC END# *46A44E1C003B_478778770380get_impl*
end;//Tl3BaseLocaleInfo.pm_GetId

function Tl3BaseLocaleInfo.pm_GetLanguage: AnsiString;
//#UC START# *46A44E3A0002_478778770380get_var*
//#UC END# *46A44E3A0002_478778770380get_var*
begin
//#UC START# *46A44E3A0002_478778770380get_impl*
 assert(false, 'Tl3BaseLocaleInfo.pm_GetLanguage not implemented');
//#UC END# *46A44E3A0002_478778770380get_impl*
end;//Tl3BaseLocaleInfo.pm_GetLanguage

function Tl3BaseLocaleInfo.pm_GetSubLanguage: AnsiString;
//#UC START# *46A44E5C0340_478778770380get_var*
//#UC END# *46A44E5C0340_478778770380get_var*
begin
//#UC START# *46A44E5C0340_478778770380get_impl*
 assert(false, 'Tl3BaseLocaleInfo.pm_GetSubLanguage not implemented');
//#UC END# *46A44E5C0340_478778770380get_impl*
end;//Tl3BaseLocaleInfo.pm_GetSubLanguage

function Tl3BaseLocaleInfo.pm_GetName: AnsiString;
//#UC START# *46A44E770154_478778770380get_var*
//#UC END# *46A44E770154_478778770380get_var*
begin
//#UC START# *46A44E770154_478778770380get_impl*
 assert(false, 'Tl3BaseLocaleInfo.pm_GetName not implemented');
//#UC END# *46A44E770154_478778770380get_impl*
end;//Tl3BaseLocaleInfo.pm_GetName
end.