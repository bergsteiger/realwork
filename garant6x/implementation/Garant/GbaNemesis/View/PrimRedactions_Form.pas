unit PrimRedactions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimRedactions_Form.pas"
// Начат: 23.01.2009 21:55
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Redactions::PrimRedactions
//
// Редакции документа
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
  DocumentUnit,
  l3Interfaces,
  l3TreeInterfaces,
  l3Core,
  Graphics
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  DocumentAndListInterfaces,
  eeTreeView,
  Document_Strange_Controls,
  Base_Operations_Editions_Controls,
  eeTreeViewExport
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  nsLogEvent,
  vtLister,
  nscTreeViewWithAdapterDragDrop,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  vcmControllers {a}
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  eeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  RedactionsUserTypes_utRedaction_UserType
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsViewDocumentEditionListEvent = class(TnsLogEvent)
 private
 // private methods
   class procedure Log(const aDoc: IDocument); virtual;
 end;//TnsViewDocumentEditionListEvent

 _BaseDocumentForDocumentModule_Parent_ = TvcmEntityForm;
 {$Include ..\View\BaseDocumentForDocumentModule.imp.pas}
 _PageControlNotification_Parent_ = _BaseDocumentForDocumentModule_;
 {$Include ..\View\PageControlNotification.imp.pas}
 _WorkWithRedactions_Parent_ = _PageControlNotification_;
 {$Include ..\View\WorkWithRedactions.imp.pas}
 _RedactionsUserTypes_Parent_ = _WorkWithRedactions_;
 {$Include ..\View\RedactionsUserTypes.imp.pas}
 TPrimRedactionsForm = {form} class(_RedactionsUserTypes_)
  {* Редакции документа }
 private
 // private fields
   f_LocalPositioning : Integer;
   f_RedactionTree : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства RedactionTree}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure RedactionTreeLMouseDown(Sender: TObject;
     Button: TMouseButton;
     Shift: TShiftState;
     X: Integer;
     Y: Integer);
   function RedactionTreeGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
   procedure RedactionTreeCurrentChanged(aSender: TObject;
     aNewCurrent: Integer;
     aOldCurrent: Integer);
     {* событие для обработки изменения текущего элемента }
   procedure RedactionTreeMakeTreeSource(out theTree: Il3SimpleTree);
   procedure RedactionTreeBeforeWake(aSender: TObject);
   procedure RedactionTreeAfterWake(Sender: TObject;
     aWakeResult: Boolean);
   procedure RedactionTreeFormatStatusInfo(aSender: TObject;
     var Info: Il3CString;
     aCurrent: Integer;
     aCount: Integer;
     aSelected: Integer);
   procedure RedactionTreeSelectCountChanged(aSender: TObject;
     anOldCount: Integer;
     aNewCount: Integer);
   function ReadyForCompare: Boolean;
   function GetDocumentsForCompare(out aLeft: IDocument;
     out aRight: IDocument): Boolean;
   function RedactionTreeToggleSelection(aSender: TObject;
     anIndex: Integer): Boolean;
   procedure DoGetItemStyle(Sender: TObject;
     aItemIndex: Integer;
     const aFont: Il3Font;
     var aTextBackColor: TColor;
     var aItemBackColor: TColor;
     var aVJustify: TvtVJustify);
   procedure DoGetItemImageVertOffset(Sender: TObject;
     aItemIndex: Integer;
     var theImageVertOffset: Integer);
 protected
 // property methods
   function pm_GetDocument: IDocument;
 protected
 // realized methods
   procedure DoTabActivate; override;
     {* Реакция на переключение вкладки }
   function RedactionCurrentPara: IeeLeafPara; override;
     {* Текущий параграф редакции для синхронизации с окном сравннения редакций }
   function CanBeChanged: Boolean; override;
     {* Может ли документ быть изменён }
   procedure Editions_SetCurrent_Execute(const aDocument: IDocument);
     {* Установить текущую }
   procedure Editions_SetCurrent(const aParams: IvcmExecuteParams);
     {* Установить текущую }
   procedure Editions_DoCompareEditions_Test(const aParams: IvcmTestParamsPrim);
     {* Сравнить редакции }
   procedure Editions_DoCompareEditions_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Сравнить редакции }
   procedure Editions_BuildChangedFragments_Test(const aParams: IvcmTestParamsPrim);
     {* Построить обзор изменений }
   procedure Editions_BuildChangedFragments_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Построить обзор изменений }
   procedure UtRedactionQueryClose(aSender: TObject); override;
     {* Обработчик события utRedaction.OnQueryClose }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} //not NoVCL
   function CaneHaveDocumentCompareEditionsOperation: Boolean; override;
 protected
 // protected fields
   dsEditions : IdsEditions;
 protected
 // protected methods
   procedure SetCurentEdition;
   procedure StartLocalPositionning;
   procedure FinishLocalPositionning;
   function IsLocalPositionning: Boolean;
 protected
 // protected properties
   property Document: IDocument
     read pm_GetDocument;
     {* Документ, соответствующий текущей редакции }
 public
 // public properties
   property RedactionTree: TnscTreeViewWithAdapterDragDrop
     read f_RedactionTree;
 end;//TPrimRedactionsForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces,
  Types
  {$If defined(Nemesis)}
  ,
  eeTreeMisc
  {$IfEnd} //Nemesis
  ,
  nsEditionsUtils,
  nsEditionTree,
  NodeGroup_Const
  {$If defined(k2ForEditor)}
  ,
  evDocumentPart
  {$IfEnd} //k2ForEditor
  ,
  l3ScreenIC,
  l3Units,
  nsEditionNodes,
  Base_Operations_Strange_Controls,
  nsConst,
  l3ControlsTypes,
  l3Base,
  l3Nodes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Common_Strange_Controls,
  afwFacade,
  l3Variant,
  Windows
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  SysUtils {a},
  nsManagers
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  UnderControlUnit,
  l3MessageID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TPrimRedactionsForm;

{$Include ..\View\BaseDocumentForDocumentModule.imp.pas}

{$Include ..\View\PageControlNotification.imp.pas}


{$Include ..\View\WorkWithRedactions.imp.pas}

{$Include ..\View\RedactionsUserTypes.imp.pas}

// start class TPrimRedactionsForm

procedure TPrimRedactionsForm.RedactionTreeLMouseDown(Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X: Integer;
  Y: Integer);
//#UC START# *4EC3B6680086_497A12850078_var*
var
 l_Index    : Integer;
 l_ItemPart : Byte;
 l_Node     : Il3SimpleNode;
 l_ENode    : InsEditionNode;
//#UC END# *4EC3B6680086_497A12850078_var*
begin
//#UC START# *4EC3B6680086_497A12850078_impl*
 RedactionTree.HitTest(Point(X, Y), l_Index, l_ItemPart);
 if  (l_ItemPart = ihtIcon) then
 begin
  l_Node := RedactionTree.GetNode(l_Index);
  try
   if Supports(l_Node, InsEditionNode, l_ENode) then
    try
     l_ENode.ChangeCheckTypeViaClick(RedactionTree.TreeStruct);
    finally
     l_ENode := nil;
    end;//try..finally
  finally
   l_Node := nil;
  end;//try..finally
 end;//l_ItemPart = ihtIcon
//#UC END# *4EC3B6680086_497A12850078_impl*
end;//TPrimRedactionsForm.RedactionTreeLMouseDown

function TPrimRedactionsForm.RedactionTreeGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *4EC3D92302F3_497A12850078_var*
//#UC END# *4EC3D92302F3_497A12850078_var*
begin
//#UC START# *4EC3D92302F3_497A12850078_impl*
 if (Index >= 0) then
  Result := NsCalcEditionImageIndex(RedactionTree.GetNode(Index), aImages, true)
 else
  Result := -1;
//#UC END# *4EC3D92302F3_497A12850078_impl*
end;//TPrimRedactionsForm.RedactionTreeGetItemImage

procedure TPrimRedactionsForm.RedactionTreeCurrentChanged(aSender: TObject;
  aNewCurrent: Integer;
  aOldCurrent: Integer);
//#UC START# *4EC3D9E50143_497A12850078_var*
var
 l_CurNode : Il3SimpleNode;
//#UC END# *4EC3D9E50143_497A12850078_var*
begin
//#UC START# *4EC3D9E50143_497A12850078_impl*
 if not IsLocalPositionning and (aNewCurrent <> -1) then
 begin
  l_CurNode := RedactionTree.GetNode(aNewCurrent);
  try
   if (l_CurNode <> nil) then
    Op_Redactions_RedactionOnID.Call(Aggregate, (l_CurNode as InsEditionNode).EditionID);
  finally
   l_CurNode := nil;
  end;//try..finally
 end;//not IsLocalPositionning and (NewCurrent <> -1)
 if not IsModalForm then
  UpdateStatusInfo;
//#UC END# *4EC3D9E50143_497A12850078_impl*
end;//TPrimRedactionsForm.RedactionTreeCurrentChanged

procedure TPrimRedactionsForm.RedactionTreeMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *4EC3DA48035A_497A12850078_var*
//#UC END# *4EC3DA48035A_497A12850078_var*
begin
//#UC START# *4EC3DA48035A_497A12850078_impl*
 theTree := TnsEditionTree.Make;
//#UC END# *4EC3DA48035A_497A12850078_impl*
end;//TPrimRedactionsForm.RedactionTreeMakeTreeSource

procedure TPrimRedactionsForm.RedactionTreeBeforeWake(aSender: TObject);
//#UC START# *4EC3DAB000EF_497A12850078_var*
//#UC END# *4EC3DAB000EF_497A12850078_var*
begin
//#UC START# *4EC3DAB000EF_497A12850078_impl*
 StartLocalPositionning;
//#UC END# *4EC3DAB000EF_497A12850078_impl*
end;//TPrimRedactionsForm.RedactionTreeBeforeWake

procedure TPrimRedactionsForm.RedactionTreeAfterWake(Sender: TObject;
  aWakeResult: Boolean);
//#UC START# *4EC3DAD30269_497A12850078_var*
//#UC END# *4EC3DAD30269_497A12850078_var*
begin
//#UC START# *4EC3DAD30269_497A12850078_impl*
 if aWakeResult then
  SetCurentEdition;
  
 FinishLocalPositionning;
//#UC END# *4EC3DAD30269_497A12850078_impl*
end;//TPrimRedactionsForm.RedactionTreeAfterWake

procedure TPrimRedactionsForm.RedactionTreeFormatStatusInfo(aSender: TObject;
  var Info: Il3CString;
  aCurrent: Integer;
  aCount: Integer;
  aSelected: Integer);
//#UC START# *4EC3DB680251_497A12850078_var*
//#UC END# *4EC3DB680251_497A12850078_var*
begin
//#UC START# *4EC3DB680251_497A12850078_impl*
 //Info := vcmFmt(str_EditionsStatusInfoFormat, [aCurrent, aCount]);
 Info := nil;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=310675841
 // http://mdp.garant.ru/pages/viewpage.action?pageId=310675841&focusedCommentId=336661788#comment-336661788
//#UC END# *4EC3DB680251_497A12850078_impl*
end;//TPrimRedactionsForm.RedactionTreeFormatStatusInfo

procedure TPrimRedactionsForm.RedactionTreeSelectCountChanged(aSender: TObject;
  anOldCount: Integer;
  aNewCount: Integer);
//#UC START# *4EC3DC35019A_497A12850078_var*
//#UC END# *4EC3DC35019A_497A12850078_var*
begin
//#UC START# *4EC3DC35019A_497A12850078_impl*
 if not IsModalForm then
  UpdateStatusInfo;
//#UC END# *4EC3DC35019A_497A12850078_impl*
end;//TPrimRedactionsForm.RedactionTreeSelectCountChanged

function TPrimRedactionsForm.ReadyForCompare: Boolean;
//#UC START# *4EC4D3B0024F_497A12850078_var*
var
 l_Node : InsEditionNode;
//#UC END# *4EC4D3B0024F_497A12850078_var*
begin
//#UC START# *4EC4D3B0024F_497A12850078_impl*
 Result := false;
 if Supports(RedactionTree.GetCurrentNode, InsEditionNode, l_Node) then
  try
   Result := l_Node.ReadyForCompare(RedactionTree.TreeStruct);
  finally
   l_Node := nil;
  end;//try..finally
//#UC END# *4EC4D3B0024F_497A12850078_impl*
end;//TPrimRedactionsForm.ReadyForCompare

function TPrimRedactionsForm.GetDocumentsForCompare(out aLeft: IDocument;
  out aRight: IDocument): Boolean;
//#UC START# *4EC4F4B20346_497A12850078_var*
var
 l_Node : InsEditionNode;
//#UC END# *4EC4F4B20346_497A12850078_var*
begin
//#UC START# *4EC4F4B20346_497A12850078_impl*
 Result := false;
 if Supports(RedactionTree.GetCurrentNode, InsEditionNode, l_Node) then
  try
   l_Node.GetDocumentsForCompare(RedactionTree.TreeStruct, aLeft, aRight);
   Result := (aLeft <> nil) AND (aRight <> nil);
  finally
   l_Node := nil;
  end;//try..finally
//#UC END# *4EC4F4B20346_497A12850078_impl*
end;//TPrimRedactionsForm.GetDocumentsForCompare

function TPrimRedactionsForm.RedactionTreeToggleSelection(aSender: TObject;
  anIndex: Integer): Boolean;
//#UC START# *4EC502E20378_497A12850078_var*
var
 l_Node  : Il3SimpleNode;
 l_ENode : InsEditionNode;
//#UC END# *4EC502E20378_497A12850078_var*
begin
//#UC START# *4EC502E20378_497A12850078_impl*
 Result := false;
 l_Node := RedactionTree.GetNode(anIndex);
 try
  if Supports(l_Node, InsEditionNode, l_ENode) then
   try
    l_ENode.ChangeCheckTypeViaClick(RedactionTree.TreeStruct);
   finally
    l_ENode := nil;
   end;//try..finally
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *4EC502E20378_497A12850078_impl*
end;//TPrimRedactionsForm.RedactionTreeToggleSelection

procedure TPrimRedactionsForm.DoGetItemStyle(Sender: TObject;
  aItemIndex: Integer;
  const aFont: Il3Font;
  var aTextBackColor: TColor;
  var aItemBackColor: TColor;
  var aVJustify: TvtVJustify);
//#UC START# *4ED4D56603CA_497A12850078_var*
//#UC END# *4ED4D56603CA_497A12850078_var*
begin
//#UC START# *4ED4D56603CA_497A12850078_impl*
 //aVJustify := vt_vjBottom;
 // - выравниваем иконку вниз
//#UC END# *4ED4D56603CA_497A12850078_impl*
end;//TPrimRedactionsForm.DoGetItemStyle

procedure TPrimRedactionsForm.DoGetItemImageVertOffset(Sender: TObject;
  aItemIndex: Integer;
  var theImageVertOffset: Integer);
//#UC START# *4ED613000183_497A12850078_var*
var
 l_Tag : Il3TagRef;
//#UC END# *4ED613000183_497A12850078_var*
begin
//#UC START# *4ED613000183_497A12850078_impl*
 if Supports(RedactionTree.GetNode(aItemIndex), Il3TagRef, l_Tag) then
  try
   if l_Tag.AsObject.IsKindOf(k2_typNodeGroup) then
    theImageVertOffset := l3CrtIC.LP2DP(l3PointY(evDocumentPartMargin * 2 + evDocumentPartMargin div 2)).Y + 3{2};
    // - конечно надо тут брать из параграфа что-то типа Spacing,
    //   но туда - далеко пока тянуться, посему - пока костыль
    //theImageVertOffset := 20;
  finally
   l_Tag := nil;
  end;//try..finally
//#UC END# *4ED613000183_497A12850078_impl*
end;//TPrimRedactionsForm.DoGetItemImageVertOffset

procedure TPrimRedactionsForm.SetCurentEdition;
//#UC START# *4EC3C2FF00AC_497A12850078_var*

 function FindEditionOnID(aRedactionID: TRedactionID): Il3SimpleNode;

  function FindNode(const anIntf: Il3SimpleNode): Boolean;
  var
   l_EditionNode : InsEditionNode;
  begin//FindNode
   Result := Supports(anIntf, InsEditionNode, l_EditionNode) and
             l_EditionNode.IsSameID(aRedactionID);
   l_EditionNode := nil;
  end;//FindNode

 begin//FindEditionOnID
  Result := RedactionTree.TreeStruct.SimpleIterateF(l3L2SNA(@FindNode), imCheckResult);
 end;//FindEditionOnID

var
 l_State   : IDocumentState;
 l_PrevCurrent : Il3SimpleNode;
 l_CurNode : Il3SimpleNode;
 l_Info    : TRedactionInfo;
 l_ENode   : InsEditionNode;
//#UC END# *4EC3C2FF00AC_497A12850078_var*
begin
//#UC START# *4EC3C2FF00AC_497A12850078_impl*
 if (Document <> nil) then
 begin
  Document.GetCurrentState(l_State);
  try
   l3FillChar(l_Info, SizeOf(l_Info), 0);
   l_State.GetCurrentRedaction(l_Info);
   l_PrevCurrent := RedactionTree.GetCurrentNode;
   RedactionTree.Wake;
   // - иначе FindEditionOnID может и не отработать, т.к. дерево типа может "спать"
   //   и ничего не итерировать.
   // http://mdp.garant.ru/pages/viewpage.action?pageId=318374263&focusedCommentId=320738444&#comment-320738444
   // http://mdp.garant.ru/pages/viewpage.action?pageId=318374263
   l_CurNode := FindEditionOnID(l_Info.rId);
   if (l_CurNode <> nil) then
   begin
    StartLocalPositionning;
    try
     RedactionTree.GotoOnNode(l_CurNode);
     if Supports(l_CurNode, InsEditionNode, l_ENode) then
      try
       if not l_CurNode.IsSame(l_PrevCurrent) then
        l_ENode.TryMarkAsMain(RedactionTree.TreeStruct);
      finally
       l_ENode := nil;
      end;//try..finally
    finally
     FinishLocalPositionning;
    end;//try..finally
   end;//l_CurNode <> nil
  finally
   l_State := nil;
  end;//try..finally
 end;//Document <> nil
//#UC END# *4EC3C2FF00AC_497A12850078_impl*
end;//TPrimRedactionsForm.SetCurentEdition

procedure TPrimRedactionsForm.StartLocalPositionning;
//#UC START# *4EC3C50601B5_497A12850078_var*
//#UC END# *4EC3C50601B5_497A12850078_var*
begin
//#UC START# *4EC3C50601B5_497A12850078_impl*
 Inc(f_LocalPositioning);
//#UC END# *4EC3C50601B5_497A12850078_impl*
end;//TPrimRedactionsForm.StartLocalPositionning

procedure TPrimRedactionsForm.FinishLocalPositionning;
//#UC START# *4EC3C51F015E_497A12850078_var*
//#UC END# *4EC3C51F015E_497A12850078_var*
begin
//#UC START# *4EC3C51F015E_497A12850078_impl*
 if f_LocalPositioning > 0 then
  Dec(f_LocalPositioning)
 else
  Assert(False, 'Несбалансированны скобки локального позиционирования');
//#UC END# *4EC3C51F015E_497A12850078_impl*
end;//TPrimRedactionsForm.FinishLocalPositionning

function TPrimRedactionsForm.IsLocalPositionning: Boolean;
//#UC START# *4EC3D7BA0247_497A12850078_var*
//#UC END# *4EC3D7BA0247_497A12850078_var*
begin
//#UC START# *4EC3D7BA0247_497A12850078_impl*
 Result := f_LocalPositioning > 0;
//#UC END# *4EC3D7BA0247_497A12850078_impl*
end;//TPrimRedactionsForm.IsLocalPositionning
// start class TnsViewDocumentEditionListEvent

class procedure TnsViewDocumentEditionListEvent.Log(const aDoc: IDocument);
//#UC START# *4B0D11FB00CC_4B0D11B20334_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0D11FB00CC_4B0D11B20334_var*
begin
//#UC START# *4B0D11FB00CC_4B0D11B20334_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_VIEW_DOCUMENT_EDITION_LIST, l_Data);
//#UC END# *4B0D11FB00CC_4B0D11B20334_impl*
end;//TnsViewDocumentEditionListEvent.Log

function TPrimRedactionsForm.pm_GetDocument: IDocument;
//#UC START# *4A7B029201C0_497A12850078get_var*
//#UC END# *4A7B029201C0_497A12850078get_var*
begin
//#UC START# *4A7B029201C0_497A12850078get_impl*
 Supports(RedactionTree.TreeView.Tree.Root, IDocument, Result);
//#UC END# *4A7B029201C0_497A12850078get_impl*
end;//TPrimRedactionsForm.pm_GetDocument

procedure TPrimRedactionsForm.DoTabActivate;
//#UC START# *497F16AC015A_497A12850078_var*
//#UC END# *497F16AC015A_497A12850078_var*
begin
//#UC START# *497F16AC015A_497A12850078_impl*
 if (sdsBaseDocument <> nil) then
  TnsViewDocumentEditionListEvent.Log(sdsBaseDocument.DocInfo.Doc);
//#UC END# *497F16AC015A_497A12850078_impl*
end;//TPrimRedactionsForm.DoTabActivate

function TPrimRedactionsForm.RedactionCurrentPara: IeeLeafPara;
//#UC START# *4A7FCEA9025D_497A12850078_var*
//#UC END# *4A7FCEA9025D_497A12850078_var*
begin
//#UC START# *4A7FCEA9025D_497A12850078_impl*
 Result := Op_Document_GetParaForPositionning.Call(Aggregate);
//#UC END# *4A7FCEA9025D_497A12850078_impl*
end;//TPrimRedactionsForm.RedactionCurrentPara

function TPrimRedactionsForm.CanBeChanged: Boolean;
//#UC START# *4A8931130363_497A12850078_var*
//#UC END# *4A8931130363_497A12850078_var*
begin
//#UC START# *4A8931130363_497A12850078_impl*
 Result := false;
//#UC END# *4A8931130363_497A12850078_impl*
end;//TPrimRedactionsForm.CanBeChanged

procedure TPrimRedactionsForm.Editions_SetCurrent_Execute(const aDocument: IDocument);
//#UC START# *4A8EE08403B3_497A12850078exec_var*
var
 l_RootDocument: InsDocument;
//#UC END# *4A8EE08403B3_497A12850078exec_var*
begin
//#UC START# *4A8EE08403B3_497A12850078exec_impl*
 if Supports(RedactionTree.TreeView.Tree.Root, InsDocument, l_RootDocument) then
 begin
  l_RootDocument.Document := aDocument;
  SetCurentEdition;
 end;//Supports(RedactionTree.TreeView.Tree.Root, InsDocument, l_RootDocument)
//#UC END# *4A8EE08403B3_497A12850078exec_impl*
end;//TPrimRedactionsForm.Editions_SetCurrent_Execute

procedure TPrimRedactionsForm.Editions_SetCurrent(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IEditions_SetCurrent_Params) do
  Editions_SetCurrent_Execute(Document);
end;

procedure TPrimRedactionsForm.Editions_DoCompareEditions_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4EC4CDDB023C_497A12850078test_var*
//#UC END# *4EC4CDDB023C_497A12850078test_var*
begin
//#UC START# *4EC4CDDB023C_497A12850078test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Self.ReadyForCompare;
//#UC END# *4EC4CDDB023C_497A12850078test_impl*
end;//TPrimRedactionsForm.Editions_DoCompareEditions_Test

procedure TPrimRedactionsForm.Editions_DoCompareEditions_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4EC4CDDB023C_497A12850078exec_var*
var
 l_Left, l_Right : IDocument;
//#UC END# *4EC4CDDB023C_497A12850078exec_var*
begin
//#UC START# *4EC4CDDB023C_497A12850078exec_impl*
 if GetDocumentsForCompare(l_Left, l_Right) then
 begin
  if IsModalForm then
   ModalResult := mrCancel;
  TdmStdRes.MakeCompareEditions(l_Left, l_Right, RedactionCurrentPara);
 end;//GetDocumentsForCompare(l_Left, l_Right)
//#UC END# *4EC4CDDB023C_497A12850078exec_impl*
end;//TPrimRedactionsForm.Editions_DoCompareEditions_Execute

procedure TPrimRedactionsForm.Editions_BuildChangedFragments_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4EC4CE180122_497A12850078test_var*
//#UC END# *4EC4CE180122_497A12850078test_var*
begin
//#UC START# *4EC4CE180122_497A12850078test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Self.ReadyForCompare;
//#UC END# *4EC4CE180122_497A12850078test_impl*
end;//TPrimRedactionsForm.Editions_BuildChangedFragments_Test

procedure TPrimRedactionsForm.Editions_BuildChangedFragments_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4EC4CE180122_497A12850078exec_var*
var
 l_Left, l_Right : IDocument;
//#UC END# *4EC4CE180122_497A12850078exec_var*
begin
//#UC START# *4EC4CE180122_497A12850078exec_impl*
 if GetDocumentsForCompare(l_Left, l_Right) then
 begin
  if IsModalForm then
   ModalResult := mrCancel;
  TdmStdRes.ViewChangedFragments(l_Left, l_Right);
 end;//GetDocumentsForCompare(l_Left, l_Right)
//#UC END# *4EC4CE180122_497A12850078exec_impl*
end;//TPrimRedactionsForm.Editions_BuildChangedFragments_Execute

procedure TPrimRedactionsForm.UtRedactionQueryClose(aSender: TObject);
//#UC START# *E2975B7BD13F_497A12850078_var*
//#UC END# *E2975B7BD13F_497A12850078_var*
begin
//#UC START# *E2975B7BD13F_497A12850078_impl*
 afw.Settings.SaveBoolean(pi_Document_Sheets_Redactions, False);
 SafeClose;
//#UC END# *E2975B7BD13F_497A12850078_impl*
end;//TPrimRedactionsForm.UtRedactionQueryClose

{$If not defined(NoVCM)}
procedure TPrimRedactionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_497A12850078_var*
//#UC END# *497469C90140_497A12850078_var*
begin
//#UC START# *497469C90140_497A12850078_impl*
 inherited;
 if (dsEditions <> nil) then
 begin
  StartLocalPositionning;
  try
   RedactionTree.CTree.RootNode := dsEditions.GetEditionsRoot;
   SetCurentEdition;
  finally
   try
    Invalidate;
   finally
    FinishLocalPositionning;
   end;//try..finally
  end;//try..finally

  // http://mdp.garant.ru/pages/viewpage.action?pageId=328860502
  if IsModalForm and (Document <> nil) then
    TnsViewDocumentEditionListEvent.Log(Document);
 end;//dsEditions <> nil
 if RedactionTree.HandleAllocated then
  PostMessage(RedactionTree.Handle, msg_vtInvalidateNCArea, 0, 0);
//#UC END# *497469C90140_497A12850078_impl*
end;//TPrimRedactionsForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimRedactionsForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_497A12850078_var*
//#UC END# *49803F5503AA_497A12850078_var*
begin
//#UC START# *49803F5503AA_497A12850078_impl*
 inherited;
 if not IsModalForm then
  UpdateStatusInfo;
//#UC END# *49803F5503AA_497A12850078_impl*
end;//TPrimRedactionsForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimRedactionsForm.InitControls;
//#UC START# *4A8E8F2E0195_497A12850078_var*
//#UC END# *4A8E8F2E0195_497A12850078_var*
begin
//#UC START# *4A8E8F2E0195_497A12850078_impl*
 inherited;
 ActiveControl := RedactionTree;
(* RedactionTree.Left := 0;
 RedactionTree.Top := 0;
 RedactionTree.Width := 246;
 RedactionTree.Height := 444;*)
 RedactionTree.Align := alClient;
 RedactionTree.BorderStyle := bsNone;
 RedactionTree.TabOrder := 0;
 RedactionTree.MultiStrokeItem := True;
 RedactionTree.ActionElementMode := l3_amSingleClick;
 RedactionTree.ViewOptions := [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowLines, voShowOpenChip];
 RedactionTree.SettingId := 'stidRedactionTree';
 RedactionTree.NeedStatus := True;
 // begin http://mdp.garant.ru/pages/viewpage.action?pageId=232098711
 RedactionTree.SelfDrawNodes := true;
 RedactionTree.IsShowLines := false;
 RedactionTree.ShowOpenChip := false;
 RedactionTree.OnLMouseDown := Self.RedactionTreeLMouseDown;
 RedactionTree.OnGetItemStyle := Self.DoGetItemStyle;
 RedactionTree.ViewOptions := RedactionTree.ViewOptions + [voDoNotShowFocusRect];
 RedactionTree.OnGetItemImageVertOffset := Self.DoGetItemImageVertOffset;
 // end http://mdp.garant.ru/pages/viewpage.action?pageId=232098711
 RedactionTree.OnGetItemImage := Self.RedactionTreeGetItemImage;
 RedactionTree.OnCurrentChanged := Self.RedactionTreeCurrentChanged;
 RedactionTree.OnMakeTreeSource := Self.RedactionTreeMakeTreeSource;
 RedactionTree.OnBeforeWake := Self.RedactionTreeBeforeWake;
 RedactionTree.OnAfterWake := Self.RedactionTreeAfterWake;
 RedactionTree.OnSelectCountChanged := Self.RedactionTreeSelectCountChanged;
 RedactionTree.OnFormatStatusInfo := Self.RedactionTreeFormatStatusInfo;
 RedactionTree.OnToggleSelection := Self.RedactionTreeToggleSelection;
//#UC END# *4A8E8F2E0195_497A12850078_impl*
end;//TPrimRedactionsForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCL)}
procedure TPrimRedactionsForm.SetParent(AParent: TWinControl);
//#UC START# *4A97E78202FC_497A12850078_var*
//#UC END# *4A97E78202FC_497A12850078_var*
begin
//#UC START# *4A97E78202FC_497A12850078_impl*
 inherited;
 if (aParent <> nil) then
  if RedactionTree.HandleAllocated then
   PostMessage(RedactionTree.Handle, msg_vtInvalidateNCArea, 0, 0);
//#UC END# *4A97E78202FC_497A12850078_impl*
end;//TPrimRedactionsForm.SetParent
{$IfEnd} //not NoVCL

function TPrimRedactionsForm.CaneHaveDocumentCompareEditionsOperation: Boolean;
//#UC START# *4EF354C8018B_497A12850078_var*
//#UC END# *4EF354C8018B_497A12850078_var*
begin
//#UC START# *4EF354C8018B_497A12850078_impl*
 Result := not IsModalForm;
//#UC END# *4EF354C8018B_497A12850078_impl*
end;//TPrimRedactionsForm.CaneHaveDocumentCompareEditionsOperation

procedure TPrimRedactionsForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  dsEditions := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsEditions, dsEditions);
 end;//aDsNew = nil
end;

procedure TPrimRedactionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Editions, nil);
  PublishOpWithResult(en_Editions, op_SetCurrent, Editions_SetCurrent, nil, nil);
  PublishOp(en_Editions, op_DoCompareEditions, Editions_DoCompareEditions_Execute, Editions_DoCompareEditions_Test, nil);
  ShowInContextMenu(en_Editions, op_DoCompareEditions, false);
  ShowInToolbar(en_Editions, op_DoCompareEditions, true);
  PublishOp(en_Editions, op_BuildChangedFragments, Editions_BuildChangedFragments_Execute, Editions_BuildChangedFragments_Test, nil);
  ShowInContextMenu(en_Editions, op_BuildChangedFragments, false);
  ShowInToolbar(en_Editions, op_BuildChangedFragments, true);
 end;//with Entities.Entities
end;

procedure TPrimRedactionsForm.MakeControls;
begin
 inherited;
 f_RedactionTree := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_RedactionTree.Name := 'RedactionTree';
 f_RedactionTree.Parent := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include ..\View\RedactionsUserTypes.imp.pas}
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimRedactions
 TtfwClassRef.Register(TPrimRedactionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.