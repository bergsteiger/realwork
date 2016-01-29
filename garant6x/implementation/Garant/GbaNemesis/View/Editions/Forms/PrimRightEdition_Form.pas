unit PrimRightEdition_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/PrimRightEdition_Form.pas"
// Начат: 27.07.2009 11:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Пользовательские сервисы::CompareEditions::View::Editions::PrimRightEdition
//
// Текущая редакция
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
  nevTools,
  eeInterfaces,
  evSubWaiter
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  EditionsInterfaces,
  Base_Operations_Editions_Controls,
  CompareEditions_Controls,
  l3StringIDEx,
  bsTypesNew,
  DiffOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimRightEdition_utRightEdition_UserType,
  l3Variant
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  l3Tree_TLB,
  DocumentUnit,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsInitialParaWaiter = class(TevSubWaiter)
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=259163500
похож на http://mdp.garant.ru/pages/viewpage.action?pageId=217679169
по-хорошему - надо бы отрефакторить }
 private
 // private fields
   f_Para : IeeLeafPara;
   f_Form : TDiffOptionsForm;
   f_Position : TbsDocPos;
 protected
 // overridden protected methods
   function TrySelectPara(const aContainer: InevDocumentContainer;
   const aSel: InevSelection;
   aParaID: Integer): Boolean; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(aForm: TDiffOptionsForm;
     const aPara: IeeLeafPara); reintroduce; overload; 
   class function Make(aForm: TDiffOptionsForm;
     const aPara: IeeLeafPara): InevWaiter; reintroduce; overload; 
     {* Сигнатура фабрики TnsInitialParaWaiter.Make }
   constructor Create(aForm: TDiffOptionsForm;
     const aPosition: TbsDocPos); overload; 
   class function Make(aForm: TDiffOptionsForm;
     const aPosition: TbsDocPos): InevWaiter; reintroduce; overload; 
     {* Сигнатура фабрики TnsInitialParaWaiter.Make$1 }
 end;//TnsInitialParaWaiter

 TPrimRightEditionForm = {abstract form} class(TDiffOptionsForm)
  {* Текущая редакция }
 private
 // private fields
   ViewArea : IdsRightEdition;
   f_ParaForPositioning : IeePara;
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   procedure RightEdition_ReturnToDocument_Execute;
     {* Вернуться в текст документа }
   procedure RightEdition_ReturnToDocument(const aParams: IvcmExecuteParams);
     {* Вернуться в текст документа }
   procedure Document_GetParaForPositionning_Test(const aParams: IvcmTestParamsPrim);
   function Document_GetParaForPositionning_Execute: IeeLeafPara;
   procedure Document_GetParaForPositionning(const aParams: IvcmExecuteParams);
   function EditionsChooseRoot: Il3Node; override;
   procedure DoEditionChanged(anEditionID: TRedactionID); override;
   procedure RightEdition_SetFocusToText_Execute;
     {* Устанавливает фокус тексту }
   procedure RightEdition_SetFocusToText(const aParams: IvcmExecuteParams);
     {* Устанавливает фокус тексту }
   function RightEdition_IsCurrentPara_Execute(aPara: Integer): Boolean;
     {* Является ли параграф текущим }
   procedure RightEdition_IsCurrentPara(const aParams: IvcmExecuteParams);
     {* Является ли параграф текущим }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   procedure LinkWaiter(const aMade: InevDocumentContainer); override;
     {* Прикрепить Waiter'а к контейнеру документа }
   procedure SignalEditionChanged; override;
     {* Сообщение о смене редакции }
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure BecomeVisible; override;
    {$IfEnd} //not NoVCM
 public
 // overridden public methods
   {$If not defined(NoVCM)}
   function NeedSetMyFocus: Boolean; override;
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function GetIsMainObjectForm: Boolean; override;
    {$IfEnd} //not NoVCM
 end;//TPrimRightEditionForm

 TvcmEntityFormRef = TPrimRightEditionForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Block_Const,
  k2Tags,
  evdTypes,
  Document_Const
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  evSubImplementation,
  SysUtils,
  l3String
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsTypes,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  DataAdapter,
  Base_Operations_View_Controls,
  DocumentRes,
  vtUtils,
  evdStyles,
  BitmapPara_Const,
  BaseSearchInterfaces,
  l3Base,
  l3InterfacesMisc,
  nsBaseSearchService,
  vcmBase {a},
  evdBlockNameAdder,
  nsDocumentTools,
  Windows,
  PresentationInterfaces,
  nsExternalObjectPrim,
  bsUtils,
  l3Stream,
  l3Types,
  nsToMSWordOp,
  nsTrialSupport,
  FoldersDomainInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  Printers,
  nsExportToFileEvent,
  nsExportToWordEvent,
  nsSendDocumentByEMailEvent,
  nsDocumentPrintPreviewEvent,
  nsBaseTextOperationsConst,
  f1MultilinkResolver,
  l3Interfaces,
  evTypes,
  afwFacade,
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nsConst,
  nsQuestions,
  nsExternalObjectModelPart,
  bsDocumentContextSearcher,
  nsSearchInDocumentEvent,
  BaseTypesUnit,
  nsSearchInDocumentDoneEvent,
  nsSearchInDocumentNextEvent,
  nsSearchInDocumentPrevEvent,
  nsSearchWindowManager,
  Base_Operations_Strange_Controls,
  Common_FormDefinitions_Controls,
  evOp
  {$If defined(Nemesis)}
  ,
  f1TextStyle_Const
  {$IfEnd} //Nemesis
  ,
  TextSegment_Const,
  StyledLeafPara_Const,
  evCustomEditorWindow
  {$If defined(k2ForEditor)}
  ,
  evSegLst
  {$IfEnd} //k2ForEditor
  ,
  nevNavigation,
  evCustomEditor,
  evEditorWithOperations
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utRightEditionLocalConstants }
  str_utRightEditionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRightEditionCaption'; rValue : 'Текущая редакция');
   { Заголовок пользовательского типа "Текущая редакция" }

// start class TnsInitialParaWaiter

constructor TnsInitialParaWaiter.Create(aForm: TDiffOptionsForm;
  const aPara: IeeLeafPara);
//#UC START# *4D91D9A70258_4D91D8EB00AD_var*
//#UC END# *4D91D9A70258_4D91D8EB00AD_var*
begin
//#UC START# *4D91D9A70258_4D91D8EB00AD_impl*
 inherited Create(aForm.Text, aPara.ID, ev_sbtPara);
 f_Para := aPara;
 f_Form := aForm;
//#UC END# *4D91D9A70258_4D91D8EB00AD_impl*
end;//TnsInitialParaWaiter.Create

class function TnsInitialParaWaiter.Make(aForm: TDiffOptionsForm;
  const aPara: IeeLeafPara): InevWaiter;
var
 l_Inst : TnsInitialParaWaiter;
begin
 l_Inst := Create(aForm, aPara);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TnsInitialParaWaiter.Create(aForm: TDiffOptionsForm;
  const aPosition: TbsDocPos);
//#UC START# *5215B94503C0_4D91D8EB00AD_var*
//#UC END# *5215B94503C0_4D91D8EB00AD_var*
begin
//#UC START# *5215B94503C0_4D91D8EB00AD_impl*
 inherited Create(aForm.Text, aPosition.rPos, DocPosTypeToEdtSubType(aPosition.rRefType));
 f_Para := nil;
 f_Position := aPosition;
//#UC END# *5215B94503C0_4D91D8EB00AD_impl*
end;//TnsInitialParaWaiter.Create

class function TnsInitialParaWaiter.Make(aForm: TDiffOptionsForm;
  const aPosition: TbsDocPos): InevWaiter;
var
 l_Inst : TnsInitialParaWaiter;
begin
 l_Inst := Create(aForm, aPosition);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsInitialParaWaiter.TrySelectPara(const aContainer: InevDocumentContainer;
  const aSel: InevSelection;
  aParaID: Integer): Boolean;
//#UC START# *4BFFA0FF01D2_4D91D8EB00AD_var*
var
 l_Para  : InevPara;
 l_Block : Tl3Variant;
 l_Doc   : Tl3Variant;
 l_Part  : IevDocumentPart;
//#UC END# *4BFFA0FF01D2_4D91D8EB00AD_var*
begin
//#UC START# *4BFFA0FF01D2_4D91D8EB00AD_impl*
 Result := inherited TrySelectPara(aContainer, aSel, aParaID);
 if not Result then
 begin
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=217157085
  if (f_Para <> nil) then
  begin
   Result := true;
   // - будем оптимистами
   if f_Form.GotoSub(f_Para) then
    Exit;
   if (f_Para <> nil) then
    begin
     if f_Para.AsObject.QT(InevPara, l_Para) then
      try
       if evInPara(l_Para.AsObject, k2_typBlock, l_Block) AND
          (l_Block.IntA[k2_tiLayerID] = Ord(ev_sbtSub)) then
       begin
        if evInPara(l_Block.AsObject, k2_typDocument, l_Doc) then
        begin
         l_Part := TevDocumentPartImplementation.Make(l_Doc,
                                                      nil,
                                                      l_Block.IntA[k2_tiHandle],
                                                      l_Block.IntA[k2_tiLayerID]);
         try
          if f_Form.GotoBlock(l_Part) then
           Exit;
         finally
          l_Part := nil;
         end;//try..finally
        end;//evInPara(l_Block, k2_typDocument, l_Doc)
       end;//evInPara(l_Para, k2_typBlock, l_Block)
      finally
       l_Para := nil;
      end;//try..finally
    end;//f_Para <> nil
   Result := false;
  end;//f_Para <> nil
 end;//not Result
//#UC END# *4BFFA0FF01D2_4D91D8EB00AD_impl*
end;//TnsInitialParaWaiter.TrySelectPara

procedure TnsInitialParaWaiter.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Para := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsInitialParaWaiter.ClearFields

procedure TPrimRightEditionForm.RightEdition_ReturnToDocument_Execute;
//#UC START# *4B1E3833024A_4A6D5ABE020Aexec_var*
//#UC END# *4B1E3833024A_4A6D5ABE020Aexec_var*
begin
//#UC START# *4B1E3833024A_4A6D5ABE020Aexec_impl*
 ReturnToDocument;
//#UC END# *4B1E3833024A_4A6D5ABE020Aexec_impl*
end;//TPrimRightEditionForm.RightEdition_ReturnToDocument_Execute

procedure TPrimRightEditionForm.RightEdition_ReturnToDocument(const aParams: IvcmExecuteParams);
begin
 RightEdition_ReturnToDocument_Execute;
end;

procedure TPrimRightEditionForm.Document_GetParaForPositionning_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4B506F4D0196_4A6D5ABE020Atest_var*
//#UC END# *4B506F4D0196_4A6D5ABE020Atest_var*
begin
//#UC START# *4B506F4D0196_4A6D5ABE020Atest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := true;
//#UC END# *4B506F4D0196_4A6D5ABE020Atest_impl*
end;//TPrimRightEditionForm.Document_GetParaForPositionning_Test

function TPrimRightEditionForm.Document_GetParaForPositionning_Execute: IeeLeafPara;
//#UC START# *4B506F4D0196_4A6D5ABE020Aexec_var*
//#UC END# *4B506F4D0196_4A6D5ABE020Aexec_var*
begin
//#UC START# *4B506F4D0196_4A6D5ABE020Aexec_impl*
 Result := GetParaForPositionning;
//#UC END# *4B506F4D0196_4A6D5ABE020Aexec_impl*
end;//TPrimRightEditionForm.Document_GetParaForPositionning_Execute

procedure TPrimRightEditionForm.Document_GetParaForPositionning(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IDocument_GetParaForPositionning_Params) do
  ResultValue := Document_GetParaForPositionning_Execute;
end;

function TPrimRightEditionForm.EditionsChooseRoot: Il3Node;
//#UC START# *4B55ADAD0005_4A6D5ABE020A_var*
//#UC END# *4B55ADAD0005_4A6D5ABE020A_var*
begin
//#UC START# *4B55ADAD0005_4A6D5ABE020A_impl*
 if (ViewArea <> nil) then
  Result := ViewArea.NextEditions
 else
  Result := nil;
//#UC END# *4B55ADAD0005_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.EditionsChooseRoot

procedure TPrimRightEditionForm.DoEditionChanged(anEditionID: TRedactionID);
//#UC START# *4B55BB7F0172_4A6D5ABE020A_var*
var
 l_Doc       : IDocument;
 l_NewDoc    : IDocument;
 l_PrevState : IDocumentState;
 l_State     : IDocumentState;
//#UC END# *4B55BB7F0172_4A6D5ABE020A_var*
begin
//#UC START# *4B55BB7F0172_4A6D5ABE020A_impl*
 l_Doc := EditionDiff.Document;
 Assert(l_Doc <> nil);
 l_Doc.GetCurrentState(l_PrevState);
 l_PrevState.Clone(l_State);
 l_State.SetRedactionOnId(anEditionID);
 l_Doc.CreateView(l_State, l_NewDoc);
 if (l_NewDoc = nil) then
  // - документ не поменялся
  Exit;
 Assert(l_NewDoc <> nil);
 if l_NewDoc.IsSameView(l_Doc) then
  Exit;
 Assert(not l_NewDoc.IsSameView(l_Doc));
 SetFocusToText;
 TdmStdRes.MakeCompareEditions(l_NewDoc, GetParaForPositionning, CompareEditions.EditionForCompare, EditionDiff.DocumentForReturn);
//#UC END# *4B55BB7F0172_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.DoEditionChanged

procedure TPrimRightEditionForm.RightEdition_SetFocusToText_Execute;
//#UC START# *4B69B5A802C2_4A6D5ABE020Aexec_var*
//#UC END# *4B69B5A802C2_4A6D5ABE020Aexec_var*
begin
//#UC START# *4B69B5A802C2_4A6D5ABE020Aexec_impl*
 SetFocusToText;
//#UC END# *4B69B5A802C2_4A6D5ABE020Aexec_impl*
end;//TPrimRightEditionForm.RightEdition_SetFocusToText_Execute

procedure TPrimRightEditionForm.RightEdition_SetFocusToText(const aParams: IvcmExecuteParams);
begin
 RightEdition_SetFocusToText_Execute;
end;

function TPrimRightEditionForm.RightEdition_IsCurrentPara_Execute(aPara: Integer): Boolean;
//#UC START# *4B6AF2A502AE_4A6D5ABE020Aexec_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4B6AF2A502AE_4A6D5ABE020Aexec_var*
begin
//#UC START# *4B6AF2A502AE_4A6D5ABE020Aexec_impl*
 Result := IsParaCurrent(aPara);
 if Result then
  if not Text.ForceDrawFocusRect then
  begin
   Text.ForceDrawFocusRect := true;
   if Container.HasForm(vcm_ztChild, false, @l_Form) then
    Op_Finder_DisableForceDrawFocusRect.Call(l_Form);
  end;//not Text.ForceDrawFocusRect
//#UC END# *4B6AF2A502AE_4A6D5ABE020Aexec_impl*
end;//TPrimRightEditionForm.RightEdition_IsCurrentPara_Execute

procedure TPrimRightEditionForm.RightEdition_IsCurrentPara(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IRightEdition_IsCurrentPara_Params) do
  ResultValue := RightEdition_IsCurrentPara_Execute(Para);
end;

procedure TPrimRightEditionForm.Cleanup;
//#UC START# *479731C50290_4A6D5ABE020A_var*
//#UC END# *479731C50290_4A6D5ABE020A_var*
begin
//#UC START# *479731C50290_4A6D5ABE020A_impl*
 f_ParaForPositioning := nil;
 inherited;
//#UC END# *479731C50290_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.Cleanup

{$If not defined(NoVCM)}
procedure TPrimRightEditionForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_4A6D5ABE020A_var*
//#UC END# *497469C90140_4A6D5ABE020A_var*
begin
//#UC START# *497469C90140_4A6D5ABE020A_impl*
 inherited;
 //pnCaption.CCaption := l3Cat('  ', Self.CCaption);
//#UC END# *497469C90140_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

procedure TPrimRightEditionForm.LinkWaiter(const aMade: InevDocumentContainer);
//#UC START# *4A85585102D2_4A6D5ABE020A_var*
//#UC END# *4A85585102D2_4A6D5ABE020A_var*
begin
//#UC START# *4A85585102D2_4A6D5ABE020A_impl*
 if (f_ParaForPositioning <> nil) then
 begin
  // - здесь синхронизируемся с собственным состоянием ДО переключения редакций
  aMade.LinkWaiter(TevSubWaiter.Make(Text, f_ParaForPositioning.ID, ev_sbtPara));
  f_ParaForPositioning := nil;
 end//f_ParaForPositioning <> nil
 else
 begin
  if (EditionDiff.RedactionCurrentPara <> nil) then
   aMade.LinkWaiter(TnsInitialParaWaiter.Make(Self, EditionDiff.RedactionCurrentPara))
  else
  begin
   // http://mdp.garant.ru/pages/viewpage.action?pageId=476379343
   aMade.LinkWaiter(TnsInitialParaWaiter.Make(Self, GetInitialDocumentPosition));
   f_WasInitedByDocPos := True;
   (*inherited;*)
  end;
 end;
//#UC END# *4A85585102D2_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.LinkWaiter

procedure TPrimRightEditionForm.SignalEditionChanged;
//#UC START# *4A8559B0013B_4A6D5ABE020A_var*
//#UC END# *4A8559B0013B_4A6D5ABE020A_var*
begin
//#UC START# *4A8559B0013B_4A6D5ABE020A_impl*
 if TextSource.HasDocument then
 // - защита от повторного входа в нотификацию
  f_ParaForPositioning := GetParaForPositionning;
 inherited;
//#UC END# *4A8559B0013B_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.SignalEditionChanged

{$If not defined(NoVCM)}
procedure TPrimRightEditionForm.InitControls;
//#UC START# *4A8E8F2E0195_4A6D5ABE020A_var*
//#UC END# *4A8E8F2E0195_4A6D5ABE020A_var*
begin
//#UC START# *4A8E8F2E0195_4A6D5ABE020A_impl*
 Self.ActiveControl := Text; 
 inherited;
 pnCaption.FixW2kWMSize := True;
//#UC END# *4A8E8F2E0195_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimRightEditionForm.NeedSetMyFocus: Boolean;
//#UC START# *4B4F13E80365_4A6D5ABE020A_var*
//#UC END# *4B4F13E80365_4A6D5ABE020A_var*
begin
//#UC START# *4B4F13E80365_4A6D5ABE020A_impl*
 Result := true;
//#UC END# *4B4F13E80365_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.NeedSetMyFocus
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimRightEditionForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4A6D5ABE020A_var*
//#UC END# *4F7C65380244_4A6D5ABE020A_var*
begin
//#UC START# *4F7C65380244_4A6D5ABE020A_impl*
 inherited;
 SetFocusToText;
//#UC END# *4F7C65380244_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.FormInsertedIntoContainer
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimRightEditionForm.BecomeVisible;
//#UC START# *4F7C808A0349_4A6D5ABE020A_var*
//#UC END# *4F7C808A0349_4A6D5ABE020A_var*
begin
//#UC START# *4F7C808A0349_4A6D5ABE020A_impl*
 inherited;
 SetFocusToText;
//#UC END# *4F7C808A0349_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.BecomeVisible
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimRightEditionForm.GetIsMainObjectForm: Boolean;
//#UC START# *501174B10018_4A6D5ABE020A_var*
//#UC END# *501174B10018_4A6D5ABE020A_var*
begin
//#UC START# *501174B10018_4A6D5ABE020A_impl*
 Result := true;
//#UC END# *501174B10018_4A6D5ABE020A_impl*
end;//TPrimRightEditionForm.GetIsMainObjectForm
{$IfEnd} //not NoVCM

procedure TPrimRightEditionForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  ViewArea := nil;
 end//aDsNew = nil
 else
 begin
  ViewArea := aDsNew As IdsRightEdition;
 end;//aDsNew = nil
end;

procedure TPrimRightEditionForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_RightEdition, nil);
  PublishFormEntity(en_Document, nil);
  PublishOpWithResult(en_RightEdition, op_ReturnToDocument, RightEdition_ReturnToDocument, nil, nil);
  PublishOpWithResult(en_Document, op_GetParaForPositionning, Document_GetParaForPositionning, Document_GetParaForPositionning_Test, nil);
  PublishOpWithResult(en_RightEdition, op_SetFocusToText, RightEdition_SetFocusToText, nil, nil);
  PublishOpWithResult(en_RightEdition, op_IsCurrentPara, RightEdition_IsCurrentPara, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimRightEditionForm.MakeControls;
begin
 inherited;
 with AddUsertype(utRightEditionName,
  str_utRightEditionCaption,
  str_utRightEditionCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utRightEditionName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utRightEditionCaption
 str_utRightEditionCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimRightEdition
 TtfwClassRef.Register(TPrimRightEditionForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.