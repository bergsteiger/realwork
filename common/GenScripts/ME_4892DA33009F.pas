unit nsTreeMultiDocumentPreviewContainer;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsTreeMultiDocumentPreviewContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsTreeMultiDocumentPreviewContainer" MUID: (4892DA33009F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3CProtoObject
 , afwInterfaces
 , PreviewInterfaces
 , l3TreeInterfaces
 , afwTypes
 , l3Interfaces
 , l3Core
;

type
 TnsTreeMultiDocumentPreviewContainer = class(Tl3CProtoObject, IafwDocumentPreview, InsTreeMultiDocumentPreviewContainer)
  private
   f_Preview: IafwDocumentPreview;
   f_Tree: Il3ExpandedSimpleTree;
   f_Prepared: Boolean;
   f_ForSelection: Boolean;
   f_OnlyFirstLevel: Boolean;
  protected
   function DocumentName: IafwCString;
    {* имя документа для preview. }
   function InProcess: Boolean;
    {* идет процесс? }
   function InPagesCounting: Boolean;
    {* сейчас в процессе подсчета страниц? }
   function InUpdate: Boolean;
    {* находимся в процессе построения preview? }
   function InPrinting: Boolean;
    {* находимся в процессе построения печати? }
   procedure Update(const aPanel: IafwPreviewPanel);
    {* установить preview на панель для отображения. }
   procedure Print(anInterval: TafwPagesInterval = afwTypes.afw_piAll;
    const aRange: Il3RangeManager = nil;
    aCopies: Integer = 1;
    const aFileName: AnsiString = '';
    aCollate: Boolean = True);
    {* напечатать на принтер. }
   procedure Stop(aWnd: THandle = 0);
    {* остановит процесс построение preview/печати. }
   function Stopped: Boolean;
    {* процесс остановлен? }
   function CloseRequested: Boolean;
    {* при остановке процесса был запрос на закрытие превью }
   function PreviewResetting: Boolean;
    {* канва отсутствует, но будет передалываться }
   procedure SetCurrentPage(const aCursor: IUnknown);
    {* устанавливает курсор на текущую страницу. }
   procedure SetCurrentPagePara(aParaID: Integer);
    {* устанавливает курсор на текущую страницу. }
   procedure SetCurrentPageNumber(aPageNumber: Integer);
    {* устанавливает курсор на текущую страницу. }
   function CurrentPage: Integer;
    {* текущая страница для печати. }
   function HasCurrentPage: Boolean;
    {* установлена ли текущая страница. }
   function pm_GetPrinter: IafwPrinter;
   procedure pm_SetPrinter(const aValue: IafwPrinter);
   function pm_GetHasText: Boolean;
   function Get_ApproxDocCount: Integer;
   procedure Prepare;
   function pm_GetPagesInfo: TafwPagesInfo;
   procedure ClearFields; override;
  public
   constructor Create(const aTree: Il3ExpandedSimpleTree;
    ForSelection: Boolean;
    aOnlyFirstLevel: Boolean); reintroduce;
   class function MakePrim(const aTree: Il3ExpandedSimpleTree;
    ForSelection: Boolean;
    aOnlyFirstLevel: Boolean): IafwDocumentPreview; reintroduce;
   class function Make(const aTree: Il3ExpandedSimpleTree;
    ForSelection: Boolean;
    aOnlyFirstLevel: Boolean): IafwDocumentPreview;
 end;//TnsTreeMultiDocumentPreviewContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DynamicTreeUnit
 , evMultiDocumentPreview
 , bsUtils
 , nsDocumentTools
 , DataAdapter
 , SysUtils
 , bsTypes
 , l3Nodes
 , DocumentUnit
;

const
 cExportFlag = DynamicTreeUnit.FM_FIRST_USER_FLAG;

constructor TnsTreeMultiDocumentPreviewContainer.Create(const aTree: Il3ExpandedSimpleTree;
 ForSelection: Boolean;
 aOnlyFirstLevel: Boolean);
//#UC START# *4D4C073502C0_4892DA33009F_var*
//#UC END# *4D4C073502C0_4892DA33009F_var*
begin
//#UC START# *4D4C073502C0_4892DA33009F_impl*
 inherited Create;
 f_Tree := aTree;
 f_ForSelection := ForSelection;
 f_Prepared := False;
 f_Preview := TevMultiDocumentPreview.Make;
 f_OnlyFirstLevel := aOnlyFirstLevel; 
//#UC END# *4D4C073502C0_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.Create

class function TnsTreeMultiDocumentPreviewContainer.MakePrim(const aTree: Il3ExpandedSimpleTree;
 ForSelection: Boolean;
 aOnlyFirstLevel: Boolean): IafwDocumentPreview;
var
 l_Inst : TnsTreeMultiDocumentPreviewContainer;
begin
 l_Inst := Create(aTree, ForSelection, aOnlyFirstLevel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsTreeMultiDocumentPreviewContainer.MakePrim

class function TnsTreeMultiDocumentPreviewContainer.Make(const aTree: Il3ExpandedSimpleTree;
 ForSelection: Boolean;
 aOnlyFirstLevel: Boolean): IafwDocumentPreview;
//#UC START# *4D4C0E3B0225_4892DA33009F_var*
//#UC END# *4D4C0E3B0225_4892DA33009F_var*
begin
//#UC START# *4D4C0E3B0225_4892DA33009F_impl*
 if ForSelection and (aTree.SelectCount < 2) then
  Result := nil
 else
  Result := MakePrim(aTree, ForSelection, aOnlyFirstLevel);
//#UC END# *4D4C0E3B0225_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.Make

function TnsTreeMultiDocumentPreviewContainer.DocumentName: IafwCString;
 {* имя документа для preview. }
//#UC START# *473D8C450198_4892DA33009F_var*
//#UC END# *473D8C450198_4892DA33009F_var*
begin
//#UC START# *473D8C450198_4892DA33009F_impl*
 Result := f_Preview.DocumentName;
//#UC END# *473D8C450198_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.DocumentName

function TnsTreeMultiDocumentPreviewContainer.InProcess: Boolean;
 {* идет процесс? }
//#UC START# *473D8C5C0187_4892DA33009F_var*
//#UC END# *473D8C5C0187_4892DA33009F_var*
begin
//#UC START# *473D8C5C0187_4892DA33009F_impl*
 if f_Prepared then
  Result := f_Preview.InProcess
 else
  Result := False;
//#UC END# *473D8C5C0187_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.InProcess

function TnsTreeMultiDocumentPreviewContainer.InPagesCounting: Boolean;
 {* сейчас в процессе подсчета страниц? }
//#UC START# *473D8C6C0266_4892DA33009F_var*
//#UC END# *473D8C6C0266_4892DA33009F_var*
begin
//#UC START# *473D8C6C0266_4892DA33009F_impl*
 if f_Prepared then
  Result := f_Preview.InPagesCounting
 else
  Result := False;
//#UC END# *473D8C6C0266_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.InPagesCounting

function TnsTreeMultiDocumentPreviewContainer.InUpdate: Boolean;
 {* находимся в процессе построения preview? }
//#UC START# *473D8C7C01B5_4892DA33009F_var*
//#UC END# *473D8C7C01B5_4892DA33009F_var*
begin
//#UC START# *473D8C7C01B5_4892DA33009F_impl*
 if f_Prepared then
  Result := f_Preview.InUpdate
 else
  Result := False;
//#UC END# *473D8C7C01B5_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.InUpdate

function TnsTreeMultiDocumentPreviewContainer.InPrinting: Boolean;
 {* находимся в процессе построения печати? }
//#UC START# *473D8C90022C_4892DA33009F_var*
//#UC END# *473D8C90022C_4892DA33009F_var*
begin
//#UC START# *473D8C90022C_4892DA33009F_impl*
 if f_Prepared then
  Result := f_Preview.InPrinting
 else
  Result := False;
//#UC END# *473D8C90022C_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.InPrinting

procedure TnsTreeMultiDocumentPreviewContainer.Update(const aPanel: IafwPreviewPanel);
 {* установить preview на панель для отображения. }
//#UC START# *473D8CA002D9_4892DA33009F_var*
//#UC END# *473D8CA002D9_4892DA33009F_var*
begin
//#UC START# *473D8CA002D9_4892DA33009F_impl*
 if not f_Prepared then
  Prepare;
 f_Preview.Update(aPanel);
//#UC END# *473D8CA002D9_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.Update

procedure TnsTreeMultiDocumentPreviewContainer.Print(anInterval: TafwPagesInterval = afwTypes.afw_piAll;
 const aRange: Il3RangeManager = nil;
 aCopies: Integer = 1;
 const aFileName: AnsiString = '';
 aCollate: Boolean = True);
 {* напечатать на принтер. }
//#UC START# *473D8CAF028B_4892DA33009F_var*
//#UC END# *473D8CAF028B_4892DA33009F_var*
begin
//#UC START# *473D8CAF028B_4892DA33009F_impl*
 if not f_Prepared then
  Prepare;
 f_Preview.Print(anInterval, aRange, aCopies, aFileName, aCollate);
//#UC END# *473D8CAF028B_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.Print

procedure TnsTreeMultiDocumentPreviewContainer.Stop(aWnd: THandle = 0);
 {* остановит процесс построение preview/печати. }
//#UC START# *473D8CE9007C_4892DA33009F_var*
//#UC END# *473D8CE9007C_4892DA33009F_var*
begin
//#UC START# *473D8CE9007C_4892DA33009F_impl*
 if f_Prepared then
  f_Preview.Stop(aWnd);
//#UC END# *473D8CE9007C_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.Stop

function TnsTreeMultiDocumentPreviewContainer.Stopped: Boolean;
 {* процесс остановлен? }
//#UC START# *473D8CF80037_4892DA33009F_var*
//#UC END# *473D8CF80037_4892DA33009F_var*
begin
//#UC START# *473D8CF80037_4892DA33009F_impl*
 if f_Prepared then
  Result := f_Preview.Stopped
 else
  Result := False;
//#UC END# *473D8CF80037_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.Stopped

function TnsTreeMultiDocumentPreviewContainer.CloseRequested: Boolean;
 {* при остановке процесса был запрос на закрытие превью }
//#UC START# *473D8D0A01D7_4892DA33009F_var*
//#UC END# *473D8D0A01D7_4892DA33009F_var*
begin
//#UC START# *473D8D0A01D7_4892DA33009F_impl*
 if f_Prepared then
  Result := f_Preview.CloseRequested
 else
  Result := False;
//#UC END# *473D8D0A01D7_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.CloseRequested

function TnsTreeMultiDocumentPreviewContainer.PreviewResetting: Boolean;
 {* канва отсутствует, но будет передалываться }
//#UC START# *473D8D1E01B8_4892DA33009F_var*
//#UC END# *473D8D1E01B8_4892DA33009F_var*
begin
//#UC START# *473D8D1E01B8_4892DA33009F_impl*
 if f_Prepared then
  Result := f_Preview.PreviewResetting
 else
  Result := False;
//#UC END# *473D8D1E01B8_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.PreviewResetting

procedure TnsTreeMultiDocumentPreviewContainer.SetCurrentPage(const aCursor: IUnknown);
 {* устанавливает курсор на текущую страницу. }
//#UC START# *473D8D3800B1_4892DA33009F_var*
//#UC END# *473D8D3800B1_4892DA33009F_var*
begin
//#UC START# *473D8D3800B1_4892DA33009F_impl*
// DoNothing;
//#UC END# *473D8D3800B1_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.SetCurrentPage

procedure TnsTreeMultiDocumentPreviewContainer.SetCurrentPagePara(aParaID: Integer);
 {* устанавливает курсор на текущую страницу. }
//#UC START# *473D8D4A019D_4892DA33009F_var*
//#UC END# *473D8D4A019D_4892DA33009F_var*
begin
//#UC START# *473D8D4A019D_4892DA33009F_impl*
// DoNothing;
//#UC END# *473D8D4A019D_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.SetCurrentPagePara

procedure TnsTreeMultiDocumentPreviewContainer.SetCurrentPageNumber(aPageNumber: Integer);
 {* устанавливает курсор на текущую страницу. }
//#UC START# *473D8D5D032B_4892DA33009F_var*
//#UC END# *473D8D5D032B_4892DA33009F_var*
begin
//#UC START# *473D8D5D032B_4892DA33009F_impl*
// DoNothing;
//#UC END# *473D8D5D032B_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.SetCurrentPageNumber

function TnsTreeMultiDocumentPreviewContainer.CurrentPage: Integer;
 {* текущая страница для печати. }
//#UC START# *473D8D72010F_4892DA33009F_var*
//#UC END# *473D8D72010F_4892DA33009F_var*
begin
//#UC START# *473D8D72010F_4892DA33009F_impl*
 Result := -1;
//#UC END# *473D8D72010F_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.CurrentPage

function TnsTreeMultiDocumentPreviewContainer.HasCurrentPage: Boolean;
 {* установлена ли текущая страница. }
//#UC START# *473D8D830163_4892DA33009F_var*
//#UC END# *473D8D830163_4892DA33009F_var*
begin
//#UC START# *473D8D830163_4892DA33009F_impl*
 Result := False;
//#UC END# *473D8D830163_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.HasCurrentPage

function TnsTreeMultiDocumentPreviewContainer.pm_GetPrinter: IafwPrinter;
//#UC START# *473D8D9500C9_4892DA33009Fget_var*
//#UC END# *473D8D9500C9_4892DA33009Fget_var*
begin
//#UC START# *473D8D9500C9_4892DA33009Fget_impl*
 Result := f_Preview.Printer;
//#UC END# *473D8D9500C9_4892DA33009Fget_impl*
end;//TnsTreeMultiDocumentPreviewContainer.pm_GetPrinter

procedure TnsTreeMultiDocumentPreviewContainer.pm_SetPrinter(const aValue: IafwPrinter);
//#UC START# *473D8D9500C9_4892DA33009Fset_var*
//#UC END# *473D8D9500C9_4892DA33009Fset_var*
begin
//#UC START# *473D8D9500C9_4892DA33009Fset_impl*
 f_Preview.Printer := aValue;
//#UC END# *473D8D9500C9_4892DA33009Fset_impl*
end;//TnsTreeMultiDocumentPreviewContainer.pm_SetPrinter

function TnsTreeMultiDocumentPreviewContainer.pm_GetHasText: Boolean;
//#UC START# *473D8DB10141_4892DA33009Fget_var*
//#UC END# *473D8DB10141_4892DA33009Fget_var*
begin
//#UC START# *473D8DB10141_4892DA33009Fget_impl*
 Result := Get_ApproxDocCount > 0;
//#UC END# *473D8DB10141_4892DA33009Fget_impl*
end;//TnsTreeMultiDocumentPreviewContainer.pm_GetHasText

function TnsTreeMultiDocumentPreviewContainer.Get_ApproxDocCount: Integer;
//#UC START# *4991B17F004B_4892DA33009Fget_var*
var
 l_MultiPreview: IafwMultiDocumentPreview;
//#UC END# *4991B17F004B_4892DA33009Fget_var*
begin
//#UC START# *4991B17F004B_4892DA33009Fget_impl*
 if f_Prepared and Supports(f_Preview, IafwMultiDocumentPreview, l_MultiPreview) then
  Result := l_MultiPreview.DocCount
 else
 if f_ForSelection then
  Result := f_Tree.SelectCount
 else
  Result := f_Tree.RootNode.ThisChildrenCount;
//#UC END# *4991B17F004B_4892DA33009Fget_impl*
end;//TnsTreeMultiDocumentPreviewContainer.Get_ApproxDocCount

procedure TnsTreeMultiDocumentPreviewContainer.Prepare;
//#UC START# *4991B1850249_4892DA33009F_var*

 procedure FinishPrepare;
 var
  l_Root: INodeBase;
 begin//FinishPrepare
  if Supports(f_Tree.RootNode, INodeBase, l_Root) then
   l_Root.SetAllFlag(cExportFlag, False);
 end;//FinishPrepare

 procedure MarkDocumentsForPrepare;

   function lpIterator(const aNode: Il3SimpleNode): Boolean;

    procedure MarkNodeForExport(const aNode: Il3SimpleNode);

     function ListNodeType(const aNode: Il3SimpleNode): TbsListNodeType;
     var
      l_Node: INodeBase;
     begin//ListNodeType
      Supports(aNode, INodeBase, l_Node);
      try
       Result := bsListNodeType(l_Node);
      finally
       l_Node := nil;
      end;//try..finally
     end;//ListNodeType

     function FindParentDocNode(const aNode: Il3SimpleNode): Il3SimpleNode;
     begin//FindParentDocNode
      if Assigned(aNode) then
      begin
       Result := aNode.Parent;
       while Assigned(Result) and
             not (ListNodeType(Result) in
                  [lntDocActive,
                   lntDocPreActive,
                   lntDocAbolished,
                   lntRedaction,
                   lntDrugAnnuled,
                   lntDrugNarcotic,
                   lntDrugNoAnnuledNoNarcoric,
                   {lntFormAnnuled,
                   lntFormRussianImportant,
                   lntFormNoRussianImportant,
                   lntFormRussianNoImportant,
                   lntFormNoRussianNoImportant,}
                   lntMedicFirm]) do
        Result := Result.Parent;
      end//Assigned(aNode)
      else
       Result := nil;
     end;//FindParentDocNode

    var
     l_Level: Integer;
     l_Node: INodeBase;
    begin//MarkNodeForExport
     if Assigned(aNode) then
     begin
      case ListNodeType(aNode) of
       lntBlock,
       lntRedactions,
       lntFormAnnuled,
       lntFormRussianImportant,
       lntFormNoRussianImportant,
       lntFormRussianNoImportant,
       lntFormNoRussianNoImportant:
        MarkNodeForExport(FindParentDocNode(aNode));
       lntDocActive,
       lntDocPreActive,
       lntDocAbolished,
       lntRedaction,
       lntDrugAnnuled,
       lntDrugNarcotic,
       lntDrugNoAnnuledNoNarcoric,
       lntMedicFirm:
       begin
        l_Level := aNode.GetLevelFor(f_Tree.RootNode);
        if (not f_OnlyFirstLevel or (l_Level = 1)) and
           Supports(aNode, INodeBase, l_Node) then
         l_Node.SetFlag(cExportFlag, True);
        if (l_Level > 1) then
         MarkNodeForExport(FindParentDocNode(aNode));
       end;//lntBlock
       else
        Assert(false);
      end;//case ListNodeType(aNode) of
     end;//if Assigned(aNode) then
    end;//MarkNodeForExport

   begin//lpIterator
    Result := False;
    MarkNodeForExport(aNode);
   end;//lpIterator

 var
  l_Tree: Il3ExpandedSimpleTree;
  l_Flag: Word;
 begin//MarkDocumentsForPrepare
  if f_ForSelection then
   f_Tree.FlagIterateF(l3L2SNA(@lpIterator), FM_SELECTION)
  else
  begin
   if f_OnlyFirstLevel then
    l_Flag := imOneLevel
   else
    l_Flag := 0;
   f_Tree.SimpleIterateF(l3L2SNA(@lpIterator), l_Flag);
  end;//f_ForSelection
 end;//MarkDocumentsForPrepare

var
 l_MultiPreview: IafwMultiDocumentPreview;

 function lp_Prepare(const aNode: Il3SimpleNode): Boolean;
 var
  l_Doc: IDocument;
  l_ListNode: INodeBase;
 begin//lp_Prepare
  Result := True;
  if Supports(aNode, INodeBase, l_ListNode) then
  try
   l_Doc := bsExtractDocument(l_ListNode);
   try
    if (l_Doc.GetDocType <> DT_FLASH) then
     l_MultiPreview.AddDocument(
      nsGetDocumentPreview(
       nsChangeDocumentState(l_Doc, DefDataAdapter.DocDefaultLang), True, True));
   finally
    l_Doc := nil;
   end;//try..finally
  finally
   l_ListNode := nil;
  end;//try..finally
 end;//lpIterator

//#UC END# *4991B1850249_4892DA33009F_var*
begin
//#UC START# *4991B1850249_4892DA33009F_impl*
 MarkDocumentsForPrepare;
 try
  l_MultiPreview := f_Preview as IafwMultiDocumentPreview;
  try
   f_Tree.FlagIterateF(l3L2SNA(@lp_Prepare), cExportFlag);
   f_Prepared := True;
  finally
   l_MultiPreview := nil;
  end;//try..finally
 finally
  FinishPrepare;
 end;//try..finally
//#UC END# *4991B1850249_4892DA33009F_impl*
end;//TnsTreeMultiDocumentPreviewContainer.Prepare

function TnsTreeMultiDocumentPreviewContainer.pm_GetPagesInfo: TafwPagesInfo;
//#UC START# *4CC6A6FF0362_4892DA33009Fget_var*
//#UC END# *4CC6A6FF0362_4892DA33009Fget_var*
begin
//#UC START# *4CC6A6FF0362_4892DA33009Fget_impl*
 if not f_Prepared then
  Prepare;
 Result := f_Preview.PagesInfo;
//#UC END# *4CC6A6FF0362_4892DA33009Fget_impl*
end;//TnsTreeMultiDocumentPreviewContainer.pm_GetPagesInfo

procedure TnsTreeMultiDocumentPreviewContainer.ClearFields;
begin
 f_Preview := nil;
 f_Tree := nil;
 inherited;
end;//TnsTreeMultiDocumentPreviewContainer.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
