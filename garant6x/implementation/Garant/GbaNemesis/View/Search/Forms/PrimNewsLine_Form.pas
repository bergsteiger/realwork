unit PrimNewsLine_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimNewsLine_Form.pas"
// �����: 27.01.2009 11:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 ���������������� �������::Autoreferat::View::Search::PrimNewsLine
//
// �����. ��� ��������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  l3ControlsTypes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  AutoreferatInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  PrimeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  Autoreferat_InternalOperations_Controls,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  l3StringIDEx,
  vtLister,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  nscTreeViewForNewsLine
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  PrimNewsLine_nltMain_UserType,
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
var
  { ������������ ������ Local }
 str_NewsLineIsNotSetup : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'NewsLineIsNotSetup'; rValue : '�������������� ��������� ��������� ����� ����� �� ������. �� ������ ��������� ��������� ����� ����� � ������������ � ������ ����������������� ����������, �������� ������.');
  { '�������������� ��������� ��������� ����� ����� �� ������. �� ������ ��������� ��������� ����� ����� � ������������ � ������ ����������������� ����������, �������� ������.' }
 str_FormFillIsNotFinished : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'FormFillIsNotFinished'; rValue : '��������!'#13#10 +
'��������� ������ ����� �� ��������. ��� ����, ����� ��������� �������� � ����, ���������� ��������� ������ � ������ ������ "��������� � ���������".');
  { '��������!'#13#10 +
'��������� ������ ����� �� ��������. ��� ����, ����� ��������� �������� � ����, ���������� ��������� ������ � ������ ������ "��������� � ���������".' }
 str_PrimeIsOffline : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'PrimeIsOffline'; rValue : '��������!'#13#10'��� ���������� ��� ��������� ������ ����� ��������� �������� ��������-����������. ��� ��������� ���������� ����������, ����������, � ������ ���������� �������������� ���� � ������������� �����������.');
  { '��������!'#13#10'��� ���������� ��� ��������� ������ ����� ��������� �������� ��������-����������. ��� ��������� ���������� ����������, ����������, � ������ ���������� �������������� ���� � ������������� �����������.' }

type
 _vcmChromeLikeTabCaptionProvider_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabCaptionProvider.imp.pas}
 TPrimNewsLineForm = {form} class(_vcmChromeLikeTabCaptionProvider_, InsNewsLineNotifier)
  {* �����. ��� ��������� ����� }
 private
 // private fields
   f_InDataChanging : Boolean;
   f_DateList : TnscTreeViewForNewsLine;
    {* ���� ��� �������� DateList}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure VcmEntityFormCloseQuery(Sender: TObject;
     var CanClose: Boolean);
   function DateListGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   procedure DateListCurrentChanged(Sender: TObject;
     aNewCurrent: LongInt;
     aOldCurrent: LongInt);
 protected
 // realized methods
   procedure DataChanged;
   procedure Switcher_BecomeActive_Execute;
   procedure Switcher_BecomeActive(const aParams: IvcmExecuteParams);
   procedure DateInterval_OpenInt_Execute;
   procedure DateInterval_OpenInt(const aParams: IvcmExecuteParams);
   procedure Form_RequestClose_Execute;
   procedure Form_RequestClose(const aParams: IvcmExecuteParams);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure DoLoadFromSettings; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure DoSaveInSettings; override;
    {$IfEnd} //not NoVCM
 public
 // overridden public methods
    {$If not defined(NoVCM)}
   function NeedSaveInSettings: Boolean; override;
    {$IfEnd} //not NoVCM
 protected
 // protected fields
   sdsAutoreferat : IsdsAutoreferat;
   f_UpdateFlag : Boolean;
 protected
 // protected methods
   procedure ResetThemeList;
     {* ��������� ������ ResetThemeList }
   procedure UpdateNewsLineTree;
     {* ��������� ������ UpdateNewsLineTree }
   procedure OpenAutoreferat(const aNode: Il3SimpleNode;
     AllowOpen: Boolean = True);
 public
 // public properties
   property DateList: TnscTreeViewForNewsLine
     read f_DateList;
 end;//TPrimNewsLineForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsNewsLine,
  SearchRes,
  DocumentUnit,
  Common_FormDefinitions_Controls
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  DocumentUserTypes_dftAutoreferat_UserType
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  DataAdapter
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  l3Base {a},
  StdRes {a},
  SysUtils {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TPrimNewsLineForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabCaptionProvider.imp.pas}

var
   { ������������ ������ nltMainLocalConstants }
  str_nltMainCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nltMainCaption'; rValue : '�����. ��� ��������� �����');
   { ��������� ����������������� ���� "�����. ��� ��������� �����" }
  str_nltMainSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nltMainSettingsCaption'; rValue : '�����. ��� ��������� ����� (�������)');
   { ��������� ����������������� ���� "�����. ��� ��������� �����" ��� ��������� ������� ������������ }

var
   { �������� ������ ��� ������� NewsLineIsNotSetup }
  str_NewsLineIsNotSetup_Choice_FillForm : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NewsLineIsNotSetup_Choice_FillForm'; rValue : '��������� ������');
   { '��������� ������' }
  str_NewsLineIsNotSetup_Choice_ViewFullNewsLine : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NewsLineIsNotSetup_Choice_ViewFullNewsLine'; rValue : '���������� ��� ����������� � ������� �����');
   { '���������� ��� ����������� � ������� �����' }

var
   { �������� ������ ��� ������� FormFillIsNotFinished }
  str_FormFillIsNotFinished_Choice_Continue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FormFillIsNotFinished_Choice_Continue'; rValue : '���������� ���������');
   { '���������� ���������' }
  str_FormFillIsNotFinished_Choice_Exit : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FormFillIsNotFinished_Choice_Exit'; rValue : '�������� ������');
   { '�������� ������' }

var
   { �������� ������ ��� ������� PrimeIsOffline }
  str_PrimeIsOffline_Choice_Ok : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimeIsOffline_Choice_Ok'; rValue : '��');
   { '��' }
  str_PrimeIsOffline_Choice_Details : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimeIsOffline_Choice_Details'; rValue : '���������');
   { '���������' }

// start class TPrimNewsLineForm

procedure TPrimNewsLineForm.VcmEntityFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
//#UC START# *5242A36D006B_497EBEC4031D_var*
//#UC END# *5242A36D006B_497EBEC4031D_var*
begin
//#UC START# *5242A36D006B_497EBEC4031D_impl*
 TnsNewsLine.Make.SaveThemeToSettings;
//#UC END# *5242A36D006B_497EBEC4031D_impl*
end;//TPrimNewsLineForm.VcmEntityFormCloseQuery

function TPrimNewsLineForm.DateListGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *5242A3770043_497EBEC4031D_var*
//#UC END# *5242A3770043_497EBEC4031D_var*
begin
//#UC START# *5242A3770043_497EBEC4031D_impl*
 Result := siilNewsLineTheme;
//#UC END# *5242A3770043_497EBEC4031D_impl*
end;//TPrimNewsLineForm.DateListGetItemImage

procedure TPrimNewsLineForm.DateListCurrentChanged(Sender: TObject;
  aNewCurrent: LongInt;
  aOldCurrent: LongInt);
//#UC START# *5242A37E01D3_497EBEC4031D_var*
//#UC END# *5242A37E01D3_497EBEC4031D_var*
begin
//#UC START# *5242A37E01D3_497EBEC4031D_impl*
 if (aNewCurrent >= 0) and not f_InDataChanging then
  OpenAutoreferat(DateList.GetNode(aNewCurrent));
//#UC END# *5242A37E01D3_497EBEC4031D_impl*
end;//TPrimNewsLineForm.DateListCurrentChanged

procedure TPrimNewsLineForm.ResetThemeList;
//#UC START# *4C8DC50203CB_497EBEC4031D_var*
//#UC END# *4C8DC50203CB_497EBEC4031D_var*
begin
//#UC START# *4C8DC50203CB_497EBEC4031D_impl*
 UpdateNewsLineTree;
 if not f_InDataChanging then
  OpenAutoreferat(DateList.GetCurrentNode, False);
 f_UpdateFlag := True;
//#UC END# *4C8DC50203CB_497EBEC4031D_impl*
end;//TPrimNewsLineForm.ResetThemeList

procedure TPrimNewsLineForm.UpdateNewsLineTree;
//#UC START# *4C87BD85008A_497EBEC4031D_var*
var
 l_Tree: Il3SimpleTree;
//#UC END# *4C87BD85008A_497EBEC4031D_var*
begin
//#UC START# *4C87BD85008A_497EBEC4031D_impl*
 l_Tree := TnsNewsLine.Make.MakeCurrentThemeTreeStruct;
 DateList.TreeStruct := l_Tree;
 if Assigned(l_Tree)
  then DateList.Current := 0
  else DateList.Current := -1;
//#UC END# *4C87BD85008A_497EBEC4031D_impl*
end;//TPrimNewsLineForm.UpdateNewsLineTree

procedure TPrimNewsLineForm.OpenAutoreferat(const aNode: Il3SimpleNode;
  AllowOpen: Boolean = True);
//#UC START# *5242A678004A_497EBEC4031D_var*
var
 l_Document: IDocument;
//#UC END# *5242A678004A_497EBEC4031D_var*
begin
//#UC START# *5242A678004A_497EBEC4031D_impl*
 l_Document := TnsNewsLine.Make.ExtractAutoReferat(aNode);
 if Assigned(l_Document) then
 begin
  // ����� ���������� ����, ������������ ������������� �����, ������ ���� ���
  // ������� �� ������, � ��������� ������� ������ ���������:
  if AllowOpen or
     NativeMainForm.HasForm(fm_TextForm.rFormID, vcm_ztParent, True, nil, dftAutoreferat) then
  // �������� ������:
   TdmStdRes.OpenAutoreferat(l_Document, nil);
 end
 else
 begin
  while (vcmDispatcher.FormDispatcher.CurrentMainForm.AsContainer).HasForm(fm_enNewsLine.rFormID) and
         vcmDispatcher.History.CanBack do
   vcmDispatcher.History.Back(True);
 end;
//#UC END# *5242A678004A_497EBEC4031D_impl*
end;//TPrimNewsLineForm.OpenAutoreferat

procedure TPrimNewsLineForm.DataChanged;
//#UC START# *49918CC5036B_497EBEC4031D_var*
var
 l_Curr: Integer;
//#UC END# *49918CC5036B_497EBEC4031D_var*
begin
//#UC START# *49918CC5036B_497EBEC4031D_impl*
 f_InDataChanging := True;
 try
  l_Curr := DateList.Current;
  ResetThemeList;
 finally
  f_InDataChanging := False;
 end;
 DateList.Current := l_Curr;
//#UC END# *49918CC5036B_497EBEC4031D_impl*
end;//TPrimNewsLineForm.DataChanged

procedure TPrimNewsLineForm.Switcher_BecomeActive_Execute;
//#UC START# *4A9807F801F9_497EBEC4031Dexec_var*
//#UC END# *4A9807F801F9_497EBEC4031Dexec_var*
begin
//#UC START# *4A9807F801F9_497EBEC4031Dexec_impl*
 SetActiveInParent;
//#UC END# *4A9807F801F9_497EBEC4031Dexec_impl*
end;//TPrimNewsLineForm.Switcher_BecomeActive_Execute

procedure TPrimNewsLineForm.Switcher_BecomeActive(const aParams: IvcmExecuteParams);
begin
 Switcher_BecomeActive_Execute;
end;

procedure TPrimNewsLineForm.DateInterval_OpenInt_Execute;
//#UC START# *4AF822B302C4_497EBEC4031Dexec_var*
//#UC END# *4AF822B302C4_497EBEC4031Dexec_var*
begin
//#UC START# *4AF822B302C4_497EBEC4031Dexec_impl*
 OpenAutoreferat(DateList.GetCurrentNode);
//#UC END# *4AF822B302C4_497EBEC4031Dexec_impl*
end;//TPrimNewsLineForm.DateInterval_OpenInt_Execute

procedure TPrimNewsLineForm.DateInterval_OpenInt(const aParams: IvcmExecuteParams);
begin
 DateInterval_OpenInt_Execute;
end;

procedure TPrimNewsLineForm.Form_RequestClose_Execute;
//#UC START# *4AF82EFD0025_497EBEC4031Dexec_var*
//#UC END# *4AF82EFD0025_497EBEC4031Dexec_var*
begin
//#UC START# *4AF82EFD0025_497EBEC4031Dexec_impl*
 // �������� ����������� ������ � ������� ������ (cq24583)
 if (sdsAutoReferat <> nil) then
  SafeClose;
//#UC END# *4AF82EFD0025_497EBEC4031Dexec_impl*
end;//TPrimNewsLineForm.Form_RequestClose_Execute

procedure TPrimNewsLineForm.Form_RequestClose(const aParams: IvcmExecuteParams);
begin
 Form_RequestClose_Execute;
end;

procedure TPrimNewsLineForm.Cleanup;
//#UC START# *479731C50290_497EBEC4031D_var*
//#UC END# *479731C50290_497EBEC4031D_var*
begin
//#UC START# *479731C50290_497EBEC4031D_impl*
 TnsNewsLine.Make.UnSubscribe(Self);
 inherited;
//#UC END# *479731C50290_497EBEC4031D_impl*
end;//TPrimNewsLineForm.Cleanup

procedure TPrimNewsLineForm.InitFields;
//#UC START# *47A042E100E2_497EBEC4031D_var*
//#UC END# *47A042E100E2_497EBEC4031D_var*
begin
//#UC START# *47A042E100E2_497EBEC4031D_impl*
 inherited;
 f_InDataChanging := False;
 //UpdateNewsLineTree;
//#UC END# *47A042E100E2_497EBEC4031D_impl*
end;//TPrimNewsLineForm.InitFields

procedure TPrimNewsLineForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_497EBEC4031D_var*
//#UC END# *47EA4E9002C6_497EBEC4031D_var*
begin
//#UC START# *47EA4E9002C6_497EBEC4031D_impl*
 inherited;
 if (not defDataAdapter.Monitoring.IsExist) then
 begin
  if not vcmDispatcher.History.CanBack then
  begin
   TdmStdRes.OpenMainMenuIfNeeded(nil);
   vcmDispatcher.History.DeleteBackItem;
  end else
  while vcmDispatcher.FormDispatcher.CurrentMainForm.AsContainer.HasForm(fm_enNewsLine.rFormID) and
   vcmDispatcher.History.CanBack do
   vcmDispatcher.History.Back(True);
 end;
//#UC END# *47EA4E9002C6_497EBEC4031D_impl*
end;//TPrimNewsLineForm.FinishDataUpdate

{$If not defined(NoVCM)}
procedure TPrimNewsLineForm.InitControls;
//#UC START# *4A8E8F2E0195_497EBEC4031D_var*
//#UC END# *4A8E8F2E0195_497EBEC4031D_var*
begin
//#UC START# *4A8E8F2E0195_497EBEC4031D_impl*
 DateList.Images := nsSearchRes.SearchItemsImageList;
 TnsNewsLine.Make.Subscribe(Self);
 f_UpdateFlag := False;
 with DateList do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  ActionElementMode := l3_amSingleClick;
  ViewOptions := [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowLines];
  ClearTreeStructOnSaveState := False;
  OnGetItemImage := DateListGetItemImage;
  OnCurrentChanged := DateListCurrentChanged;
 end;
//#UC END# *4A8E8F2E0195_497EBEC4031D_impl*
end;//TPrimNewsLineForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimNewsLineForm.DoLoadFromSettings;
//#UC START# *4E7C2AA3037E_497EBEC4031D_var*
//#UC END# *4E7C2AA3037E_497EBEC4031D_var*
begin
//#UC START# *4E7C2AA3037E_497EBEC4031D_impl*
 TnsNewsLine.Make.LoadThemeFromSettings;
 UpdateNewsLineTree;
 inherited;
//#UC END# *4E7C2AA3037E_497EBEC4031D_impl*
end;//TPrimNewsLineForm.DoLoadFromSettings
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimNewsLineForm.DoSaveInSettings;
//#UC START# *4F7B072201AA_497EBEC4031D_var*
//#UC END# *4F7B072201AA_497EBEC4031D_var*
begin
//#UC START# *4F7B072201AA_497EBEC4031D_impl*
 inherited;
 TnsNewsLine.Make.SaveThemeToSettings;
//#UC END# *4F7B072201AA_497EBEC4031D_impl*
end;//TPrimNewsLineForm.DoSaveInSettings
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimNewsLineForm.NeedSaveInSettings: Boolean;
//#UC START# *4FC38C4C0119_497EBEC4031D_var*
//#UC END# *4FC38C4C0119_497EBEC4031D_var*
begin
//#UC START# *4FC38C4C0119_497EBEC4031D_impl*
 Result := True;
//#UC END# *4FC38C4C0119_497EBEC4031D_impl*
end;//TPrimNewsLineForm.NeedSaveInSettings
{$IfEnd} //not NoVCM

procedure TPrimNewsLineForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  sdsAutoreferat := nil;
 end//aDsNew = nil
 else
 begin
  aDsNew.CastUCC(IsdsAutoreferat, sdsAutoreferat);
 end;//aDsNew = nil
end;

procedure TPrimNewsLineForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Switcher, nil);
  PublishFormEntity(en_DateInterval, nil);
  PublishFormEntity(en_Form, nil);
  PublishOpWithResult(en_Switcher, op_BecomeActive, Switcher_BecomeActive, nil, nil);
  PublishOpWithResult(en_DateInterval, op_OpenInt, DateInterval_OpenInt, nil, nil);
  PublishOpWithResult(en_Form, op_RequestClose, Form_RequestClose, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimNewsLineForm.MakeControls;
begin
 inherited;
 f_DateList := TnscTreeViewForNewsLine.Create(Self);
 f_DateList.Name := 'DateList';
 f_DateList.Parent := Self;
 with AddUsertype(nltMainName,
  str_nltMainCaption,
  str_nltMainSettingsCaption,
  true,
  145,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccDisable) do
 begin
 end;//with AddUsertype(nltMainName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nltMainCaption
 str_nltMainCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nltMainSettingsCaption
 str_nltMainSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_NewsLineIsNotSetup_Choice_FillForm
 str_NewsLineIsNotSetup_Choice_FillForm.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_NewsLineIsNotSetup_Choice_ViewFullNewsLine
 str_NewsLineIsNotSetup_Choice_ViewFullNewsLine.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_FormFillIsNotFinished_Choice_Continue
 str_FormFillIsNotFinished_Choice_Continue.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_FormFillIsNotFinished_Choice_Exit
 str_FormFillIsNotFinished_Choice_Exit.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_PrimeIsOffline_Choice_Ok
 str_PrimeIsOffline_Choice_Ok.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_PrimeIsOffline_Choice_Details
 str_PrimeIsOffline_Choice_Details.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_NewsLineIsNotSetup
 str_NewsLineIsNotSetup.Init;
 str_NewsLineIsNotSetup.AddChoice(str_NewsLineIsNotSetup_Choice_FillForm);
 str_NewsLineIsNotSetup.AddChoice(str_NewsLineIsNotSetup_Choice_ViewFullNewsLine);
 str_NewsLineIsNotSetup.AddDefaultChoice(str_NewsLineIsNotSetup_Choice_FillForm);
 str_NewsLineIsNotSetup.SetDlgType(mtConfirmation);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_FormFillIsNotFinished
 str_FormFillIsNotFinished.Init;
 str_FormFillIsNotFinished.AddChoice(str_FormFillIsNotFinished_Choice_Continue);
 str_FormFillIsNotFinished.AddChoice(str_FormFillIsNotFinished_Choice_Exit);
 str_FormFillIsNotFinished.AddDefaultChoice(str_FormFillIsNotFinished_Choice_Continue);
 str_FormFillIsNotFinished.SetDlgType(mtWarning);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_PrimeIsOffline
 str_PrimeIsOffline.Init;
 str_PrimeIsOffline.AddChoice(str_PrimeIsOffline_Choice_Ok);
 str_PrimeIsOffline.AddChoice(str_PrimeIsOffline_Choice_Details);
 str_PrimeIsOffline.AddDefaultChoice(str_PrimeIsOffline_Choice_Ok);
 str_PrimeIsOffline.SetDlgType(mtError);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� PrimNewsLine
 TtfwClassRef.Register(TPrimNewsLineForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.