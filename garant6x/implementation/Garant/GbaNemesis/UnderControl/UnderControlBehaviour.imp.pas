{$IfNDef UnderControlBehaviour_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "UnderControl$Resetter"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/UnderControl/UnderControlBehaviour.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Core::Common::UnderControl$Resetter::UnderControlImpl::UnderControlBehaviour
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define UnderControlBehaviour_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _afwApplicationDataUpdate_Parent_ = _UnderControlBehaviour_Parent_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 _UnderControlBehaviour_ = {mixin} class(_afwApplicationDataUpdate_, IucpUnderControl)
 private
 // private fields
   f_HasControlStatus : Tl3Bool;
 protected
 // realized methods
   function Get_HasControlStatus: Boolean;
   function Get_Controllable: IControllable;
   function Get_ControlStatus: Longword;
 public
 // realized methods
   procedure ClearControlStatus;
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
 protected
 // protected methods
   function DoGetControllable: IControllable; virtual; abstract;
 end;//_UnderControlBehaviour_
{$Else}

 _afwApplicationDataUpdate_Parent_ = _UnderControlBehaviour_Parent_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 _UnderControlBehaviour_ = _afwApplicationDataUpdate_;

{$IfEnd} //not Admin AND not Monitorings

{$Else UnderControlBehaviour_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class _UnderControlBehaviour_

procedure _UnderControlBehaviour_.ClearControlStatus;
//#UC START# *4B9A2F660115_4B9A34C4007A_var*
var
 l_Controllable: IControllable;
//#UC END# *4B9A2F660115_4B9A34C4007A_var*
begin
//#UC START# *4B9A2F660115_4B9A34C4007A_impl*
 if Get_HasControlStatus then
 begin
  l_Controllable := Get_Controllable;
  if Assigned(l_Controllable) then
  try
   l3BoolReset(f_HasControlStatus);
   l_Controllable.ResetControlStatus;
  finally
   l_Controllable := nil;
  end;{try..finally}
 end;//Get_HasControlStatus
//#UC END# *4B9A2F660115_4B9A34C4007A_impl*
end;//_UnderControlBehaviour_.ClearControlStatus

function _UnderControlBehaviour_.Get_HasControlStatus: Boolean;
//#UC START# *4B9A2F95007C_4B9A34C4007Aget_var*
//#UC END# *4B9A2F95007C_4B9A34C4007Aget_var*
begin
//#UC START# *4B9A2F95007C_4B9A34C4007Aget_impl*
 Result := False;
 if not l3BoolCheck(f_HasControlStatus, Result) then
  Result := l3BoolSet(Get_ControlStatus <> CS_NONE, f_HasControlStatus);
//#UC END# *4B9A2F95007C_4B9A34C4007Aget_impl*
end;//_UnderControlBehaviour_.Get_HasControlStatus

function _UnderControlBehaviour_.Get_Controllable: IControllable;
//#UC START# *4B9A2FB102EE_4B9A34C4007Aget_var*
//#UC END# *4B9A2FB102EE_4B9A34C4007Aget_var*
begin
//#UC START# *4B9A2FB102EE_4B9A34C4007Aget_impl*
 Result := DoGetControllable;
//#UC END# *4B9A2FB102EE_4B9A34C4007Aget_impl*
end;//_UnderControlBehaviour_.Get_Controllable

function _UnderControlBehaviour_.Get_ControlStatus: Longword;
//#UC START# *4B9A2FD30344_4B9A34C4007Aget_var*
var
 l_Controllable: IControllable;
//#UC END# *4B9A2FD30344_4B9A34C4007Aget_var*
begin
//#UC START# *4B9A2FD30344_4B9A34C4007Aget_impl*
 l_Controllable := Get_Controllable;
 if Assigned(l_Controllable) and l_Controllable.GetControlled then
  Result := l_Controllable.GetControlStatus
 else
  Result := CS_NONE;
//#UC END# *4B9A2FD30344_4B9A34C4007Aget_impl*
end;//_UnderControlBehaviour_.Get_ControlStatus

procedure _UnderControlBehaviour_.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4B9A34C4007A_var*
//#UC END# *47EA4E9002C6_4B9A34C4007A_var*
begin
//#UC START# *47EA4E9002C6_4B9A34C4007A_impl*
 inherited;
 l3BoolReset(f_HasControlStatus);
//#UC END# *47EA4E9002C6_4B9A34C4007A_impl*
end;//_UnderControlBehaviour_.FinishDataUpdate

{$IfEnd} //not Admin AND not Monitorings

{$EndIf UnderControlBehaviour_imp}
