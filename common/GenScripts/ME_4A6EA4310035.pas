unit AbstractHistory_Form;
 {* ����������� ���� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\AbstractHistory_Form.pas"
// ���������: "VCMContainer"
// ������� ������: "AbstractHistory" MUID: (4A6EA4310035)
// ��� ����: "TAbstractHistoryForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ChatInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , ChatTypes
 {$If Defined(Nemesis)}
 , nscChatMemo
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , DocumentUnit
 , evCustomEditorWindow
 , bsTypesNew
 , NavigationInterfaces
 , nevNavigation
 , nevBase
 , ExternalOperationUnit
 , DocumentInterfaces
 , nevGUIInterfaces
 , afwInterfaces
 , afwNavigation
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _TextWithComments_Parent_ = TvcmContainerForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\TextWithComments.imp.pas}
 _HyperlinkProcessorWithOwnLocalLink_Parent_ = _TextWithComments_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorWithOwnLocalLink.imp.pas}
 TAbstractHistoryForm = class(_HyperlinkProcessorWithOwnLocalLink_, IbsAbstractChatWindow)
  {* ����������� ���� ������� }
  private
   f_HistoryEditor: TnscChatMemo;
    {* ���� ��� �������� HistoryEditor }
   f_UserID: TbsUserID;
    {* ���� ��� �������� UserID }
  protected
   procedure RegisterInDispatcher; virtual; abstract;
   procedure UnRegisterInDispatcher; virtual; abstract;
   procedure AddToHistory(const aMessage: InsChatMessage);
   procedure ProcessMessages(const aData: InsChatMessages);
   procedure InitEditors; virtual;
   function HistoryLimit: Integer; virtual;
   function NeedClose: Boolean; virtual;
   function Get_UserID: TbsUserID;
   procedure ActivateChatWindow;
   procedure GotoPoint(aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub); override;
    {* ������� �� ����� � ��������� }
   function HyperlinkDocument: IDocument; override;
    {* �������� �� �������� ���� ������ }
   function pm_GetHyperlinkText: TevCustomEditorWindow; override;
   function IsFloating: Boolean; override;
    {* ����� ��������� }
   function pm_GetTextWithComments: TevCustomEditorWindow; override;
   procedure OpenRedactionGlobalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); override;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   function DoProcessLocalLink(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; override;
    {* ��������� ��������� ������ }
   procedure DoCheckLinkInfo(const aLink: IevHyperlink); override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
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
   class function MakeSingleChild(anUID: TbsUserID;
    const aName: Il3CString): IvcmEntityForm; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function SettingsSuffix: AnsiString; override;
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property UserID: TbsUserID
    read f_UserID
    write f_UserID;
  public
   property HistoryEditor: TnscChatMemo
    read f_HistoryEditor;
 end;//TAbstractHistoryForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , evOp
 , ComObj
 , l3Types
 , evTypes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , afwFacade
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , evdTypes
 , nsTypes
 , deDocInfo
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 , nevTools
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , DocumentRes
 , vtUtils
 , evdStyles
 , k2Tags
 , BitmapPara_Const
 , nsHyperLinkProcessor
 , nsOpenUtils
 , nsConst
 , nsTabbedContainerUtils
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsHyperlinkProcessorTypes
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4A6EA4310035impl_uses*
 //#UC END# *4A6EA4310035impl_uses*
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TAbstractHistoryForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\TextWithComments.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorWithOwnLocalLink.imp.pas}

procedure TAbstractHistoryForm.AddToHistory(const aMessage: InsChatMessage);
//#UC START# *4A6EA62A0096_4A6EA4310035_var*
const
 cFlags = (evDefaultLoadFlags + [ev_lfInternal] - [ev_lfNeedJoin]) - [ev_lfSkipSubdocuments];
var
 l_Fake : Int64;
 l_W : InevTagWriter;
 l_C : InevBasePoint;
 l_Op : InevOp;
//#UC END# *4A6EA62A0096_4A6EA4310035_var*
begin
//#UC START# *4A6EA62A0096_4A6EA4310035_impl*
 with HistoryEditor do
 begin
  l_W := TextSource.DocumentContainer.TagWriter;
  Assert(l_W <> nil);
  l_C := Selection.Cursor;
  Assert(l_C <> nil);
  l_Op := Processor.StartOp;
  try
   l_C.Move(View, ev_ocBottomRight);
   OleCheck(aMessage.Title.Seek(0, STREAM_SEEK_SET, l_Fake));
   l_W.WriteTag(View, cf_EverestTxt, aMessage.Title, l_C, cFlags);
   l_C.Move(View, ev_ocBottomRight);
   OleCheck(aMessage.Body.Seek(0, STREAM_SEEK_SET, l_Fake));
   l_W.WriteTag(View, CF_EverestBin, aMessage.Body, l_C, cFlags);
   l_C.Move(View, ev_ocBottomRight);
  finally
   l_Op := nil;
  end;
  Processor.UndoBuffer.Clear;
 end;//with HistoryEditor
//#UC END# *4A6EA62A0096_4A6EA4310035_impl*
end;//TAbstractHistoryForm.AddToHistory

procedure TAbstractHistoryForm.ProcessMessages(const aData: InsChatMessages);
//#UC START# *4A6EA655038C_4A6EA4310035_var*
var
 l_IDX: Integer;
//#UC END# *4A6EA655038C_4A6EA4310035_var*
begin
//#UC START# *4A6EA655038C_4A6EA4310035_impl*
 if Assigned(aData) then
 begin
  for l_IDX := 0 to aData.Messagescount - 1 do
   AddToHistory(aData.Message[l_IDX]);
  //HistoryEditor.Selection.Unselect; 
 end;//Assigned(aData)
//#UC END# *4A6EA655038C_4A6EA4310035_impl*
end;//TAbstractHistoryForm.ProcessMessages

class function TAbstractHistoryForm.MakeSingleChild(anUID: TbsUserID;
 const aName: Il3CString): IvcmEntityForm;
var
 l_Inst : TAbstractHistoryForm;
begin
 l_Inst := Create(anUID, aName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAbstractHistoryForm.MakeSingleChild

procedure TAbstractHistoryForm.InitEditors;
//#UC START# *4AC5CD4402E7_4A6EA4310035_var*
//#UC END# *4AC5CD4402E7_4A6EA4310035_var*
begin
//#UC START# *4AC5CD4402E7_4A6EA4310035_impl*
 HistoryEditor.TextSource.New;
//#UC END# *4AC5CD4402E7_4A6EA4310035_impl*
end;//TAbstractHistoryForm.InitEditors

function TAbstractHistoryForm.HistoryLimit: Integer;
//#UC START# *4AC5CD9C02FA_4A6EA4310035_var*
//#UC END# *4AC5CD9C02FA_4A6EA4310035_var*
begin
//#UC START# *4AC5CD9C02FA_4A6EA4310035_impl*
 Result := 0;
//#UC END# *4AC5CD9C02FA_4A6EA4310035_impl*
end;//TAbstractHistoryForm.HistoryLimit

function TAbstractHistoryForm.NeedClose: Boolean;
//#UC START# *4B1633CF01C2_4A6EA4310035_var*
//#UC END# *4B1633CF01C2_4A6EA4310035_var*
begin
//#UC START# *4B1633CF01C2_4A6EA4310035_impl*
 Result := True;
//#UC END# *4B1633CF01C2_4A6EA4310035_impl*
end;//TAbstractHistoryForm.NeedClose

function TAbstractHistoryForm.Get_UserID: TbsUserID;
//#UC START# *4A6EA502033A_4A6EA4310035get_var*
//#UC END# *4A6EA502033A_4A6EA4310035get_var*
begin
//#UC START# *4A6EA502033A_4A6EA4310035get_impl*
 Result := UserID;
//#UC END# *4A6EA502033A_4A6EA4310035get_impl*
end;//TAbstractHistoryForm.Get_UserID

procedure TAbstractHistoryForm.ActivateChatWindow;
//#UC START# *4A6EA50801BA_4A6EA4310035_var*
//#UC END# *4A6EA50801BA_4A6EA4310035_var*
begin
//#UC START# *4A6EA50801BA_4A6EA4310035_impl*
 if IsIconic(Handle) then
  ShowWindow(Handle, SW_RESTORE);
 SetFocus;
//#UC END# *4A6EA50801BA_4A6EA4310035_impl*
end;//TAbstractHistoryForm.ActivateChatWindow

procedure TAbstractHistoryForm.GotoPoint(aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub);
 {* ������� �� ����� � ��������� }
//#UC START# *4A8164E801AE_4A6EA4310035_var*
//#UC END# *4A8164E801AE_4A6EA4310035_var*
begin
//#UC START# *4A8164E801AE_4A6EA4310035_impl*
 Assert(false);
//#UC END# *4A8164E801AE_4A6EA4310035_impl*
end;//TAbstractHistoryForm.GotoPoint

function TAbstractHistoryForm.HyperlinkDocument: IDocument;
 {* �������� �� �������� ���� ������ }
//#UC START# *4A8168BB0217_4A6EA4310035_var*
//#UC END# *4A8168BB0217_4A6EA4310035_var*
begin
//#UC START# *4A8168BB0217_4A6EA4310035_impl*
 Result := nil;
//#UC END# *4A8168BB0217_4A6EA4310035_impl*
end;//TAbstractHistoryForm.HyperlinkDocument

function TAbstractHistoryForm.pm_GetHyperlinkText: TevCustomEditorWindow;
//#UC START# *4A82BC390036_4A6EA4310035get_var*
//#UC END# *4A82BC390036_4A6EA4310035get_var*
begin
//#UC START# *4A82BC390036_4A6EA4310035get_impl*
 Result := HistoryEditor;
//#UC END# *4A82BC390036_4A6EA4310035get_impl*
end;//TAbstractHistoryForm.pm_GetHyperlinkText

function TAbstractHistoryForm.IsFloating: Boolean;
 {* ����� ��������� }
//#UC START# *4A8A9DB0001A_4A6EA4310035_var*
//#UC END# *4A8A9DB0001A_4A6EA4310035_var*
begin
//#UC START# *4A8A9DB0001A_4A6EA4310035_impl*
 Result := true;
//#UC END# *4A8A9DB0001A_4A6EA4310035_impl*
end;//TAbstractHistoryForm.IsFloating

function TAbstractHistoryForm.pm_GetTextWithComments: TevCustomEditorWindow;
//#UC START# *4A8AAD450084_4A6EA4310035get_var*
//#UC END# *4A8AAD450084_4A6EA4310035get_var*
begin
//#UC START# *4A8AAD450084_4A6EA4310035get_impl*
 Result := HistoryEditor;
//#UC END# *4A8AAD450084_4A6EA4310035get_impl*
end;//TAbstractHistoryForm.pm_GetTextWithComments

procedure TAbstractHistoryForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* ������ }
//#UC START# *4AC5D61E0284_4A6EA4310035test_var*
//#UC END# *4AC5D61E0284_4A6EA4310035test_var*
begin
//#UC START# *4AC5D61E0284_4A6EA4310035test_impl*
 // - ������ �� ������
//#UC END# *4AC5D61E0284_4A6EA4310035test_impl*
end;//TAbstractHistoryForm.Result_Cancel_Test

procedure TAbstractHistoryForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ������ }
//#UC START# *4AC5D61E0284_4A6EA4310035exec_var*
//#UC END# *4AC5D61E0284_4A6EA4310035exec_var*
begin
//#UC START# *4AC5D61E0284_4A6EA4310035exec_impl*
 SafeClose;
//#UC END# *4AC5D61E0284_4A6EA4310035exec_impl*
end;//TAbstractHistoryForm.Result_Cancel_Execute

procedure TAbstractHistoryForm.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
 {* ������ }
//#UC START# *4AC5D61E0284_4A6EA4310035getstate_var*
//#UC END# *4AC5D61E0284_4A6EA4310035getstate_var*
begin
//#UC START# *4AC5D61E0284_4A6EA4310035getstate_impl*
 if NeedClose then
  State := st_user_Result_Cancel_Close
//#UC END# *4AC5D61E0284_4A6EA4310035getstate_impl*
end;//TAbstractHistoryForm.Result_Cancel_GetState

procedure TAbstractHistoryForm.OpenRedactionGlobalLink(const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *53A303BE03A8_4A6EA4310035_var*
//#UC END# *53A303BE03A8_4A6EA4310035_var*
begin
//#UC START# *53A303BE03A8_4A6EA4310035_impl*
 Assert(False, '513615258');
//#UC END# *53A303BE03A8_4A6EA4310035_impl*
end;//TAbstractHistoryForm.OpenRedactionGlobalLink

procedure TAbstractHistoryForm.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4A6EA4310035_var*
//#UC END# *479731C50290_4A6EA4310035_var*
begin
//#UC START# *479731C50290_4A6EA4310035_impl*
 if (ZoneType <> vcm_ztForToolbarsInfo) then
  UnRegisterInDispatcher;
 inherited;
//#UC END# *479731C50290_4A6EA4310035_impl*
end;//TAbstractHistoryForm.Cleanup

function TAbstractHistoryForm.DoProcessLocalLink(const aDocument: IDocument;
 aPointType: TDocumentPositionType;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {* ��������� ��������� ������ }
//#UC START# *4A8160720125_4A6EA4310035_var*
//#UC END# *4A8160720125_4A6EA4310035_var*
begin
//#UC START# *4A8160720125_4A6EA4310035_impl*
 Result := false;
//#UC END# *4A8160720125_4A6EA4310035_impl*
end;//TAbstractHistoryForm.DoProcessLocalLink

procedure TAbstractHistoryForm.DoCheckLinkInfo(const aLink: IevHyperlink);
//#UC START# *4A8A9E2A004F_4A6EA4310035_var*
//#UC END# *4A8A9E2A004F_4A6EA4310035_var*
begin
//#UC START# *4A8A9E2A004F_4A6EA4310035_impl*
 if (aLink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID = CI_ExternalOperation) then
 begin
  alink.Kind := ev_lvkInternalInvalid;
  alink.Hint := Tl3PCharLen(nsWStr(vcmCStr(str_UnsupportedLink)));
 end;//aLink.Address.TypeID = CI_ExternalOperation
//#UC END# *4A8A9E2A004F_4A6EA4310035_impl*
end;//TAbstractHistoryForm.DoCheckLinkInfo

function TAbstractHistoryForm.SettingsSuffix: AnsiString;
//#UC START# *4A8E425D0268_4A6EA4310035_var*
//#UC END# *4A8E425D0268_4A6EA4310035_var*
begin
//#UC START# *4A8E425D0268_4A6EA4310035_impl*
 Result := Format('_%d',[f_UserID]);
//#UC END# *4A8E425D0268_4A6EA4310035_impl*
end;//TAbstractHistoryForm.SettingsSuffix

procedure TAbstractHistoryForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4A6EA4310035_var*
//#UC END# *4A8E8F2E0195_4A6EA4310035_var*
begin
//#UC START# *4A8E8F2E0195_4A6EA4310035_impl*
 inherited;
 with HistoryEditor do
 begin
  Align := alClient;
  ReadOnly := true;
 end;//with HistoryEditor
//#UC END# *4A8E8F2E0195_4A6EA4310035_impl*
end;//TAbstractHistoryForm.InitControls

procedure TAbstractHistoryForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Edit, nil);
  MakeEntitySupportedByControl(en_Edit, HistoryEditor);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, Result_Cancel_GetState);
 end;//with Entities.Entities
end;//TAbstractHistoryForm.InitEntities

procedure TAbstractHistoryForm.MakeControls;
begin
 inherited;
 f_HistoryEditor := TnscChatMemo.Create(Self);
 f_HistoryEditor.Name := 'HistoryEditor';
 f_HistoryEditor.Parent := Self;
end;//TAbstractHistoryForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAbstractHistoryForm);
 {* ����������� AbstractHistory }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
