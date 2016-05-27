unit PrimAttributes_Form;
 {* �������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimAttributes_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimAttributes" MUID: (4979DA14019A)
// ��� ����: "TPrimAttributesForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , nscTreeViewWithAdapterDragDrop
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _BaseDocumentForDocumentModule_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseDocumentForDocumentModule.imp.pas}
 _PageControlNotification_Parent_ = _BaseDocumentForDocumentModule_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}
 _AttributesUserTypes_Parent_ = _PageControlNotification_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes.imp.pas}
 TPrimAttributesForm = class(_AttributesUserTypes_)
  {* �������� ��������� }
  private
   f_tvAttributes: TnscTreeViewWithAdapterDragDrop;
    {* ���� ��� �������� tvAttributes }
  protected
   CoDS: IdsAttributes;
  protected
   procedure fDocAttributeQueryClose(aSender: TObject); override;
    {* ���������� ������� fDocAttribute.OnQueryClose }
   procedure DoTabActivate; override;
    {* ������� �� ������������ ������� }
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
   property tvAttributes: TnscTreeViewWithAdapterDragDrop
    read f_tvAttributes;
 end;//TPrimAttributesForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsLogEvent
 , DocumentUnit
 , nsSingleAttributeData
 , F1Like_InternalOperations_Controls
 , Common_Strange_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , nsManagers
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , LoggingUnit
 , l3MessageID
;

type
 TnsViewDocumentAttributesEvent = {final} class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsViewDocumentAttributesEvent

class procedure TnsViewDocumentAttributesEvent.Log(const aDoc: IDocument);
//#UC START# *4B150D310061_4B150CFE01CB_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B150D310061_4B150CFE01CB_var*
begin
//#UC START# *4B150D310061_4B150CFE01CB_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_VIEW_DOCUMENT_ATTRIBUTES, l_Data);
//#UC END# *4B150D310061_4B150CFE01CB_impl*
end;//TnsViewDocumentAttributesEvent.Log

type _Instance_R_ = TPrimAttributesForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseDocumentForDocumentModule.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes.imp.pas}

procedure TPrimAttributesForm.fDocAttributeQueryClose(aSender: TObject);
 {* ���������� ������� fDocAttribute.OnQueryClose }
//#UC START# *37BE60CD03ED_4979DA14019A_var*
//#UC END# *37BE60CD03ED_4979DA14019A_var*
begin
//#UC START# *37BE60CD03ED_4979DA14019A_impl*
 if op_Document_AttributesCanBeClosed.Call(Aggregate) then
  SafeClose
 else
  op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *37BE60CD03ED_4979DA14019A_impl*
end;//TPrimAttributesForm.fDocAttributeQueryClose

procedure TPrimAttributesForm.DoTabActivate;
 {* ������� �� ������������ ������� }
//#UC START# *497F16AC015A_4979DA14019A_var*
//#UC END# *497F16AC015A_4979DA14019A_var*
begin
//#UC START# *497F16AC015A_4979DA14019A_impl*
 if (sdsBaseDocument <> nil) then
  TnsViewDocumentAttributesEvent.Log(sdsBaseDocument.DocInfo.Doc);
//#UC END# *497F16AC015A_4979DA14019A_impl*
end;//TPrimAttributesForm.DoTabActivate

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
end;//TPrimAttributesForm.SignalDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
end;//TPrimAttributesForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributesForm.MakeControls;
begin
 inherited;
 f_tvAttributes := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvAttributes.Name := 'tvAttributes';
 f_tvAttributes.Parent := Self;
end;//TPrimAttributesForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAttributesForm);
 {* ����������� PrimAttributes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
