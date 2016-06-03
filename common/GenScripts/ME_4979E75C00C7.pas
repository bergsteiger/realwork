unit PrimSynchroView_Form;
 {* ���������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimSynchroView_Form.pas"
// ���������: "VCMContainer"
// ������� ������: "PrimSynchroView" MUID: (4979E75C00C7)
// ��� ����: "TPrimSynchroViewForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Base_Operations_Strange_Controls
 , WorkWithListInterfaces
 , vtPanel
 , nsTypes
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _PageControlNotification_Parent_ = TvcmContainerForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}
 _SynchroViewUserTypes_Parent_ = _PageControlNotification_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\SynchroViewUserTypes.imp.pas}
 TPrimSynchroViewForm = class(_SynchroViewUserTypes_)
  {* ���������� �������� }
  private
   f_DocView: TvtPanel;
  protected
   ViewArea: IdsSynchroView;
   sdsList: IsdsList;
  protected
   procedure DoTabActivate; override;
    {* ������� �� ������������ ������� }
   procedure SvSynchroViewQueryClose(aSender: TObject); override;
    {* ���������� ������� svSynchroView.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure SynchroView_BecomeActive_Execute(aFormType: TnsShowSynchroForm);
   procedure SynchroView_BecomeActive(const aParams: IvcmExecuteParams);
  public
   property DocView: TvtPanel
    read f_DocView;
 end;//TPrimSynchroViewForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsLogEvent
 , DynamicDocListUnit
 , F1Like_InternalOperations_Controls
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsManagers
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , LoggingUnit
 , SynchroViewUserTypes_svSynchroView_UserType
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 //#UC START# *4979E75C00C7impl_uses*
 //#UC END# *4979E75C00C7impl_uses*
;

{$If NOT Defined(NoVCM)}
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

procedure TPrimSynchroViewForm.SynchroView_BecomeActive_Execute(aFormType: TnsShowSynchroForm);
//#UC START# *4AE9E3CC03C7_4979E75C00C7exec_var*
//#UC END# *4AE9E3CC03C7_4979E75C00C7exec_var*
begin
//#UC START# *4AE9E3CC03C7_4979E75C00C7exec_impl*
 case aFormType of
  ssfRelated:
   ViewArea.OpenRelatedDoc;
  ssfAttribute:
   ViewArea.OpenAttributes;
  ssfAnnotation:
   ViewArea.OpenAnnotation;
  ssfSimilarDocuments:
   ViewArea.OpenSimilarDocuments;
 end;//case aFormType of
 // ������� �������� ��������
 SetActiveInParent;
//#UC END# *4AE9E3CC03C7_4979E75C00C7exec_impl*
end;//TPrimSynchroViewForm.SynchroView_BecomeActive_Execute

procedure TPrimSynchroViewForm.SynchroView_BecomeActive(const aParams: IvcmExecuteParams);
begin
 with ISynchroView_BecomeActive_Params(aParams.Data) do
  Self.SynchroView_BecomeActive_Execute(FormType);
end;//TPrimSynchroViewForm.SynchroView_BecomeActive

procedure TPrimSynchroViewForm.SvSynchroViewQueryClose(aSender: TObject);
 {* ���������� ������� svSynchroView.OnQueryClose }
//#UC START# *F5C4A5904D01_4979E75C00C7_var*
//#UC END# *F5C4A5904D01_4979E75C00C7_var*
begin
//#UC START# *F5C4A5904D01_4979E75C00C7_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *F5C4A5904D01_4979E75C00C7_impl*
end;//TPrimSynchroViewForm.SvSynchroViewQueryClose

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

procedure TPrimSynchroViewForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  ViewArea := nil;
  sdsList := nil;
 end//aNew = nil
 else
 begin
  ViewArea := aNew As IdsSynchroView;
  aNew.CastUCC(IsdsList, sdsList);
 end;//aNew = nil
end;//TPrimSynchroViewForm.SignalDataSourceChanged

procedure TPrimSynchroViewForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_SynchroView, nil);
  PublishOpWithResult(en_SynchroView, op_BecomeActive, SynchroView_BecomeActive, nil, nil);
 end;//with Entities.Entities
end;//TPrimSynchroViewForm.InitEntities

procedure TPrimSynchroViewForm.MakeControls;
begin
 inherited;
 f_DocView := TvtPanel.Create(Self);
 f_DocView.Name := 'DocView';
 f_DocView.Parent := Self;
 with DefineZone(vcm_ztChild, DocView) do
 begin
  FormStyle.Toolbars.Top.MergeWithContainer := vcm_bTrue;
 end;//with DefineZone(vcm_ztChild
end;//TPrimSynchroViewForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSynchroViewForm);
 {* ����������� PrimSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
