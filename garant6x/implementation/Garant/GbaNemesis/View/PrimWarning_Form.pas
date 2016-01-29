unit PrimWarning_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimWarning_Form.pas"
// Начат: 23.01.2009 18:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Warning::PrimWarning
//
// Предупреждение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwInterfaces,
  nevTools,
  eeInterfaces,
  DocumentAndListInterfaces
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  Document_Strange_Controls,
  Base_Operations_Editions_Controls,
  afwDockingInterfaces,
  DocumentUnit,
  ExternalOperationUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  evCustomEditorWindow,
  nevGUIInterfaces,
  afwNavigation,
  nevNavigation,
  NavigationInterfaces,
  DocumentInterfaces,
  bsTypesNew,
  vcmExternalInterfaces {a}
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
//#UC START# *4979E5520222ci*
 {$IfOpt D+}
  {$IfNDef Console}
   {.$Define DebugViewer}
  {$EndIf  Console}
 {$EndIf D+}
//#UC END# *4979E5520222ci*
 _HyperlinkProcessorWithOwnLocalLink_Parent_ = TvcmEntityForm;
 {$Include ..\View\HyperlinkProcessorWithOwnLocalLink.imp.pas}
//#UC START# *4979E5520222cit*
//#UC END# *4979E5520222cit*
 TPrimWarningForm = {form} class(_HyperlinkProcessorWithOwnLocalLink_, IafwFormView, IafwDockableControl)
  {* Предупреждение }
 private
 // private fields
   f_Viewer : TnscEditor;
    {* Поле для свойства Viewer}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure MakeDocumentContainer(Sender: TObject;
     var aMade: InevDocumentContainer);
 protected
 // realized methods
   procedure GotoPoint(aPointID: Cardinal;
    aPointType: TDocumentPositionType = dptSub); override;
     {* Переход на точку в документе }
   function HyperlinkDocument: IDocument; override;
     {* Документ ИЗ которого ведёт ссылка }
   function pm_GetHyperlinkText: TevCustomEditorWindow; override;
   function IsFloating: Boolean; override;
     {* Форма плавающая }
   procedure System_TimeMachineStateChange_Execute(aStayInCurrentRedaction: Boolean = false);
   procedure System_TimeMachineStateChange(const aParams: IvcmExecuteParams);
   function CalculateHeightByWidth(var theWidth: Integer;
    aForceLoadData: Boolean): Integer;
   procedure SetBackColor(aColor: TafwColor);
   function CanBeDockedInto(aControl: TWinControl): Boolean;
   procedure OpenRedactionGlobalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); override;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   ViewArea : IdsWarning;
 protected
 // protected methods
   procedure PositionOnRequestedSub(aSubID: TnsWarningSub);
 public
 // public properties
   property Viewer: TnscEditor
     read f_Viewer;
//#UC START# *4979E5520222publ*
//#UC END# *4979E5520222publ*
 end;//TPrimWarningForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Base_Operations_Strange_Controls,
  F1Like_InternalOperations_Controls
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  SysUtils,
  TextPara_Const,
  k2Tags,
  l3ScreenIC,
  l3InternalInterfaces,
  l3String,
  l3Chars,
  l3Types,
  evDef,
  l3MinMax,
  Graphics,
  DocumentUserTypes_dftDocument_UserType,
  DocumentUserTypes_dftDrug_UserType,
  nsWarningDocumentContainer
  {$If defined(Nemesis)}
  ,
  eeTextSourceExport
  {$IfEnd} //Nemesis
  ,
  WarningUserTypes_Warning_UserType,
  BaloonWarningUserTypes_Fake_UserType,
  BaloonWarningUserTypes_WarnJuror_UserType,
  BaloonWarningUserTypes_WarnPreActive_UserType,
  BaloonWarningUserTypes_WarnIsAbolished_UserType,
  BaloonWarningUserTypes_WarnOnControl_UserType,
  BaloonWarningUserTypes_WarnInactualDocument_UserType,
  BaloonWarningUserTypes_WarnTimeMachineOn_UserType,
  BaloonWarningUserTypes_WarnRedaction_UserType,
  BaloonWarningUserTypes_WarnTimeMachineWarning_UserType,
  BaloonWarningUserTypes_WarnTimeMachineException_UserType,
  BaloonWarningUserTypes_remListModified_UserType,
  BaloonWarningUserTypes_remListFiltered_UserType,
  BaloonWarningUserTypes_remTimeMachineWarning_UserType,
  BaloonWarningUserTypes_remUnreadConsultations_UserType,
  BaloonWarningUserTypes_remOnlineDead_UserType,
  BaloonWarningUserTypes_TrialModeWarning_UserType,
  BaloonWarningUserTypes_OldBaseWarning_UserType,
  BaloonWarningUserTypes_ControlledChangingWarning_UserType,
  nevBase
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  nsConst,
  afwFacade
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsHyperLinkProcessor,
  deDocInfo,
  nsOpenUtils,
  nsTabbedContainerUtils
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  nsHyperlinkProcessorTypes,
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TPrimWarningForm;

{$Include ..\View\HyperlinkProcessorWithOwnLocalLink.imp.pas}

// start class TPrimWarningForm

procedure TPrimWarningForm.MakeDocumentContainer(Sender: TObject;
  var aMade: InevDocumentContainer);
//#UC START# *4F153B0E0018_4979E5520222_var*
//#UC END# *4F153B0E0018_4979E5520222_var*
begin
//#UC START# *4F153B0E0018_4979E5520222_impl*
 Assert(ViewArea <> nil);
 aMade := TnsWarningDocumentContainer.Make(ViewArea, UserType);
//#UC END# *4F153B0E0018_4979E5520222_impl*
end;//TPrimWarningForm.MakeDocumentContainer

procedure TPrimWarningForm.PositionOnRequestedSub(aSubID: TnsWarningSub);
//#UC START# *4AE9DF9401A6_4979E5520222_var*
//#UC END# *4AE9DF9401A6_4979E5520222_var*
var
 l_Sub : IeeSub;
begin
//#UC START# *4AE9DF9401A6_4979E5520222_impl*
 l_Sub := Viewer.Editor.Data.Document.Subs.SubsByID[Ord(aSubID)];
 if (l_Sub <> nil) and
    l_Sub.Exists then
  l_Sub.Select;
//#UC END# *4AE9DF9401A6_4979E5520222_impl*
end;//TPrimWarningForm.PositionOnRequestedSub

procedure TPrimWarningForm.GotoPoint(aPointID: Cardinal;
  aPointType: TDocumentPositionType = dptSub);
//#UC START# *4A8164E801AE_4979E5520222_var*
//#UC END# *4A8164E801AE_4979E5520222_var*
begin
//#UC START# *4A8164E801AE_4979E5520222_impl*
 Op_Document_SetPosition.Call(Aggregate, aPointID, aPointType, dftDocument);
//#UC END# *4A8164E801AE_4979E5520222_impl*
end;//TPrimWarningForm.GotoPoint

function TPrimWarningForm.HyperlinkDocument: IDocument;
//#UC START# *4A8168BB0217_4979E5520222_var*
//#UC END# *4A8168BB0217_4979E5520222_var*
begin
//#UC START# *4A8168BB0217_4979E5520222_impl*
 if (ViewArea = nil) OR (ViewArea.DocInfo = nil) then
  Result := nil
 else
  Result := ViewArea.DocInfo.Doc;
//#UC END# *4A8168BB0217_4979E5520222_impl*
end;//TPrimWarningForm.HyperlinkDocument

function TPrimWarningForm.pm_GetHyperlinkText: TevCustomEditorWindow;
//#UC START# *4A82BC390036_4979E5520222get_var*
//#UC END# *4A82BC390036_4979E5520222get_var*
begin
//#UC START# *4A82BC390036_4979E5520222get_impl*
 Result := Viewer;
//#UC END# *4A82BC390036_4979E5520222get_impl*
end;//TPrimWarningForm.pm_GetHyperlinkText

function TPrimWarningForm.IsFloating: Boolean;
//#UC START# *4A8A9DB0001A_4979E5520222_var*
//#UC END# *4A8A9DB0001A_4979E5520222_var*
begin
//#UC START# *4A8A9DB0001A_4979E5520222_impl*
 Result := (UserType > 0);
//#UC END# *4A8A9DB0001A_4979E5520222_impl*
end;//TPrimWarningForm.IsFloating

procedure TPrimWarningForm.System_TimeMachineStateChange_Execute(aStayInCurrentRedaction: Boolean = false);
//#UC START# *4A8EF367029E_4979E5520222exec_var*
//#UC END# *4A8EF367029E_4979E5520222exec_var*
begin
//#UC START# *4A8EF367029E_4979E5520222exec_impl*
 if (UserType = WarnTimeMachineOn) then
  if Assigned(Viewer) and Assigned(Viewer.TextSource) then
   Viewer.TextSource.DocumentContainer := nil; // сбрасываем текст баллона
//#UC END# *4A8EF367029E_4979E5520222exec_impl*
end;//TPrimWarningForm.System_TimeMachineStateChange_Execute

procedure TPrimWarningForm.System_TimeMachineStateChange(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISystem_TimeMachineStateChange_Params) do
  System_TimeMachineStateChange_Execute(StayInCurrentRedaction);
end;

function TPrimWarningForm.CalculateHeightByWidth(var theWidth: Integer;
  aForceLoadData: Boolean): Integer;
//#UC START# *4D8CA46002BE_4979E5520222_var*
const
 cSherMagicLen = 50;
var
 l_Para : Tl3Variant;
 l_S, l_S_tmp : Tl3PCharLen;
 l_IC : Il3InfoCanvas;
 l_ind: Integer;
//#UC END# *4D8CA46002BE_4979E5520222_var*
begin
//#UC START# *4D8CA46002BE_4979E5520222_impl*
 l3AssignNil(l_S);

 //Viewer.LeftIndentDelta := 2;
 Viewer.TabStop := false;
 //Viewer.TabStop := true;
 // - чтобы фокус ставился в редактор, а не уходил в странную панель
 // http://mdp.garant.ru/pages/viewpage.action?pageId=352452629&focusedCommentId=354683670#comment-354683670
 // - вроде бы поборол это в TvcmDispatcher.EntityOperation
 Viewer.ScrollStyle := ssNone;
 {$IfDef DebugViewer}
 Viewer.DrawSpecial := true;
 Viewer.Color := clWhite;
 {$EndIf DebugViewer}
 if aForceLoadData then
  if not Viewer.Document.AsObject.IsValid then
   if (Viewer.TextSource <> nil) then
    if (Viewer.TextSource.DocumentContainer <> nil) then
     Viewer.TextSource.DocumentContainer.Document;
     // - пытаемся прогрузить документ
 with Viewer.Document do
 begin
  if AsObject.IsValid AND (AsObject.ChildrenCount > 0) then
  begin
   // раньше ориентировались только на первый параграф
   // но может возникнуть случай, когда он пустой, либо короткий
   // и чтобы балон в этом случае не был слишком сжат, лучше проверять все параграфы
   for l_ind := 0 to Pred(AsObject.ChildrenCount) do
   begin
    l_Para := AsObject.Child[l_ind];
    Assert(l_Para.IsKindOf(k2_typTextPara)); // на случай, если в параграфе когда-то будет не просто текст

    l_S_tmp := l_Para.PCharLenA[k2_tiText];
    if l_S_tmp.SLen > l_S.SLen then
     l_S := l_S_tmp;
   end;

   if (l_S.SLen <= cSherMagicLen) then
   begin
    if not l3HasChar(cc_SoftEnter, l_S) then
    begin
     l_IC := L3CrtIC;
     try
      l_IC.Font.Name := def_ArialFontName;
      l_IC.Font.Style := []; 
      l_IC.Font.Size := l_Para.Attr[k2_tiFont].IntA[k2_tiSize];
      Assert(l_IC.Font.Size > 3);
      theWidth := Min(theWidth, l_IC.LP2DP(l_IC.TextExtent(l_S)).X + Viewer.LeftIndentDelta * 3{50});
     finally
      l_IC := nil;
     end;//try..finally
    end;//not l3HasChar(cc_SoftEnter, l_S)
   end;//l_S.SLen <= cSherMagicLen
  end;//IsValid AND (ChildrenCount > 0)
 end;//with Viewer.Document
 Self.Width := theWidth;
 Self.ClientWidth := theWidth;
 //Viewer.AutoHeightByText := true;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=265393897
 // Что-то там с VGScene идёт поперёк борозды. Редактор в какой-то момент становиться меньше, чем текст.
 Viewer.Align := alNone;
 Viewer.Width := theWidth;
 Viewer.NeedDrawDocumentEdge := false;
 //Result := Viewer.Height;
 Result := Viewer.DocumentFullHeight + 10;
 Viewer.Height := Result;
//#UC END# *4D8CA46002BE_4979E5520222_impl*
end;//TPrimWarningForm.CalculateHeightByWidth

procedure TPrimWarningForm.SetBackColor(aColor: TafwColor);
//#UC START# *4D8CA47B0343_4979E5520222_var*
//#UC END# *4D8CA47B0343_4979E5520222_var*
begin
//#UC START# *4D8CA47B0343_4979E5520222_impl*
 Self.Color := aColor;
 {$IfNDef DebugViewer}
 Viewer.Color := aColor;
 {$EndIf  DebugViewer}
//#UC END# *4D8CA47B0343_4979E5520222_impl*
end;//TPrimWarningForm.SetBackColor

function TPrimWarningForm.CanBeDockedInto(aControl: TWinControl): Boolean;
//#UC START# *4DA835E501AA_4979E5520222_var*
//#UC END# *4DA835E501AA_4979E5520222_var*
begin
//#UC START# *4DA835E501AA_4979E5520222_impl*
 Result := ANSISameText(CurUserType.Name, aControl.Name); 
//#UC END# *4DA835E501AA_4979E5520222_impl*
end;//TPrimWarningForm.CanBeDockedInto

procedure TPrimWarningForm.OpenRedactionGlobalLink(const aDocument: IDocument;
  aSub: Cardinal;
  aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *53A303BE03A8_4979E5520222_var*
//#UC END# *53A303BE03A8_4979E5520222_var*
begin
//#UC START# *53A303BE03A8_4979E5520222_impl*
 Assert(False, '513615258');
//#UC END# *53A303BE03A8_4979E5520222_impl*
end;//TPrimWarningForm.OpenRedactionGlobalLink

{$If not defined(NoVCM)}
procedure TPrimWarningForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_4979E5520222_var*
//#UC END# *497469C90140_4979E5520222_var*
begin
//#UC START# *497469C90140_4979E5520222_impl*
 inherited;
 if Assigned(ViewArea) then
 begin
  Viewer.TextSource.NeedProcessMessages := false;
  Viewer.TextSource.DocumentContainer := nil;
  // - просто сбрасываем контейнер документа, а генерацию предупреждения перенесём в TnsWarningDocumentContainer
  //ViewArea.GenerateWarning(Viewer.TextSource.GetGenerator(Viewer.View, nil), UserType);
(*  if (ViewArea.WarningContent <> cEmptyWarning) then
   Viewer.Invalidate;*)
  if not Viewer.IsStaticText then
   Viewer.IsStaticText := True;
 end;//Assigned(ViewArea)
//#UC END# *497469C90140_4979E5520222_impl*
end;//TPrimWarningForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimWarningForm.InitControls;
//#UC START# *4A8E8F2E0195_4979E5520222_var*
//#UC END# *4A8E8F2E0195_4979E5520222_var*
begin
//#UC START# *4A8E8F2E0195_4979E5520222_impl*
 inherited;
 ActiveControl := Viewer;
(*    Left = 0
    Top = 0
    Width = 250
    Height = 173*)
 Viewer.Align := alClient;
 Viewer.TabOrder := 0;
 Viewer.IsStaticText := True;
 (Viewer.TextSource As TeeTextSourceExport).OnMakeDocumentContainer := Self.MakeDocumentContainer;
//#UC END# *4A8E8F2E0195_4979E5520222_impl*
end;//TPrimWarningForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimWarningForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  ViewArea := nil;
 end//aDsNew = nil
 else
 begin
  ViewArea := aDsNew As IdsWarning;
 end;//aDsNew = nil
end;

procedure TPrimWarningForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_System, nil);
  PublishOpWithResult(en_System, op_TimeMachineStateChange, System_TimeMachineStateChange, nil, nil, true);
 end;//with Entities.Entities
end;

procedure TPrimWarningForm.MakeControls;
begin
 inherited;
 f_Viewer := TnscEditor.Create(Self);
 f_Viewer.Name := 'Viewer';
 f_Viewer.Parent := Self;
end;

//#UC START# *4979E5520222impl*
//#UC END# *4979E5520222impl*

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimWarning
 TtfwClassRef.Register(TPrimWarningForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.