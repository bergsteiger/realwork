{$IfNDef m3RootStream_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3RootStream.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::m3::m3CoreObjects::m3RootStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define m3RootStream_imp}
 {$Include ..\m3\m3CustomHeaderStream.imp.pas}
 _m3RootStream_ = {mixin} class(_m3CustomHeaderStream_)
 private
 // private fields
   f_Logger : Tl3Logger;
    {* Поле для свойства Logger}
 protected
 // property methods
   procedure pm_SetLogger(aValue: Tl3Logger);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DefaultInitAction; override;
   procedure DefaultDoneAction; override;
   function DoLockHeader: Boolean; override;
   function DoUnlockHeader: Boolean; override;
 public
 // public methods
   constructor Create(const aStream: IStream;
     aAccess: Integer); reintroduce;
 public
 // public properties
   property Logger: Tl3Logger
     read f_Logger
     write pm_SetLogger;
 end;//_m3RootStream_

{$Else m3RootStream_imp}

{$Include ..\m3\m3CustomHeaderStream.imp.pas}

// start class _m3RootStream_

constructor _m3RootStream_.Create(const aStream: IStream;
  aAccess: Integer);
//#UC START# *540F06F60288_54073B760302_var*
//#UC END# *540F06F60288_54073B760302_var*
begin
//#UC START# *540F06F60288_54073B760302_impl*
 inherited;
//#UC END# *540F06F60288_54073B760302_impl*
end;//_m3RootStream_.Create

procedure _m3RootStream_.pm_SetLogger(aValue: Tl3Logger);
//#UC START# *540F06CE030B_54073B760302set_var*
//#UC END# *540F06CE030B_54073B760302set_var*
begin
//#UC START# *540F06CE030B_54073B760302set_impl*
 aValue.SetRefTo(f_Logger);
//#UC END# *540F06CE030B_54073B760302set_impl*
end;//_m3RootStream_.pm_SetLogger

procedure _m3RootStream_.Cleanup;
//#UC START# *479731C50290_54073B760302_var*
//#UC END# *479731C50290_54073B760302_var*
begin
//#UC START# *479731C50290_54073B760302_impl*
 Logger := nil;
 inherited;
//#UC END# *479731C50290_54073B760302_impl*
end;//_m3RootStream_.Cleanup

procedure _m3RootStream_.DefaultInitAction;
//#UC START# *53FDFD1D0164_54073B760302_var*
//#UC END# *53FDFD1D0164_54073B760302_var*
begin
//#UC START# *53FDFD1D0164_54073B760302_impl*
 // - ничего не делаем
//#UC END# *53FDFD1D0164_54073B760302_impl*
end;//_m3RootStream_.DefaultInitAction

procedure _m3RootStream_.DefaultDoneAction;
//#UC START# *53FDFD34034B_54073B760302_var*
//#UC END# *53FDFD34034B_54073B760302_var*
begin
//#UC START# *53FDFD34034B_54073B760302_impl*
 // - ничего не делаем
//#UC END# *53FDFD34034B_54073B760302_impl*
end;//_m3RootStream_.DefaultDoneAction

function _m3RootStream_.DoLockHeader: Boolean;
//#UC START# *540F07260255_54073B760302_var*
//#UC END# *540F07260255_54073B760302_var*
begin
//#UC START# *540F07260255_54073B760302_impl*
 Result := inherited DoLockHeader;
 {$IfDef m3LogRootStreamHeaderLocks}
 if Result then
  if (Logger <> nil) then
   Logger.ToLog('Header locked');
 {$EndIf m3LogRootStreamHeaderLocks}  
//#UC END# *540F07260255_54073B760302_impl*
end;//_m3RootStream_.DoLockHeader

function _m3RootStream_.DoUnlockHeader: Boolean;
//#UC START# *540F072F02B4_54073B760302_var*
//#UC END# *540F072F02B4_54073B760302_var*
begin
//#UC START# *540F072F02B4_54073B760302_impl*
 Result := inherited DoUnlockHeader;
 {$IfDef m3LogRootStreamHeaderLocks}
 if Result then
  if (Logger <> nil) then
   Logger.ToLog('Header unlocked');
 {$EndIf m3LogRootStreamHeaderLocks}  
//#UC END# *540F072F02B4_54073B760302_impl*
end;//_m3RootStream_.DoUnlockHeader

{$EndIf m3RootStream_imp}
