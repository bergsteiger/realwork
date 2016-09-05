unit evCursorTools;
 {* Вспомогательные функции для работы с курсорами. }

// Модуль: "w:\common\components\gui\Garant\Everest\evCursorTools.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evCursorTools" MUID: (48453B7601F9)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevTools
 , l3Variant
 , l3Types
 , k2Base
 , evInternalInterfaces
 , nevBase
;

type
 TevBool2FlagsAtEnd = array [Boolean] of TevInsertParaFlags;

const
 AtEndFromBool: TevBool2FlagsAtEnd = ([], [ev_ipfAtEnd]);

function evMergeParaList(const aView: InevView;
 const aCursor: InevBasePoint;
 const aParaList: InevParaList;
 aType: TevMergeParaListType;
 const anOp: InevOp;
 aFrom: Integer;
 pListEnd: PIUnknown = nil;
 const anIndicator: InevProgress = nil): Boolean;
 {* объединяет список параграфов aCursor.Target с содержимым aParaList }
function evDeletePara(const anOpPack: InevOp;
 const aCursor: InevBasePoint;
 aFlags: TevDeleteParaFlags = [ev_dpfAtEnd]): Boolean;
function evInsertPara(const aProcessor: InevProcessor;
 const aCursor: InevBasePoint;
 aPara: Tl3Variant;
 aFlags: TevInsertParaFlags = [ev_ipfAtEnd]): Boolean; overload;
function evInsertPara(const anOpPack: InevOp;
 const aCursor: InevBasePoint;
 aPara: Tl3Variant;
 aFlags: TevInsertParaFlags = [ev_ipfAtEnd]): Boolean; overload;
function evCalcDiffInLines(const aView: InevView;
 const aFirstPoint: InevBasePoint;
 const aSecondPoint: InevBasePoint;
 aParentFI: TnevFormatInfoPrim): Integer;
function evCalcDiffInLines4Block(const aView: InevView;
 const aTop: InevBasePoint;
 const aBottom: InevBasePoint;
 aParentFI: TnevFormatInfoPrim): Integer;
function evCalcDiffInLines4MakePointVisible(const aView: InevView;
 const aTop: InevBasePoint;
 const aBottom: InevBasePoint;
 aParentFI: TnevFormatInfoPrim): Integer;
function evGetColumnBlock(const aView: InevView;
 const aTable: InevParaList;
 aColumnIndex: Integer): InevRange;
function evShrinkCursorChildren(const aCursor: InevBasePoint;
 aTag: Tl3Variant): Boolean;
 {* обрезает дочерние курсоры до aTag }
procedure evIterateCursorsF(aTag: Tl3Variant;
 Action: Tl3IteratorAction);
 {* перебирает все курсоры для тега aTag, с освобождением заглушки для Action }
function evSelectTablePara(const aContext: InevSelection;
 const aPara: InevParaList): Boolean;
 {* Выделяет таблицу/строку/ячейку }
function evSelectTableColumn(const aContext: InevSelection;
 const aTable: InevParaList;
 aColumnIndex: Integer): Boolean;
 {* выделяет колонку таблицы }
function evSelectBlock(const aContext: InevSelection;
 const aBlock: InevParaList): Boolean;
 {* Выделяет блок целиком }
function evInPara(const aCursor: InevBasePoint;
 aTypeID: Tk2Type;
 out theParaCursor: InevBasePoint;
 anExcludeType: Tk2Type = nil): Boolean; overload;
 {* курсор в параграфе который наследуется от типа aTypeID? }
function evInPara(const aCursor: InevBasePoint;
 aTypeID: Tk2Type;
 anExcludeType: Tk2Type = nil): Boolean; overload;
 {* курсор в параграфе который наследуется от типа aTypeID? }
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , SysUtils
 , k2OpMisc
 , evMsgCode
 , l3Base
 , evOp
 , k2Tags
 , k2InterfaceFactory
 , nevFacade
 //#UC START# *48453B7601F9impl_uses*
 //#UC END# *48453B7601F9impl_uses*
;

function evMergeParaList(const aView: InevView;
 const aCursor: InevBasePoint;
 const aParaList: InevParaList;
 aType: TevMergeParaListType;
 const anOp: InevOp;
 aFrom: Integer;
 pListEnd: PIUnknown = nil;
 const anIndicator: InevProgress = nil): Boolean;
 {* объединяет список параграфов aCursor.Target с содержимым aParaList }
//#UC START# *4F6AE7A70152_48453B7601F9_var*
var
 l_RowID        : Integer;
 l_List         : InevParas;
 l_PL           : InevParaList;
 l_PL2          : InevParaListModify;
 l_MI           : InevBasePoint;
 l_Cell         : InevTableCell;
 l_PrevCell     : InevTableCell;
 l_NewPoint     : InevBasePoint;
 l_HasIndicator : Boolean;
 l_FInsertFlags : TevInsertParaFlags;
 l_OpBottomCode : Integer;
//#UC END# *4F6AE7A70152_48453B7601F9_var*
begin
//#UC START# *4F6AE7A70152_48453B7601F9_impl*
 if aType = ev_mtlTables then
  l_OpBottomCode := ev_ocBottomRightIgnoreMergedCell
 else
  l_OpBottomCode := ev_ocBottomRight;
 aCursor.Move(aView, l_OpBottomCode, anOp);
 l_MI := aCursor.MostInner;
 if (l_MI.ParentPoint <> nil) and (l_MI.ParentPoint.Obj^.OverlapType = otUpper) then
 begin
  l_MI.ParentPoint.AsObject.QT(InevTableCell, l_Cell);
  Assert(l_Cell <> nil);
  while l_Cell <> nil do
  begin
   l_PrevCell := l_Cell;
   l_Cell := l_PrevCell.GetContinueCell(True, fc_Down);
  end; // while l_Cell <> nil do
  l_NewPoint := l_PrevCell.OwnerPara.MakePoint;
  l_NewPoint.Inner := l_PrevCell.MakePoint;
  l_MI.ParentPoint.ParentPoint.ParentPoint.Inner := l_NewPoint;
 end; // if l_MI.ParentPoint.Obj^.OverlapType = ev_msHead then
 if (pListEnd <> nil) then
  pListEnd^ := aCursor.ClonePoint(aView);
 if (aFrom <= 0) then
  aFrom := 1;
 Dec(aFrom);
 // - Cмещаемся на конец таблицы
 if aCursor.AsObject.QT(InevParaList, l_PL, k2Proc(anOp)) then
  try
   l_PL2 := l_PL.Modify;
   l_List := aParaList.GetParas(aFrom);
   if (aType in [ev_mtlTables, ev_mtlCells]) or aParaList.SubRange(aView, Succ(aFrom), High(aFrom)).Modify.Delete(aView, anOp) then
   //if aParaList.DeleteParas(aView, anOp, aFrom) then
   begin
    if aType = ev_mtlTables then
     l_FInsertFlags := [ev_ipfNeedFire, ev_ipfForce]
    else
     l_FInsertFlags := [ev_ipfNeedFire];
    l_HasIndicator := anIndicator <> nil;
    if l_HasIndicator then
     if (pListEnd = nil) then
      anIndicator.Start(l_List.Count, l3CStr('Разбиение таблиц.'))
     else
      anIndicator.Start(l_List.Count, l3CStr('Объединение таблиц.'));
    try
     for l_RowID := 0 to l_List.Count - 1 do
     begin
      l_PL2.InsertPara(aCursor.Position, l_List[l_RowID].AsObject, anOp, l_FInsertFlags);
      aCursor.Move(aView, l_OpBottomCode, anOp);
      if l_HasIndicator then
       anIndicator.Progress(l_RowID);
     end;//for l_RowID
    finally
     if l_HasIndicator then
      anIndicator.Finish;
    end;
   end;//aParaList.DeleteParas(aFrom)
  finally
   l_PL2 := nil;
  end//try..finall
 else
  Assert(False, 'Не поддерживается список параграфов');
 Result := True;
//#UC END# *4F6AE7A70152_48453B7601F9_impl*
end;//evMergeParaList

function evDeletePara(const anOpPack: InevOp;
 const aCursor: InevBasePoint;
 aFlags: TevDeleteParaFlags = [ev_dpfAtEnd]): Boolean;
//#UC START# *4F6B07C20045_48453B7601F9_var*
var
 l_Op : IevOpDeletePara;
//#UC END# *4F6B07C20045_48453B7601F9_var*
begin
//#UC START# *4F6B07C20045_48453B7601F9_impl*
 if Supports(aCursor, IevOpDeletePara, l_Op) then
  try
   Result := l_Op.DoIt(anOpPack, aFlags);
  finally
   l_Op := nil;
  end//try..finally
 else
  Result := false;
//#UC END# *4F6B07C20045_48453B7601F9_impl*
end;//evDeletePara

function evInsertPara(const aProcessor: InevProcessor;
 const aCursor: InevBasePoint;
 aPara: Tl3Variant;
 aFlags: TevInsertParaFlags = [ev_ipfAtEnd]): Boolean;
//#UC START# *4F6B0ECD019E_48453B7601F9_var*
//#UC END# *4F6B0ECD019E_48453B7601F9_var*
begin
//#UC START# *4F6B0ECD019E_48453B7601F9_impl*
 if (aCursor = nil) then
  Result := False
 else
  Result := evInsertPara(k2StartOp(aProcessor, ev_msgInsertPara), aCursor, aPara, aFlags);
//#UC END# *4F6B0ECD019E_48453B7601F9_impl*
end;//evInsertPara

function evInsertPara(const anOpPack: InevOp;
 const aCursor: InevBasePoint;
 aPara: Tl3Variant;
 aFlags: TevInsertParaFlags = [ev_ipfAtEnd]): Boolean;
//#UC START# *4F6B0F34012A_48453B7601F9_var*
var
 l_Op : IevOpInsertPara;
//#UC END# *4F6B0F34012A_48453B7601F9_var*
begin
//#UC START# *4F6B0F34012A_48453B7601F9_impl*
 if Supports(aCursor, IevOpInsertPara, l_Op) then
  try
   Result := l_Op.DoIt(anOpPack, aPara, aFlags);
  finally
   l_Op := nil;
  end//try..finally
 else
  Result := False;
//#UC END# *4F6B0F34012A_48453B7601F9_impl*
end;//evInsertPara

function evCalcDiffInLines(const aView: InevView;
 const aFirstPoint: InevBasePoint;
 const aSecondPoint: InevBasePoint;
 aParentFI: TnevFormatInfoPrim): Integer;
//#UC START# *50C6F95E02D3_48453B7601F9_var*
var
 l_LinesCount : Integer absolute Result;
 l_Start      : Integer;
 l_Finish     : Integer;
 l_TopInner   : InevBasePoint;
 l_BottomInner: InevBasePoint;

 function lp_IncLines(const aTag: InevPara; anIndex: TnevParaIndex): Boolean;
 var
  l_FI : TnevFormatInfoPrim;
 begin//IncDelta
  l_FI := aParentFI.InfoForChild(aTag);
  if anIndex = l_Finish then
   Inc(l_LinesCount, l_BottomInner.VertPosition(aView, l_FI))
  else
   Inc(l_LinesCount, l_FI.MaxLinesCount);
  if anIndex = l_Start then
   Dec(l_LinesCount, l_TopInner.VertPosition(aView, l_FI));
  Result := True;
 end;//IncDelta

var
 l_Top    : InevBasePoint;
 l_Bottom : InevBasePoint;
 l_Line   : Integer;
//#UC END# *50C6F95E02D3_48453B7601F9_var*
begin
//#UC START# *50C6F95E02D3_48453B7601F9_impl*
 l_Top := aFirstPoint;
 l_Bottom := aSecondPoint;
 l_LinesCount := 0;
 l_TopInner := l_Top.Inner;
 l_BottomInner := l_Bottom.Inner;
 if not l_TopInner.Obj.IsList and (l_BottomInner <> nil) and l_TopInner.AsObject.IsSame(l_BottomInner.AsObject) then
  l_LinesCount := l_Bottom.Diff(aView, l_Top, aParentFI)
 else
 begin
  l_Start := l_Top.Inner.Obj.PID;
  if l_BottomInner = nil then Exit;
  l_Finish := l_BottomInner.Obj.PID;
  l_Top.Obj^.AsPara.AsList.IterateParaF(nevL2PIA(@lp_IncLines), l_Start, l_Finish);
 end;
//#UC END# *50C6F95E02D3_48453B7601F9_impl*
end;//evCalcDiffInLines

function evCalcDiffInLines4Block(const aView: InevView;
 const aTop: InevBasePoint;
 const aBottom: InevBasePoint;
 aParentFI: TnevFormatInfoPrim): Integer;
//#UC START# *50FF931D03C5_48453B7601F9_var*
var
 l_Line: Integer;
//#UC END# *50FF931D03C5_48453B7601F9_var*
begin
//#UC START# *50FF931D03C5_48453B7601F9_impl*
 Result := 0;
 while aBottom.Diff(aView, aTop, aParentFI) <> 0 do
 begin
  l_Line := 1;
  aTop.IncLine(aView, l_Line, True);
  if l_Line > 0 then Break;
  Inc(Result);
 end // while l_Bottom.Diff(aView, l_Top, aParentFI) <> 0 do
//#UC END# *50FF931D03C5_48453B7601F9_impl*
end;//evCalcDiffInLines4Block

function evCalcDiffInLines4MakePointVisible(const aView: InevView;
 const aTop: InevBasePoint;
 const aBottom: InevBasePoint;
 aParentFI: TnevFormatInfoPrim): Integer;
//#UC START# *50FF94E8029B_48453B7601F9_var*
const
 cnMaxLineCount = 10; // Экспериментально число строк, при котором пробуем смещать табилцу без виртуальной перерисовки. 
var
 l_Line: Integer;
//#UC END# *50FF94E8029B_48453B7601F9_var*
begin
//#UC START# *50FF94E8029B_48453B7601F9_impl*
 Result := 0;
 while aBottom.Diff(aView, aTop, aParentFI) > 0 do
 begin
  l_Line := 1;
  aTop.IncLine(aView, l_Line, True);
  if l_Line > 0 then Break;
  Inc(Result);
  (*if Result > cnMaxLineCount then
  begin
   Result := -1;
   Break;
  end; //if Result > cnMaxLineCount then*)
 end // while l_Bottom.Diff(aView, l_Top, aParentFI) <> 0 do
//#UC END# *50FF94E8029B_48453B7601F9_impl*
end;//evCalcDiffInLines4MakePointVisible

function evGetColumnBlock(const aView: InevView;
 const aTable: InevParaList;
 aColumnIndex: Integer): InevRange;
//#UC START# *52B444FA01BE_48453B7601F9_var*
var
 l_PID           : Integer;
 l_Table         : InevParaList;
 l_Start         : InevBasePoint;
 l_Finish        : InevBasePoint;
 l_OffsetX       : Integer;
 l_TableRow      : InevTableRow;
 l_CellWidth     : Integer;
 l_RowIndex0     : Integer;
 l_ChildrenCount : Integer;
//#UC END# *52B444FA01BE_48453B7601F9_var*
begin
//#UC START# *52B444FA01BE_48453B7601F9_impl*
 Result := nil;
 with aTable do
 begin
  l_ChildrenCount := AsObject.ChildrenCount;
  if (l_ChildrenCount > 0) then
  begin
   for l_RowIndex0 := 0 to l_ChildrenCount - 1 do  //Бежим по всем строчкам.
   begin
    with Para[l_RowIndex0] do
    begin
     if (AsObject.ChildrenCount > aColumnIndex) then
     begin
      l_Start := MakePoint;
      try
       l_Start.SetEntryPoint(aColumnIndex + 1);
       l_Start.Inner.Move(aView, ev_ocTopLeft);
       l_CellWidth := l_Start.Inner.Obj.AsObject.IntA[k2_tiWidth];
       l_OffsetX := l_Start.Inner.Obj.OffsetX;
       l_Start := l_Start.PointToParent(aTable);
       with aTable[l_ChildrenCount - 1] do
       begin
        l_TableRow := aTable[l_ChildrenCount - 1] as InevTableRow;
        l_PID := l_TableRow.FindCell(l_OffsetX, l_CellWidth);
        l_Finish := MakePoint;
        try
         l_Finish.SetEntryPoint(l_PID + 1);
         if l_Finish.Inner.HasInner then
          l_Finish.Inner.Move(aView, ev_ocBottomRight);
         l_Finish := l_Finish.PointToParent(aTable);
         Result := aTable.Range(l_Start, l_Finish);
        finally
         l_Finish := nil;
        end;//try..finally
       end;//with aTable[l_ChildrenCount - 1] do
      finally
       l_Start := nil;
      end;//try..finally
      Break;
     end;//ChildrenCount > aColumIndex
    end;//with Child[l_RowIndex0]
   end;//for l_RowIndex0
  end;//ChildrenCount > 0
 end;//with aTable do
//#UC END# *52B444FA01BE_48453B7601F9_impl*
end;//evGetColumnBlock

function evShrinkCursorChildren(const aCursor: InevBasePoint;
 aTag: Tl3Variant): Boolean;
 {* обрезает дочерние курсоры до aTag }
//#UC START# *48E50160015B_48453B7601F9_var*
var
 l_Cursor : InevBasePoint;  
//#UC END# *48E50160015B_48453B7601F9_var*
begin
//#UC START# *48E50160015B_48453B7601F9_impl*
 Result := False;
 if (aCursor <> nil) then
 begin
  l_Cursor := aCursor.MostInner;
  while (l_Cursor <> nil) do
  begin
   if l_Cursor.Obj.AsObject.IsSame(aTag) then
   begin
    l_Cursor.Inner := nil;
    Result := True;
    Break;
   end;//l_Cursor.Obj.EQ(aTag)
   if (l_Cursor.ParentPoint <> nil) then
    l_Cursor := l_Cursor.ParentPoint
   else
    l_Cursor := nil; 
  end;//l_Cursor <> nil
 end;//aCursor <> nil
//#UC END# *48E50160015B_48453B7601F9_impl*
end;//evShrinkCursorChildren

procedure evIterateCursorsF(aTag: Tl3Variant;
 Action: Tl3IteratorAction);
 {* перебирает все курсоры для тега aTag, с освобождением заглушки для Action }
//#UC START# *48E501750350_48453B7601F9_var*
var
 l_CursorCache : Tk2InterfaceFactory;
//#UC END# *48E501750350_48453B7601F9_var*
begin
//#UC START# *48E501750350_48453B7601F9_impl*
 try
  l_CursorCache := Tk2Type(aTag.TagType).InterfaceFactory;
  if (l_CursorCache <> nil) then
   l_CursorCache.Iterate(aTag, Action);
 finally
  l3FreeIA(Action);
 end;{try..finally}
//#UC END# *48E501750350_48453B7601F9_impl*
end;//evIterateCursorsF

function evSelectTablePara(const aContext: InevSelection;
 const aPara: InevParaList): Boolean;
 {* Выделяет таблицу/строку/ячейку }
//#UC START# *48E5018C028D_48453B7601F9_var*
var
 l_Block  : InevRange;
 l_Start  : InevBasePoint;
 l_Finish : InevBasePoint;
 l_Para   : InevParaList;
//#UC END# *48E5018C028D_48453B7601F9_var*
begin
//#UC START# *48E5018C028D_48453B7601F9_impl*
 Result := False;
 if (aContext <> nil) then
 begin
  l_Start := aPara.Para[0].MakePoint;
  l_Start.SetEntryPoint(1);
  if l_Start.HasInner then
   l_Start.Inner.Move(aContext.View, ev_ocTopLeft);
  l_Start := l_Start.PointToParent(aPara);
  l_Para := aPara.Para[aPara.ParaCount - 1].AsList;
  l_Finish := l_Para.MakePoint;
  l_Finish.SetEntryPoint(l_Para.ParaCount);
  if l_Finish.HasInner then
   l_Finish.Inner.Move(aContext.View, ev_ocBottomRight);
  l_Finish := l_Finish.PointToParent(aPara);
  if (aPara.AsObject.ChildrenCount <= 1) AND l_Finish.AtStart then
   l_Block := aPara.Range(l_Finish, l_Finish)
  else
   l_Block := aPara.Range(l_Start, l_Finish);
  aContext.Select(l_Block, false);
  Result := True;
 end;//if (aContext <> nil) then
//#UC END# *48E5018C028D_48453B7601F9_impl*
end;//evSelectTablePara

function evSelectTableColumn(const aContext: InevSelection;
 const aTable: InevParaList;
 aColumnIndex: Integer): Boolean;
 {* выделяет колонку таблицы }
//#UC START# *48E501A60222_48453B7601F9_var*
var
 l_Block: InevRange;
//#UC END# *48E501A60222_48453B7601F9_var*
begin
//#UC START# *48E501A60222_48453B7601F9_impl*
 Result := False;
 if (aContext <> nil) then
 begin
  l_Block := evGetColumnBlock(aContext.View, aTable, aColumnIndex);
  if l_Block <> nil then
  begin
   aContext.Select(l_Block, false);
   Result := True;
  end; // if l_Block <> nil then
 end;//aContext <> nil
//#UC END# *48E501A60222_48453B7601F9_impl*
end;//evSelectTableColumn

function evSelectBlock(const aContext: InevSelection;
 const aBlock: InevParaList): Boolean;
 {* Выделяет блок целиком }
//#UC START# *48E501BE009F_48453B7601F9_var*
var
 l_Block  : InevRange;
 l_Start  : InevPoint;
 l_Finish : InevPoint;
//#UC END# *48E501BE009F_48453B7601F9_var*
begin
//#UC START# *48E501BE009F_48453B7601F9_impl*
 Result := False;
 if (aContext <> nil) then
 begin
  l_Start := aBlock.MakePoint;
  l_Start.SetAtStart(aContext.View, True);
  l_Finish := aBlock.MakePoint;
  l_Finish.SetAtEnd(aContext.View, True);
  l_Block := aBlock.Range(l_Start, l_Finish);
  aContext.Select(l_Block, false);
  Result := True;
 end;//if (aContext <> nil) then
//#UC END# *48E501BE009F_48453B7601F9_impl*
end;//evSelectBlock

function evInPara(const aCursor: InevBasePoint;
 aTypeID: Tk2Type;
 out theParaCursor: InevBasePoint;
 anExcludeType: Tk2Type = nil): Boolean;
 {* курсор в параграфе который наследуется от типа aTypeID? }
//#UC START# *48E501F60339_48453B7601F9_var*
var
 l_Cursor : InevBasePoint;
//#UC END# *48E501F60339_48453B7601F9_var*
begin
//#UC START# *48E501F60339_48453B7601F9_impl*
 Result := False;
 if (aCursor <> nil) then
 begin
  l_Cursor := aCursor.MostInner;
  while (l_Cursor <> nil) do
   if l_Cursor.Obj.AsObject.IsKindOf(aTypeID) then
   begin
    if (anExcludeType <> nil) AND
       l_Cursor.Obj.AsObject.IsKindOf(anExcludeType) then
     Result := False
    else
    begin
     Result := True;
     theParaCursor := l_Cursor;
    end;//anExcludeType <> nil
    break;
   end else
    l_Cursor := l_Cursor.ParentPoint;
 end;//aCursor <> nil
//#UC END# *48E501F60339_48453B7601F9_impl*
end;//evInPara

function evInPara(const aCursor: InevBasePoint;
 aTypeID: Tk2Type;
 anExcludeType: Tk2Type = nil): Boolean;
 {* курсор в параграфе который наследуется от типа aTypeID? }
//#UC START# *48E5021F003F_48453B7601F9_var*
var
 l_FakeCursor : InevBasePoint;
//#UC END# *48E5021F003F_48453B7601F9_var*
begin
//#UC START# *48E5021F003F_48453B7601F9_impl*
 Result := evInPara(aCursor, aTypeID, l_FakeCursor, anExcludeType);
//#UC END# *48E5021F003F_48453B7601F9_impl*
end;//evInPara
{$IfEnd} // Defined(k2ForEditor)

end.
