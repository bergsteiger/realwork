unit nscHideField;

interface

uses
 l3IntfUses
 , vtHideField
 , vcmExternalInterfaces
 , l3ProtoObject
;

type
 TnscCustomHideField = class(TvtHideField)
  function MakeSettingId(const aSettingId: AnsiString): AnsiString;
  function SettingIdStored: Boolean;
   {* "‘ункци€ определ€юща€, что свойство SettingId сохран€етс€" }
 end;//TnscCustomHideField
 
 InscHideFieldState = interface
 end;//InscHideFieldState
 
 TnscHideFieldState = class(Tl3ProtoObject, InscHideFieldState)
  function Make: InscHideFieldState;
  function State: ThfState;
 end;//TnscHideFieldState
 
 TnscHideField = class(TnscCustomHideField)
 end;//TnscHideField
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , SysUtils
 , afwConsts
;

end.
