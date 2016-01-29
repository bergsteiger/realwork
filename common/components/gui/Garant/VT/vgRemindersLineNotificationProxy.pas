unit vgRemindersLineNotificationProxy;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT$Rem"
// ������: "w:/common/components/gui/Garant/VT/vgRemindersLineNotificationProxy.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$Rem::NewReminders::TvgRemindersLineNotificationProxy
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVGScene)}
uses
  l3ProtoObject,
  spHelpNotifyManager
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgRemindersLineNotificationProxy = class(Tl3ProtoObject, IspHelpNotifyListener)
 protected
 // realized methods
   procedure HelpShown;
     {* ��������� ������ HelpShown }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure InitFields; override;
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TvgRemindersLineNotificationProxy;
    {- ���������� ��������� ����������. }
 end;//TvgRemindersLineNotificationProxy
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  l3Base {a},
  vgRemindersLineManager
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}


// start class TvgRemindersLineNotificationProxy

var g_TvgRemindersLineNotificationProxy : TvgRemindersLineNotificationProxy = nil;

procedure TvgRemindersLineNotificationProxyFree;
begin
 l3Free(g_TvgRemindersLineNotificationProxy);
end;

class function TvgRemindersLineNotificationProxy.Instance: TvgRemindersLineNotificationProxy;
begin
 if (g_TvgRemindersLineNotificationProxy = nil) then
 begin
  l3System.AddExitProc(TvgRemindersLineNotificationProxyFree);
  g_TvgRemindersLineNotificationProxy := Create;
 end;
 Result := g_TvgRemindersLineNotificationProxy;
end;


class function TvgRemindersLineNotificationProxy.Exists: Boolean;
 {-}
begin
 Result := g_TvgRemindersLineNotificationProxy <> nil;
end;//TvgRemindersLineNotificationProxy.Exists

procedure TvgRemindersLineNotificationProxy.HelpShown;
//#UC START# *53760DC000EE_5376118F03C8_var*
//#UC END# *53760DC000EE_5376118F03C8_var*
begin
//#UC START# *53760DC000EE_5376118F03C8_impl*
 TvgRemindersLineManager.CheckZOrder;
//#UC END# *53760DC000EE_5376118F03C8_impl*
end;//TvgRemindersLineNotificationProxy.HelpShown

procedure TvgRemindersLineNotificationProxy.Cleanup;
//#UC START# *479731C50290_5376118F03C8_var*
//#UC END# *479731C50290_5376118F03C8_var*
begin
//#UC START# *479731C50290_5376118F03C8_impl*
 TspHelpNotifyManager.RemoveListener(Self);
 inherited;
//#UC END# *479731C50290_5376118F03C8_impl*
end;//TvgRemindersLineNotificationProxy.Cleanup

procedure TvgRemindersLineNotificationProxy.InitFields;
//#UC START# *47A042E100E2_5376118F03C8_var*
//#UC END# *47A042E100E2_5376118F03C8_var*
begin
//#UC START# *47A042E100E2_5376118F03C8_impl*
 inherited;
 TspHelpNotifyManager.AddListener(Self);
//#UC END# *47A042E100E2_5376118F03C8_impl*
end;//TvgRemindersLineNotificationProxy.InitFields

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoVGScene)}
//#UC START# *53763C3A0170*
 TvgRemindersLineNotificationProxy.Instance;
//#UC END# *53763C3A0170*
{$IfEnd} //not NoVGScene

end.