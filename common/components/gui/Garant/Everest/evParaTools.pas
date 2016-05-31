unit evParaTools;
 {* Реализация интерфейсов различных параграфов. }

// Модуль: "w:\common\components\gui\Garant\Everest\evParaTools.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evParaTools" MUID: (47F1F3BC0330)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevTools
 , l3Interfaces
 , nevBase
 , evInternalInterfaces
 , l3Variant
 , evdInterfaces
 , l3IID
 , k2Base
 , evTypes
 , k2Interfaces
 , evdTypes
;

function evInPara(anAtom: Tl3Variant;
 aTypeID: Tk2Type;
 const anExclude: array of Tl3VariantDef;
 out theParent: Tl3Variant): Boolean; overload;
 {* Возвращает является ли атом anAtom или кто-то из его владельцев наследником от aTypeID.  theParent - найденный владелец подходящего типа. Можно задавать исключения в наследовании }
function evIsInReadOnlyPara(const aPara: InevPara): Boolean;
function evDeleteIfReadOnly(const aPara: InevPara): Boolean;
function evInPara(aFi: TnevFormatInfoPrim;
 aTypeID: Tk2Type;
 out theParent: Tl3Variant): Boolean; overload;
function evMergeParaListWithNext(const aView: InevView;
 const aParaList: InevParaList;
 aType: TevMergeParaListType;
 const aProcessor: InevProcessor;
 aFinish: Integer = MaxInt;
 const anIndicator: InevProgress = nil): Boolean;
 {* Объединяет список параграфов со следующим }
function evHasOwnStyle(const anObject: InevObjectPrim): Boolean;
procedure evSetStyle2Block(aTag: Tl3Variant;
 const anOp: InevOp;
 aStyleID: Integer);
function evHasAACStyle(aPara: Tl3Variant): Boolean;
 {* Проверяет принадлежит ли стиль параграфа к стилям, используемым в ААК. }
function evAACStyle(aStyleID: Integer): Boolean;
procedure evSetStyle2Table(aTag: Tl3Variant;
 const anOp: InevOp;
 aStyleID: Integer);
function evExpandedText(aPara: Tl3Variant): Boolean;
procedure evCheckCollapsed(const anObject: Tl3Variant;
 var aValue: Boolean);
function EvParentGetLeftIndent(aPara: Tl3Variant): Integer;
function evExpandOrCollapse(const aView: InevControlView;
 const aTextPara: InevPara): Boolean;
function evBlockCollapsed(const aView: InevView;
 const aTextPara: InevPara): Boolean;
function evHeaderTextPara(const aPara: InevObjectPrim): Boolean; overload;
procedure evExpandOwnerStyleBlocks(const aPara: InevObject;
 const aView: InevControlView);
function evNeedDrawParaInCollapsedMode(const aPara: InevObjectPrim): Boolean;
function evHeaderTextPara(aPara: Tl3Variant): Boolean; overload;
function evInBlock(anAtom: Tl3Variant;
 aViewKind: TevBlockViewKind;
 out theParent: Tl3Variant): Boolean;
function evCheckParaOwner(aPara: Tl3Variant): Tl3Variant; overload;
function evCheckParaOwner(const aPara: InevPara): InevPara; overload;
function evSearchPara(const aList: InevObject;
 const aSearcher: IevSearcher;
 out aPara: InevObject;
 StopOnBlock: Boolean = False;
 aBlock: PIevDataObject = nil): Boolean; overload;
function evSearchPara(aList: Tl3Variant;
 const aSearcher: IevSearcher;
 out aBlock: IevdDataObject): Boolean; overload;
function evQueryParaInterface(const aView: InevView;
 const aContext: InevProcessor;
 const aTagWrap: InevPara;
 const anIID: Tl3GUID;
 out Obj): hResult;
 {* Возвращает интерфейс anIID для aTagWrap и aContext }
procedure evClearPara(const aView: InevView;
 const aPara: InevObject;
 const anOp: InevOp;
 aMode: TevClearMode = nevTools.ev_cmKeepOne;
 const aTopPara: InevPara = nil);
 {* Очищает параграф aPara }
function evCopyParaList(const aView: InevView;
 const aContext: InevProcessor;
 const aDest: InevPara;
 const aSource: InevPara;
 aFlags: TevLoadFlags = nevBase.evDefaultCopyFlags;
 SkipEmpty: Boolean = False;
 const aStart: InevPoint = nil;
 NeedDelete: Boolean = False): Boolean;
 {* Копирует содержимое из aSource в aDest }
function evMergeParaText(const aView: InevView;
 const aParaList: InevParaList;
 const anOpPack: InevOp = nil): Boolean;
 {* Объединяет текст списка параграфов }
function evInPara(anAtom: Tl3Variant;
 aTypeID: Tk2Type;
 out theParent: Tl3Variant): Boolean; overload;
 {* Возвращает является ли атом anAtom или кто-то из его владельцев наследником от aTypeID.
       theParent - найденный владелец подходящего типа }
function evInPara(anAtom: Tl3Variant;
 aTypeID: Tk2Type): Boolean; overload;
 {* Возвращает является ли атом anAtom или кто-то из его владельцев наследником от aTypeID }
function evHasText(anAtom: Tl3Variant): Boolean;
 {* Возвращает есть ли у параграфа непустой текст }
function evTextLength(anAtom: Tl3Variant): Integer;
 {* Возвращает длину текста параграфа }
procedure evMoveBorders(const aView: InevView;
 var aBlock: IevdDataObject;
 aD1: Integer;
 aD2: Integer);
function evReplaceInPara(const aList: InevPara;
 const aSearcher: IevSearcher;
 const aReplacer: IevReplacer;
 const aConfirm: InevConfirm = nil;
 const aFromPoint: InevBasePoint = nil): Boolean;
function evGetParaTextByCondition(const aPara: InevObject;
 const aSearcher: IevSearcher;
 out theText: Il3CString;
 aFormat: TevFormat = cf_Text): Boolean;
function evCheckParaTextByCondition(const aPara: InevPara;
 const aSearcher: IevSearcher): Boolean;
function evGetParaTextByMask(const aPara: InevObject;
 const aMask: AnsiString;
 out theText: Il3CString;
 aIgnoreCase: Boolean = True;
 aFormat: TevFormat = cf_Text): Boolean;
function evCheckParaTextByMask(const aPara: InevPara;
 const aMask: AnsiString;
 aIgnoreCase: Boolean = True): Boolean;
function evFindNumberedPara(const aPara: InevObject;
 aSearchDown: Boolean = False;
 aDivergentSearch: Boolean = True): InevLeafPara;
 {* Ищет ближайший нумерованный параграф,
    aSearchDown - искать сначала вниз, иначе искать сначала вверх
    aDivergentSearch - если в одну сторону не нашли - искать в противоположную }
function evPrevOverallPara(const aPara: InevPara): InevPara;
 {* Ищет предыдущий параграф, с заходом в родителей }
function evNextOverallPara(const aPara: InevPara): InevPara;
 {* Ищет следующий параграф, с заходом в родителей }
function evAsString(const aData: IevdDataObject;
 aFormat: Tl3ClipboardFormat = cf_Text;
 StoreParaEnd: Boolean = False;
 const aFilters: Ik2TagGenerator = nil): Il3CString;
 {* Преобразует объект данных к строке. Замена IevDataObject.AsString }
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , evSearch
 , nevConfirm
 , l3Base
 , evExcept
 {$If Defined(evNeedEditableCursors)}
 , evParaUtilClasses
 {$IfEnd} // Defined(evNeedEditableCursors)
 , evEditorInterfaces
 , k2Tags
 , l3Memory
 , evMsgCode
 , evOp
 , l3Chars
 , l3InterfacedString
 , evCursorTools
 , l3String
 , k2OpMisc
 , SysUtils
 , TableCell_Const
 , ParaList_Const
 , TextPara_Const
 , k2Context
 , Block_Const
 , LeafPara_Const
 , Formula_Const
 , DecorTextPara_Const
 , Document_Const
 , LeafParaDecorationsHolder_Const
 , k2Const
 , evdStyles
 , evdFrame_Const
;

function evInPara(anAtom: Tl3Variant;
 aTypeID: Tk2Type;
 const anExclude: array of Tl3VariantDef;
 out theParent: Tl3Variant): Boolean;
 {* Возвращает является ли атом anAtom или кто-то из его владельцев наследником от aTypeID.  theParent - найденный владелец подходящего типа. Можно задавать исключения в наследовании }
var l_Parent: Tl3Variant;
//#UC START# *4A829D3500A9_47F1F3BC0330_var*
//#UC END# *4A829D3500A9_47F1F3BC0330_var*
begin
//#UC START# *4A829D3500A9_47F1F3BC0330_impl*
 Result := false;
 l_Parent := anAtom.AsObject;
 while (l_Parent <> nil) AND l_Parent.IsValid do
 begin
  if l_Parent.IsKindOf(aTypeID, anExclude) then
  begin
   theParent := l_Parent;
   Result := True;
   Break;
  end;//l_Parent.IhneritsFrom(aTypeID)
  l_Parent := l_Parent.Owner;
 end;//while l_Parent.IsValid
//#UC END# *4A829D3500A9_47F1F3BC0330_impl*
end;//evInPara

function evIsInReadOnlyPara(const aPara: InevPara): Boolean;
var l_Container: InevDocumentContainer;
var l_E: IevF1LikeEditor;
//#UC START# *4A8C2CE10376_47F1F3BC0330_var*
//#UC END# *4A8C2CE10376_47F1F3BC0330_var*
begin
//#UC START# *4A8C2CE10376_47F1F3BC0330_impl*
 l_Container := aPara.DocumentContainer;
 if (l_Container = nil) then
  Result := false
 else
 if (l_Container.TextSource <> nil) AND
    l_Container.TextSource.CastAnyEditorTo(IevF1LikeEditor, l_E) AND
    l_E.IsInReadOnlyPara(aPara, false) then
  Result := true
 else
  Result := false; 
//#UC END# *4A8C2CE10376_47F1F3BC0330_impl*
end;//evIsInReadOnlyPara

function evDeleteIfReadOnly(const aPara: InevPara): Boolean;
var l_Container: InevDocumentContainer;
var l_E: IevF1LikeEditor;
//#UC START# *4A8C2EBB03A8_47F1F3BC0330_var*
//#UC END# *4A8C2EBB03A8_47F1F3BC0330_var*
begin
//#UC START# *4A8C2EBB03A8_47F1F3BC0330_impl*
 l_Container := aPara.DocumentContainer;
 if (l_Container = nil) then
  Result := false
 else
 if (l_Container.TextSource <> nil) AND
    l_Container.TextSource.CastAnyEditorTo(IevF1LikeEditor, l_E) AND
    l_E.IsInReadOnlyPara(aPara, true) then
  Result := true
 else
  Result := false; 
//#UC END# *4A8C2EBB03A8_47F1F3BC0330_impl*
end;//evDeleteIfReadOnly

function evInPara(aFi: TnevFormatInfoPrim;
 aTypeID: Tk2Type;
 out theParent: Tl3Variant): Boolean;
//#UC START# *4E5E693B0035_47F1F3BC0330_var*
var
 l_Parent : TnevFormatInfoPrim;
 l_Obj    : Tl3Variant;
//#UC END# *4E5E693B0035_47F1F3BC0330_var*
begin
//#UC START# *4E5E693B0035_47F1F3BC0330_impl*
 Result := false;
 l_Parent := aFI;
 while (l_Parent <> nil) do
 begin
  l_Obj := l_Parent.Obj.AsObject;
  if l_Obj.IsKindOf(aTypeID) then
  begin
   theParent := l_Obj;
   Result := True;
   Break;
  end;//l_Parent.IhneritsFrom(aTypeID)
  l_Parent := l_Parent.ParentInfo;
 end;//while l_Parent.IsValid
//#UC END# *4E5E693B0035_47F1F3BC0330_impl*
end;//evInPara

function evMergeParaListWithNext(const aView: InevView;
 const aParaList: InevParaList;
 aType: TevMergeParaListType;
 const aProcessor: InevProcessor;
 aFinish: Integer = MaxInt;
 const anIndicator: InevProgress = nil): Boolean;
 {* Объединяет список параграфов со следующим }
//#UC START# *4F6AE2E80217_47F1F3BC0330_var*
var
 l_Point    : InevBasePoint;
 l_NextList : InevPara;
 l_ListID   : Integer;
 l_OpPack   : InevOp;
 l_ListEnd  : InevPoint;
 l_SubID    : Integer;
 l_SubList  : InevSubList;
 l_Sub      : IevSub;
//#UC END# *4F6AE2E80217_47F1F3BC0330_var*
begin
//#UC START# *4F6AE2E80217_47F1F3BC0330_impl*
 Result := False;
 l_Point := aParaList.MakePoint;
 try
  if (aProcessor = nil) then
   l_OpPack := nil
  else
   l_OpPack := aProcessor.StartOp(ev_msgInsertPara);
  try
   l_Point := l_Point.PointToParent;   
   with l_Point do
   begin
    l_ListID := Position;
    with l_Point.Obj.AsPara.AsList do
     if (l_ListID <= aFinish) AND (l_ListID < AsObject.ChildrenCount) then
     begin
      l_NextList := Para[l_ListID];
      // - Берем следующий параграф
      if not l_NextList.AsObject.IsKindOf(aParaList.AsObject.TagType) then
      begin
       // - Если следующий параграф не таблица, то выходим
       if aType <> ev_mtlTables then
        Exit;
       Inc(l_ListID);
       if (l_ListID <= aFinish) AND
          (l_ListID < AsObject.ChildrenCount) AND
          (l_NextList.AsObject.ChildrenCount <= 0) then
       begin
        l_NextList := Para[l_ListID];
        if not l_NextList.AsObject.IsKindOf(aParaList.AsObject.TagType) then
        // - Если следующий параграф не таблица, то выходим
         Exit;
        Para[l_ListID - 1].Edit.Delete(False, k2StartOp(aProcessor, ev_msgDeletePara));
       end//l_ListID <= aFinish..
       else
        Exit;
        // - Если следующий параграф не пустой, то выходим
      end;//not l_NextList.IsKindOf(aParaList.TagType)
      //l_ListID <..
     end
     else
      Exit;
   end;//with l_Point
   Result := evMergeParaList(aView,
                             l_Point.Inner,
                             l_NextList.AsList,
                             aType,
                             l_OpPack,
                             0,
                             @l_ListEnd,
                             anIndicator);
   try
    if Result AND (l_NextList.AsObject.ChildrenCount <= 0) then
    begin
     l_SubID := -1;
     with l_NextList do
      if AsObject.IsKindOf(k2_typBlock) then
       with AsObject.Attr[k2_tiHandle] do
        if IsValid then
         l_SubID := AsLong;
     if l_NextList.Edit.Delete(False, k2StartOp(aProcessor, ev_msgDeletePara)) AND
        (l_SubID > 0) then
     begin
      // - Удаляем следующий список параграфов
      l_SubList := aParaList.MainSubList;
      if (l_SubList <> nil) then
       try
        l_Sub := l_SubList.Sub[l_SubID];
        try
         if l_ListEnd.MostInner.Move(aView,ev_ocCharRight) then
          l_Sub.SetTo(l_ListEnd.MostInner.Obj^.AsObject);
          // - Устанавливаем метку вместо блока
        finally
         l_Sub := nil;
        end;//try..finally
       finally
        l_SubList := nil;
       end;//try..finally
     end;//l_NextList.Edit..
    end;//Result..
   finally
    l_ListEnd := nil;
   end;//try..finally
  finally
   l_OpPack := nil;
  end;//try..finally
 finally
  l_Point := nil;
 end;//try..finally
//#UC END# *4F6AE2E80217_47F1F3BC0330_impl*
end;//evMergeParaListWithNext

function evHasOwnStyle(const anObject: InevObjectPrim): Boolean;
//#UC START# *4FBDEF6A019B_47F1F3BC0330_var*
//#UC END# *4FBDEF6A019B_47F1F3BC0330_var*
begin
//#UC START# *4FBDEF6A019B_47F1F3BC0330_impl*
 Result := anObject.AsObject.Attr[k2_tiStyle].IsValid and (anObject.AsObject.IntA[k2_tiStyle] <> k2_TransparentValue);
//#UC END# *4FBDEF6A019B_47F1F3BC0330_impl*
end;//evHasOwnStyle

procedure evSetStyle2Block(aTag: Tl3Variant;
 const anOp: InevOp;
 aStyleID: Integer);
//#UC START# *4FD84DC20233_47F1F3BC0330_var*
var
 l_Para: InevPara;
//#UC END# *4FD84DC20233_47F1F3BC0330_var*
begin
//#UC START# *4FD84DC20233_47F1F3BC0330_impl*
 if aTag.QT(InevPara, l_Para) then
 begin
  if aStyleID = ev_saEmpty then
  begin
   if l_Para.AsObject.Attr[k2_tiStyle].IsValid then
    l_Para.AsObject.AttrW[k2_tiStyle, anOp] := nil;
  end // if aStyleID = 0 then
  else
   l_Para.AsObject.IntW[k2_tiStyle, anOp] := aStyleID;
  l_Para := l_Para.Prev;
  if (l_Para <> nil) and l_Para.AsObject.IsValid and l_Para.AsObject.IsKindOf(k2_typBlock) and evHasOwnStyle(l_Para) then
   l_Para.Invalidate([nev_spExtent]);
 end // if aTag.QT(InevPara, l_Para) then
 else
  Assert(False);
//#UC END# *4FD84DC20233_47F1F3BC0330_impl*
end;//evSetStyle2Block

function evHasAACStyle(aPara: Tl3Variant): Boolean;
 {* Проверяет принадлежит ли стиль параграфа к стилям, используемым в ААК. }
//#UC START# *50629BBB03DC_47F1F3BC0330_var*
var
 l_StyleID: Integer;
//#UC END# *50629BBB03DC_47F1F3BC0330_var*
begin
//#UC START# *50629BBB03DC_47F1F3BC0330_impl*
 Result := aPara.Attr[k2_tiStyle].IsValid;
 if Result then
 begin
  l_StyleID := aPara.IntA[k2_tiStyle];
  Result := EvAACStyle(l_StyleID);
 end; // if Result then
//#UC END# *50629BBB03DC_47F1F3BC0330_impl*
end;//evHasAACStyle

function evAACStyle(aStyleID: Integer): Boolean;
//#UC START# *5069781D0126_47F1F3BC0330_var*
//#UC END# *5069781D0126_47F1F3BC0330_var*
begin
//#UC START# *5069781D0126_47F1F3BC0330_impl*
 Result := ((aStyleID >= ev_saHLE6) and (ev_saHLE1 >= aStyleID));
 if not Result then
  Result := (aStyleID = ev_saFormulaInAAC) or (aStyleID = ev_saAttention) or
            (aStyleID = ev_saWriteToUs);
//#UC END# *5069781D0126_47F1F3BC0330_impl*
end;//evAACStyle

procedure evSetStyle2Table(aTag: Tl3Variant;
 const anOp: InevOp;
 aStyleID: Integer);
//#UC START# *52B15CA1039C_47F1F3BC0330_var*

 function lp_IterateRow(aRow: Tl3Variant; Index: LongInt): Boolean;

  function lp_ClearCellsFrame(aCell: Tl3Variant; Index: LongInt): Boolean;
  begin
   aCell.IntW[k2_tiFrame, anOp] := evd_fvEmpty;
   Result := True;
  end;

 begin
  aRow.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_ClearCellsFrame));
  Result := True;
 end;

var
 l_Para: InevPara;
//#UC END# *52B15CA1039C_47F1F3BC0330_var*
begin
//#UC START# *52B15CA1039C_47F1F3BC0330_impl*
 if aTag.QT(InevPara, l_Para) then
 begin
  if aStyleID = ev_saEmpty then
  begin
   if l_Para.AsObject.Attr[k2_tiStyle].IsValid then
    l_Para.AsObject.AttrW[k2_tiStyle, anOp] := nil;
  end // if aStyleID = 0 then
  else
  begin
   l_Para.AsObject.IntW[k2_tiStyle, anOp] := aStyleID;
   l_Para.AsObject.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_IterateRow));
  end;
 end // if aTag.QT(InevPara, l_Para) then
 else
  Assert(False);
//#UC END# *52B15CA1039C_47F1F3BC0330_impl*
end;//evSetStyle2Table

function evExpandedText(aPara: Tl3Variant): Boolean;
//#UC START# *5519015202C1_47F1F3BC0330_var*
//#UC END# *5519015202C1_47F1F3BC0330_var*
begin
//#UC START# *5519015202C1_47F1F3BC0330_impl*
 Result := aPara.Attr[k2_tiStyle].IsValid;
 if Result then
  Result := aPara.Attr[k2_tiStyle].BoolA[k2_tiCollapsable];
//#UC END# *5519015202C1_47F1F3BC0330_impl*
end;//evExpandedText

procedure evCheckCollapsed(const anObject: Tl3Variant;
 var aValue: Boolean);
//#UC START# *5523B5A1010B_47F1F3BC0330_var*
//#UC END# *5523B5A1010B_47F1F3BC0330_var*
begin
//#UC START# *5523B5A1010B_47F1F3BC0330_impl*
 {$IFNDEF Nemesis}
 if anObject.IsKindOf(k2_typLeafPara) then
  with anObject do
  begin
   if IsKindOf(k2_typTextPara) and not IsKindOf(k2_typFormula) then
    if IntA[k2_tiStyle] <> Ord(ev_saChangesInfo) then
     aValue := False;
  end; // with anObject.AsObject do
 {$ENDIF Nemesis}  
//#UC END# *5523B5A1010B_47F1F3BC0330_impl*
end;//evCheckCollapsed

function EvParentGetLeftIndent(aPara: Tl3Variant): Integer;
//#UC START# *5530AB81002B_47F1F3BC0330_var*
var
 l_Style: Tl3Variant;
//#UC END# *5530AB81002B_47F1F3BC0330_var*
begin
//#UC START# *5530AB81002B_47F1F3BC0330_impl*
 Result := 0;
 l_Style := aPara.Owner.Attr[k2_tiStyle];
 if l_Style.IsValid then
  Result := l_Style.IntA[k2_tiLeftIndent];
//#UC END# *5530AB81002B_47F1F3BC0330_impl*
end;//EvParentGetLeftIndent

function evExpandOrCollapse(const aView: InevControlView;
 const aTextPara: InevPara): Boolean;
//#UC START# *5530BEFD0336_47F1F3BC0330_var*
var
 l_Block    : InevPara;
 l_SubCache : IevSubCache;
 l_Collapsed: Boolean;
//#UC END# *5530BEFD0336_47F1F3BC0330_var*
begin
//#UC START# *5530BEFD0336_47F1F3BC0330_impl*
 l_Block := aTextPara.OwnerPara;
 l_Collapsed := not aView.IsObjectCollapsed[l_Block];
 if EvExpandedText(l_Block.AsObject) then
 begin
  aView.IsObjectCollapsed[l_Block] := l_Collapsed;
  if Supports(aView.Control, IevSubCache, l_SubCache) then
   l_SubCache.ClearSubs;
 end;
 Result := true;
//#UC END# *5530BEFD0336_47F1F3BC0330_impl*
end;//evExpandOrCollapse

function evBlockCollapsed(const aView: InevView;
 const aTextPara: InevPara): Boolean;
//#UC START# *55B785E003CD_47F1F3BC0330_var*
var
 l_Block    : InevPara;
 l_Collapsed: Boolean;
//#UC END# *55B785E003CD_47F1F3BC0330_var*
begin
//#UC START# *55B785E003CD_47F1F3BC0330_impl*
 l_Block := aTextPara.OwnerPara;
 Result := aView.IsObjectCollapsed[l_Block];
//#UC END# *55B785E003CD_47F1F3BC0330_impl*
end;//evBlockCollapsed

function evHeaderTextPara(const aPara: InevObjectPrim): Boolean;
//#UC START# *552FA1280185_47F1F3BC0330_var*
var
 l_Parent : Tl3Variant;
//#UC END# *552FA1280185_47F1F3BC0330_var*
begin
//#UC START# *552FA1280185_47F1F3BC0330_impl*
 l_Parent := aPara.Owner;
 Result := l_Parent.IsValid and l_Parent.IsKindOf(k2_typBlock) and not l_Parent.IsKindOf(k2_typDocument) and EvExpandedText(l_Parent);
 if Result then
  if aPara.IsKindOf(k2_typLeafPara) then
   if aPara.IsKindOf(k2_typDecorTextPara) then
    Result := False
   else
   begin
    Result := (aPara.PID = 0);
    if not Result and (aPara.PID = 1) then
     Result := aPara.Owner.Child[0].IsKindOf(k2_typDecorTextPara);
   end
  else
   Result := (aPara.PID = 0)
//#UC END# *552FA1280185_47F1F3BC0330_impl*
end;//evHeaderTextPara

procedure evExpandOwnerStyleBlocks(const aPara: InevObject;
 const aView: InevControlView);
//#UC START# *55F7F2C60135_47F1F3BC0330_var*
var
  l_OwnerPara: InevObjectList;
//#UC END# *55F7F2C60135_47F1F3BC0330_var*
begin
//#UC START# *55F7F2C60135_47F1F3BC0330_impl*
 if aPara.IsKindOf(k2_typLeafPara) then
 begin
  l_OwnerPara := aPara.OwnerObj;
  while (l_OwnerPara <> nil) and l_OwnerPara.IsValid do
  begin
   if EvExpandedText(l_OwnerPara.AsObject) and aView.IsObjectCollapsed[l_OwnerPara] then
    aView.IsObjectCollapsed[l_OwnerPara] := False;
   l_OwnerPara := l_OwnerPara.OwnerObj;
  end; //while (l_Owner <> nil) do
 end // if aPara.IsKindOf(k2_typLeafPara) then
 else
  if EvExpandedText(aPara.AsObject) then
   aView.IsObjectCollapsed[aPara] := False;
//#UC END# *55F7F2C60135_47F1F3BC0330_impl*
end;//evExpandOwnerStyleBlocks

function evNeedDrawParaInCollapsedMode(const aPara: InevObjectPrim): Boolean;
//#UC START# *5600F8C80213_47F1F3BC0330_var*
//#UC END# *5600F8C80213_47F1F3BC0330_var*
begin
//#UC START# *5600F8C80213_47F1F3BC0330_impl*
 Result := ((aPara.PID = 0) and aPara.IsKindOf(k2_typDecorTextPara)) or EvHeaderTextPara(aPara);
//#UC END# *5600F8C80213_47F1F3BC0330_impl*
end;//evNeedDrawParaInCollapsedMode

function evHeaderTextPara(aPara: Tl3Variant): Boolean;
//#UC START# *5603D8AD0108_47F1F3BC0330_var*
var
 l_Para: InevPara;
//#UC END# *5603D8AD0108_47F1F3BC0330_var*
begin
//#UC START# *5603D8AD0108_47F1F3BC0330_impl*
 aPara.QT(InevPara, l_Para);
 Result := EvHeaderTextPara(l_Para);
//#UC END# *5603D8AD0108_47F1F3BC0330_impl*
end;//evHeaderTextPara

function evInBlock(anAtom: Tl3Variant;
 aViewKind: TevBlockViewKind;
 out theParent: Tl3Variant): Boolean;
//#UC START# *5715E58F019A_47F1F3BC0330_var*
//#UC END# *5715E58F019A_47F1F3BC0330_var*
begin
//#UC START# *5715E58F019A_47F1F3BC0330_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E58F019A_47F1F3BC0330_impl*
end;//evInBlock

function evCheckParaOwner(aPara: Tl3Variant): Tl3Variant;
//#UC START# *57187A09034A_47F1F3BC0330_var*
//#UC END# *57187A09034A_47F1F3BC0330_var*
begin
//#UC START# *57187A09034A_47F1F3BC0330_impl*
 !!! Needs to be implemented !!!
//#UC END# *57187A09034A_47F1F3BC0330_impl*
end;//evCheckParaOwner

function evCheckParaOwner(const aPara: InevPara): InevPara;
//#UC START# *57187A510399_47F1F3BC0330_var*
//#UC END# *57187A510399_47F1F3BC0330_var*
begin
//#UC START# *57187A510399_47F1F3BC0330_impl*
 !!! Needs to be implemented !!!
//#UC END# *57187A510399_47F1F3BC0330_impl*
end;//evCheckParaOwner

function evSearchPara(const aList: InevObject;
 const aSearcher: IevSearcher;
 out aPara: InevObject;
 StopOnBlock: Boolean = False;
 aBlock: PIevDataObject = nil): Boolean;
//#UC START# *47F1F3EF01BC_47F1F3BC0330_var*
{$IfDef evUseVisibleCursors}
var
 l_Block    : InevRange;
 l_Cursor   : InevPoint;
 l_Searcher : IevSearcher;
 l_BC       : TevBlockCollector;
{$EndIf evUseVisibleCursors} 
//#UC END# *47F1F3EF01BC_47F1F3BC0330_var*
begin
//#UC START# *47F1F3EF01BC_47F1F3BC0330_impl*
 Result := false;
 {$IfDef evUseVisibleCursors}
 l_Block := aList.Range;
 try
  l_Cursor := aList.MakePoint;
  try
   try
    if StopOnBlock then
     l_Searcher := TevOneLevelSearcher.Make(aList.AsObject, aSearcher)
    else
     l_Searcher := aSearcher;
    if (aBlock <> nil) then
     l_BC := TevBlockCollector.Create
    else
     l_BC := nil;
    try
     l_Block.SearchReplace(l_Searcher, l_BC, TnevConfirm.Make, l_Cursor);
     Result := True;
     aPara := l_Cursor.MostInner.Obj^;
     if (aBlock <> nil) then
      aBlock^ := l_BC.Block;
    finally
     l3Free(l_BC);
    end;//try..finally
   except
    on EevSearchFailed do
     Exit;
   end;//try..except
  finally
   l_Cursor := nil;
  end;//try..finally
 finally
  l_Block := nil;
 end;//try..finally
 {$Else evUseVisibleCursors}
 Assert(false);
 {$EndIf evUseVisibleCursors}
//#UC END# *47F1F3EF01BC_47F1F3BC0330_impl*
end;//evSearchPara

function evSearchPara(aList: Tl3Variant;
 const aSearcher: IevSearcher;
 out aBlock: IevdDataObject): Boolean;
//#UC START# *47F1F42F032D_47F1F3BC0330_var*
var
 l_ParaList : InevPara;
 l_Para     : InevObject;
//#UC END# *47F1F42F032D_47F1F3BC0330_var*
begin
//#UC START# *47F1F42F032D_47F1F3BC0330_impl*
 aList.QT(InevPara, l_ParaList);
 Result := evSearchPara(l_ParaList, aSearcher, l_Para, False, @aBlock);
//#UC END# *47F1F42F032D_47F1F3BC0330_impl*
end;//evSearchPara

function evQueryParaInterface(const aView: InevView;
 const aContext: InevProcessor;
 const aTagWrap: InevPara;
 const anIID: Tl3GUID;
 out Obj): hResult;
 {* Возвращает интерфейс anIID для aTagWrap и aContext }
//#UC START# *48E4E9370259_47F1F3BC0330_var*
{$IfDef evUseVisibleCursors}
var
 l_Point : InevBasePoint;
 l_Table : TevTable;
{$EndIf evUseVisibleCursors}
//#UC END# *48E4E9370259_47F1F3BC0330_var*
begin
//#UC START# *48E4E9370259_47F1F3BC0330_impl*
 Result := E_NoInterface;
 Pointer(Obj) := nil;
 {$IfDef evUseVisibleCursors}
 if (aTagWrap <> nil) AND aTagWrap.AsObject.IsValid AND
    (aContext <> nil) then
   with aTagWrap do
   begin
    l_Point := MakePoint;
    try
     if anIID.EQ(IedTable) OR anIID.EQ(IedCell) OR anIID.EQ(IedColumn) then
     begin
      if AsObject.IsKindOf(k2_typTableCell) then
       l_Point := l_Point.PointToParent(OwnerPara.OwnerPara)
      else
       Exit;
      l_Table := TevTable.Create(aView, l_Point.Obj^.AsObject, aContext, l_Point);
      try
       if anIID.EQ(IedTable) then
       begin
        IedTable(Obj) := l_Table;
        Result := S_Ok;
       end//anIID.EQ(IedTable)
       else
       if anIID.EQ(IedColumn) then
       begin
        IedColumn(Obj) := IedTable(l_Table).Column;
        if (Pointer(Obj) <> nil) then
         Result := S_Ok;
       end//anIID.EQ(IedColumn)
       else
       begin
        IedCell(Obj) := IedTable(l_Table).Cell;
        if (Pointer(Obj) <> nil) then
         Result := S_Ok;
       end;//..IedTable
      finally
       l3Free(l_Table);
      end;//try..finally
     end;//..IedTable..
    finally
     l_Point := nil;
    end;//try..finally
   end;//with aTagWrap
 {$Else  evUseVisibleCursors}
 Assert(false);  
 {$EndIf evUseVisibleCursors}
//#UC END# *48E4E9370259_47F1F3BC0330_impl*
end;//evQueryParaInterface

procedure evClearPara(const aView: InevView;
 const aPara: InevObject;
 const anOp: InevOp;
 aMode: TevClearMode = nevTools.ev_cmKeepOne;
 const aTopPara: InevPara = nil);
 {* Очищает параграф aPara }
//#UC START# *48E4E992004F_47F1F3BC0330_var*

 procedure ClearSubs(aPara : Tl3Variant);
 var
  l_Index : Integer;
 begin//ClearSubs
  with aPara do
  begin
   AttrW[k2_tiSubs, anOp] := nil;
   if aMode <> ev_cmLeaveSegments then
    AttrW[k2_tiSegments, anOp] := nil;
   if IsKindOf(k2_typParaList) then
    for l_Index := 0 to Pred(ChildrenCount) do
     ClearSubs(Child[l_Index]);
  end;//with aPara
 end;//ClearSubs

//#UC END# *48E4E992004F_47F1F3BC0330_var*
begin
//#UC START# *48E4E992004F_47F1F3BC0330_impl*
 ClearSubs(aPara.AsObject);
 if aMode = ev_cmLeaveSegments then
  aMode := ev_cmKeepOne;
 aPara.Range.Modify.Delete(aView, anOp, aMode, aTopPara);
//#UC END# *48E4E992004F_47F1F3BC0330_impl*
end;//evClearPara

function evCopyParaList(const aView: InevView;
 const aContext: InevProcessor;
 const aDest: InevPara;
 const aSource: InevPara;
 aFlags: TevLoadFlags = nevBase.evDefaultCopyFlags;
 SkipEmpty: Boolean = False;
 const aStart: InevPoint = nil;
 NeedDelete: Boolean = False): Boolean;
 {* Копирует содержимое из aSource в aDest }
//#UC START# *48E4E9B50256_47F1F3BC0330_var*
{$IfDef evUseVisibleCursors}
var
 l_MemPool : Tl3MemoryPool;
 l_Block   : InevRange;
 l_Cursor  : InevPoint;
 l_OpPack  : InevOp;
{$EndIf evUseVisibleCursors}
//#UC END# *48E4E9B50256_47F1F3BC0330_var*
begin
//#UC START# *48E4E9B50256_47F1F3BC0330_impl*
 Result := False;
 {$IfDef evUseVisibleCursors}
 if (aDest <> nil) AND (aSource <> nil) then
 begin
  if SkipEmpty then
  begin
   with aSource do
   begin
    case AsObject.ChildrenCount of
     0 : Exit;
     1 : begin
      with AsObject.Child[0] do
      begin
       if AsObject.IsKindOf(k2_typTextPara) then
       begin
        with AsObject.Attr[k2_tiText] do
         if not IsValid OR (AsObject As Tl3CustomString).Empty then
          Exit;
       end;//k2_idTextPara
      end;//with Child[0]
     end;//1
    end;//case ChildrenCount
   end;//with aSource
  end;//SkipEmpty
  if aContext = nil then
   l_OpPack := nil
  else
   l_OpPack := aContext.StartOp(ev_msgInsertPara);
  try
   Result := True;
   l_MemPool := Tl3MemoryPool.Create;
   try
    try
     l_Block := aSource.Range(aStart, nil);
     if not l_Block.Data.Store(cf_EverestBin, l_MemPool As IStream, nil, evDefaultStoreFlags + [evd_sfChildrenOnly] - [evd_sfInternal]) then
      Exit;
     if NeedDelete then
      l_Block.Modify.Delete(aView, l_OpPack, ev_cmKeepOne);
    finally
     l_Block := nil;
    end;//try..finally
    l_Cursor := aDest.MakePoint;
    try
     if (ev_lfAtEnd in aFlags) then
      l_Cursor.Move(aView, ev_ocBottomRight)
     else
      l_Cursor.Move(aView, ev_ocTopLeft);
     l_Cursor.Text.Modify.InsertStream(aView, l_MemPool As IStream, cf_EverestBin, l_OpPack, aFlags);
    finally
     l_Cursor := nil;
    end;//try..finally
   finally
    l3Free(l_MemPool);
   end;//try..finally
  finally
   l_OpPack := nil;
  end;//try..finally
 end;//aDest <> nil..
 {$Else  evUseVisibleCursors}
 Assert(false);
 {$EndIf evUseVisibleCursors}
//#UC END# *48E4E9B50256_47F1F3BC0330_impl*
end;//evCopyParaList

function evMergeParaText(const aView: InevView;
 const aParaList: InevParaList;
 const anOpPack: InevOp = nil): Boolean;
 {* Объединяет текст списка параграфов }
//#UC START# *48E4EA2D0094_47F1F3BC0330_var*
var
 l_Cursor : InevPoint;
 l_Next   : InevPara;
 l_Space  : Tl3InterfacedString;
//#UC END# *48E4EA2D0094_47F1F3BC0330_var*
begin
//#UC START# *48E4EA2D0094_47F1F3BC0330_impl*
 Result := False;
 with aParaList do
  if (AsObject.ChildrenCount > 1) then
  begin
   l_Cursor := Para[0].MakePoint;
   try
    l_Space := Tl3InterfacedString.Make(l3PCharLen(AnsiString(cc_HardSpace)));
    try
     while (AsObject.ChildrenCount > 1) do
     begin
      l_Next := Para[1];
      with l_Cursor.Obj.AsObject.Attr[k2_tiText] do
       if IsValid AND not (AsObject As Tl3CustomString).Empty then
       begin
        if l_Cursor.Move(aView,ev_ocBottomRight) then
         l_Cursor.Text.Modify.InsertString(aView, l_Space, anOpPack);
       end;//IsValid
      if (l_Cursor.Text.Modify.JoinWith(aView, l_Next.AsObject, anOpPack) >= 0) then
      begin
       Result := True;
       if not l_Next.Edit.Delete(False, anOpPack) then
        Break;
      end//...JoinWith(l_Cursor, l_Next, anOpPack) >= 0
      else
       Break;
     end;//while (ChildrenCount > 1)
    finally
     l3Free(l_Space);
    end;//try..finally
   finally
    l_Cursor := nil;
   end;//try..finally
  end;//ChildrenCount > 2
//#UC END# *48E4EA2D0094_47F1F3BC0330_impl*
end;//evMergeParaText

function evInPara(anAtom: Tl3Variant;
 aTypeID: Tk2Type;
 out theParent: Tl3Variant): Boolean;
 {* Возвращает является ли атом anAtom или кто-то из его владельцев наследником от aTypeID.
       theParent - найденный владелец подходящего типа }
//#UC START# *48E4EE7002FB_47F1F3BC0330_var*
var
 l_Parent : Tl3Variant;
//#UC END# *48E4EE7002FB_47F1F3BC0330_var*
begin
//#UC START# *48E4EE7002FB_47F1F3BC0330_impl*
 Result := false;
 l_Parent := anAtom.AsObject;
 while (l_Parent <> nil) AND l_Parent.IsValid do
 begin
  if l_Parent.IsKindOf(aTypeID) then
  begin
   theParent := l_Parent;
   Result := True;
   Break;
  end;//l_Parent.IhneritsFrom(aTypeID)
  l_Parent := l_Parent.Owner;
 end;//while l_Parent.IsValid
//#UC END# *48E4EE7002FB_47F1F3BC0330_impl*
end;//evInPara

function evInPara(anAtom: Tl3Variant;
 aTypeID: Tk2Type): Boolean;
 {* Возвращает является ли атом anAtom или кто-то из его владельцев наследником от aTypeID }
//#UC START# *48E4EE990334_47F1F3BC0330_var*
var
 l_Parent : Tl3Variant;
//#UC END# *48E4EE990334_47F1F3BC0330_var*
begin
//#UC START# *48E4EE990334_47F1F3BC0330_impl*
 Result := evInPara(anAtom, aTypeID, l_Parent);
//#UC END# *48E4EE990334_47F1F3BC0330_impl*
end;//evInPara

function evHasText(anAtom: Tl3Variant): Boolean;
 {* Возвращает есть ли у параграфа непустой текст }
//#UC START# *48E4EEB300BF_47F1F3BC0330_var*
//#UC END# *48E4EEB300BF_47F1F3BC0330_var*
begin
//#UC START# *48E4EEB300BF_47F1F3BC0330_impl*
 Result := evTextLength(anAtom) > 0;
//#UC END# *48E4EEB300BF_47F1F3BC0330_impl*
end;//evHasText

function evTextLength(anAtom: Tl3Variant): Integer;
 {* Возвращает длину текста параграфа }
//#UC START# *48E4EEC2031D_47F1F3BC0330_var*
//#UC END# *48E4EEC2031D_47F1F3BC0330_var*
begin
//#UC START# *48E4EEC2031D_47F1F3BC0330_impl*
 Result := anAtom.PCharLenA[k2_tiText].SLen;
//#UC END# *48E4EEC2031D_47F1F3BC0330_impl*
end;//evTextLength

procedure evMoveBorders(const aView: InevView;
 var aBlock: IevdDataObject;
 aD1: Integer;
 aD2: Integer);
//#UC START# *48E4EED700C0_47F1F3BC0330_var*
var
 l_Sel   : InevRange;
 l_S     : InevBasePoint;
 l_F     : InevBasePoint;
 l_Block : InevRangeFactory;
//#UC END# *48E4EED700C0_47F1F3BC0330_var*
begin
//#UC START# *48E4EED700C0_47F1F3BC0330_impl*
 l_Sel := aBlock As InevRange;
 l_Sel.GetBorderPoints(l_S, l_F);
 with l_S.MostInner do
  PositionW := Position + aD1;
 with l_F.MostInner do
  PositionW := Position + aD2;
 if Supports(l_Sel, InevRangeFactory, l_Block) then
 begin
  l_Block.Init(l_S, l_F);
  aBlock := l_Block.Data;
 end;
//#UC END# *48E4EED700C0_47F1F3BC0330_impl*
end;//evMoveBorders

function evReplaceInPara(const aList: InevPara;
 const aSearcher: IevSearcher;
 const aReplacer: IevReplacer;
 const aConfirm: InevConfirm = nil;
 const aFromPoint: InevBasePoint = nil): Boolean;
//#UC START# *48E4EEF300D4_47F1F3BC0330_var*
var
 l_Block   : InevRange;
 l_Op      : Tk2Context;
 l_Confirm : InevConfirm;
//#UC END# *48E4EEF300D4_47F1F3BC0330_var*
begin
//#UC START# *48E4EEF300D4_47F1F3BC0330_impl*
 Result := false;
 l_Block := aList.Range;
 try
  l_Op := Tk2Context.Create(nil);
  try
   try
    if aConfirm <> nil then
     l_Confirm := aConfirm
    else
     l_Confirm := TnevConfirm.Make;
    l_Block.SearchReplace(aSearcher, aReplacer, l_Confirm, aFromPoint, l_Op);
    Result := true;
   except
    on EevSearchFailed do
     Exit;
   end;//try..except
  finally
   FreeAndNil(l_Op);
  end;//try..finally
 finally
  l_Block := nil;
 end;//try..finally
//#UC END# *48E4EEF300D4_47F1F3BC0330_impl*
end;//evReplaceInPara

function evGetParaTextByCondition(const aPara: InevObject;
 const aSearcher: IevSearcher;
 out theText: Il3CString;
 aFormat: TevFormat = cf_Text): Boolean;
//#UC START# *48E4EF06007B_47F1F3BC0330_var*
var
 l_Block : IevdDataObject;
 l_Para  : InevObject;
//#UC END# *48E4EF06007B_47F1F3BC0330_var*
begin
//#UC START# *48E4EF06007B_47F1F3BC0330_impl*
 if (@theText = nil) then
  Result := evSearchPara(aPara, aSearcher, l_Para, False)
 else
  Result := evSearchPara(aPara, aSearcher, l_Para, False, @l_Block);
 if Result AND (l_Block <> nil) AND (@theText <> nil) then
  try
   theText := EvAsString(l_Block, aFormat);
  finally
   l_Block := nil;
  end;//try..finally
//#UC END# *48E4EF06007B_47F1F3BC0330_impl*
end;//evGetParaTextByCondition

function evCheckParaTextByCondition(const aPara: InevPara;
 const aSearcher: IevSearcher): Boolean;
//#UC START# *48E4EF1E02EB_47F1F3BC0330_var*
var
 l_S : ^Il3CString;
//#UC END# *48E4EF1E02EB_47F1F3BC0330_var*
begin
//#UC START# *48E4EF1E02EB_47F1F3BC0330_impl*
 l_S := nil;
 Result := evGetParaTextByCondition(aPara, aSearcher, l_S^);
//#UC END# *48E4EF1E02EB_47F1F3BC0330_impl*
end;//evCheckParaTextByCondition

function evGetParaTextByMask(const aPara: InevObject;
 const aMask: AnsiString;
 out theText: Il3CString;
 aIgnoreCase: Boolean = True;
 aFormat: TevFormat = cf_Text): Boolean;
//#UC START# *48E4EF360192_47F1F3BC0330_var*
{$IfDef evUseVisibleCursors}
var
 l_Searcher : IevSearcher;
{$EndIf evUseVisibleCursors}
//#UC END# *48E4EF360192_47F1F3BC0330_var*
begin
//#UC START# *48E4EF360192_47F1F3BC0330_impl*
 {$IfDef evUseVisibleCursors}
 if aIgnoreCase then
  l_Searcher := TevRegularExpressionSearcher.Make(aMask)
 else
  l_Searcher := TevRegularExpressionSearcher.Make(aMask, [ev_soMatchCase]);
 Result := evGetParaTextByCondition(aPara, l_Searcher, theText, aFormat);
 {$Else  evUseVisibleCursors}
 Result := false;
 Assert(false);
 {$EndIf evUseVisibleCursors}
//#UC END# *48E4EF360192_47F1F3BC0330_impl*
end;//evGetParaTextByMask

function evCheckParaTextByMask(const aPara: InevPara;
 const aMask: AnsiString;
 aIgnoreCase: Boolean = True): Boolean;
//#UC START# *48E4EF550336_47F1F3BC0330_var*
var
 l_S : ^Il3CString;
//#UC END# *48E4EF550336_47F1F3BC0330_var*
begin
//#UC START# *48E4EF550336_47F1F3BC0330_impl*
 l_S := nil;
 Result := evGetParaTextByMask(aPara, aMask, l_S^, aIgnoreCase);
//#UC END# *48E4EF550336_47F1F3BC0330_impl*
end;//evCheckParaTextByMask

function evFindNumberedPara(const aPara: InevObject;
 aSearchDown: Boolean = False;
 aDivergentSearch: Boolean = True): InevLeafPara;
 {* Ищет ближайший нумерованный параграф,
    aSearchDown - искать сначала вниз, иначе искать сначала вверх
    aDivergentSearch - если в одну сторону не нашли - искать в противоположную }
//#UC START# *48E4EF6B00D3_47F1F3BC0330_var*

 function GetNumberedPara(const aPara : InevLeafPara; 
                          aPrevious   : Boolean): InevLeafPara;
 var
  l_Leaf: InevLeafPara;
 begin//GetNumberedPara
  Result := aPara;
  repeat
   if aPrevious then
    Supports(evPrevOverallPara(Result), InevLeafPara, l_Leaf)
   else
    Supports(evNextOverallPara(Result), InevLeafPara, l_Leaf);

   if l_Leaf <> nil then
    try
     Result := l_Leaf;
    finally
     l_Leaf := nil;
    end//try..finally
   else
    Result := nil;
  until (Result = nil) or (Result.AsObject.IntA[k2_tiHandle] > 0);
 end;//GetNumberedPara

var
 l_Para: InevLeafPara;
//#UC END# *48E4EF6B00D3_47F1F3BC0330_var*
begin
//#UC START# *48E4EF6B00D3_47F1F3BC0330_impl*
 Result := nil;
 if aPara.AsObject.QT(InevLeafPara, l_Para) then
 try
  if (l_Para.AsObject.IntA[k2_tiHandle] <= 0) then
  begin
   Result := GetNumberedPara(l_Para, True xor aSearchDown);
   if aDivergentSearch and (Result = nil) then
    Result := GetNumberedPara(l_Para, False xor aSearchDown);
  end
  else//l_Para.ID <= 0
   Result := l_Para;
 finally
  l_Para := nil;
 end;//try..finally
//#UC END# *48E4EF6B00D3_47F1F3BC0330_impl*
end;//evFindNumberedPara

function evPrevOverallPara(const aPara: InevPara): InevPara;
 {* Ищет предыдущий параграф, с заходом в родителей }
//#UC START# *48E4EF91007F_47F1F3BC0330_var*
var
 l_Parent : InevPara;
 l_List   : InevParaList;
 l_Leaf   : InevLeafPara;
//#UC END# *48E4EF91007F_47F1F3BC0330_var*
begin
//#UC START# *48E4EF91007F_47F1F3BC0330_impl*
 Result := aPara.Prev;
 if (Result = nil) or not Result.AsObject.IsValid then
 begin
  l_Parent := aPara.OwnerPara;
  while True do
  begin
   if (l_Parent = nil) or not l_Parent.AsObject.IsValid then
    Break
   else
    Result := l_Parent.Prev;
   if (Result = nil) or not Result.AsObject.IsValid then
    l_Parent := l_Parent.OwnerPara
   else
    Break;
  end;//while True do
 end;//Result = nil
 while True do
  // - Заходим внутрь списков параграфов
  if Result.AsObject.QT(InevParaList, l_List) then
   try
    if (l_List.ParaCount = 0) then
     Break
    else
     Result := l_List.Para[l_List.ParaCount - 1];
   finally
    l_List := nil;
   end//try..finally
  else
   Break;
 if Result.AsObject.QT(InevLeafPara, l_Leaf) then
  try
   Result := l_Leaf;
  finally
   l_Leaf := nil;
  end;//try..finally
//#UC END# *48E4EF91007F_47F1F3BC0330_impl*
end;//evPrevOverallPara

function evNextOverallPara(const aPara: InevPara): InevPara;
 {* Ищет следующий параграф, с заходом в родителей }
//#UC START# *48E4EFA1005F_47F1F3BC0330_var*
var
 l_Parent : InevPara;
 l_List   : InevParaList;
 l_Leaf   : InevLeafPara;
//#UC END# *48E4EFA1005F_47F1F3BC0330_var*
begin
//#UC START# *48E4EFA1005F_47F1F3BC0330_impl*
 Result := aPara.Next;
 if (Result = nil) or not Result.AsObject.IsValid then
 begin
  l_Parent := aPara.OwnerPara;
  while True do
  begin
   if (l_Parent = nil) or not l_Parent.AsObject.IsValid then
    Break
   else
    Result := l_Parent.Next;
   if (Result = nil) or not Result.AsObject.IsValid then
    l_Parent := l_Parent.OwnerPara
   else
    Break;
  end;//while True
 end;//Result = nil
 while True do
  // - Заходим внутрь списков параграфов
  if Result.AsObject.QT(InevParaList, l_List) then
   try
    if (l_List.ParaCount = 0) then
     break
    else
     Result := l_List.Para[0];
   finally
    l_List := nil;
   end//try..finally
  else
   Break;
 if Result.AsObject.QT(InevLeafPara, l_Leaf) then
  try
   Result := l_Leaf;
  finally
   l_Leaf := nil;
  end;//try..finally
//#UC END# *48E4EFA1005F_47F1F3BC0330_impl*
end;//evNextOverallPara

function evAsString(const aData: IevdDataObject;
 aFormat: Tl3ClipboardFormat = cf_Text;
 StoreParaEnd: Boolean = False;
 const aFilters: Ik2TagGenerator = nil): Il3CString;
 {* Преобразует объект данных к строке. Замена IevDataObject.AsString }
//#UC START# *48F5BD610106_47F1F3BC0330_var*
var
 l_String : Tl3InterfacedString;
 l_Flags  : TevStoreFlags;
 l_Stream : IStream;
//#UC END# *48F5BD610106_47F1F3BC0330_var*
begin
//#UC START# *48F5BD610106_47F1F3BC0330_impl*
 if (aData = nil) then
  Result := nil
 else
 begin
  l_String := Tl3InterfacedString.Create;
  try
   l_Flags := evDefaultStoreFlags;
   if StoreParaEnd then
    l_Flags := l_Flags + [evd_sfStoreParaEnd]
   else
    l_Flags := l_Flags - [evd_sfStoreParaEnd];
   if not l3IOk(l_String.QueryInterface(IStream, l_Stream)) then
    Assert(false);
   aData.Store(aFormat, l_Stream, aFilters, l_Flags);
   Result := l_String;
  finally
   l3Free(l_String);
  end;//try..finally
 end;//aData = nil
//#UC END# *48F5BD610106_47F1F3BC0330_impl*
end;//evAsString
{$IfEnd} // Defined(k2ForEditor)

end.
