unit nevTableRowRenderInfo;
 {* Информация о форматировании строки таблицы. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfo.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevListFormatInfo
 , l3LongintList
 , nevFormatInfo
 , nevTools
;

type
 TnevTableRowRenderInfo = class(TnevListFormatInfo)
  {* Информация о форматировании строки таблицы. }
  private
   f_DeltaHeight: Integer;
    {* Здесь храним вычисленную поправку к высоте. }
   f_GreatestObjPID: Integer;
    {* Индекс продолжения Head-ячейки в последней строке (если она Head-ячейка влияет на высоту - иначе -1). }
   f_HeightList: Tl3LongintList;
   f_AllCellsIsMerged: Boolean;
    {* Все ячейки строки объединены }
   f_HeadMax: Integer;
  private
   procedure CheckDeltaHeight;
   function CalcDeltaHeight: Integer;
    {* Здесь считаем добавку к высоте строки. }
  protected
   function IsCellChildSpacingEqual(anIndex: Integer): Boolean; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetlocDeltaHeight: Integer; override;
   function DoCompareWithMax(anIndex: Integer): Integer; override;
   procedure DoUpdateHeitghPart(anIndex: Integer;
    aValue: Integer); override;
   function GetMaxLinesCount: Integer; override;
   function GetIsHidden: Boolean; override;
    {* Объект спрятан }
   procedure HRecalcChild(const aChild: InevPara;
    var sPW: Integer;
    var sPH: Integer); override;
  public
   procedure wForce(aParts: TnevRenderingInfoParts); override;
   function GreatestObjPID(anInLines: Boolean = True): Integer; override;
 end;//TnevTableRowRenderInfo

implementation

uses
 l3ImplUses
 , l3MinMax
 , nevFacade
 , k2Tags
 , evdTypes
 , nevBase
 , evConst
 , SysUtils
 , l3Base
 {$If Defined(k2ForEditor)}
 , evTableCellUtils
 {$IfEnd} // Defined(k2ForEditor)
;

procedure TnevTableRowRenderInfo.CheckDeltaHeight;
//#UC START# *4B9A319D01D2_4848EBFB00B0_var*
//#UC END# *4B9A319D01D2_4848EBFB00B0_var*
begin
//#UC START# *4B9A319D01D2_4848EBFB00B0_impl*
 if f_AllCellsIsMerged and (f_HeightList.Count = 0) and (Obj.AsObject.ChildrenCount > 0) then
  Prepared := Prepared - [nev_ripDeltaHeight];
 if not (nev_ripDeltaHeight in Prepared) then
 begin
  f_DeltaHeight := CalcDeltaHeight;
  Prepared := Prepared + [nev_ripDeltaHeight];
 end;//not (nev_ripDeltaHeight in Prepared)
//#UC END# *4B9A319D01D2_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.CheckDeltaHeight

function TnevTableRowRenderInfo.IsCellChildSpacingEqual(anIndex: Integer): Boolean;
//#UC START# *50A37A030343_4848EBFB00B0_var*
//#UC END# *50A37A030343_4848EBFB00B0_var*
begin
//#UC START# *50A37A030343_4848EBFB00B0_impl*
 Result := False;
//#UC END# *50A37A030343_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.IsCellChildSpacingEqual

function TnevTableRowRenderInfo.CalcDeltaHeight: Integer;
 {* Здесь считаем добавку к высоте строки. }
//#UC START# *4848EECE0287_4848EBFB00B0_var*
var
 l_Delta        : Integer absolute Result;
 l_MaxLC        : Integer;
 l_MergedOnly   : Boolean;
 l_NonHMaxLC    : Integer;
 l_GreatPID     : Integer;
 l_NonHeighList : Tl3LongintList;
 l_IsSingle     : Boolean;
 l_HeadDelta    : Integer;
 l_MaxSpacing   : Integer;

 function CheckFinishCell(const anItem: InevPara; anIndex: Integer): Boolean;

  procedure lp_CheckLineCount(aToSecondList: Boolean = False);
  var
   l_CellInfo : TnevFormatInfoPrim;
   l_LC       : Integer;
  begin
   l_CellInfo := InfoForChild(anItem);
   l_LC := l_CellInfo.MaxLinesCount;
   if aToSecondList then
   begin
    l_NonHeighList[anIndex] := l_LC;
    if l_NonHMaxLC < l_LC then
    begin
     l_HeadDelta := Max(l_HeadDelta, l_CellInfo.Height);
     l_NonHMaxLC := l_LC;
     l_GreatPID := anIndex;
    end; // if l_MaxLC < l_CellInfo.Height then
   end // if aToSeondList then
   else
   begin
    f_HeightList[anIndex] := l_LC;
    if (l_MaxLC < l_LC) or ((l_MaxLC = l_LC) and IsCellChildSpacingEqual(anIndex)) then
    begin
     l_MaxLC := l_LC;
     f_GreatestObjPID := anIndex;
    end; // if l_MaxLC < l_CellInfo.Height then
   end;
  end;

 var
  l_Head      : InevTableCell;
  l_Cell      : InevTableCell;
  l_ContCell  : InevTableCell;
  l_StartRow  : InevPara;
  l_TableInfo : TnevFormatInfo;
  l_RowInfo   : TnevFormatInfo;
  l_CellFI    : TnevFormatInfo;
  l_Row       : InevPara;
  l_HeadRowsH : Integer;
  l_HeadCellH : Integer;
  l_CurDelta  : Integer;
  l_LineCount : Integer;
  l_RowLC     : Integer;
 begin
  Result := true;
  f_HeightList[anIndex] := evUndefHeight;
  l_NonHeighList[anIndex] := evUndefHeight;
  if (TevMergeStatus(anItem.AsObject.IntA[k2_tiMergeStatus]) = ev_msNone) then
  begin
   l_MergedOnly := False;
   lp_CheckLineCount;
   //{$IFOPT D+}
   f_AllCellsIsMerged := False;
   //{$ENDIF}
  end // if (TevMergeStatus(anItem.IntA[k2_tiMergeStatus]) = ev_msNone) then
  else
   if (TevMergeStatus(anItem.AsObject.IntA[k2_tiMergeStatus]) = ev_msHead) then
   begin
    //{$IFOPT D+}
    f_AllCellsIsMerged := False;
    //{$ENDIF}
    if not anItem.AsObject.QT(InevTableCell, l_Cell) then
     Assert(false);
    if (l_Cell.GetContinueCell(True, fc_Down) = nil) then
    begin
     l_MergedOnly := False;
     lp_CheckLineCount;
    end // if (l_Cell.GetContinueCell(True, fc_Down) = nil) then
    else
     if l_MergedOnly then
      lp_CheckLineCount(True);
   end
   else
    if (TevMergeStatus(anItem.AsObject.IntA[k2_tiMergeStatus]) = ev_msContinue) then
     if l_IsSingle then
     begin
      f_AllCellsIsMerged := anItem.AsObject.ChildrenCount = 0;
      if not f_AllCellsIsMerged then
       anItem.AsObject.IntA[k2_tiMergeStatus] := Ord(ev_msNone);
      l_MergedOnly := False;
      lp_CheckLineCount;
     end // if l_IsSingle then
     else
     begin
      if not anItem.AsObject.QT(InevTableCell, l_Cell) then                                   
       Assert(false);
      if (l_Cell.GetContinueCell(True, fc_Down) = nil) then
      begin
       l_Head := l_Cell.GetMergeHead;
       if l_Head <> nil then
       begin
        l_StartRow := l_Head.OwnerPara;
        l_TableInfo := Self.Parent;
        Assert(l_TableInfo <> nil);
        l_Row := l_StartRow;
        l_HeadRowsH := 0;
        l_HeadCellH := 0;
        l_ContCell := l_Head;
        l_LineCount := 0;
        while not l_Row.AsObject.IsSame(Obj.AsObject.Box) do
        begin
         l_RowInfo := l_TableInfo.GetInfoForChild(l_Row);
         Assert(l_RowInfo <> nil);
         if l_Row.AsObject.IsSame(l_StartRow.AsObject.Box) then
         begin
          l_CellFI := l_RowInfo.GetInfoForChild(l_Head);
          if l_Head.PID = l_RowInfo.GreatestObjPID then Exit;
          // ^ - [$219120094]. Если начальная ячейка объединения влияет на высоту строки,
          // где она расположена, то она не может влиять на высоту нижних строк.
          l_HeadCellH := l_CellFI.Height;
          l_LineCount := l_CellFI.MaxLinesCount;
         end; // if l_Row.IsSame(l_StartRow.Box) then
         Inc(l_HeadRowsH, l_RowInfo.DeltaHeight);
         l_RowLC := l_RowInfo.MaxLinesCount;
         if (l_LineCount > evUndefHeight) then
          if (l_LineCount <= l_RowLC) then
          begin
           l_RowInfo.UpdateHeitghPart(l_ContCell.PID, l_LineCount);
           l_LineCount := evUndefHeight;
          end // if (l_LineCount <= l_RowInfo.MaxLinesCount) then
          else
           if l_RowLC > 0 then
            Dec(l_LineCount, l_RowLC + 1);
         l_ContCell := l_ContCell.GetContinueCell(True, fc_Down);
         if l_HeadCellH < l_HeadRowsH then
         begin
          if l_ContCell <> nil then l_LineCount := evUndefHeight;
          Break; // Дальше смысла сравнивать нет!
         end; // if l_HeadCellH < l_HeadRowsH then
         if l_ContCell = nil then
          Break
         else
         begin
          l_Row := l_ContCell.OwnerPara;
          Assert(l_Row <> nil);
         end;
        end; //while not l_Row.IsSame(Obj.Box) do
        l_CurDelta := l_HeadCellH - l_HeadRowsH;
        if l_Delta < l_CurDelta then
        begin
         l_Delta := l_CurDelta;
         f_HeadMax := l_Cell.PID;
        end; // if l_Delta < l_CurDelta then
        if (l_LineCount > evUndefHeight) then // значит, что-то осталось...
        begin
         f_HeightList[anIndex] := l_LineCount;
         if l_MaxLC < l_LineCount then
         begin
          l_MaxLC := l_LineCount;
          f_GreatestObjPID := l_Cell.PID;
          f_HeadMax := l_Cell.PID;
          l_MergedOnly := False;
         end; // if l_MaxLC < l_LC then
        end; // if (l_LineCount > evUndefHeight) then
       end; // if l_Head <> nil then
      end; // if l_Cell.GetContinueCell(True, fc_Down) = nil then
     end; // TevMergeStatus(anItem.IntA[k2_tiMergeStatus]) = ev_msContinue
 end;

var
 l_List : InevParaList;
//#UC END# *4848EECE0287_4848EBFB00B0_var*
begin
//#UC START# *4848EECE0287_4848EBFB00B0_impl*
 l_Delta := 0;
 l_HeadDelta := 0;
 l_MaxLC := 0;
 l_NonHMaxLC := 0;
 f_GreatestObjPID := 0;
 f_HeadMax := -1;
 l_GreatPID := 0;
 l_MergedOnly := True;
 l_List := (Obj As InevObject).AsPara.AsList;
 l_IsSingle := evCheckSingleContinueCell(l_List);
 l_MaxSpacing := 0;
 if (f_HeightList = nil) then
  f_HeightList := Tl3LongintList.Create;
 f_HeightList.Count := l_List.ParaCount;
 l_NonHeighList := Tl3LongintList.Create;
 l_NonHeighList.Count := l_List.ParaCount;
 //{$IFOPT D+}
 f_AllCellsIsMerged := True;
 //{$ENDIF}
 l_List.IterateParaF(nevL2PIA(@CheckFinishCell));
 if l_MergedOnly then
 begin
  l3Free(f_HeightList);
  f_HeightList := l_NonHeighList;
  f_GreatestObjPID := l_GreatPID;
  l_Delta := Max(l_HeadDelta, Height);
 end // if (f_GreatestObjPID = -1) and l_MergedOnly then
 else
 begin
  l_Delta := Max(l_Delta, Height);
  l3Free(l_NonHeighList);
 end;
 //{$IFOPT D+}
 if f_AllCellsIsMerged then
  Result := 0;
 //Assert(not f_AllCellsIsMerged, 'Строка содержит только продолжения объединенных ячеек!');
 //{$ENDIF}
 //V - http://mdp.garant.ru/pages/viewpage.action?pageId=200085334&focusedCommentId=205358121#comment-205358121  
 //Assert(f_GreatestObjPID > -1);
//#UC END# *4848EECE0287_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.CalcDeltaHeight

procedure TnevTableRowRenderInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4848EBFB00B0_var*
//#UC END# *479731C50290_4848EBFB00B0_var*
begin
//#UC START# *479731C50290_4848EBFB00B0_impl*
 l3Free(f_HeightList);
 f_AllCellsIsMerged := false;
 inherited;
//#UC END# *479731C50290_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.Cleanup

procedure TnevTableRowRenderInfo.wForce(aParts: TnevRenderingInfoParts);
//#UC START# *48175C1302A3_4848EBFB00B0_var*
//#UC END# *48175C1302A3_4848EBFB00B0_var*
begin
//#UC START# *48175C1302A3_4848EBFB00B0_impl*
 if (nev_ripHeight in aParts) then
  Include(aParts, nev_ripDeltaHeight);
 inherited;
//#UC END# *48175C1302A3_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.wForce

function TnevTableRowRenderInfo.pm_GetlocDeltaHeight: Integer;
//#UC START# *4848EB800387_4848EBFB00B0get_var*
//#UC END# *4848EB800387_4848EBFB00B0get_var*
begin
//#UC START# *4848EB800387_4848EBFB00B0get_impl*
 CheckDeltaHeight;
 Result := f_DeltaHeight;
//#UC END# *4848EB800387_4848EBFB00B0get_impl*
end;//TnevTableRowRenderInfo.pm_GetlocDeltaHeight

function TnevTableRowRenderInfo.DoCompareWithMax(anIndex: Integer): Integer;
//#UC START# *4B9A10070246_4848EBFB00B0_var*
var
 l_ItemH : Integer;
//#UC END# *4B9A10070246_4848EBFB00B0_var*
begin
//#UC START# *4B9A10070246_4848EBFB00B0_impl*
 CheckDeltaHeight;
 l_ItemH := f_HeightList[anIndex];
 if l_ItemH = evUndefHeight then
  Result := evUndefHeight
 else
  Result := f_HeightList[anIndex] - f_HeightList[GreatestObjPID];
//#UC END# *4B9A10070246_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.DoCompareWithMax

procedure TnevTableRowRenderInfo.DoUpdateHeitghPart(anIndex: Integer;
 aValue: Integer);
//#UC START# *4B9A1028013D_4848EBFB00B0_var*
//#UC END# *4B9A1028013D_4848EBFB00B0_var*
begin
//#UC START# *4B9A1028013D_4848EBFB00B0_impl*
 CheckDeltaHeight;
 f_HeightList[anIndex] := aValue;
//#UC END# *4B9A1028013D_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.DoUpdateHeitghPart

function TnevTableRowRenderInfo.GetMaxLinesCount: Integer;
//#UC START# *4BC45843011E_4848EBFB00B0_var*
//#UC END# *4BC45843011E_4848EBFB00B0_var*
begin
//#UC START# *4BC45843011E_4848EBFB00B0_impl*
 CheckDeltaHeight;
 Result := f_HeightList[f_GreatestObjPID];
//#UC END# *4BC45843011E_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.GetMaxLinesCount

function TnevTableRowRenderInfo.GetIsHidden: Boolean;
 {* Объект спрятан }
//#UC START# *4C0D27380357_4848EBFB00B0_var*
//#UC END# *4C0D27380357_4848EBFB00B0_var*
begin
//#UC START# *4C0D27380357_4848EBFB00B0_impl*
 CheckDeltaHeight;
 Result := f_AllCellsIsMerged OR inherited GetIsHidden;
//#UC END# *4C0D27380357_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.GetIsHidden

procedure TnevTableRowRenderInfo.HRecalcChild(const aChild: InevPara;
 var sPW: Integer;
 var sPH: Integer);
//#UC START# *4E7096D600BD_4848EBFB00B0_var*
var
 l_PH  : Integer;
 l_Map : TnevFormatInfo;
//#UC END# *4E7096D600BD_4848EBFB00B0_var*
begin
//#UC START# *4E7096D600BD_4848EBFB00B0_impl*
 FormatChild(aChild, l_Map);
 Inc(sPW, l_Map.Width);
 if aChild.NeedIncludeHeight then
 begin
  l_PH := l_Map.Height;
  if (sPH < l_PH) then
   sPH := l_PH;
 end;//aChild.NeedIncludeHeight 
//#UC END# *4E7096D600BD_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.HRecalcChild

function TnevTableRowRenderInfo.GreatestObjPID(anInLines: Boolean = True): Integer;
//#UC START# *55794BA600EA_4848EBFB00B0_var*
//#UC END# *55794BA600EA_4848EBFB00B0_var*
begin
//#UC START# *55794BA600EA_4848EBFB00B0_impl*
 CheckDeltaHeight;
 if anInLines then
  Result := f_GreatestObjPID
 else
  Result := f_HeadMax;
//#UC END# *55794BA600EA_4848EBFB00B0_impl*
end;//TnevTableRowRenderInfo.GreatestObjPID

end.
