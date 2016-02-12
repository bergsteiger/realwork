unit NOT_FINISHED_l3LocaleInfo;

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3LocaleInfo.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
;

type
 Tl3BaseLocaleInfo = class(Tl3ProtoObject, Il3LocaleInfo)
  protected
   function pm_GetId: LCID;
   function pm_GetLanguage: AnsiString;
   function pm_GetSubLanguage: AnsiString;
   function pm_GetName: AnsiString;
 end;//Tl3BaseLocaleInfo

 Tl3UnixLocaleInfo = class(Tl3BaseLocaleInfo)
 end;//Tl3UnixLocaleInfo

implementation

uses
 l3ImplUses
 , l3Base
;

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
