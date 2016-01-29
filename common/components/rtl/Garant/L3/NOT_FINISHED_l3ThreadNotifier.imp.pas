{$IfNDef l3ThreadNotifier_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3ThreadNotifier.imp.pas"
// Начат: 2005/11/22 16:19:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3ThreadNotifier
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3ThreadNotifier_imp}
 Tl3DataHolder = class(Tl3CacheableBase)
 private
 // private fields
   f_Intf : array of IUnknown;
   f_Data : Pointer;
    {* Поле для свойства Data}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aData: Pointer;
    aDataSize: Integer;
    const anIntf: array of IUnknown); reintroduce;
 public
 // public properties
   property Data: Pointer
     read f_Data;
 end;//Tl3DataHolder

 Rl3DataHolder = class of Tl3DataHolder;

 TnsOnChangeInOtherThreadMethod = procedure (aDataPtr: Tl3DataHolder) of object;

 _l3ThreadNotifier_ = {mixin} class(_l3ThreadNotifier_Parent_)
 private
 // private fields
   f_CustomChangeWindow : hWnd;
   f_PostMessageCounter : Integer;
 private
 // private methods
   class function SynchronizeMessage: Longword;
   procedure WndProc(var aMessage: TMessage);
 protected
 // protected methods
   function HolderClass: Rl3DataHolder; virtual;
   procedure InitFields; override;
   procedure Cleanup; override;
   procedure Synchronize(aOnChangeInOtherThread: TnsOnChangeInOtherThreadMethod;
    aDataPtr: Pointer;
    aDataSize: Integer;
    const anIntf: array of IUnknown); overload; 
   procedure Synchronize(aOnChangeInOtherThread: TnsOnChangeInOtherThreadMethod;
    aDataPtr: Pointer;
    aDataSize: Integer); overload; 
   procedure Synchronize(aOnChangeInOtherThread: TnsOnChangeInOtherThreadMethod;
    aDataPtr: Tl3DataHolder = nil); overload; 
 end;//_l3ThreadNotifier_

{$Else l3ThreadNotifier_imp}

// start class Tl3DataHolder

constructor Tl3DataHolder.Create(aData: Pointer;
  aDataSize: Integer;
  const anIntf: array of IUnknown);
//#UC START# *48FD94F00280_48FD94080208_var*
//#UC END# *48FD94F00280_48FD94080208_var*
begin
//#UC START# *48FD94F00280_48FD94080208_impl*
 !!! Needs to be implemented !!!
//#UC END# *48FD94F00280_48FD94080208_impl*
end;//Tl3DataHolder.Create

procedure Tl3DataHolder.Cleanup;
//#UC START# *479731C50290_48FD94080208_var*
//#UC END# *479731C50290_48FD94080208_var*
begin
//#UC START# *479731C50290_48FD94080208_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_48FD94080208_impl*
end;//Tl3DataHolder.Cleanup

function _l3ThreadNotifier_.HolderClass: Rl3DataHolder;
//#UC START# *48FD9562004C_48FD8E460027_var*
//#UC END# *48FD9562004C_48FD8E460027_var*
begin
//#UC START# *48FD9562004C_48FD8E460027_impl*
 !!! Needs to be implemented !!!
//#UC END# *48FD9562004C_48FD8E460027_impl*
end;//_l3ThreadNotifier_.HolderClass

class function _l3ThreadNotifier_.SynchronizeMessage: Longword;
//#UC START# *48FD977D00E2_48FD8E460027_var*
//#UC END# *48FD977D00E2_48FD8E460027_var*
begin
//#UC START# *48FD977D00E2_48FD8E460027_impl*
 !!! Needs to be implemented !!!
//#UC END# *48FD977D00E2_48FD8E460027_impl*
end;//_l3ThreadNotifier_.SynchronizeMessage

procedure _l3ThreadNotifier_.WndProc(var aMessage: TMessage);
//#UC START# *48FD978F02C0_48FD8E460027_var*
//#UC END# *48FD978F02C0_48FD8E460027_var*
begin
//#UC START# *48FD978F02C0_48FD8E460027_impl*
 !!! Needs to be implemented !!!
//#UC END# *48FD978F02C0_48FD8E460027_impl*
end;//_l3ThreadNotifier_.WndProc

procedure _l3ThreadNotifier_.InitFields;
//#UC START# *48FD97AF03AF_48FD8E460027_var*
//#UC END# *48FD97AF03AF_48FD8E460027_var*
begin
//#UC START# *48FD97AF03AF_48FD8E460027_impl*
 !!! Needs to be implemented !!!
//#UC END# *48FD97AF03AF_48FD8E460027_impl*
end;//_l3ThreadNotifier_.InitFields

procedure _l3ThreadNotifier_.Cleanup;
//#UC START# *48FD97BC0335_48FD8E460027_var*
//#UC END# *48FD97BC0335_48FD8E460027_var*
begin
//#UC START# *48FD97BC0335_48FD8E460027_impl*
 !!! Needs to be implemented !!!
//#UC END# *48FD97BC0335_48FD8E460027_impl*
end;//_l3ThreadNotifier_.Cleanup

procedure _l3ThreadNotifier_.Synchronize(aOnChangeInOtherThread: TnsOnChangeInOtherThreadMethod;
  aDataPtr: Pointer;
  aDataSize: Integer;
  const anIntf: array of IUnknown);
//#UC START# *48FD98230314_48FD8E460027_var*
//#UC END# *48FD98230314_48FD8E460027_var*
begin
//#UC START# *48FD98230314_48FD8E460027_impl*
 !!! Needs to be implemented !!!
//#UC END# *48FD98230314_48FD8E460027_impl*
end;//_l3ThreadNotifier_.Synchronize

procedure _l3ThreadNotifier_.Synchronize(aOnChangeInOtherThread: TnsOnChangeInOtherThreadMethod;
  aDataPtr: Pointer;
  aDataSize: Integer);
//#UC START# *48FD989D02FB_48FD8E460027_var*
//#UC END# *48FD989D02FB_48FD8E460027_var*
begin
//#UC START# *48FD989D02FB_48FD8E460027_impl*
 !!! Needs to be implemented !!!
//#UC END# *48FD989D02FB_48FD8E460027_impl*
end;//_l3ThreadNotifier_.Synchronize

procedure _l3ThreadNotifier_.Synchronize(aOnChangeInOtherThread: TnsOnChangeInOtherThreadMethod;
  aDataPtr: Tl3DataHolder = nil);
//#UC START# *48FD98BB0289_48FD8E460027_var*
//#UC END# *48FD98BB0289_48FD8E460027_var*
begin
//#UC START# *48FD98BB0289_48FD8E460027_impl*
 !!! Needs to be implemented !!!
//#UC END# *48FD98BB0289_48FD8E460027_impl*
end;//_l3ThreadNotifier_.Synchronize

{$EndIf l3ThreadNotifier_imp}
