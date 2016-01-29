{$IfNDef m3BaseStore_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3BaseStore.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi For Archi::m3::Streams::m3BaseStore
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define m3BaseStore_imp}
 _m3BaseStore_ = {mixin} class(_m3BaseStore_Parent_, Im2StoreStat)
 private
 // private fields
   f_Access : Tm3StoreAccess;
    {* Поле для свойства Access}
 protected
 // realized methods
   function pm_GetAccess: LongInt;
   function pm_GetLocksSupported: LongInt;
   function pm_GetSize: Int64;
   function pm_GetPosition: Int64;
   function Get_Name: WideString;
 protected
 // protected methods
   function DoGetPosition: Int64; virtual;
   function DoGetSize: Int64; virtual;
   function DoGetLocksSupported: Integer; virtual;
   function DoGetAccess: Integer;
   function DoGetName: WideString; virtual;
 public
 // public methods
   constructor Create(anAccess: Tm3StoreAccess); reintroduce;
   function ReadOnly: Boolean;
     {* только для чтения? }
 protected
 // protected properties
   property Access: Tm3StoreAccess
     read f_Access;
 end;//_m3BaseStore_

{$Else m3BaseStore_imp}

// start class _m3BaseStore_

function _m3BaseStore_.DoGetPosition: Int64;
//#UC START# *4FA280090314_4FA276650046_var*
//#UC END# *4FA280090314_4FA276650046_var*
begin
//#UC START# *4FA280090314_4FA276650046_impl*
 Result := 0;
 Assert(false);
//#UC END# *4FA280090314_4FA276650046_impl*
end;//_m3BaseStore_.DoGetPosition

function _m3BaseStore_.DoGetSize: Int64;
//#UC START# *4FA2802E0231_4FA276650046_var*
//#UC END# *4FA2802E0231_4FA276650046_var*
begin
//#UC START# *4FA2802E0231_4FA276650046_impl*
 Result := 0;
//#UC END# *4FA2802E0231_4FA276650046_impl*
end;//_m3BaseStore_.DoGetSize

function _m3BaseStore_.DoGetLocksSupported: Integer;
//#UC START# *4FA2805002E3_4FA276650046_var*
//#UC END# *4FA2805002E3_4FA276650046_var*
begin
//#UC START# *4FA2805002E3_4FA276650046_impl*
 Result := 0;
//#UC END# *4FA2805002E3_4FA276650046_impl*
end;//_m3BaseStore_.DoGetLocksSupported

function _m3BaseStore_.DoGetAccess: Integer;
//#UC START# *4FA28066013B_4FA276650046_var*
//#UC END# *4FA28066013B_4FA276650046_var*
begin
//#UC START# *4FA28066013B_4FA276650046_impl*
 Result := Self.Access;
//#UC END# *4FA28066013B_4FA276650046_impl*
end;//_m3BaseStore_.DoGetAccess

function _m3BaseStore_.DoGetName: WideString;
//#UC START# *5412FB880320_4FA276650046_var*
//#UC END# *5412FB880320_4FA276650046_var*
begin
//#UC START# *5412FB880320_4FA276650046_impl*
 Result := '';
//#UC END# *5412FB880320_4FA276650046_impl*
end;//_m3BaseStore_.DoGetName

constructor _m3BaseStore_.Create(anAccess: Tm3StoreAccess);
//#UC START# *5481BE57013F_4FA276650046_var*
//#UC END# *5481BE57013F_4FA276650046_var*
begin
//#UC START# *5481BE57013F_4FA276650046_impl*
 inherited Create;
 f_Access := anAccess;
//#UC END# *5481BE57013F_4FA276650046_impl*
end;//_m3BaseStore_.Create

function _m3BaseStore_.ReadOnly: Boolean;
//#UC START# *5481BE870251_4FA276650046_var*
//#UC END# *5481BE870251_4FA276650046_var*
begin
//#UC START# *5481BE870251_4FA276650046_impl*
 Result := (Access AND (STGM_WRITE OR STGM_READWRITE) = 0);
//#UC END# *5481BE870251_4FA276650046_impl*
end;//_m3BaseStore_.ReadOnly

function _m3BaseStore_.pm_GetAccess: LongInt;
//#UC START# *4EFAE62A0025_4FA276650046get_var*
//#UC END# *4EFAE62A0025_4FA276650046get_var*
begin
//#UC START# *4EFAE62A0025_4FA276650046get_impl*
 Result := DoGetAccess;
//#UC END# *4EFAE62A0025_4FA276650046get_impl*
end;//_m3BaseStore_.pm_GetAccess

function _m3BaseStore_.pm_GetLocksSupported: LongInt;
//#UC START# *4EFAE64E031B_4FA276650046get_var*
//#UC END# *4EFAE64E031B_4FA276650046get_var*
begin
//#UC START# *4EFAE64E031B_4FA276650046get_impl*
 Result := DoGetLocksSupported;
//#UC END# *4EFAE64E031B_4FA276650046get_impl*
end;//_m3BaseStore_.pm_GetLocksSupported

function _m3BaseStore_.pm_GetSize: Int64;
//#UC START# *4EFAE66C02BA_4FA276650046get_var*
//#UC END# *4EFAE66C02BA_4FA276650046get_var*
begin
//#UC START# *4EFAE66C02BA_4FA276650046get_impl*
 Result := DoGetSize;
//#UC END# *4EFAE66C02BA_4FA276650046get_impl*
end;//_m3BaseStore_.pm_GetSize

function _m3BaseStore_.pm_GetPosition: Int64;
//#UC START# *4EFAF2DF01C3_4FA276650046get_var*
//#UC END# *4EFAF2DF01C3_4FA276650046get_var*
begin
//#UC START# *4EFAF2DF01C3_4FA276650046get_impl*
 Result := DoGetPosition;
//#UC END# *4EFAF2DF01C3_4FA276650046get_impl*
end;//_m3BaseStore_.pm_GetPosition

function _m3BaseStore_.Get_Name: WideString;
//#UC START# *5412F6940100_4FA276650046get_var*
//#UC END# *5412F6940100_4FA276650046get_var*
begin
//#UC START# *5412F6940100_4FA276650046get_impl*
 Result := DoGetName;
//#UC END# *5412F6940100_4FA276650046get_impl*
end;//_m3BaseStore_.Get_Name

{$EndIf m3BaseStore_imp}
