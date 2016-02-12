unit PrimSynchroView_Form;
 {* ���������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimSynchroView_Form.pas"
// ���������: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Base_Operations_Strange_Controls
 , WorkWithListInterfaces
 , vtPanel
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , nsLogEvent
 , DynamicDocListUnit
;

type
 // Child

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}
 _SynchroViewUserTypes_Parent_ = _PageControlNotification_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\SynchroViewUserTypes.imp.pas}
 TPrimSynchroViewForm = class(_SynchroViewUserTypes_)
  {* ���������� �������� }
  private
   f_DocView: TvtPanel;
    {* ���� ��� �������� DocView }
  protected
   : IdsSynchroView;
   sdsList: IsdsList;
  protected
   procedure DoTabActivate; override;
    {* ������� �� ������������ ������� }
   procedure svSynchroViewQueryClose(aSender: TObject); override;
    {* ���������� ������� svSynchroView.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure BecomeActive; override;
  public
   property DocView: TvtPanel
    read f_DocView;
 end;//TPrimSynchroViewForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , F1Like_InternalOperations_Controls
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , nsManagers
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , LoggingUnit
 , l3StringIDEx
 , l3MessageID
;

type
 TnsSynchroviewActivateEvent = {final} class(TnsLogEvent)
  public
   class procedure Log(const aList: IDynList);
 end;//TnsSynchroviewActivateEvent

class procedure TnsSynchroviewActivateEvent.Log(const aList: IDynList);
//#UC START# *4B150F39031A_4B150F140142_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B150F39031A_4B150F140142_var*
begin
//#UC START# *4B150F39031A_4B150F140142_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 GetLogger.AddEvent(LE_SYNCHROVIEW_ACTIVATE, l_Data);
//#UC END# *4B150F39031A_4B150F140142_impl*
end;//TnsSynchroviewActivateEvent.Log

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\SynchroViewUserTypes.imp.pas}

procedure TPrimSynchroViewForm.DoTabActivate;
 {* ������� �� ������������ ������� }
//#UC START# *497F16AC015A_4979E75C00C7_var*
//#UC END# *497F16AC015A_4979E75C00C7_var*
begin
//#UC START# *497F16AC015A_4979E75C00C7_impl*
 if (sdsList <> nil) then
  TnsSynchroviewActivateEvent.Log(sdsList.dsList.List);
//#UC END# *497F16AC015A_4979E75C00C7_impl*
end;//TPrimSynchroViewForm.DoTabActivate

procedure TPrimSynchroViewForm.BecomeActive;
//#UC START# *4AE9E3CC03C7_4979E75C00C7_var*
//#UC END# *4AE9E3CC03C7_4979E75C00C7_var*
begin
//#UC START# *4AE9E3CC03C7_4979E75C00C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE9E3CC03C7_4979E75C00C7_impl*
end;//TPrimSynchroViewForm.BecomeActive

procedure TPrimSynchroViewForm.svSynchroViewQueryClose(aSender: TObject);
 {* ���������� ������� svSynchroView.OnQueryClose }
//#UC START# *F5C4A5904D01_4979E75C00C7_var*
//#UC END# *F5C4A5904D01_4979E75C00C7_var*
begin
//#UC START# *F5C4A5904D01_4979E75C00C7_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *F5C4A5904D01_4979E75C00C7_impl*
end;//TPrimSynchroViewForm.svSynchroViewQueryClose

{$If NOT Defined(NoVCM)}
procedure TPrimSynchroViewForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4979E75C00C7_var*
//#UC END# *4A8E8F2E0195_4979E75C00C7_var*
begin
//#UC START# *4A8E8F2E0195_4979E75C00C7_impl*
 with DocView do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
//#UC END# *4A8E8F2E0195_4979E75C00C7_impl*
end;//TPrimSynchroViewForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSynchroViewForm);
 {* ����������� PrimSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
