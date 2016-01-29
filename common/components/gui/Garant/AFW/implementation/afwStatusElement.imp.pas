{$IfNDef afwStatusElement_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW"
// ������: "w:/common/components/gui/Garant/AFW/implementation/afwStatusElement.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::AFW::afwMixIns::afwStatusElement
//
// ���������� IafwStatusElement
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define afwStatusElement_imp}
 _afwStatusElement_ = {mixin} class(_afwStatusElement_Parent_, IafwStatusElement)
  {* ���������� IafwStatusElement }
 private
 // private fields
   f_Status : IafwStatus;
    {* ���� ��� �������� Status}
 protected
 // realized methods
   procedure GetStatusInfo(out theString: IafwCString;
    out theNeedProgress: Boolean);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 protected
 // protected methods
   procedure DoGetStatusInfo(out theString: IafwCString;
    out theNeedProgress: Boolean); virtual; abstract;
     {* ���������� ������� ��������� ���������� }
   function DoSubscribe: Boolean;
     {* ����������� � ������ ������� }
   procedure DoUnsubscribe;
     {* ���������� �� ������ ������� }
   function NeedUpdateOnUnsubscribe: Boolean; virtual;
 private
 // private properties
   property Status: IafwStatus
     read f_Status;
     {* ������ ������� � ������� �� ��������� }
 end;//_afwStatusElement_

{$Else afwStatusElement_imp}

// start class _afwStatusElement_

function _afwStatusElement_.DoSubscribe: Boolean;
//#UC START# *49CCA29A000E_49CCA20A0092_var*
var
 l_Status : IafwStatus;
//#UC END# *49CCA29A000E_49CCA20A0092_var*
begin
//#UC START# *49CCA29A000E_49CCA20A0092_impl*
 if (afw.Application = nil) OR
    (afw.Application.CurrentMainForm = nil) OR
    (afw.Application.CurrentMainForm.Status = nil) then
 begin
  Result := false;
  DoUnsubscribe;
  // - � �� �����, �� ��� ���� ���������
 end//afw.Application = nil
 else
 begin
  Result := true;
  l_Status := afw.Application.CurrentMainForm.Status;
  if (l_Status <> f_Status) then
  begin
   if (f_Status <> nil) then
    f_Status.RemoveElement(Self);
    // - � �� �����, �� ��� ���� ���������
   f_Status := l_Status;
   f_Status.AddElement(Self);
  end;//l_Status <> f_Status
 end;//afwGetApplication = nil
//#UC END# *49CCA29A000E_49CCA20A0092_impl*
end;//_afwStatusElement_.DoSubscribe

procedure _afwStatusElement_.DoUnsubscribe;
//#UC START# *49CCA2C80106_49CCA20A0092_var*
//#UC END# *49CCA2C80106_49CCA20A0092_var*
begin
//#UC START# *49CCA2C80106_49CCA20A0092_impl*
 if (f_Status <> nil) then
 begin
  f_Status.RemoveElement(Self);
  if NeedUpdateOnUnsubscribe then
   f_Status.Update;
  f_Status := nil;
 end;//f_Status <> nil
//#UC END# *49CCA2C80106_49CCA20A0092_impl*
end;//_afwStatusElement_.DoUnsubscribe

function _afwStatusElement_.NeedUpdateOnUnsubscribe: Boolean;
//#UC START# *49CCA4C90343_49CCA20A0092_var*
//#UC END# *49CCA4C90343_49CCA20A0092_var*
begin
//#UC START# *49CCA4C90343_49CCA20A0092_impl*
 Result := false;
//#UC END# *49CCA4C90343_49CCA20A0092_impl*
end;//_afwStatusElement_.NeedUpdateOnUnsubscribe

procedure _afwStatusElement_.GetStatusInfo(out theString: IafwCString;
  out theNeedProgress: Boolean);
//#UC START# *475E9466022A_49CCA20A0092_var*
//#UC END# *475E9466022A_49CCA20A0092_var*
begin
//#UC START# *475E9466022A_49CCA20A0092_impl*
 DoGetStatusInfo(theString, theNeedProgress);
//#UC END# *475E9466022A_49CCA20A0092_impl*
end;//_afwStatusElement_.GetStatusInfo

procedure _afwStatusElement_.Cleanup;
//#UC START# *479731C50290_49CCA20A0092_var*
//#UC END# *479731C50290_49CCA20A0092_var*
begin
//#UC START# *479731C50290_49CCA20A0092_impl*
 inherited;
 DoUnsubscribe;
//#UC END# *479731C50290_49CCA20A0092_impl*
end;//_afwStatusElement_.Cleanup

procedure _afwStatusElement_.ClearFields;
 {-}
begin
 f_Status := nil;
 inherited;
end;//_afwStatusElement_.ClearFields

{$EndIf afwStatusElement_imp}
