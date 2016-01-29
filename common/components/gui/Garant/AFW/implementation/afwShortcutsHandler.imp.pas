{$IfNDef afwShortcutsHandler_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW$Core"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/AFW/implementation/afwShortcutsHandler.imp.pas"
// �����: 22.04.2009 19:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::AFW$Core::ControlsMixIns::afwShortcutsHandler
//
// ���������� ShortCut'��
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define afwShortcutsHandler_imp}
{$If not defined(DesignTimeLibrary)}
 _afwShortcutsHandler_ = {mixin} class(_afwShortcutsHandler_Parent_)
  {* ���������� ShortCut'�� }
 protected
 // protected methods
   function IsHandledShortcut(var Msg: TMessage): Boolean;
     {* ���������� ShortCut'�� }
   function IsSomePopupWasClosed: Boolean; virtual;
   procedure WndProc(var Message: TMessage); override;
     {* ������� ��������� }
 end;//_afwShortcutsHandler_
{$Else}

 _afwShortcutsHandler_ = _afwShortcutsHandler_Parent_;

{$IfEnd} //not DesignTimeLibrary

{$Else afwShortcutsHandler_imp}

{$If not defined(DesignTimeLibrary)}

// start class _afwShortcutsHandler_

function _afwShortcutsHandler_.IsHandledShortcut(var Msg: TMessage): Boolean;
//#UC START# *49EF3805033D_49EF346400A4_var*
//#UC END# *49EF3805033D_49EF346400A4_var*
var
 l_Controller : TOvcController;
begin
//#UC START# *49EF3805033D_49EF346400A4_impl*
 Result := false;
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if (TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut) then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    Result := true;
   end;//TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut
//#UC END# *49EF3805033D_49EF346400A4_impl*
end;//_afwShortcutsHandler_.IsHandledShortcut

function _afwShortcutsHandler_.IsSomePopupWasClosed: Boolean;
//#UC START# *4EBD2EE8031A_49EF346400A4_var*
//#UC END# *4EBD2EE8031A_49EF346400A4_var*
begin
//#UC START# *4EBD2EE8031A_49EF346400A4_impl*
 Result := false;
//#UC END# *4EBD2EE8031A_49EF346400A4_impl*
end;//_afwShortcutsHandler_.IsSomePopupWasClosed

procedure _afwShortcutsHandler_.WndProc(var Message: TMessage);
//#UC START# *49EF38CC0345_49EF346400A4_var*
var
 Msg : TMessage;
//#UC END# *49EF38CC0345_49EF346400A4_var*
begin
//#UC START# *49EF38CC0345_49EF346400A4_impl*
 if (Message.Msg = CN_KEYDOWN) or (Message.Msg = CN_SYSKEYDOWN) then
 begin
  Msg := Message;
  Msg.Msg := Message.Msg - CN_BASE;

  // ������������ �������
  if (TWMKeyDown(Message).CharCode = VK_ESCAPE) then
  begin
   if IsSomePopupWasClosed then
   begin
    Message.Result := 1;
    Exit;
   end;
  end;//TWMKeyDown(Message).Key = VK_ESCAPE

  // ��� ������� Enter �� ������������ ������� OVC, ���� ������:
  //  http://mdp.garant.ru/pages/viewpage.action?pageId=269061880
  if not ( (TWMKeyDown(Message).CharCode = VK_RETURN) and
           (KeyDataToShiftState(TWMKeyDown(Message).KeyData) = []) ) 
     and IsHandledShortcut(Msg) then
  begin
   Message.Result := 1;
   Exit;
  end;//...TWMKeyDown(Message).CharCode = VK_RETURN..
 end;//Message.Msg = CN_KEYDOWN
 inherited;
//#UC END# *49EF38CC0345_49EF346400A4_impl*
end;//_afwShortcutsHandler_.WndProc

{$IfEnd} //not DesignTimeLibrary

{$EndIf afwShortcutsHandler_imp}
