unit bsDocumentContextSearcher;
 {* Объект предназначенный для контекстного поиска в документе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\bsDocumentContextSearcher.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , BaseSearchInterfaces
 , eeEditor
 , DynamicTreeUnit
 , l3Interfaces
 , nevTools
;

type
 TbsDocumentContextSearcher = class(Tl3ProtoObject, IbsBaseDocumentContextSearcher)
  {* Объект предназначенный для контекстного поиска в документе }
  private
   f_Editor: TeeCustomEditor;
   f_Found: IFindIterator;
   f_Context: Il3CString;
   f_WasFound: Boolean;
   f_CaretPoint: InevBasePoint;
  private
   procedure DoContextFound(const aFoundBlock: InevRange;
    var aResult: TbsBaseSearchResult);
   procedure DoSearchFinished(const aPrevFoundBlock: InevRange;
    SearchDown: Boolean;
    var aResult: TbsBaseSearchResult);
  protected
   function Find(const aContext: Il3CString): TbsBaseSearchResult;
    {* поиск }
   procedure ContextChanged(const aNewContext: Il3CString);
   function pm_GetCanContinue: Boolean;
   function pm_GetContext: Il3CString;
   function FindBack: TbsBaseSearchResult;
    {* Вернутся к предыдущему вхождению }
   function Get_CanFindBack: Boolean;
   function pm_GetFragmentsCount: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aEditor: TeeCustomEditor); reintroduce;
   class function Make(aEditor: TeeCustomEditor): IbsBaseDocumentContextSearcher; reintroduce;
 end;//TbsDocumentContextSearcher
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3String
 , nsTagNodeTools
 , SysUtils
 , DataAdapter
 , nsTypes
 , k2Tags
 , nsContextSearchParams
 , Document_Const
 , Block_Const
 , BaseTypesUnit
 , nsFindIteratorNew
 , nsFindIteratorNewForAutoreferat
 , nsFindIteratorNewForDiction
 , DocumentUnit
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evSearch
 , nsContextListForSearchViaEverestOwnSearcher
 , nsFoundRangeCollector
 , evTypes
 , l3Variant
;

procedure TbsDocumentContextSearcher.DoContextFound(const aFoundBlock: InevRange;
 var aResult: TbsBaseSearchResult);
var l_Start: InevBasePoint;
var l_Finish: InevBasePoint;
var l_Lock: Il3Lock;
//#UC START# *4A1FEB0D01AF_495137C70135_var*
//#UC END# *4A1FEB0D01AF_495137C70135_var*
begin
//#UC START# *4A1FEB0D01AF_495137C70135_impl*
 aResult := bsrContinueSearch;
 f_WasFound := True;
 Supports(f_Editor, Il3Lock, l_Lock);
 with f_Editor do
 begin
  if Assigned(l_Lock) then
   l_Lock.Lock(Self);
  try
   if Assigned(f_CaretPoint) then
    InevSelection(Selection).SelectPoint(f_CaretPoint, False, False);
   Selection.FoundBlock := aFoundBlock;
   InevSelection(Selection).GetBlock.GetBorderPoints(l_Start, l_Finish);
   View.MakePairVisible(l_Start, l_Finish);
  finally
   if Assigned(l_Lock) then
    l_Lock.UnLock(Self);
  end;
 end;
//#UC END# *4A1FEB0D01AF_495137C70135_impl*
end;//TbsDocumentContextSearcher.DoContextFound

procedure TbsDocumentContextSearcher.DoSearchFinished(const aPrevFoundBlock: InevRange;
 SearchDown: Boolean;
 var aResult: TbsBaseSearchResult);
var l_HasEntries: Boolean;
//#UC START# *4A1FEB3F01DB_495137C70135_var*
//#UC END# *4A1FEB3F01DB_495137C70135_var*
begin
//#UC START# *4A1FEB3F01DB_495137C70135_impl*
 l_HasEntries := Assigned(f_Found) and (f_Found.GetCount > 0);
 f_Editor.Selection.FoundBlock := aPrevFoundBlock;
 // Завершен поиск в выделенном:
 if SearchDown then
 begin
  if f_wasFound then
   aResult := bsrSearchFinished
    // - поиск в тексте завершен;
  else
   if l_HasEntries then
    aResult := bsrSearchFinishedAllInHidden
   else
    aResult := bsrSearchFinishedNotFound;
    // - в тексте ничего не нашли;
 end
 else
  aResult := bsrSearchFinishedAllInHidden;
 if aResult <> bsrSearchFinished then
  f_Found := nil;
 f_WasFound := False;
//#UC END# *4A1FEB3F01DB_495137C70135_impl*
end;//TbsDocumentContextSearcher.DoSearchFinished

constructor TbsDocumentContextSearcher.Create(aEditor: TeeCustomEditor);
//#UC START# *4C9C8EA2016A_495137C70135_var*
//#UC END# *4C9C8EA2016A_495137C70135_var*
begin
//#UC START# *4C9C8EA2016A_495137C70135_impl*
 inherited Create;
 f_Editor := aEditor;
//#UC END# *4C9C8EA2016A_495137C70135_impl*
end;//TbsDocumentContextSearcher.Create

class function TbsDocumentContextSearcher.Make(aEditor: TeeCustomEditor): IbsBaseDocumentContextSearcher;
var
 l_Inst : TbsDocumentContextSearcher;
begin
 l_Inst := Create(aEditor);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsDocumentContextSearcher.Make

function TbsDocumentContextSearcher.Find(const aContext: Il3CString): TbsBaseSearchResult;
 {* поиск }
//#UC START# *4952664C03BC_495137C70135_var*

 function lp_MakeFound(const aDoc   : InevObject;
                       const aPoint : InevBasePoint): IFindIterator;
 
  function FindInProvider(aDoc      : Tl3Variant;
                          aFromParaID     : Integer;
                          out theIterator : IFindIterator) : Boolean;
  var
   l_Provider : IDocumentTextProvider;
   l_Found    : IFoundContext;
  begin//FindInProvider
   if aDoc.Box.QI(IDocumentTextProvider, l_Provider) then
    try
     Result := true;
     try
      l_Provider.FindContext(nsIStr(aContext),
                             aFromParaID,
                             l_Found);
     except
      on ECannotFindData do
      begin
       theIterator := nil;
       Exit;
      end;//ECannotFindData
     end;//try..except
     theIterator := TnsFindIteratorNew.Make(l_Found);
    finally
     l_Provider := nil;
    end//try..finally
   else
    Result := false;
  end;//FindInProvider

  function FindViaEverestOwnSearcher(const aDoc: InevObject;
                                     const aPoint : InevBasePoint;
                                     out theIterator : IFindIterator): Boolean;
  const
   cOp = [ev_soGlobal, ev_soReplace, ev_soReplaceAll, ev_soNoException];
  var
   l_C  : TnsFoundRangeCollector;
   l_BM : TevBMTextSearcher;
   l_P  : InevPara;
   l_Ctx : Il3CString;
  begin//FindViaEverestOwnSearcher
   Result := false;
   l_C := TnsFoundRangeCollector.Create;
   try
    l_BM := TevBMTextSearcher.Create;
    try
     l_Ctx := aContext;
     l3DeleteChars(l_Ctx, ['*','"','!']);
     l_BM.Text := l3Str(l_Ctx);
     if not aDoc.AsObject.QT(InevPara, l_P) then
      Assert(false);
     l_C.Options := cOp;
     l_BM.Options := cOp;
     if evReplaceInPara(l_P, l_BM, l_C, nil, aPoint) then
      if not l_C.FoundRanges.Empty then
      begin
       Result := true;
       theIterator := TnsFindIteratorNew.Make(
                       TnsContextListForSearchViaEverestOwnSearcher.Make(
                        aDoc,
                        l_C.FoundRanges));
      end;//not l_C.FoundRanges.Empty
    finally
     FreeAndNil(l_BM);
    end;//try..finally
   finally
    FreeAndNil(l_C);
   end;//try..finally
  end;//FindViaEverestOwnSearcher

  procedure TryFindInProvidersList(const aDoc : InevObjectList; var thereWasDoc : Boolean);

  var
   l_ID : Integer;
   l_L  : TnsIFindIteratorList;

   procedure DoDoc(const aDoc : InevObject; aNeedID : Boolean);
   var
    l_It : IFindIterator;
    l_ThisDocID : Integer;
    l_Pt        : InevBasePoint;
   begin//DoDoc
    if aDoc.AsObject.IsKindOf(k2_typDocument) then
    begin
     // - это вложенный документ
     thereWasDoc := true;
     if aNeedID then
      l_ThisDocID := l_ID
     else
      l_ThisDocID := 0;
     if FindInProvider(aDoc.AsObject, l_ThisDocID, l_It) then
     begin
      // - вкладываем один итератор в другой
      if (l_It <> nil) then
       l_L.Add(TnsFindIteratorDef_C(aDoc, l_It));
     end//FindInProvider(aDoc, l_ThisDocID, l_It)
     else
     begin
      if aNeedID then
      begin
       l_Pt := aPoint.MostInner.PointToParent(aDoc);
       // - учитываем что попросили искать не с самого начала документа 
       Assert(l_Pt <> nil);
      end//aNeedID
      else
       l_Pt := aDoc.MakePoint;
      FindViaEverestOwnSearcher(aDoc, l_Pt, l_It);
      if (l_It <> nil) then
       l_L.Add(TnsFindIteratorDef_C(aDoc, l_It));
     end;//FindInProvider(aDoc, l_ThisDocID, l_It)
    end;//aDoc.IsKindOf(k2_typDocument)
   end;//DoDoc

  var
   l_Index  : Integer;
   l_C      : InevObject;
   l_Median : Integer;
  begin//TryFindInProvidersList
   l_L := TnsIFindIteratorList.Create;
   try
    l_Median := aPoint.Position;
    Dec(l_Median);
    // - учитываем кривизну мира курсоров от списков параграфов
    Assert(l_Median >= 0);
    l_ID := aPoint.MostInner.AsObject.IntA[k2_tiHandle];
    for l_Index := l_Median to Pred(aDoc.Count) do
     DoDoc(aDoc.Obj[l_Index], l_Index = l_Median);
    for l_Index := 0 to Pred(l_Median) do
     DoDoc(aDoc.Obj[l_Index], false);
    if (l_L.Count > 0) then
    begin
     Result := TnsFindIteratorNewForAutoreferat.Make(l_L);
    end//l_L.Count > 0
    else
    begin
     //Assert(false);
     // http://mdp.garant.ru/pages/viewpage.action?pageId=255981614
     Result := nil;
    end;//l_L.Count > 0
   finally
    FreeAndNil(l_L);
   end;//try..finally
  end;//TryFindInProvidersList

 var
  l_Child0     : Tl3Variant;
  l_FromParaID : Integer;
  l_WasDoc     : Boolean;
 begin//lp_MakeFound
  l_FromParaID := aPoint.MostInner.AsObject.IntA[k2_tiHandle];
  if FindInProvider(aDoc.AsObject, l_FromParaID, Result) then
  // - нашли в "новом" документе
  begin
   Exit;
  end//FindInProvider(aDoc, l_FromParaID, Result)
  else
  if (aDoc.AsObject.ChildrenCount = 1) then
  begin
   l_Child0 := aDoc.AsObject.Child[0];
   if l_Child0.IsKindOf(k2_typBlock) AND
     not l_Child0.IsKindOf(k2_typDocument) then
    // - наверное это толковый словарь
   begin
    if FindInProvider(l_Child0, l_FromParaID, Result) then
    begin
     if (Result <> nil) then
      Result := TnsFindIteratorNewForDiction.Make(Result, l_Child0);
     Exit;
    end;//FindInProvider(l_Child0, l_FromParaID, Result)
   end;//l_Child0.IsKindOf(k2_typBlock)
  end;//aDoc.ChildrenCount = 1
  if (Result = nil) then
  begin
   l_WasDoc := false;
   TryFindInProvidersList(aDoc.ToList, l_WasDoc);
   if not l_WasDoc then
   // - это не составной документ, попытаемся искать своими собственными средствами
   begin
    FindViaEverestOwnSearcher(aDoc, aPoint, Result);
   end;//not l_WasDoc
  end;//Result = nil
 end;//lp_MakeFound
 
var
 l_Doc            : InevObject;
 l_SearchResult   : Boolean;
 l_PrevFoundBlock : InevRange;
 l_FoundBlock     : InevRange;
//#UC END# *4952664C03BC_495137C70135_var*
begin
//#UC START# *4952664C03BC_495137C70135_impl*
 Result := bsrNone;
 if not l3IsNil(aContext) then
 begin
  with f_Editor, Selection do
   if Assigned(FoundBlock) then
    l_PrevFoundBlock := FoundBlock.CloneSel(View)
   else
    l_PrevFoundBlock := nil;
  f_Editor.Selection.DeleteFoundBlockBeforeSearch;
  l_Doc := f_Editor.Document;
  // Поиск в тексте:
  f_Context := aContext;

  if Assigned(f_CaretPoint) and
     (f_CaretPoint.Compare(f_Editor.Selection.Cursor) <> 0) then
   f_Found := nil;

  if not f_WasFound then
   f_Found := nil;

  if not Assigned(f_Found) then
   f_Found := lp_MakeFound(l_Doc, f_Editor.Selection.Cursor);
  l_SearchResult := nsIteratorToRange(l_Doc,
                                      f_Found,
                                      f_Editor.View,
                                      nil,
                                      True,
                                      f_Editor,
                                      l_FoundBlock,
                                      f_CaretPoint);
  if l_SearchResult then
   DoContextFound(l_FoundBlock, Result)
  // Ничего не нашли:
  else
   DoSearchFinished(l_PrevFoundBlock, true, Result);
 end;//not l3IsNil(aContext)
//#UC END# *4952664C03BC_495137C70135_impl*
end;//TbsDocumentContextSearcher.Find

procedure TbsDocumentContextSearcher.ContextChanged(const aNewContext: Il3CString);
//#UC START# *4952665F0298_495137C70135_var*
//#UC END# *4952665F0298_495137C70135_var*
begin
//#UC START# *4952665F0298_495137C70135_impl*
 if (aNewContext = nil) or not l3Same(f_Context, aNewContext) then
 begin
  f_Found := nil;
  f_Context := nil;
  f_WasFound := False;
 end;//(aNewContext = nil) or not l3Same(f_Context, aNewContext)
//#UC END# *4952665F0298_495137C70135_impl*
end;//TbsDocumentContextSearcher.ContextChanged

function TbsDocumentContextSearcher.pm_GetCanContinue: Boolean;
//#UC START# *4952667C0385_495137C70135get_var*
//#UC END# *4952667C0385_495137C70135get_var*
begin
//#UC START# *4952667C0385_495137C70135get_impl*
 Result := Assigned(f_Found);
//#UC END# *4952667C0385_495137C70135get_impl*
end;//TbsDocumentContextSearcher.pm_GetCanContinue

function TbsDocumentContextSearcher.pm_GetContext: Il3CString;
//#UC START# *495266A500B0_495137C70135get_var*
//#UC END# *495266A500B0_495137C70135get_var*
begin
//#UC START# *495266A500B0_495137C70135get_impl*
 Result := f_Context;
//#UC END# *495266A500B0_495137C70135get_impl*
end;//TbsDocumentContextSearcher.pm_GetContext

function TbsDocumentContextSearcher.FindBack: TbsBaseSearchResult;
 {* Вернутся к предыдущему вхождению }
//#UC START# *49FEAD670382_495137C70135_var*
var
 l_Doc   : InevObject;
 l_SearchResult: Boolean;
 l_FoundBlock: InevRange;
 l_PrevFoundBlock: InevRange;
//#UC END# *49FEAD670382_495137C70135_var*
begin
//#UC START# *49FEAD670382_495137C70135_impl*
 Result := bsrNone;
 if Assigned(f_Found) then
 begin
  with f_Editor, Selection do
   if Assigned(FoundBlock) then
    l_PrevFoundBlock := FoundBlock.CloneSel(View)
   else
    l_PrevFoundBlock := nil;
  f_Editor.Selection.DeleteFoundBlockBeforeSearch;
  l_Doc := f_Editor.Document;

  l_SearchResult := nsFindBackToRange(l_Doc,
                                      f_Found,
                                      f_Editor.View,
                                      nil,
                                      True,
                                      f_Editor,
                                      l_FoundBlock,
                                      f_CaretPoint);
  if l_SearchResult then
   DoContextFound(l_FoundBlock, Result)
  // Ничего не нашли:
  else
   DoSearchFinished(l_PrevFoundBlock, False, Result);
 end;//Assigned(f_Found)
//#UC END# *49FEAD670382_495137C70135_impl*
end;//TbsDocumentContextSearcher.FindBack

function TbsDocumentContextSearcher.Get_CanFindBack: Boolean;
//#UC START# *49FEB49800A8_495137C70135get_var*
//#UC END# *49FEB49800A8_495137C70135get_var*
begin
//#UC START# *49FEB49800A8_495137C70135get_impl*
 Result := Assigned(f_Found) and not f_Found.IsFirst;
//#UC END# *49FEB49800A8_495137C70135get_impl*
end;//TbsDocumentContextSearcher.Get_CanFindBack

function TbsDocumentContextSearcher.pm_GetFragmentsCount: Integer;
//#UC START# *49FFE06200FA_495137C70135get_var*
//#UC END# *49FFE06200FA_495137C70135get_var*
begin
//#UC START# *49FFE06200FA_495137C70135get_impl*
 if Assigned(f_Found) then
  Result := f_Found.GetCount
 else
  Result := 0;
//#UC END# *49FFE06200FA_495137C70135get_impl*
end;//TbsDocumentContextSearcher.pm_GetFragmentsCount

procedure TbsDocumentContextSearcher.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_495137C70135_var*
//#UC END# *479731C50290_495137C70135_var*
begin
//#UC START# *479731C50290_495137C70135_impl*
 f_CaretPoint := nil;
 f_Found := nil;
 f_Context := nil;
 f_Editor := nil;
 inherited;
//#UC END# *479731C50290_495137C70135_impl*
end;//TbsDocumentContextSearcher.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
