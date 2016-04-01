unit evCell;
 {* –еализаци€ интерфейса IedCell дл€ обычной €чейки таблицы. }

// ћодуль: "w:\common\components\gui\Garant\Everest\evCell.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TevCell" MUID: (502CC6560261)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
uses
 l3IntfUses
 , evCustomParaListUtils
 , evEditorInterfaces
 , nevTools
 , l3Variant
 , nevBase
 , evdTypes
 , l3Interfaces
;

type
 TevCell = class(TevTableChild, IedCell)
  {* –еализаци€ интерфейса IedCell дл€ обычной €чейки таблицы. }
  private
   f_Neighbours: TevCellNeighbours;
  protected
   function Get_Frame: IedFrame;
   procedure UpdateWidthAndCheckHead(aNewWidth: Integer);
    {* измен€ет ширину €чейки, в том числе и объединенных }
   function Merge(aNeighbour: TedNeighbourIndex = ed_fpiRight): Boolean;
    {* объедин€ет €чейку с соседом }
   function Split(aColNum: Integer = 2;
    aRowNum: Integer = 1): Boolean; overload;
    {* разбивает €чейку }
   function Split(anOrientation: Tl3Orientation1): Boolean; overload;
    {* разбивает €чейку }
   function IsFirst: Boolean;
    {* возвращает - перва€ ли это €чейка }
   function IsLast: Boolean;
    {* возвращает - последн€€ ли это €чейка }
   function IsBottom: Boolean;
    {* возвращает - сама€ ли €чейка нижн€€ }
   function Delete(const anOp: InevOp;
    anInMerge: Boolean = False): Boolean;
    {* удал€ет €чейку }
   function pm_GetTable: IedTable;
   function pm_GetNeighbour(aNeighbour: TedNeighbourIndex): IedCell;
   function pm_GetWidth: Integer;
   procedure pm_SetWidth(aValue: Integer);
   function pm_GetVerticalAligment: TevVerticalAligment;
   procedure pm_SetVerticalAligment(aValue: TevVerticalAligment);
   function pm_GetMergeStatus: TevMergeStatus;
   function TextAsInteger: Integer;
    {* ѕытаетс€ преобразовать текст в €чейке к целому числу. }
   function GetFirstLineText: AnsiString;
    {* ¬озвращает первую строку €чейки. »спользыетс€ дл€ тестов. }
   function IsEmptyCell: Boolean;
   function IsFrameEmpty: Boolean;
   function GetCellType: TedCellType;
    {* ¬озвращает тип содержимого €чейки. }
   procedure MakeCellContinue(const anOp: InevOp);
    {* ¬ыставить тип €чейке (ev_msContinue) и очистить еЄ содержимое. }
   function CalcHeadCellHeghtInRow: Integer;
    {* ѕосчитать сколько занимает строк объедиенна€ €чейка. }
   procedure UpdateWidth(aNewWidth: Integer);
   procedure Cleanup; override;
    {* ‘ункци€ очистки полей объекта. }
  public
   constructor Create(const aView: InevView;
    const aTable: IedTable;
    aTagWrap: Tl3Variant;
    const aProcessor: InevProcessor;
    const aNeighbours: TevCellNeighbours;
    const aLocation: InevLocation = nil); reintroduce;
   class function Make(const aView: InevView;
    const aTable: IedTable;
    aTagWrap: Tl3Variant;
    const aProcessor: InevProcessor;
    const aNeighbours: TevCellNeighbours;
    const aLocation: InevLocation = nil): IedCell;
 end;//TevCell
{$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)

implementation

{$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
 , evParaFrame
 , k2Tags
 , k2Base
 , evParaTools
 , evMsgCode
 , l3IID
 , k2OpMisc
 , TextPara_Const
 , evCursorTools
 , l3UnitsTools
 , l3String
 , l3Chars
;

constructor TevCell.Create(const aView: InevView;
 const aTable: IedTable;
 aTagWrap: Tl3Variant;
 const aProcessor: InevProcessor;
 const aNeighbours: TevCellNeighbours;
 const aLocation: InevLocation = nil);
//#UC START# *502CCB6101BA_502CC6560261_var*
//#UC END# *502CCB6101BA_502CC6560261_var*
begin
//#UC START# *502CCB6101BA_502CC6560261_impl*
 inherited Create(aView, aTable, aTagWrap, aProcessor, aLocation);
 f_Neighbours := aNeighbours;
//#UC END# *502CCB6101BA_502CC6560261_impl*
end;//TevCell.Create

class function TevCell.Make(const aView: InevView;
 const aTable: IedTable;
 aTagWrap: Tl3Variant;
 const aProcessor: InevProcessor;
 const aNeighbours: TevCellNeighbours;
 const aLocation: InevLocation = nil): IedCell;
//#UC START# *502CCBA80063_502CC6560261_var*
var
 l_Cell : TevCell;
//#UC END# *502CCBA80063_502CC6560261_var*
begin
//#UC START# *502CCBA80063_502CC6560261_impl*
 l_Cell := Create(aView, aTable, aTagWrap, aProcessor, aNeighbours, aLocation);
 try
  Result := l_Cell;
 finally
  l3Free(l_Cell);
 end;//try..finally
//#UC END# *502CCBA80063_502CC6560261_impl*
end;//TevCell.Make

function TevCell.Get_Frame: IedFrame;
//#UC START# *4BBC89F8009C_502CC6560261get_var*
var
 l_Neighbours : TevCellNeighbours;
 
 procedure CheckNeighbour(anIndex: TedNeighbourIndex);
 var
  l_Neighbour   : InevPara;
  l_MergeStatus : TevMergeStatus;
  l_CellTool    : InevTableCell;
 begin//CheckNeighbour
  if (l_Neighbour <> nil) then
  begin
  if not l_Neighbours[anIndex].AsObject.QT(InevPara, l_Neighbour, Processor) then
    Assert(False);
   try
    with l_Neighbour.AsObject.Attr[k2_tiMergeStatus] do
     if IsValid then
      l_MergeStatus := TevMergeStatus(AsLong)
     else
      l_MergeStatus := ev_msNone;
    case l_MergeStatus of
     ev_msContinue : l_Neighbours[anIndex] := Tl3NullTag.Instance;
     ev_msHead : begin
      if Supports(l_Neighbour, InevTableCell, l_CellTool) then
       l_Neighbour := l_CellTool.GetContinueCell(False, fc_DownInternal);
      if (l_Neighbour <> nil) AND l_Neighbour.AsObject.IsValid then
       l_Neighbours[anIndex] := Tl3NullTag.Instance;
     end;//ev_msHead
    end;//Case l_MergeStatus
   finally
    l_Neighbour := nil;
   end;//try..finally
  end;
 end;//CheckNeighbour

//#UC END# *4BBC89F8009C_502CC6560261get_var*
begin
//#UC START# *4BBC89F8009C_502CC6560261get_impl*
 l_Neighbours := f_Neighbours;
 CheckNeighbour(ed_fpiLeft);
 CheckNeighbour(ed_fpiRight);
 Pointer(Result) := Pointer(IedFrame(TevCellFrame.Create(TagInst, Processor, l_Neighbours)));
//#UC END# *4BBC89F8009C_502CC6560261get_impl*
end;//TevCell.Get_Frame

procedure TevCell.UpdateWidthAndCheckHead(aNewWidth: Integer);
 {* измен€ет ширину €чейки, в том числе и объединенных }
//#UC START# *4BBC90300154_502CC6560261_var*
var
 l_MS      : TevMergeStatus;
 l_Cell    : InevTableCell;
 l_NewCell : InevTableCell;
 l_OpPack  : InevOp;
//#UC END# *4BBC90300154_502CC6560261_var*
begin
//#UC START# *4BBC90300154_502CC6560261_impl*
 if aNewWidth > 0 then
 begin
  l_MS := pm_GetMergeStatus;
  if l_MS <> ev_msContinue then
  begin
   if l_MS = ev_msHead then
   begin
    l_OpPack := Processor.StartOp;
    try
     TagInst.QT(InevTableCell, l_Cell);
     Assert(l_Cell <> nil);
     repeat
      l_NewCell := l_Cell.GetContinueCell(True, fc_Down); // —начала ищем, а потом - правим!
      if aNewWidth <> l_Cell.AsObject.IntA[k2_tiWidth] then
       l_Cell.AsObject.IntW[k2_tiWidth, l_OpPack] := aNewWidth;
      l_Cell := l_NewCell;
     until (l_Cell = nil);
    finally
     l_OpPack := nil;
    end;//try..finally
   end // if l_MS = ev_msHead then
   else
    if pm_GetWidth <> aNewWidth then
     pm_SetWidth(aNewWidth);
  end; // if l_MS <> ev_msContinue then
 end; // if aNewWidth > 0 then
//#UC END# *4BBC90300154_502CC6560261_impl*
end;//TevCell.UpdateWidthAndCheckHead

function TevCell.Merge(aNeighbour: TedNeighbourIndex = ed_fpiRight): Boolean;
 {* объедин€ет €чейку с соседом }
//#UC START# *4BBC906D00E8_502CC6560261_var*

 procedure DoMerge(const aCell: IedCell; aAtEnd: Boolean);
 var
  l_OpPack : InevOp;
  l_Flags  : TevLoadFlags;
  l_Para   : InevPara;
  l_Para1  : InevPara;
 begin
  if (aCell = nil) then
   Result := False
  else
  begin
   l_OpPack := Processor.StartOp(ev_msgBlock2Para);
   try
    pm_SetWidth(pm_GetWidth + aCell.Width); // - ¬ыставл€ем новую ширину €чейки.
    l_Flags := evDefaultCopyFlags;
    if aAtEnd then
     l_Flags := l_Flags + [ev_lfAtEnd];
    if aCell.AsObject.QT(InevPara, l_Para, Processor) then
     try
      if TagInst.QT(InevPara, l_Para1, Processor) then
       try                                                          
        evCopyParaList(View, Processor, l_Para1, l_Para, l_Flags, True);
       finally
        l_Para1 := nil;
       end;//try..finally
     finally
      l_Para := nil;
     end//try..finally
    else
     Assert(False);
    // - ќбъедин€ем тексты двух €чеек.
    aCell.Delete(nil, True); // - ”дал€ем соседнюю €чейку.
    Result := True;
   finally
    l_OpPack := nil;
   end;//try..finally
  end
 end;

//#UC END# *4BBC906D00E8_502CC6560261_var*
begin
//#UC START# *4BBC906D00E8_502CC6560261_impl*
 if (aNeighbour = ed_fpiRight) AND IsLast then aNeighbour := ed_fpiLeft;
 case aNeighbour of
  ed_fpiLeft  : DoMerge(pm_GetNeighbour(aNeighbour), False);
  ed_fpiRight : DoMerge(pm_GetNeighbour(aNeighbour), True);
  else
   Result := False;
 end;//case aNeighbour
//#UC END# *4BBC906D00E8_502CC6560261_impl*
end;//TevCell.Merge

function TevCell.Split(aColNum: Integer = 2;
 aRowNum: Integer = 1): Boolean;
 {* разбивает €чейку }
//#UC START# *4BBC908A0312_502CC6560261_var*
var
 l_OpPack: InevOp;

 procedure lp_CheckHeadCell(const aCheckCell: InevPara);
 var
  l_HeadCell : InevPara;
  l_MergeCell: InevTableCell;
 begin
  if Supports(aCheckCell, InevTableCell, l_MergeCell) and (l_MergeCell.GetHeadCellPara = nil) then
  begin
   l_HeadCell := l_MergeCell.GetUpperCell;
   if (l_HeadCell <> nil) and (l_HeadCell.IntA[k2_tiMergeStatus] <> Ord(ev_msContinue)) then
    l_HeadCell.IntW[k2_tiMergeStatus, l_OpPack] := Ord(ev_msHead);
  end; // if Supports(l_NewCell, InevTableCell, l_MergeCell) and (l_MergeCell.GetMergeHead = nil) then
 end;

 procedure lp_CheckFrame(const aCheckCell: InevPara);
 var
  l_HeadCell : InevPara;
  l_MergeCell: InevTableCell;
 begin
  if Supports(aCheckCell, InevTableCell, l_MergeCell) then
  begin
   l_HeadCell := l_MergeCell.GetUpperCell;
   if l_HeadCell <> nil then
    aCheckCell.IntW[k2_tiFrame, l_OpPack] := l_HeadCell.IntA[k2_tiFrame];
  end; // if Supports(aCheckCell, InevTableCell, l_MergeCell) then
 end;

var
 l_Cell          : InevPara;
 l_PrevCell      : InevPara;
 l_CellI         : IedCell;
 l_NewCell       : InevPara;
 l_NewCell1      : InevPara;
 l_Width         : Integer;
 l_CellWidth     : Integer;
 l_Point         : InevBasePoint;
 l_ColNum        : Integer;
 l_WasMerge      : Boolean;
 l_CellTool      : InevTableCell;
 l_NeighbourCell : IedCell;
 l_NextCell      : InevPara;
//#UC END# *4BBC908A0312_502CC6560261_var*
begin
//#UC START# *4BBC908A0312_502CC6560261_impl*
 Result := False;
 l_WasMerge := False;
 try
  if (aColNum > 0) AND (aRowNum > 0) then
  begin
   if (Processor = nil) then
    l_OpPack := nil
   else
    l_OpPack := Processor.StartOp(M_evSplit);
   try
    if not TagInst.QT(InevPara, l_Cell, Processor) then
     Assert(False);
    if (aRowNum > 1) then
    begin
     with l_Cell do
     begin
      with Attr[k2_tiMergeStatus] do
       l_WasMerge := IsValid AND (AsLong = Ord(ev_msHead));
      AttrW[k2_tiMergeStatus, l_OpPack] := nil;
      evCheckCellStatus(l_OpPack, l_Cell);
      // - Ќадо очистить признак объединени€
     end;//with l_Cell
    end;//aRowNum > 1..
    if (aColNum > 1) then
    begin
     while True do
     begin
      // - Ёто цикл дл€ разделени€ всех объединенных €чеек
      with l_Cell do
      begin
       with Attr[k2_tiWidth] do
        if IsValid then
         l_Width := AsLong
        else
         l_Width := 0;
       if (l_Width > 0) then
       begin
        Result := True;
        // ѕолучаем следующую €чейку именно здесь, т.к. дальше с новой шириной мы еЄ не найдем.
        if Supports(l_Cell, InevTableCell, l_CellTool) then
         l_NextCell := l_CellTool.GetContinueCell(False, fc_DownInternal);
        lp_CheckFrame(l_Cell);
        l_ColNum := aColNum;
        l_CellWidth := l_Width div aColNum;
        l_CellWidth := l_CellTool.CheckCellWidth(l_CellWidth, l_Width);
        Dec(l_Width, l_CellWidth);
        IntW[k2_tiWidth, l_OpPack] := l_CellWidth;
        // - ”станавливаем новую ширину €чейки
        if not l_Cell.AsObject.CloneTag.AsObject.QT(InevPara, l_NewCell, Processor) then
         Assert(False);
        try
         evClearPara(View, l_NewCell, nil);
         l_Point := MakePoint;
         try
          l_Point := l_Point.PointToParent;
          // - ѕриводим курсор к строке таблицы
          while True do
          begin
           Dec(l_ColNum);
           l_CellWidth := l_Width div l_ColNum;
           if l_ColNum > 1 then
            l_CellWidth := l_CellTool.CheckCellWidth(l_CellWidth, l_Width);
           Dec(l_Width, l_CellWidth);
           l_NewCell.AsObject.IntA[k2_tiWidth] := l_CellWidth;
           evInsertPara(l_OpPack, l_Point, l_NewCell.AsObject);
           lp_CheckHeadCell(l_NewCell);
           // - ¬ставл€ем новую €чейку
           if (l_ColNum = 1) then
            Break
           else
           begin
            l_Point.PositionW := l_Point.Position + 1;
            // - ѕеремещаем курсор
            if not l_NewCell.AsObject.CloneTag.AsObject.QT(InevPara, l_NewCell1, Processor) then
             Assert(False);
            try
             l_NewCell := l_NewCell1;
            finally
             l_NewCell1 := nil;
            end;//try..finally
           end;//l_ColNum = 1
          end;//while True
         finally
          l_Point := nil;
         end;//try..finally
        finally
         l_NewCell := nil;
        end;//try..finally
       end//l_Width > 0
       else
        Break;
        // - Ќадо выйти, т.к. раздел€ть нечего
      end;//with l_Cell
      if (l_NextCell <> nil) AND l_NextCell.AsObject.IsValid then
       l_Cell := l_NextCell
      else
       Break;
       // - ¬се соседи кончились
     end;//while True
    end;//aColNum > 1
    if not TagInst.QT(InevPara, l_Cell, Processor) then
     Assert(False);
    with l_Cell do
    begin
     if (aRowNum > 1) then
     begin
      if l_WasMerge then
      begin
       if Supports(l_Cell, InevTableCell, l_CellTool) then
        l_NewCell := l_CellTool.GetContinueCell(False, fc_DownInternal);
       if (l_NewCell <> nil) AND l_NewCell.AsObject.IsValid then
        if l3IOk(evQueryParaInterface(View, Processor, l_NewCell, Tl3GUID_C(IedCell), l_CellI)) then
         try
          Result := True;
          l_NewCell.AsObject.IntW[k2_tiMergeStatus, l_OpPack] := Ord(ev_msHead);
          evCheckCellStatus(l_OpPack, l_NewCell);
          l_CellI.Split(aColNum, aRowNum - 1);
          Exit;
         finally
          l_CellI := nil;
         end;//try..finally
      end;//l_WasMerge
      if not Owner.CloneTag.AsObject.QT(InevPara, l_NewCell, Processor) then
       Assert(False);
      // -  опируем строку таблицы
      with OwnerPara do
      begin
       try
        Result := True;
        evClearPara(View, l_NewCell, nil);
        // - ќчищаем новую строку
        l_ColNum := 0;
        while (l_ColNum < ChildrenCount) do
        begin
         l_NewCell1 := Para[l_ColNum];
         if l_NewCell1.AsObject.IsSame(l_Cell.AsObject) then
          Inc(l_ColNum, aColNum)
          // - ѕропускаем €чейки, относ€щиес€ к нашему столбцу
         else
         begin
          with l_NewCell1 do
          begin
           with Attr[k2_tiMergeStatus] do
            l_WasMerge := IsValid AND (AsLong <> Ord(ev_msNone));
           if not l_WasMerge then
            IntW[k2_tiMergeStatus, l_OpPack] := Ord(ev_msHead);
           evCheckCellStatus(l_OpPack, l_NewCell1); 
          end;//with l_NewCell1
          evClearPara(View, l_NewCell.AsList.ToList.Obj[l_ColNum], l_OpPack, ev_cmAll);
          l_NewCell.AsObject.Child[l_ColNum].IntA[k2_tiMergeStatus] := Ord(ev_msContinue);
          // - ћетим €чейки новой строки как объединение
          Inc(l_ColNum);
         end;//l_NewCell1.EQ(l_Cell)
        end;//while (l_ColNum < ChildrenCount)
        // - «десь обрабатываем выделение
        l_ColNum := aRowNum;
        l_Point := MakePoint;
        try
         l_Point := l_Point.PointToParent;
         // - ѕриводим курсор к таблице
         while True do
         begin
          evInsertPara(l_OpPack, l_Point, l_NewCell.AsObject);
          // - ¬ставл€ем новую строку
          Dec(l_ColNum);
          if (l_ColNum = 1) then
           Break
          else
          begin
           l_Point.PositionW := l_Point.Position + 1;
           // - ѕеремещаем курсор
           if not l_NewCell.AsObject.CloneTag.AsObject.QT(InevPara, l_NewCell1, Processor) then
            Assert(False);
           try
            l_NewCell := l_NewCell1;
           finally
            l_NewCell1 := nil;
           end;//try..finally
          end;//l_ColNum = 1
         end;//while True
        finally
         l_Point := nil;
        end;//try..finally
       finally
        l_NewCell := nil;
       end;//try..finally
       l_NewCell := OwnerPara;
       l_NewCell.Invalidate([nev_spExtent]);
      end;//with TagOwner
     end;//aRowNum > 1
    end;//with l_Cell
   finally
    l_OpPack := nil;
   end;//try..finally
  end;//aColNum > 0
 finally
  if Result then
  begin
   l_NeighbourCell := pm_GetTable.Cell;
   if not l_NeighbourCell.IsLast and (l_NeighbourCell.Neighbour[ed_fpiRight] <> nil) then
    f_Neighbours[ed_fpiRight] := l_NeighbourCell.Neighbour[ed_fpiRight].AsObject.Box.AsRef
   else
    f_Neighbours[ed_fpiRight] := Tl3NullTag.Instance;
   if not l_NeighbourCell.IsBottom and (l_NeighbourCell.Neighbour[ed_fpiDown] <> nil) then
    f_Neighbours[ed_fpiDown] := l_NeighbourCell.Neighbour[ed_fpiDown].AsObject.Box.AsRef
   else
    f_Neighbours[ed_fpiDown] := Tl3NullTag.Instance;
  end;
 end;//try..finally
//#UC END# *4BBC908A0312_502CC6560261_impl*
end;//TevCell.Split

function TevCell.Split(anOrientation: Tl3Orientation1): Boolean;
 {* разбивает €чейку }
//#UC START# *4BBC90A5006F_502CC6560261_var*
var
 l_OpPack : InevOp;
 l_Dest   : InevPara;
 l_Cursor : InevPoint;
 l_Para   : InevPara;
//#UC END# *4BBC90A5006F_502CC6560261_var*
begin
//#UC START# *4BBC90A5006F_502CC6560261_impl*
 if (Processor = nil) then
  l_OpPack := nil
 else
  l_OpPack := Processor.StartOp(M_evSplit);
 try
  if (anOrientation = ev_orHorizontal) then
   Result := Split(1, 2)
  else
   Result := Split(2, 1);
  if Result then
  begin
   if Supports(f_Location, InevPoint, l_Cursor) then
   begin
    if (anOrientation = ev_orHorizontal) then
    begin
     if not IsBottom and not f_Neighbours[ed_fpiDown].AsObject.QT(InevPara, l_Dest, Processor) then
      Assert(False);
    end//anOrientation = ev_orHorizontal
    else
    begin
     if not f_Neighbours[ed_fpiRight].AsObject.QT(InevPara, l_Dest, Processor) then
      Assert(False);
    end;//anOrientation = ev_orHorizontal
    if Self.QT(InevPara, l_Para) then
    begin
     evCopyParaList(View,
                    Processor,
                    l_Dest,
                    l_Para,
                    evDefaultCopyFlags + [ev_lfNeedJoin] - [ev_lfAtEnd],
                    False,
                    l_Cursor, True);
    end
    else
     Assert(False);                
   end;//Owner Is TevCursor
  end;//Result
 finally
  l_OpPack := nil;
 end;//try..finally 
//#UC END# *4BBC90A5006F_502CC6560261_impl*
end;//TevCell.Split

function TevCell.IsFirst: Boolean;
 {* возвращает - перва€ ли это €чейка }
//#UC START# *4BBC90B601A3_502CC6560261_var*
//#UC END# *4BBC90B601A3_502CC6560261_var*
begin
//#UC START# *4BBC90B601A3_502CC6560261_impl*
 Result := (f_Neighbours[ed_fpiLeft] = nil) or f_Neighbours[ed_fpiLeft].AsObject.IsNull;
//#UC END# *4BBC90B601A3_502CC6560261_impl*
end;//TevCell.IsFirst

function TevCell.IsLast: Boolean;
 {* возвращает - последн€€ ли это €чейка }
//#UC START# *4BBC90CB0396_502CC6560261_var*
//#UC END# *4BBC90CB0396_502CC6560261_var*
begin
//#UC START# *4BBC90CB0396_502CC6560261_impl*
 Result := (f_Neighbours[ed_fpiRight] = nil) or f_Neighbours[ed_fpiRight].AsObject.IsNull;
//#UC END# *4BBC90CB0396_502CC6560261_impl*
end;//TevCell.IsLast

function TevCell.IsBottom: Boolean;
 {* возвращает - сама€ ли €чейка нижн€€ }
//#UC START# *4BBC90DE010C_502CC6560261_var*
//#UC END# *4BBC90DE010C_502CC6560261_var*
begin
//#UC START# *4BBC90DE010C_502CC6560261_impl*
 Result := (f_Neighbours[ed_fpiDown] = nil) or f_Neighbours[ed_fpiDown].AsObject.IsNull;
//#UC END# *4BBC90DE010C_502CC6560261_impl*
end;//TevCell.IsBottom

function TevCell.Delete(const anOp: InevOp;
 anInMerge: Boolean = False): Boolean;
 {* удал€ет €чейку }
//#UC START# *4BBC90F1002D_502CC6560261_var*
var
 l_Op   : InevOp;
 l_Para : InevTableCell;
 l_Head : InevPara;
//#UC END# *4BBC90F1002D_502CC6560261_var*
begin
//#UC START# *4BBC90F1002D_502CC6560261_impl*
 if TagInst.QT(InevTableCell, l_Para, Processor) then
 begin
  if anOp = nil then
   l_Op := k2StartOp(Processor, ev_msgDeletePara)
  else
   l_Op := anOp;
  l_Head := l_Para.GetHeadCellPara;
  Result := l_Para.Edit.Delete(anInMerge, l_Op);
  if (l_Head <> nil) and not l_Head.AsObject.IsSame(l_Para.AsObject) then
   l_Head.Invalidate([nev_spExtent]);
 end // if TagInst.QT(InevPara, l_Para, Processor) then
 else
  Result := false;
//#UC END# *4BBC90F1002D_502CC6560261_impl*
end;//TevCell.Delete

function TevCell.pm_GetTable: IedTable;
//#UC START# *4BBC91340257_502CC6560261get_var*
//#UC END# *4BBC91340257_502CC6560261get_var*
begin
//#UC START# *4BBC91340257_502CC6560261get_impl*
 Result := GetTable;
//#UC END# *4BBC91340257_502CC6560261get_impl*
end;//TevCell.pm_GetTable

function TevCell.pm_GetNeighbour(aNeighbour: TedNeighbourIndex): IedCell;
//#UC START# *4BBC914B03C3_502CC6560261get_var*
var
 l_Para : InevPara;
//#UC END# *4BBC914B03C3_502CC6560261get_var*
begin
//#UC START# *4BBC914B03C3_502CC6560261get_impl*
 if f_Neighbours[aNeighbour].AsObject.IsNull then
  Result := nil
 else
 begin
  if not f_Neighbours[aNeighbour].AsObject.QT(InevPara, l_Para, Processor) then
   Assert(False);
  if l3IFail(evQueryParaInterface(View, Processor, l_Para, Tl3GUID_C(IedCell), Result)) then
   Result := nil;
 end;
//#UC END# *4BBC914B03C3_502CC6560261get_impl*
end;//TevCell.pm_GetNeighbour

function TevCell.pm_GetWidth: Integer;
//#UC START# *4BBC91960248_502CC6560261get_var*
//#UC END# *4BBC91960248_502CC6560261get_var*
begin
//#UC START# *4BBC91960248_502CC6560261get_impl*
 Result := TagInst.IntA[k2_tiWidth];
//#UC END# *4BBC91960248_502CC6560261get_impl*
end;//TevCell.pm_GetWidth

procedure TevCell.pm_SetWidth(aValue: Integer);
//#UC START# *4BBC91960248_502CC6560261set_var*
var
 l_OpPack : InevOp;
//#UC END# *4BBC91960248_502CC6560261set_var*
begin
//#UC START# *4BBC91960248_502CC6560261set_impl*
 if (aValue > 0) then
 begin
  l_OpPack := Processor.StartOp;
  try
   TagInst.IntW[k2_tiWidth, l_OpPack] := aValue;
  finally
   l_OpPack := nil;
  end;//try..finally
 end;//Value > 0
//#UC END# *4BBC91960248_502CC6560261set_impl*
end;//TevCell.pm_SetWidth

function TevCell.pm_GetVerticalAligment: TevVerticalAligment;
//#UC START# *4BBC91DF0370_502CC6560261get_var*
//#UC END# *4BBC91DF0370_502CC6560261get_var*
begin
//#UC START# *4BBC91DF0370_502CC6560261get_impl*
 with TagInst.Attr[k2_tiVerticalAligment] do
  if IsValid then
   Result := TevVerticalAligment(AsLong)
  else
   Result := ev_valTop;
//#UC END# *4BBC91DF0370_502CC6560261get_impl*
end;//TevCell.pm_GetVerticalAligment

procedure TevCell.pm_SetVerticalAligment(aValue: TevVerticalAligment);
//#UC START# *4BBC91DF0370_502CC6560261set_var*
var
 l_OpPack : InevOp;
//#UC END# *4BBC91DF0370_502CC6560261set_var*
begin
//#UC START# *4BBC91DF0370_502CC6560261set_impl*
 l_OpPack := Processor.StartOp;
 try
  TagInst.IntW[k2_tiVerticalAligment, l_OpPack] := Ord(aValue);
 finally
  l_OpPack := nil;
 end;//try..finally
//#UC END# *4BBC91DF0370_502CC6560261set_impl*
end;//TevCell.pm_SetVerticalAligment

function TevCell.pm_GetMergeStatus: TevMergeStatus;
//#UC START# *4F290E34016D_502CC6560261get_var*
//#UC END# *4F290E34016D_502CC6560261get_var*
begin
//#UC START# *4F290E34016D_502CC6560261get_impl*
 Result := TevMergeStatus(TagInst.IntA[k2_tiMergeStatus]);
//#UC END# *4F290E34016D_502CC6560261get_impl*
end;//TevCell.pm_GetMergeStatus

function TevCell.TextAsInteger: Integer;
 {* ѕытаетс€ преобразовать текст в €чейке к целому числу. }
//#UC START# *4FA4EEDF0370_502CC6560261_var*
var
 l_Value: Integer;
 l_Child: Tl3Variant;
//#UC END# *4FA4EEDF0370_502CC6560261_var*
begin
//#UC START# *4FA4EEDF0370_502CC6560261_impl*
 Result := 0;
 if TagInst.ChildrenCount = 1 then
 begin
  l_Child := TagInst.Child[0];
  if l_Child.IsKindOf(k2_typTextPara) and TryStrToInt(l_Child.StrA[k2_tiText], l_Value) then
   Result := l_Value;
 end; // if TagInst.ChildrenCount = 1 then
//#UC END# *4FA4EEDF0370_502CC6560261_impl*
end;//TevCell.TextAsInteger

function TevCell.GetFirstLineText: AnsiString;
 {* ¬озвращает первую строку €чейки. »спользыетс€ дл€ тестов. }
//#UC START# *4FC728DF02A2_502CC6560261_var*
//#UC END# *4FC728DF02A2_502CC6560261_var*
begin
//#UC START# *4FC728DF02A2_502CC6560261_impl*
 if TagInst.ChildrenCount > 0 then
  Result := TagInst.Child[0].StrA[k2_tiText]
 else
  Result := '';
//#UC END# *4FC728DF02A2_502CC6560261_impl*
end;//TevCell.GetFirstLineText

function TevCell.IsEmptyCell: Boolean;
//#UC START# *4FC764D402BF_502CC6560261_var*

 function lp_CheckCell(aCell: Tl3Variant; Index: LongInt): Boolean;
 begin
  Result := l3Trim(aCell.PCharLenA[k2_tiText], cc_WhiteSpaceExt).SLen = 0;
  if not Result then
   IsEmptyCell := False;
 end;

//#UC END# *4FC764D402BF_502CC6560261_var*
begin
//#UC START# *4FC764D402BF_502CC6560261_impl*
 with TagInst do
 begin
  Result := (ChildrenCount > 0) and (ChildrenCount <= 2);
  if Result then
   IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckCell));
 end;
//#UC END# *4FC764D402BF_502CC6560261_impl*
end;//TevCell.IsEmptyCell

function TevCell.IsFrameEmpty: Boolean;
//#UC START# *502CAE3301E7_502CC6560261_var*
//#UC END# *502CAE3301E7_502CC6560261_var*
begin
//#UC START# *502CAE3301E7_502CC6560261_impl*
 with TagInst.Attr[k2_tiFrame] do
  if IsValid then
   Result := IntA[k2_tiHandle] = 0
  else
   Result := True;
//#UC END# *502CAE3301E7_502CC6560261_impl*
end;//TevCell.IsFrameEmpty

function TevCell.GetCellType: TedCellType;
 {* ¬озвращает тип содержимого €чейки. }
//#UC START# *5112045801FF_502CC6560261_var*
var
 i          : Integer;
 l_Char     : Char;
 l_Value    : Integer;
 l_Child    : Tl3Variant;
 l_Count    : Integer;
 l_WasPoint : Boolean;
 l_ValueStr : String;
//#UC END# *5112045801FF_502CC6560261_var*
begin
//#UC START# *5112045801FF_502CC6560261_impl*
 Result := ed_None;
 if IsEmptyCell then
  if IsFrameEmpty then
   Result := ed_EmptyAndNotFramed
  else
   Result := ed_Empty
 else
 if TagInst.ChildrenCount = 1 then
 begin
  l_Child := TagInst.Child[0];
  if l_Child.IsKindOf(k2_typTextPara) then
  begin
   l_ValueStr := l_Child.StrA[k2_tiText];
   if TryStrToInt(l_ValueStr, l_Value) then
   begin
    Result := ed_Integer;
    Exit;
   end; // if TryStrToInt(l_Child.StrA[k2_tiText], l_Value) then
   if Pos('____', l_ValueStr) > 0 then
   begin
    Result := ed_HasFormLine;
    Exit;
   end; // if Pos('____', l_Child.StrA[k2_tiText]) > 0 then
   // ѕока так - врем€нка:
   l_WasPoint := False;
   l_Count := Length(l_ValueStr);
   Result := ed_Number;
   for i := 1 to l_Count do
   begin
    l_Char := l_ValueStr[i];
    if i = 1 then
    begin
     if not (l_Char in ['1'..'9']) then // ƒолжно начинатьс€ с 1.
     begin
      Result := ed_None;
      Break;
     end // if i = 1 then
    end // if i = 1 then
    else
    begin
     if l_WasPoint and (l_Char = '.') then // »збегаем двойных точек
     begin
      Result := ed_None;
      Break;
     end;
     l_WasPoint := l_Char = '.';
     if not l_WasPoint and not (l_Char in ['0'..'9']) then
     begin
      Result := ed_None;
      Break;
     end; // if not l_WasPoint and not (l_Char in ['0'..'9'])then
    end;
   end; // for i := 1 to l_Count do
   if Result = ed_Number then
   begin
    if l_WasPoint then
     Exit
    else
     Result := ed_None;
   end; // if IsEmptyStr(l_ValueStr, ['0'..'9', '.']) then
  end; // if l_Child.IsKindOf(k2_typTextPara) then
  if Length(l_ValueStr) < 10 then
   Result := ed_SmallText
  else
   Result := ed_Text;
 end // if TagInst.ChildrenCount = 1 then
 else
  if TagInst.ChildrenCount > 1 then
   Result := ed_Text;
 if Result = ed_Empty then
  if pm_GetWidth <= evCellWidthEpsilon then
   Result := ed_NeedDelete;
//#UC END# *5112045801FF_502CC6560261_impl*
end;//TevCell.GetCellType

procedure TevCell.MakeCellContinue(const anOp: InevOp);
 {* ¬ыставить тип €чейке (ev_msContinue) и очистить еЄ содержимое. }
//#UC START# *511B2BEC02F0_502CC6560261_var*
var
 l_Para: InevPara;
//#UC END# *511B2BEC02F0_502CC6560261_var*
begin
//#UC START# *511B2BEC02F0_502CC6560261_impl*
 if TagInst.QT(InevPara, l_Para, Processor) then
 begin
  evClearPara(View, l_Para, anOp, ev_cmAll);
  l_Para.AsObject.IntW[k2_tiMergeStatus, anOp] := Ord(ev_msContinue);
 end; // if TagInst.QT(InevPara, l_Para, Processor) then
//#UC END# *511B2BEC02F0_502CC6560261_impl*
end;//TevCell.MakeCellContinue

function TevCell.CalcHeadCellHeghtInRow: Integer;
 {* ѕосчитать сколько занимает строк объедиенна€ €чейка. }
//#UC START# *511B2C39034C_502CC6560261_var*
var
 l_Cell: InevTableCell;
//#UC END# *511B2C39034C_502CC6560261_var*
begin
//#UC START# *511B2C39034C_502CC6560261_impl*
 Result := 0;
 if pm_GetMergeStatus = ev_msHead then
 begin
  TagInst.QT(InevTableCell, l_Cell);
  Assert(l_Cell <> nil);
  while l_Cell <> nil do
  begin
   l_Cell := l_Cell.GetContinueCell(True, fc_Down);
   if l_Cell <> nil then Inc(Result);
  end; // while l_Cell <> nil do
 end; // if pm_GetMergeStatus = ev_msHead then
//#UC END# *511B2C39034C_502CC6560261_impl*
end;//TevCell.CalcHeadCellHeghtInRow

procedure TevCell.UpdateWidth(aNewWidth: Integer);
//#UC START# *512CB1DC00D1_502CC6560261_var*
//#UC END# *512CB1DC00D1_502CC6560261_var*
begin
//#UC START# *512CB1DC00D1_502CC6560261_impl*
 if (aNewWidth > 0) and (pm_GetWidth <> aNewWidth) then
  pm_SetWidth(aNewWidth);
//#UC END# *512CB1DC00D1_502CC6560261_impl*
end;//TevCell.UpdateWidth

procedure TevCell.Cleanup;
 {* ‘ункци€ очистки полей объекта. }
//#UC START# *479731C50290_502CC6560261_var*
var
 i : TedFramePartIndex;
//#UC END# *479731C50290_502CC6560261_var*
begin
//#UC START# *479731C50290_502CC6560261_impl*
 for i := Low(f_Neighbours) to High(f_Neighbours) do
  f_Neighbours[i] := nil;
 inherited;
//#UC END# *479731C50290_502CC6560261_impl*
end;//TevCell.Cleanup
{$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)

end.
