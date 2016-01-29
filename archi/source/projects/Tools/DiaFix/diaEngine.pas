unit diaEngine;

interface
uses
 SysUtils,
 Classes,

 l3Types,
 l3ProtoObject,
 l3FieldSortRecList,
 l3Interfaces,
 l3Except,

 DT_Types,
 DT_Const,
 DT_Free,
 DT_Serv,
 DT_Doc,
 DT_LinkServ,
 DT_Renum,
 DT_Sab;

type
 PdiaRange = ^TdiaRange;
 TdiaRange = packed record
  rStart : TDocID;
  rFinish: TDocID;
 end;

 TdiaLimitsHolder = class(Tl3ProtoObject)
 private
  f_Min: Longword;
  f_Max: Longword;
  f_NumCount: LongWord;
 public
  constructor Create(const aMin, aMax: Longword);
  property Min: Longword read f_Min write f_Min;
  property Max: Longword read f_Max write f_Max;
  property NumCount: LongWord read f_NumCount write f_NumCount;
 end;

 TdiaFreeBuilder = class(Tl3ProtoObject)
 private
  f_IsTerminated: Boolean;
  f_List: Tl3FieldSortRecList;
  f_OnProgress: Tl3ProgressProc;
  procedure DoProgress(aState: Byte; aValue: Long);
 protected
  procedure Cleanup; override;
  procedure ExcludeNum(aNum: TDocID);
  procedure Commit(aName: string);
 public
  constructor Create;
  function BuildIntervals(const aName: string; const aDiapason: string): Boolean;
  property IsTerminated: Boolean read f_IsTerminated write f_IsTerminated;
  property OnProgress: Tl3ProgressProc read f_OnProgress write f_OnProgress;
 end;

 EDiapasonError = class(El3Error);

procedure FillDiapasonList(const aList: TStrings);
procedure ClearObjects(const aList: TStrings);

implementation
uses
 HT_Const,
 l3String,
 l3RangeManager,
 l3InternalInterfaces,
 l3ProtoPtrRecListPrim, StrUtils;

procedure ClearObjects(const aList: TStrings);
var
 I: Integer;
begin
 for I := 0 to aList.Count - 1 do
 begin
  aList.Objects[I].Free;
  aList.Objects[I] := nil;
 end;
end;


procedure FillDiapasonList(const aList: TStrings);
var
 l_Sab: ISab;
 l_SC : ISabCursor;
 I: Integer;
 l_Rec : PFreeRec;
 l_Name, l_PrevName: string;
 l_Idx: Integer;
 l_Obj: TdiaLimitsHolder;
 l_NumCount : Longword;
begin
 ClearObjects(aList);
 aList.Clear;
 l_Sab := MakeSab(GlobalHtServer.FreeTbl[CurrentFamily]);
 if l_Sab = nil then
  Exit;
 l_Sab.SelectAll;
 l_SC := l_Sab.MakeSabCursor([ftTblName, ftFreeNum, ftLimit], cmForward);
 if l_SC = nil then
  Exit;
 l_PrevName := '';
 l_SC.Sort(ftTblName);
 for I := 0 to l_SC.Count-1 do
 begin
  l_Rec := PFreeRec(l_SC.GetItem(I));
  l_Name := l3ArrayToString(l_Rec^.TblName, SizeOf(TNameArr));
  if not ((l_Name = '') or (l_Name[1] = '$') or AnsiStartsText('DT#', l_Name)) then
  begin
   l_Idx := aList.IndexOf(l_Name);
   if (l_Idx = -1) then
   begin
    l_Obj := TdiaLimitsHolder.Create(l_Rec.FreeNum, l_Rec.Limit);
    l_Idx := aList.AddObject(l_Name, l_Obj);
   end
   else
   begin
    l_Obj := TdiaLimitsHolder(aList.Objects[l_Idx]);
    if l_Rec.FreeNum < l_Obj.Min then
     l_Obj.Min := l_Rec.FreeNum;
    if l_Rec.Limit > l_Obj.Max then
     l_Obj.Max := l_Rec.Limit;
   end;
   if l_Rec.Limit = c_EmptyLimit then
    l_NumCount := 1
   else
    l_NumCount := l_Rec.Limit - l_Rec.FreeNum + 1;
   l_Obj.NumCount := l_Obj.NumCount + l_NumCount;
  end
 end;
end;

constructor TdiaFreeBuilder.Create;
begin
 inherited Create;
 f_List := Tl3FieldSortRecList.Create(SizeOf(TdiaRange), [SizeOf(TDocID), SizeOf(TDocID)], [1,2]);
end;

function TdiaFreeBuilder.BuildIntervals(const aName: string; const aDiapason: string): Boolean;
var
 l_Rec: TdiaRange;
 l_Sab: ISab;
 l_SC : ISabCursor;
 l_DocSab: ISab;
 l_Doc: PRenumRec;
 I, N: Integer;
 l_RM: Tl3RangeManager;
 l_RT: Il3RangeTool;
 l_Range: Tl3Range;
 l_LastFinish: Integer;

 function IsIntersected(const aRec: TdiaRange): Boolean;
 var
  I: Integer;
  l_R: PdiaRange;
 begin
  Result := False;
  for I := 0 to f_List.Count - 1 do
  begin
   l_R := PdiaRange(f_List.ItemSlot(I));
   if ((aRec.rStart >= l_R.rStart) and (aRec.rStart <= l_R.rFinish)) or
      ((aRec.rFinish >= l_R.rStart) and (aRec.rFinish <= l_R.rFinish)) then
   begin
    Result := True;
    Break;
   end;
  end;
 end;

begin
 Result := False;
 f_List.Clear;
 l_RM := Tl3RangeManager.Create;
 try
  l_RM.SrcString := aDiapason;
  l_RT := l_RM;
  N := l_RT.RangeCount-1;
  for I := 0 to N do
  begin
   l_Range := l_RT.Ranges[I];
   l_Rec.rStart := l_Range.rStart;
   l_Rec.rFinish := l_Range.rStart + l_Range.rLength - 1;
   // проверим на непересечение с ранее добавленными диапазонами
   if not IsIntersected(l_Rec) then
    f_List.Add(l_Rec)
   else
    raise EDiapasonError.Create('Заданные части диапазона пересекаются!'); 
  end;
  l_RT := nil;
 finally
  FreeAndNil(l_RM);
 end;

 if f_List.Count = 0 then
  raise EDiapasonError.Create('Диапазон не задан!');

 l_Sab := MakeSab(LinkServer(CurrentFamily).Renum);
 l_Rec.rStart  := PdiaRange(f_List.ItemSlot(0))^.rStart;
 l_Rec.rFinish := PdiaRange(f_List.ItemSlot(f_List.Count-1))^.rFinish;
 l_Sab.Select(rnImportID_fld, l_Rec.rStart, l_Rec.rFinish);
 if not l_Sab.IsEmpty then
 begin
  DocumentServer.Family := CurrentFamily;
  l_DocSab := MakeSab(DocumentServer.FileTbl);
  l_SC := l_Sab.MakeSabCursor([rnRealID_fld, rnImportID_fld], cmForward);
  DoProgress(piStart, l_SC.Count);
  for I := 0 to l_SC.Count-1 do
  begin
   if IsTerminated then
    Exit;
   l_Doc := PRenumRec(l_SC.GetItem(I));
   // а в таблице FILE эта запись присутствует?
   l_DocSab.Select(fId_Fld, l_Doc.RealID);
   if not l_DocSab.IsEmpty then
    ExcludeNum(l_Doc.ImportID); // Присутствует, удаляем из диапазона
   if I mod 50 = 0 then
    DoProgress(piCurrent, I+1);
  end;
 end;
 Commit(aName);
 Result := True;
end;

procedure TdiaFreeBuilder.Cleanup;
begin
 FreeAndNil(f_List);
 inherited;
end;

procedure TdiaFreeBuilder.Commit(aName: string);
var
 l_Free  : TFreeTbl;
 I: Integer;
 l_Range: PdiaRange;
begin
 l_Free := GlobalHtServer.FreeTbl[CurrentFamily];
 l_Free.LockTbl;
 try
  // удаляем старые данные по этому диапазону
  l_Free.DeleteAllIntervals(aName);
  // добавляем вычисленные
  for I := 0 to f_List.Count - 1 do
  begin
   l_Range := PdiaRange(f_List.ItemSlot(I));
   l_Free.AddIntervalPrim(aName, l_Range.rStart, l_Range.rFinish);
  end;
 finally
  l_Free.UnlockTbl;
 end;
end;

procedure TdiaFreeBuilder.DoProgress(aState: Byte; aValue: Long);
begin
 if Assigned(f_OnProgress) then
  f_OnProgress(aState, aValue);
end;

procedure TdiaFreeBuilder.ExcludeNum(aNum: TDocID);
var
 I: Integer;
 l_Range: PdiaRange;
 l_New  : TdiaRange;
begin
 for I := 0 to f_List.Count - 1 do
 begin
  l_Range := PdiaRange(f_List.ItemSlot(I));
  if (aNum >= l_Range.rStart) and (aNum <= l_Range.rFinish) then
  begin
   if l_Range.rStart = l_Range.rFinish then // единичный интервал, просто удаляем
    f_List.Delete(I)
   else
    if aNum = l_Range.rStart then
     l_Range.rStart := l_Range.rStart + 1 // двигаем начало
    else
     if aNum = l_Range.rFinish then
      l_Range.rFinish := l_Range.rFinish - 1 // двигаем конец
     else
     begin
      // пилим диапазон на два
      l_New := l_Range^;
      l_Range.rFinish := aNum - 1;
      l_New.rStart := aNum + 1;
      f_List.Add(l_New);
     end;
   Break;
  end;
 end;
end;

constructor TdiaLimitsHolder.Create(const aMin, aMax: Longword);
begin
 inherited Create;
 f_Min := aMin;
 f_Max := aMax;
end;

end.
