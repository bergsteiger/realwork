unit PrimDocumentWithFlash_Form;
 {* ��������-����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocumentWithFlash_Form.pas"
// ���������: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Search_Strange_Controls
 , Common_Strange_Controls
 , l3TabbedContainersDispatcher
 , DocInfoInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 {$If NOT Defined(NoFlash)}
 , vtShockwaveFlashEx
 {$IfEnd} // NOT Defined(NoFlash)
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 , nevGUIInterfaces
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypes
 , Messages
 , nevNavigation
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , afwNavigation
 , l3Interfaces
 , DocumentInterfaces
 , Classes
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Base_Operations_Strange_Controls
 , WorkWithDocumentInterfaces
 , l3TreeInterfaces
 , UnderControlUnit
 , BaseDocumentWithAttributesInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , UnderControlInterfaces
 , Hypertext_Controls_Controls
 , l3Bitmap
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3SimpleObject
 , DocumentWithFlashUserTypes_dwftSynchro_UserType
;

const
 {* ������ }
 c_OpenDoc = Messages.WM_User + 100;
 c_OpenDocInNewTab = c_OpenDoc + 1;

type
 InsDocumentWithFlashState = interface(IvcmBase)
  ['{5F467A22-A292-4360-B74C-CCA62C7A957B}']
  function pm_GetFrame: Integer;
  property Frame: Integer
   read pm_GetFrame;
   {* ����� ����� }
 end;//InsDocumentWithFlashState

 TnsDocumentWithFlashState = class(Tl3SimpleObject, InsDocumentWithFlashState)
  private
   f_Frame: Integer;
  protected
   function pm_GetFrame: Integer;
  public
   constructor Create(aFrame: Integer); reintroduce;
   class function Make(aFrame: Integer): InsDocumentWithFlashState; reintroduce;
 end;//TnsDocumentWithFlashState

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseDocumentForDocumentModule.imp.pas}
 _CommonForTextAndFlashOperations_Parent_ = _BaseDocumentForDocumentModule_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlashOperations.imp.pas}
 _DocumentWithFlashUserTypes_Parent_ = _CommonForTextAndFlashOperations_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes.imp.pas}
 _vcmChromeLikeTabIconUpdater_Parent_ = _DocumentWithFlashUserTypes_;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 _PrintableFlashWithInfo_Parent_ = _vcmChromeLikeTabIconUpdater_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableFlashWithInfo.imp.pas}
 TPrimDocumentWithFlashForm = class(_PrintableFlashWithInfo_, Il3TabbedContainersListener)
  {* ��������-����� }
  private
   f_FlashLoaded: Boolean;
   f_Flash: TvtShockwaveFlashEx;
    {* ���� ��� �������� Flash }
   f_Editor: TnscEditor;
    {* ���� ��� �������� Editor }
   f_FromHistory: Boolean;
    {* ���� ��� �������� FromHistory }
   f_State: InsDocumentWithFlashState;
    {* ���� ��� �������� State }
  protected
   bsFlash: IbsFlash;
   dsBaseDocument: IdsBaseDocument;
  private
   procedure UpdateCaption;
   procedure OnChangeFrameInFlash(aSender: TObject);
   procedure OpenDocument(aDocID: Integer;
    aPosID: Integer;
    aOpenKind: TvcmMainFormOpenKind);
   procedure WMSetFocus(var Msg: TWMSetFocus);
  protected
   function pm_GetDocument: IDocument;
   function pm_GetFlash: TvtShockwaveFlashEx;
   function DocumentOnJumpTo(Sender: TObject;
    anEffects: TafwJumpToEffects;
    const aMoniker: IevMoniker): Boolean;
    {* ������� �� ������ }
   procedure OnFSCommand(aSender: TObject;
    const command: WideString;
    const args: WideString);
    {* ��������� ������ � ������ }
   procedure OnLoadFlash(aSender: TObject);
    {* ��������� ����� �� ���������� }
   procedure DoLoadFlash;
    {* ��������� ����� }
   procedure AddToWorkJournal;
   procedure DocumentGetHotSpotInfo(Sender: TObject;
    const aHotSpot: IevHotSpot;
    const aKeys: TafwCursorState;
    var theInfo: TafwCursorInfo);
    {* ��� ������� }
   procedure OpenCRListTest(const aParams: IvcmTestParamsPrim;
    aType: TlstCRType);
   procedure SetBookmark; override;
    {* ������������� �������� �� ������� ����� �������� ��������� }
   function CanAddBookmark: Boolean; override;
    {* ����� �� ������ ��������� �������� }
   function pm_GetFlashForPrint: TvtShockwaveFlashEx; override;
   function Name: Il3CString; override;
   function ShortName: Il3CString; override;
   function GetDocumentForInfo: IdeDocInfo; override;
   procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* ��������� �������� ������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function CallCloseQuery(aCaller: TCustomForm): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* ��������� ��������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* ��������� ��������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function NeedsStatusBarItems: Boolean; override;
    {* ����������, ��� �������� � ��������� ������ ���� ���� ����������� }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PageActive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   procedure DoPrintExecute(const aParams: IvcmExecuteParamsPrim); override;
   procedure DoPreviewExecute(const aParams: IvcmExecuteParamsPrim); override;
   function MakePreview: IafwDocumentPreview; override;
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetTabImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetCanDefineFormSetIcon: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
  public
   {$If NOT Defined(NoVCM)}
   procedure Save; override;
    {* ��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure SaveToFolder; override;
    {* ��������� � ����� }
   procedure LoadFromFolder; override;
    {* ��������� �� ����� }
   procedure OpenCorrespondentList; override;
    {* �������, ��� ���? }
   procedure OpenRespondentList; override;
    {* �������, ��� ���? }
   procedure GetAttributesFrmAct; override;
    {* ���������� � ��������� }
   function Load: Boolean; override;
    {* �������, ��� ����� ������� ���� �����? }
   procedure GetRelatedDocFrmAct; override;
    {* ������� � ��������� }
   procedure GetCorrespondentList; override;
    {* ������ �� �������� }
   procedure GetRespondentList; override;
    {* ������ �� ��������� }
   function AttributesCanBeClosed: Boolean; override;
    {* ��� �������� �� ������� � Facet ��� ���-�� �������� }
   procedure GetCorrespondentListExFrmAct; override;
    {* ������ �� �������� (��� ����������) }
   procedure GetRespondentListExFrmAct; override;
    {* ������ �� ��������� (��� ����������) }
   procedure GetGraphicImage; override;
   procedure GetAttributesFrmAct; override;
    {* ���������� � ��������� }
   constructor Create(AOwner: TComponent); override;
   {$If NOT Defined(NoVCM)}
   procedure SetPositionByDS; override;
    {* ���������� ����� ����� �������� ������� ��������� �������� ������. [$136258455] }
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property Document: IDocument
    read pm_GetDocument;
    {* ���������� �������� }
   property Flash: TvtShockwaveFlashEx
    read pm_GetFlash;
    {* ��������� ��� ������������ flash-������� }
   property Editor: TnscEditor
    read f_Editor
    write f_Editor;
    {* ��������� � ���, ��� ����� �� ���������� � ������� }
   property FromHistory: Boolean
    read f_FromHistory
    write f_FromHistory;
    {* ����� ��������� ��������� �� �������. ����� ����� ������� �������� �� ���������� }
   property State: InsDocumentWithFlashState
    read f_State
    write f_State;
    {* ��������� ������ }
 end;//TPrimDocumentWithFlashForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsDocumentTools
 , FoldersDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUtils
 , nsConst
 , l3Variant
 , k2Tags
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , FlashUtils
 , Windows
 , nsExternalObjectPrim
 , l3String
 , DataAdapter
 , BaseTreeSupportUnit
 , BaseTypesUnit
 , nsOpenUtils
 , FoldersUnit
 , Document_Const
 , nsTypes
 , bsTypesNew
 , nsDocumentPrintEvent
 , nsDocumentPrintPreviewEvent
 , LoggingInterfaces
 , nscDocumentHistory
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , bsUtils
 , DynamicTreeUnit
 , ExternalObjectUnit
 , nsDocumentFromListNavigationEvent
 {$If Defined(Nemesis)}
 , nscStatusBarItemDef
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDef
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarDelimiterDef
 {$IfEnd} // Defined(Nemesis)
 , DocumentUtil
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDefsList
 {$IfEnd} // Defined(Nemesis)
 , SysUtils
 , afwFacade
 , Common_FormDefinitions_Controls
 , evConstStringData
 , l3Base
 , evdHyperlinkInfo
 , nsHyperlinkToDocumentProducerConst
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsDocumentPreview
 , afwComplexDocumentPreview
 , evBitmapDataObject
 , nsFixedHAFMacroReplacer
 , nsObjectPreview
 , nevBase
 , nsHAFPainter
 , ShellAPI
;

type
 // ExcludeForSynchro

const
 c_FSCommandOpen = 'open';
 c_FSCommandOpenTab = 'open_tab';

constructor TnsDocumentWithFlashState.Create(aFrame: Integer);
//#UC START# *49900CC302D0_498855F60137_var*
//#UC END# *49900CC302D0_498855F60137_var*
begin
//#UC START# *49900CC302D0_498855F60137_impl*
 inherited Create;
 f_Frame := aFrame;
//#UC END# *49900CC302D0_498855F60137_impl*
end;//TnsDocumentWithFlashState.Create

class function TnsDocumentWithFlashState.Make(aFrame: Integer): InsDocumentWithFlashState;
var
 l_Inst : TnsDocumentWithFlashState;
begin
 l_Inst := Create(aFrame);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDocumentWithFlashState.Make

function TnsDocumentWithFlashState.pm_GetFrame: Integer;
//#UC START# *49900C5303E7_498855F60137get_var*
//#UC END# *49900C5303E7_498855F60137get_var*
begin
//#UC START# *49900C5303E7_498855F60137get_impl*
 Result := f_Frame;
//#UC END# *49900C5303E7_498855F60137get_impl*
end;//TnsDocumentWithFlashState.pm_GetFrame

type _Instance_R_ = TPrimDocumentWithFlashForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseDocumentForDocumentModule.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlashOperations.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes.imp.pas}

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableFlashWithInfo.imp.pas}

function TPrimDocumentWithFlashForm.pm_GetDocument: IDocument;
//#UC START# *4988194E02F8_497EDE780363get_var*
//#UC END# *4988194E02F8_497EDE780363get_var*
begin
//#UC START# *4988194E02F8_497EDE780363get_impl*
 if (sdsBaseDocument <> nil) and Assigned(sdsBaseDocument.DocInfo) then
  Result := sdsBaseDocument.DocInfo.Doc
 else
  Result := nil;
//#UC END# *4988194E02F8_497EDE780363get_impl*
end;//TPrimDocumentWithFlashForm.pm_GetDocument

function TPrimDocumentWithFlashForm.pm_GetFlash: TvtShockwaveFlashEx;
//#UC START# *498845CE003C_497EDE780363get_var*
const
 c_HyperlinkLenght = 10;

  procedure lp_MakeEditor;

    procedure lp_GenerateText;
    var
     l_Gen: Ik2TagGenerator;
    begin
     with Editor do
      l_Gen := TextSource.GetGenerator(View, nil);
     with l_Gen do
     begin
      Start;
      try
       StartChild(k2_typDocument);
       try
        with vcmCStr(str_FlashActiveXDoesNotInstalled) do
         bsEditorAddPara(l_Gen,
                         AsWStr,
                         false,
                         cNoneWarningSub,
                         cnsFlashActiveXInstallLinkId,
                         Pred(AsWStr.SLen - c_HyperlinkLenght),
                          // - Pred - ���������� ����� � �����.
                         Pred(AsWStr.SLen)
                          // - Pred - ���������� ����� � �����.
                         );
       finally
        Finish;
       end;//StartChild(k2_typDocument);
      finally
       Finish;
      end;//Start;
     end;//with aGen do
    end;//lp_GenerateText

  begin
   Editor := TnscEditor.Create(nil);
   with Editor do
   begin
    Parent := Self;
    Align := alClient;
    IsStaticText := True;
    OnJumpTo := DocumentOnJumpTo;
    OnGetHotSpotInfo := DocumentGetHotSpotInfo;
   end;//with f_Editor do
   if (UserType <> dwftSynchro) then
    if Editor.CanFocus then
     Editor.SetFocus;
   //ActiveControl := Editor;
   lp_GenerateText;
  end;

//#UC END# *498845CE003C_497EDE780363get_var*
begin
//#UC START# *498845CE003C_497EDE780363get_impl*
 if (f_Flash = nil) and (Editor = nil) then
  // �������� ��������� ��� ������ flash-������:
  if nsMakeFlashActiveX(Self, false, f_Flash) then
  begin
   with f_Flash do
   begin
    Name := 'Flash';
    OnFSCommand := Self.OnFSCommand;
    OnLoadFlash := Self.OnLoadFlash;
    OnChangeFrameInFlash := Self.OnChangeFrameInFlash;
   end;//with f_Flash
  end//nsMakeFlashActiveX
  // �������, ��� ��������� � ������� �� ����������:
  else
  if Editor = nil then
   lp_MakeEditor;
 Result := f_Flash;
//#UC END# *498845CE003C_497EDE780363get_impl*
end;//TPrimDocumentWithFlashForm.pm_GetFlash

function TPrimDocumentWithFlashForm.DocumentOnJumpTo(Sender: TObject;
 anEffects: TafwJumpToEffects;
 const aMoniker: IevMoniker): Boolean;
 {* ������� �� ������ }
var l_HL: IevHyperlink;
var l_Form: IvcmEntityForm;
//#UC START# *4A23B242004C_497EDE780363_var*
//#UC END# *4A23B242004C_497EDE780363_var*
begin
//#UC START# *4A23B242004C_497EDE780363_impl*
 Result := False;
 if Supports(aMoniker, IevHyperlink, l_HL) then
 begin
  case l_HL.ID of
   Ord(cnsFlashActiveXInstallLinkId):
   begin
    ShellExecute(0, 'open', c_FlashActiveXInstallURL, nil, nil, SW_SHOWNORMAL);
    Result := True;
   end;//Ord(cnsFlashActiveXInstallLinkId)
   else
    Assert(false);
  end;//case l_HL.ID of
 end;//if Supports(aMoniker, IevHyperlink, l_HL) then
//#UC END# *4A23B242004C_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.DocumentOnJumpTo

procedure TPrimDocumentWithFlashForm.UpdateCaption;
//#UC START# *544656D00099_497EDE780363_var*
//#UC END# *544656D00099_497EDE780363_var*
begin
//#UC START# *544656D00099_497EDE780363_impl*
 case UserType of
  dwftMain:
   CCaption := DataSource.DisplayName;
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=565269766
  else
   CCaption := nsCStr(CurUserType.Caption);
 end;
//#UC END# *544656D00099_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.UpdateCaption

procedure TPrimDocumentWithFlashForm.OnChangeFrameInFlash(aSender: TObject);
//#UC START# *5595389C014A_497EDE780363_var*
//#UC END# *5595389C014A_497EDE780363_var*
begin
//#UC START# *5595389C014A_497EDE780363_impl*
 ClearPreview;
//#UC END# *5595389C014A_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.OnChangeFrameInFlash

procedure TPrimDocumentWithFlashForm.OpenDocument(aDocID: Integer;
 aPosID: Integer;
 aOpenKind: TvcmMainFormOpenKind);
//#UC START# *560A2EB9008B_497EDE780363_var*
//#UC END# *560A2EB9008B_497EDE780363_var*
begin
//#UC START# *560A2EB9008B_497EDE780363_impl*
 nsOpenDocumentByNumber(aDocID, aPosID, dptSub, True, False, aOpenKind);
//#UC END# *560A2EB9008B_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.OpenDocument

procedure TPrimDocumentWithFlashForm.OnFSCommand(aSender: TObject;
 const command: WideString;
 const args: WideString);
 {* ��������� ������ � ������ }
//#UC START# *4988487A023D_497EDE780363_var*
type
 TFSCommandKind = (fscNone, fscOpen, fscOpenTab);
const
 c_CommandMsgArr: array[TFSCommandKind] of UINT = (0, c_OpenDoc, c_OpenDocInNewTab);
var
 l_CommandKind: TFSCommandKind;
 l_Msg        : UINT;
 l_DocId      : Integer;
 l_PosId      : Integer;
 l_OpenPosId  : LPARAM;
 l_PosType    : TDocumentPositionType;
//#UC END# *4988487A023D_497EDE780363_var*
begin
//#UC START# *4988487A023D_497EDE780363_impl*
 l_CommandKind := fscNone;
 
 if (command = c_FSCommandOpen) then
  l_CommandKind := fscOpen
 else
 if (command = c_FSCommandOpenTab) then
  l_CommandKind := fscOpenTab;

 if (l_CommandKind in [fscOpen, fscOpenTab]) then
 begin
  nsParseDocumentNumber(nsCStr(args), l_DocId, l_PosId, l_PosType);
  Inc(l_DocId, c_InternalDocShift);
  Flash.Stop;
  if (l_PosType = dptSub) then
   l_OpenPosId := l_PosId
  else
   l_OpenPosId := 0;
  PostMessage(Handle, c_CommandMsgArr[l_CommandKind], l_DocId, l_OpenPosId);
 end;
//#UC END# *4988487A023D_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.OnFSCommand

procedure TPrimDocumentWithFlashForm.OnLoadFlash(aSender: TObject);
 {* ��������� ����� �� ���������� }
//#UC START# *498848DB00BD_497EDE780363_var*
//#UC END# *498848DB00BD_497EDE780363_var*
begin
//#UC START# *498848DB00BD_497EDE780363_impl*
 DoLoadFlash;
//#UC END# *498848DB00BD_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.OnLoadFlash

procedure TPrimDocumentWithFlashForm.DoLoadFlash;
 {* ��������� ����� }
//#UC START# *49884900020F_497EDE780363_var*

  procedure lp_LoadFlash;
  var
   l_Flash  : IbsFlash;
   l_Stream : TnsExternalObjectStream;
   l_FrameIndex : Integer;
  begin
   if (Flash <> nil) and
      (bsFlash <> nil) and
      (bsFlash.FlashData <> nil) then
   begin
    l_Stream := TnsExternalObjectStream.Create(bsFlash.FlashData);
    try
     with Flash do
     begin
      Stop;
      LoadMovieFromStream(l_Stream);
      Stop;
     end;
     if FromHistory then
     begin
      Flash.FrameNum := State.Frame;
      State := nil;
     end
     else
      SetPositionByDS;

     // http://mdp.garant.ru/pages/viewpage.action?pageId=294599729&focusedCommentId=306938204#comment-306938204
     l_FrameIndex := Flash.CurrentFrame;
     if l_FrameIndex > 0 then
     begin
       Flash.Rewind;
       Flash.FrameNum := l_FrameIndex;
     end;
    finally
     FreeAndNil(l_Stream);
    end;//try..finally
   end;//Flash <> nil
  end;

//#UC END# *49884900020F_497EDE780363_var*
begin
//#UC START# *49884900020F_497EDE780363_impl*
 lp_LoadFlash;
 UpdateCaption;
 if FromHistory then
  AddToWorkJournal;
 f_FlashLoaded := True;
//#UC END# *49884900020F_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.DoLoadFlash

procedure TPrimDocumentWithFlashForm.AddToWorkJournal;
//#UC START# *49884DFB0368_497EDE780363_var*
var
 l_BookMark: IJournalBookmark;
//#UC END# *49884DFB0368_497EDE780363_var*
begin
//#UC START# *49884DFB0368_497EDE780363_impl*
 if Document <> nil then
 begin
  Document.CreateJournalBookmark(0, l_Bookmark);
  TdmStdRes.MakeWorkJournal.AddBookMark(l_Bookmark);
 end;
//#UC END# *49884DFB0368_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.AddToWorkJournal

procedure TPrimDocumentWithFlashForm.DocumentGetHotSpotInfo(Sender: TObject;
 const aHotSpot: IevHotSpot;
 const aKeys: TafwCursorState;
 var theInfo: TafwCursorInfo);
 {* ��� ������� }
//#UC START# *49884FB500EB_497EDE780363_var*
//#UC END# *49884FB500EB_497EDE780363_var*
begin
//#UC START# *49884FB500EB_497EDE780363_impl*
 if Supports(aHotSpot, IevHyperlink) then
  theInfo.rCursor := ev_csExternalHand;
//#UC END# *49884FB500EB_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.DocumentGetHotSpotInfo

procedure TPrimDocumentWithFlashForm.OpenCRListTest(const aParams: IvcmTestParamsPrim;
 aType: TlstCRType);
//#UC START# *498859BF027A_497EDE780363_var*
var
 l_List: IvcmNodes;
//#UC END# *498859BF027A_497EDE780363_var*
begin
//#UC START# *498859BF027A_497EDE780363_impl*
 OpenCRListOpTest(aParams, aType);
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  l_List := aParams.Op.SubNodes;
  if l_List <> nil then
   l_List.Add(DefDataAdapter.CRSimpleListTypeRootNode);
 end;
//#UC END# *498859BF027A_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.OpenCRListTest

procedure TPrimDocumentWithFlashForm.WMSetFocus(var Msg: TWMSetFocus);
//#UC START# *5449221E001D_497EDE780363_var*
//#UC END# *5449221E001D_497EDE780363_var*
begin
//#UC START# *5449221E001D_497EDE780363_impl*
 inherited;
 if Assigned(f_Flash) then
  Windows.SetFocus(f_Flash.Handle);
//#UC END# *5449221E001D_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.WMSetFocus

{$If NOT Defined(NoVCM)}
procedure TPrimDocumentWithFlashForm.Save;
 {* ��������� }
//#UC START# *495235F401C0_497EDE780363_var*
//#UC END# *495235F401C0_497EDE780363_var*
begin
//#UC START# *495235F401C0_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.Save
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimDocumentWithFlashForm.SaveToFolder;
 {* ��������� � ����� }
//#UC START# *49885D540232_497EDE780363_var*
//#UC END# *49885D540232_497EDE780363_var*
begin
//#UC START# *49885D540232_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *49885D540232_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.SaveToFolder

procedure TPrimDocumentWithFlashForm.LoadFromFolder;
 {* ��������� �� ����� }
//#UC START# *49885D59018D_497EDE780363_var*
//#UC END# *49885D59018D_497EDE780363_var*
begin
//#UC START# *49885D59018D_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *49885D59018D_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.LoadFromFolder

procedure TPrimDocumentWithFlashForm.OpenCorrespondentList;
 {* �������, ��� ���? }
//#UC START# *4988752302F4_497EDE780363_var*
//#UC END# *4988752302F4_497EDE780363_var*
begin
//#UC START# *4988752302F4_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *4988752302F4_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.OpenCorrespondentList

procedure TPrimDocumentWithFlashForm.OpenRespondentList;
 {* �������, ��� ���? }
//#UC START# *49888E8003B9_497EDE780363_var*
//#UC END# *49888E8003B9_497EDE780363_var*
begin
//#UC START# *49888E8003B9_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *49888E8003B9_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.OpenRespondentList

procedure TPrimDocumentWithFlashForm.GetAttributesFrmAct;
 {* ���������� � ��������� }
//#UC START# *498891640253_497EDE780363_var*
//#UC END# *498891640253_497EDE780363_var*
begin
//#UC START# *498891640253_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *498891640253_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.GetAttributesFrmAct

function TPrimDocumentWithFlashForm.Load: Boolean;
 {* �������, ��� ����� ������� ���� �����? }
//#UC START# *49895A2102E8_497EDE780363_var*
//#UC END# *49895A2102E8_497EDE780363_var*
begin
//#UC START# *49895A2102E8_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *49895A2102E8_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.Load

procedure TPrimDocumentWithFlashForm.GetRelatedDocFrmAct;
 {* ������� � ��������� }
//#UC START# *498993C801DC_497EDE780363_var*
//#UC END# *498993C801DC_497EDE780363_var*
begin
//#UC START# *498993C801DC_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *498993C801DC_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.GetRelatedDocFrmAct

procedure TPrimDocumentWithFlashForm.SetBookmark;
 {* ������������� �������� �� ������� ����� �������� ��������� }
//#UC START# *4989CD040306_497EDE780363_var*
var
 l_Bookmark : IBookmark;
//#UC END# *4989CD040306_497EDE780363_var*
begin
//#UC START# *4989CD040306_497EDE780363_impl*
 CreateBookmark(Document, 0, true, l_Bookmark);
 if (l_Bookmark <> nil) then
 try
  TdmStdRes.SaveOpen(Self.As_IvcmEntityForm,
                     dsBaseDocument.As_IucpFilterInfoFactory.MakeFilterInfo(ffListAndBookMarks),
                     fetBookMark,
                     l_Bookmark,
                     false);
 finally
  l_Bookmark := nil;
 end;//try..finally
//#UC END# *4989CD040306_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.SetBookmark

function TPrimDocumentWithFlashForm.CanAddBookmark: Boolean;
 {* ����� �� ������ ��������� �������� }
//#UC START# *4989CF90010A_497EDE780363_var*
//#UC END# *4989CF90010A_497EDE780363_var*
begin
//#UC START# *4989CF90010A_497EDE780363_impl*
 Result := (Document <> nil);
//#UC END# *4989CF90010A_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.CanAddBookmark

procedure TPrimDocumentWithFlashForm.GetCorrespondentList;
 {* ������ �� �������� }
//#UC START# *4989D65C0275_497EDE780363_var*
//#UC END# *4989D65C0275_497EDE780363_var*
begin
//#UC START# *4989D65C0275_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D65C0275_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.GetCorrespondentList

procedure TPrimDocumentWithFlashForm.GetRespondentList;
 {* ������ �� ��������� }
//#UC START# *4989D8430128_497EDE780363_var*
//#UC END# *4989D8430128_497EDE780363_var*
begin
//#UC START# *4989D8430128_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D8430128_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.GetRespondentList

function TPrimDocumentWithFlashForm.AttributesCanBeClosed: Boolean;
 {* ��� �������� �� ������� � Facet ��� ���-�� �������� }
//#UC START# *4989DE3702CF_497EDE780363_var*
//#UC END# *4989DE3702CF_497EDE780363_var*
begin
//#UC START# *4989DE3702CF_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989DE3702CF_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.AttributesCanBeClosed

procedure TPrimDocumentWithFlashForm.GetCorrespondentListExFrmAct;
 {* ������ �� �������� (��� ����������) }
//#UC START# *4AF329F6002A_497EDE780363_var*
//#UC END# *4AF329F6002A_497EDE780363_var*
begin
//#UC START# *4AF329F6002A_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF329F6002A_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.GetCorrespondentListExFrmAct

procedure TPrimDocumentWithFlashForm.GetRespondentListExFrmAct;
 {* ������ �� ��������� (��� ����������) }
//#UC START# *4AF329FD014D_497EDE780363_var*
//#UC END# *4AF329FD014D_497EDE780363_var*
begin
//#UC START# *4AF329FD014D_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF329FD014D_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.GetRespondentListExFrmAct

procedure TPrimDocumentWithFlashForm.GetGraphicImage;
//#UC START# *4C3C77CC012A_497EDE780363_var*
//#UC END# *4C3C77CC012A_497EDE780363_var*
begin
//#UC START# *4C3C77CC012A_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C77CC012A_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.GetGraphicImage

procedure TPrimDocumentWithFlashForm.GetAttributesFrmAct;
 {* ���������� � ��������� }
//#UC START# *4C7B9EBC01AC_497EDE780363_var*
//#UC END# *4C7B9EBC01AC_497EDE780363_var*
begin
//#UC START# *4C7B9EBC01AC_497EDE780363_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7B9EBC01AC_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.GetAttributesFrmAct

function TPrimDocumentWithFlashForm.pm_GetFlashForPrint: TvtShockwaveFlashEx;
//#UC START# *4CDACDBE00B2_497EDE780363get_var*
//#UC END# *4CDACDBE00B2_497EDE780363get_var*
begin
//#UC START# *4CDACDBE00B2_497EDE780363get_impl*
 Result := Flash;
//#UC END# *4CDACDBE00B2_497EDE780363get_impl*
end;//TPrimDocumentWithFlashForm.pm_GetFlashForPrint

function TPrimDocumentWithFlashForm.Name: Il3CString;
//#UC START# *4CDAD282005F_497EDE780363_var*
//#UC END# *4CDAD282005F_497EDE780363_var*
begin
//#UC START# *4CDAD282005F_497EDE780363_impl*
 Result := nsGetDocumentName(Document);
//#UC END# *4CDAD282005F_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.Name

function TPrimDocumentWithFlashForm.ShortName: Il3CString;
//#UC START# *4CDAD29D0169_497EDE780363_var*
//#UC END# *4CDAD29D0169_497EDE780363_var*
begin
//#UC START# *4CDAD29D0169_497EDE780363_impl*
 Result := nsGetDocumentShortName(Document);
//#UC END# *4CDAD29D0169_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.ShortName

function TPrimDocumentWithFlashForm.GetDocumentForInfo: IdeDocInfo;
//#UC START# *54D8913B03A6_497EDE780363_var*
//#UC END# *54D8913B03A6_497EDE780363_var*
begin
//#UC START# *54D8913B03A6_497EDE780363_impl*
 Result := dsDocument.DocInfo;
//#UC END# *54D8913B03A6_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.GetDocumentForInfo

procedure TPrimDocumentWithFlashForm.NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
//#UC START# *55321ADE02E9_497EDE780363_var*
//#UC END# *55321ADE02E9_497EDE780363_var*
begin
//#UC START# *55321ADE02E9_497EDE780363_impl*
 if (aNotification = tcnApplicationTerminating) then
  AddToWorkJournal;
//#UC END# *55321ADE02E9_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.NotifyContainersChanged

procedure TPrimDocumentWithFlashForm.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_497EDE780363_var*
//#UC END# *479731C50290_497EDE780363_var*
begin
//#UC START# *479731C50290_497EDE780363_impl*
 Tl3TabbedContainersDispatcher.Instance.Unsubscribe(Self);
 ActiveOleControl := nil;
 FreeAndNil(f_Flash);
 FreeAndNil(f_Editor);
 f_State := nil;
 inherited;
//#UC END# *479731C50290_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.Cleanup

constructor TPrimDocumentWithFlashForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_497EDE780363_var*
//#UC END# *47D1602000C6_497EDE780363_var*
begin
//#UC START# *47D1602000C6_497EDE780363_impl*
 inherited;
 //Flash;
//#UC END# *47D1602000C6_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.Create

{$If NOT Defined(NoVCL)}
procedure TPrimDocumentWithFlashForm.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_497EDE780363_var*
var
 l_OpenKind: TvcmMainFormOpenKind;
//#UC END# *47E136A80191_497EDE780363_var*
begin
//#UC START# *47E136A80191_497EDE780363_impl*
 case Message.Msg of
  c_OpenDoc:
   l_OpenKind := vcm_okInCurrentTab;
  c_OpenDocInNewTab:
   l_OpenKind := vcm_okInNewTab;
 else
  inherited;
  Exit;
 end;
 OpenDocument(Message.WParam, Message.LParam, l_OpenKind);
//#UC END# *47E136A80191_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.WndProc
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCM)}
procedure TPrimDocumentWithFlashForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* ��������� �������� ������. ��� ���������� � �������� }
//#UC START# *497469C90140_497EDE780363_var*
 procedure lp_AddDocumentToHistory;
 begin
  if ((Self.UserType <> dwftSynchro) or IsActiveInParent) and // �� �������� ������� ��� ������� �����
   not FromHistory and Assigned(Document) then
   TnscDocumentHistory.Instance.AddDocument(Document.GetInternalId);
 end;

 procedure lp_ClearActiveControl;
 var
  l_Ctrl: TWinControl;
  l_Form: TForm;
 begin
  l_Ctrl := Self;
  while (l_Ctrl.Parent <> nil) do
  begin
   if (l_Ctrl is TForm) then
   begin
    l_Form := TForm(l_Ctrl);
    if (l_Form.ActiveControl <> nil) and
     (csDestroying in l_Form.ActiveControl.ComponentState) then
     l_Form.ActiveControl := nil;
   end;
   l_Ctrl := l_Ctrl.Parent;
  end;
 end;

//#UC END# *497469C90140_497EDE780363_var*
begin
//#UC START# *497469C90140_497EDE780363_impl*
 g_Dispatcher.LockActionUpdate;
 inherited;

 if f_FlashLoaded then
  FromHistory := false;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=606827039

 lp_ClearActiveControl; 

 ActiveOleControl := nil;
 ActiveControl := nil;
 FreeAndNil(f_Flash);

 if (aNew <> nil) then
 begin
//  ActiveOleControl := nil;
//  ActiveControl := nil;
//  FreeAndNil(f_Flash);
  if (Flash <> nil) then
  begin
   lp_AddDocumentToHistory;
   f_FlashLoaded := False;
   Flash.LoadByRequest;
   if (UserType <> dwftSynchro) then
    if Self.CanFocus then
     if Self.Visible AND Self.Enabled then
      if Flash.CanFocus then
       try
        Flash.SetFocus;
       except
        on EInvalidOperation do;
       end;//try..except
  end;//Flash <> nil
  UpdateCaption;
 end;//aNew <> nil
 g_Dispatcher.UnlockActionUpdate;
//#UC END# *497469C90140_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDocumentWithFlashForm.DoInit(aFromHistory: Boolean);
 {* ������������� �����. ��� ���������� � �������� }
//#UC START# *49803F5503AA_497EDE780363_var*
//#UC END# *49803F5503AA_497EDE780363_var*
begin
//#UC START# *49803F5503AA_497EDE780363_impl*
 FromHistory := aFromHistory or InHistoryStep;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=606128235,
 // http://mdp.garant.ru/pages/viewpage.action?pageId=604485184
 inherited;
//#UC END# *49803F5503AA_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimDocumentWithFlashForm.CallCloseQuery(aCaller: TCustomForm): Boolean;
//#UC START# *4980407F0076_497EDE780363_var*
//#UC END# *4980407F0076_497EDE780363_var*
begin
//#UC START# *4980407F0076_497EDE780363_impl*
 Result := inherited CallCloseQuery(aCaller);
 AddToWorkJournal;
//#UC END# *4980407F0076_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.CallCloseQuery
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimDocumentWithFlashForm.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* ��������� ��������� �����. ��� ���������� � �������� }
//#UC START# *49806ED503D5_497EDE780363_var*
//#UC END# *49806ED503D5_497EDE780363_var*
begin
//#UC START# *49806ED503D5_497EDE780363_impl*
 if (aStateType = vcm_stContent) and (Flash <> nil) then
 begin
  AddToWorkJournal;
  theState := TnsDocumentWithFlashState.Make(Flash.FrameNum);
  Result := true;
 end
 else
  Result := inherited DoSaveState(theState, aStateType, aForClone);
//#UC END# *49806ED503D5_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.DoSaveState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimDocumentWithFlashForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* ��������� ��������� �����. ��� ���������� � �������� }
//#UC START# *49807428008C_497EDE780363_var*
//#UC END# *49807428008C_497EDE780363_var*
begin
//#UC START# *49807428008C_497EDE780363_impl*
 if (aStateType = vcm_stContent) then
 begin
  Result := Supports(aState, InsDocumentWithFlashState, f_State);
 end//aStateType = vcm_stContent
 else
  Result := inherited DoLoadState(aState, aStateType);
//#UC END# *49807428008C_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.DoLoadState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDocumentWithFlashForm.SetPositionByDS;
 {* ���������� ����� ����� �������� ������� ��������� �������� ������. [$136258455] }
//#UC START# *498953170108_497EDE780363_var*
//#UC END# *498953170108_497EDE780363_var*
begin
//#UC START# *498953170108_497EDE780363_impl*
 inherited;
 if Flash = nil then exit;
 if (dsDocument <> nil) then
 begin
  if (dsDocument.DocInfo.Pos.rRefType = dptSub) OR
     (dsDocument.DocInfo.Pos.rRefType = dptPara)
     // http://mdp.garant.ru/pages/viewpage.action?pageId=235865644
     // http://mdp.garant.ru/pages/viewpage.action?pageId=235865644&focusedCommentId=294604779&#comment-294604779
   then
   Flash.FrameNum := dsDocument.DocInfo.Pos.rPos
  else
   Flash.FrameNum := 0;
  ClearPreview;
 end;//dsDocument <> nil
//#UC END# *498953170108_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.SetPositionByDS
{$IfEnd} // NOT Defined(NoVCM)

function TPrimDocumentWithFlashForm.NeedsStatusBarItems: Boolean;
 {* ����������, ��� �������� � ��������� ������ ���� ���� ����������� }
//#UC START# *4A8E5CEC021F_497EDE780363_var*
//#UC END# *4A8E5CEC021F_497EDE780363_var*
begin
//#UC START# *4A8E5CEC021F_497EDE780363_impl*
 Result := (UserType <> dwftSynchro);
//#UC END# *4A8E5CEC021F_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.NeedsStatusBarItems

{$If NOT Defined(NoVCM)}
procedure TPrimDocumentWithFlashForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_497EDE780363_var*
//#UC END# *4A8E8F2E0195_497EDE780363_var*
begin
//#UC START# *4A8E8F2E0195_497EDE780363_impl*
 inherited;
 AutoScroll := true;
 Color := clWhite;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=235872341
 Tl3TabbedContainersDispatcher.Instance.Subscribe(Self);
//#UC END# *4A8E8F2E0195_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDocumentWithFlashForm.PageActive;
//#UC START# *4C52E8030278_497EDE780363_var*
//#UC END# *4C52E8030278_497EDE780363_var*
begin
//#UC START# *4C52E8030278_497EDE780363_impl*
 inherited;
 if Assigned(Document) then
  TnscDocumentHistory.Instance.AddDocument(Document.GetInternalId);
//#UC END# *4C52E8030278_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.PageActive
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimDocumentWithFlashForm.ClearFields;
begin
 State := nil;
 inherited;
end;//TPrimDocumentWithFlashForm.ClearFields

procedure TPrimDocumentWithFlashForm.DoPrintExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *51A45199015E_497EDE780363_var*
var
 l_Preview : IafwDocumentPreview;
 l_Event: InsEventHolder;
//#UC END# *51A45199015E_497EDE780363_var*
begin
//#UC START# *51A45199015E_497EDE780363_impl*
 l_Preview := Preview;
 if (Supports(l_Preview, InsEventHolder, l_Event)) then
  l_Event.SetEvent(TnsDocumentPrintEvent.Make(Document, False))
 else
  Assert(False);
 inherited;
//#UC END# *51A45199015E_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.DoPrintExecute

procedure TPrimDocumentWithFlashForm.DoPreviewExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *51A451E20376_497EDE780363_var*
var
 l_Event: InsEventHolder;
//#UC END# *51A451E20376_497EDE780363_var*
begin
//#UC START# *51A451E20376_497EDE780363_impl*
 TnsDocumentPrintPreviewEvent.Log(Document);
 inherited;
//#UC END# *51A451E20376_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.DoPreviewExecute

function TPrimDocumentWithFlashForm.MakePreview: IafwDocumentPreview;
//#UC START# *5301CBFE023E_497EDE780363_var*
var
 l_Event: InsEventHolder;
//#UC END# *5301CBFE023E_497EDE780363_var*
begin
//#UC START# *5301CBFE023E_497EDE780363_impl*
 Result := inherited MakePreview;                      
 if Assigned(Document) and Supports(Result, InsEventHolder, l_Event) then
  l_Event.SetEvent(TnsDocumentPrintEvent.Make(Document, False));
//#UC END# *5301CBFE023E_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.MakePreview

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimDocumentWithFlashForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_497EDE780363_var*
//#UC END# *543E3AA801D0_497EDE780363_var*
begin
//#UC START# *543E3AA801D0_497EDE780363_impl*
 if (DataSource <> nil) and (DataSource.UseCaseController <> nil) then
  Result := DataSource.UseCaseController.FormSetImageIndex
 else
  Result := 0;
//#UC END# *543E3AA801D0_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.DoGetTabImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimDocumentWithFlashForm.DoGetCanDefineFormSetIcon: Boolean;
//#UC START# *544609B9032D_497EDE780363_var*
//#UC END# *544609B9032D_497EDE780363_var*
begin
//#UC START# *544609B9032D_497EDE780363_impl*
 Result := (UserType <> dwftSynchro);
//#UC END# *544609B9032D_497EDE780363_impl*
end;//TPrimDocumentWithFlashForm.DoGetCanDefineFormSetIcon
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDocumentWithFlashForm);
 {* ����������� PrimDocumentWithFlash }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
