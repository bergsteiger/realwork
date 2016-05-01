unit evCellsWidthCorrecter;
 {* Инструмент для выравнивания границ ячеек. }

// Модуль: "w:\common\components\gui\Garant\Everest\evCellsWidthCorrecter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCellsWidthCorrecter" MUID: (4F2B767D015E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evRowAndTableTypeSupport
 , evCellsOffsetsPairList
 , evCellsOffsetsPair
 , l3LongintList
 , evEditorInterfaces
 , evCellWidthCorrecterSpy
 , evCellsOffsetsList
 , nevBase
 , l3Interfaces
 , evEditorInterfacesTypes
;

type
 TevFoundSuitebleType = (
  ev_fstNone
  , ev_fstTemplate
  , ev_fstInList
 );//TevFoundSuitebleType

 TevCellsWidthCorrecter = class(TevRowAndTableTypeSupport)
  {* Инструмент для выравнивания границ ячеек. }
  private
   f_CellsOffsetPairList: TevCellsOffsetsPairList;
    {* Список с парами значений выравненных и невыравненных. }
   f_Index: Integer;
    {* Индекс для прохода с установкой ширины ячеек. }
   f_PrevRowWidth: Integer;
    {* Закешированная ширина предыдущей строки - используется при выравнивании строк. }
   f_PriorityTemplateRow: TevCellsOffsetsPair;
    {* Текущий шаблон для выравнивания. Используется если при анализе таблицы был найден загооловок (в начале таблицы закончились объединенные ячеки или была найдена строка с номерами). После этого такой шаблон обновляется ближайшим подходящим. }
   f_RowsWithSingleCell: Tl3LongintList;
    {* Список номеров строк с одиночными или "притворящимися" такими ячейками. }
   f_Row: IedRow;
    {* Указатель на текущую строку. }
   f_LogSpy: TevCellWidthCorrecterSpy;
    {* Сохраняльщик результатов выравнивания для тестов. }
   f_WasNotEqualRows: Boolean;
    {* Флаг - были после выранивания неодинаковые строки. }
   f_HeadAlignment: Boolean;
    {* Выравнивание заголовка таблицы. Выставляется при повторном выравнивании заголовка на основе выравненных перед этим строк. }
   f_ForegnTemplates: TevCellsOffsetsList;
    {* Список для выравнивания "из вне" - применяется при копировании/вставке вершин. }
   f_NumbericData: TevCellsOffsetsPair;
  private
   procedure ApplyChanges(const anOp: InevOp;
    const anIterator: IedBackCellsIterator;
    aCellCount: Integer);
   function TryToCopyFromSuitableList: Boolean;
   function GetTemplate: TevCellsOffsetsPair;
   function GetRowsWithSingleCell: Tl3LongintList;
   function AddevCellsOffsetsPair(const aCellIterator: IedCellsIterator): TevCellsOffsetsPair;
   function GetSuitableList(out aFoundType: TevFoundSuitebleType): TevCellsOffsetsPair;
   procedure CopyFromSuitableList(const aList: TevCellsOffsetsPair;
    aFoundType: TevFoundSuitebleType);
   function GetIterator: IedCellsIterator;
   function CheckPreparrePriorityTemplate(out aFoundType: TevFoundSuitebleType): TevCellsOffsetsPair;
    {* Инициализация шаблона строк таблицы с проверокой. Шаблон строк может потребовать дополнительного выравнивани или просто не подходить для выравнивания. }
   function FoundPriorityTemplate: Boolean;
   procedure AlighHeader;
    {* Повторное выравнивание заголовка. }
   function TryToCopyForeignList: Boolean;
   function FindSuitableListInPrevious(const anIterator: IedCellsIterator;
    out aFoundType: TevFoundSuitebleType): TevCellsOffsetsPair;
   procedure SaveCellsTypeList(const aCellIterator: IedCellsIterator;
    const aCellOffsetPair: TevCellsOffsetsPair);
  protected
   function GetPrevRowType: TedRowType; override;
   function GetCellsCountInPreviousRow: Integer; override;
    {* Возвращает число ячеек в последней выравненной строке }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aForegnTemplates: TevCellsOffsetsList); reintroduce;
   procedure CheckRowsWithSingleCell;
   procedure CheckLog;
   class function DoCorrection(const aTable: IedTable;
    const aForegnTemplates: TevCellsOffsetsList;
    aSeparateOp: Boolean;
    const aProgress: Il3Progress = nil): Boolean;
   procedure CorrectCells(const aRow: IedRow);
   procedure ApplyChanges2Row(const anOp: InevOp;
    const aRow: IedRow;
    aFirst: Boolean);
 end;//TevCellsWidthCorrecter

implementation

uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evTableCellUtils
 {$IfEnd} // Defined(k2ForEditor)
 , l3Base
 , l3Types
 , afwFacade
 , k2Op
 , evOp
 , evMsgCode
 , evCellsCharOffsets
 , edCellTypesList
;

procedure TevCellsWidthCorrecter.ApplyChanges(const anOp: InevOp;
 const anIterator: IedBackCellsIterator;
 aCellCount: Integer);
//#UC START# *4F2F734203C7_4F2B767D015E_var*
var
 l_WidthList : TevCellsOffsetsPair;

 procedure lp_SaveLogRowData;
 begin
  if f_LogSpy <> nil then
   f_LogSpy.SaveRowData(f_Index, l_WidthList.GetRowWidth(False), l_WidthList.GetRowWidth(True));
 end;

var
 l_Width    : Integer;
 l_CellIndex: Integer;
 l_Cell     : IedCell;
 l_CellData : TevCellLogData;

 procedure lp_SaveCellData;
 begin
  if f_LogSpy <> nil then
  begin
   with l_CellData do
   begin
    l_CellData.rCellID := l_CellIndex;
    l_CellData.rCellText := l_Cell.GetFirstLineText;
    l_CellData.rOldWidth := l_Cell.Width;
    l_CellData.rNewWidth := l_Width;
   end; // with l_CellData do
   f_LogSpy.SaveAlignmentData(l_CellData);
  end; // if f_LogSpy <> nil then
 end;        

var
 //l_Delta        : Integer;
 l_PrevList     : TevCellsOffsetsPair;
 l_DeletingCell : IedCell;
//#UC END# *4F2F734203C7_4F2B767D015E_var*
begin
//#UC START# *4F2F734203C7_4F2B767D015E_impl*
 l_Cell := anIterator.Last(False);
 l_WidthList := f_CellsOffsetPairList[f_Index];
 if f_Index > 0 then
  l_PrevList := f_CellsOffsetPairList[f_Index - 1]
 else                                       
  l_PrevList := nil; 
 l_Width := l_WidthList.LastNewWidth;
 l_CellIndex := aCellCount - 1;
 //l_Delta := 0;
 while (l_Cell <> nil) do
 begin
  (*if l_WidthList.CellsType[l_CellIndex] = ed_NeedDelete then
  begin
   l_DeletingCell := l_Cell;
   Inc(l_Delta, l_Width);
   l_Cell := anIterator.Prev;
   l_DeletingCell.Delete(anOp, True);
  end // if l_WidthList.CellsType[[l_CellIndex] = ed_NeedDelete then
  else*)
  begin
   lp_SaveCellData;
   if l_Width > 0 then
   begin
    //Inc(l_Width, l_Delta);
    l_Cell.UpdateWidthAndCheckHead(l_Width);
   end; // if l_Width > 0 then
   //l_Delta := 0;
   l_Cell := anIterator.Prev;
  end;
  Dec(l_CellIndex);
  l_Width := l_WidthList.PrevNewWidth;
 end; // while (l_Cell <> nil) do
 lp_SaveLogRowData;
//#UC END# *4F2F734203C7_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.ApplyChanges

constructor TevCellsWidthCorrecter.Create(const aForegnTemplates: TevCellsOffsetsList);
//#UC START# *4F2F73CD01D1_4F2B767D015E_var*
//#UC END# *4F2F73CD01D1_4F2B767D015E_var*
begin
//#UC START# *4F2F73CD01D1_4F2B767D015E_impl*
 inherited Create;
 f_CellsOffsetPairList := TevCellsOffsetsPairList.Create;
 f_PrevRowWidth := 0;
 f_WasNotEqualRows := False;
 f_HeadAlignment := False;
 f_ForegnTemplates := aForegnTemplates;
//#UC END# *4F2F73CD01D1_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.Create

function TevCellsWidthCorrecter.TryToCopyFromSuitableList: Boolean;
//#UC START# *4FA504FF0217_4F2B767D015E_var*
var
 l_FindList   : TevCellsOffsetsPair;
 l_FoundType  : TevFoundSuitebleType;
 l_WasTemlate : Boolean;
//#UC END# *4FA504FF0217_4F2B767D015E_var*
begin
//#UC START# *4FA504FF0217_4F2B767D015E_impl*
 Result := False;
 l_WasTemlate := FoundPriorityTemplate;
 if f_CellsOffsetPairList.Count = 0 then Exit;
 l_FindList := GetSuitableList(l_FoundType);
 if l_FindList <> nil then
 begin
  Result := True;
  CopyFromSuitableList(l_FindList, l_FoundType);
  if CurrentRowType = ed_NumericCels then
   f_NumbericData := f_CellsOffsetPairList.Last;
 end; // if l_FindList <> nil then
 if not l_WasTemlate and FoundPriorityTemplate and f_WasNotEqualRows then // Значит - пора выравнивать предыдущие...
  AlighHeader;
//#UC END# *4FA504FF0217_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.TryToCopyFromSuitableList

function TevCellsWidthCorrecter.GetTemplate: TevCellsOffsetsPair;
//#UC START# *4FA5095F01AE_4F2B767D015E_var*
//#UC END# *4FA5095F01AE_4F2B767D015E_var*
begin
//#UC START# *4FA5095F01AE_4F2B767D015E_impl*
 if FoundPriorityTemplate then
  Result := f_PriorityTemplateRow
 else
  Result := f_CellsOffsetPairList.PenultimateItem;
//#UC END# *4FA5095F01AE_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.GetTemplate

function TevCellsWidthCorrecter.GetRowsWithSingleCell: Tl3LongintList;
//#UC START# *4FA5209302CC_4F2B767D015E_var*
//#UC END# *4FA5209302CC_4F2B767D015E_var*
begin
//#UC START# *4FA5209302CC_4F2B767D015E_impl*
 if f_RowsWithSingleCell = nil then
  f_RowsWithSingleCell := Tl3LongintList.Create;
 Result := f_RowsWithSingleCell; 
//#UC END# *4FA5209302CC_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.GetRowsWithSingleCell

function TevCellsWidthCorrecter.AddevCellsOffsetsPair(const aCellIterator: IedCellsIterator): TevCellsOffsetsPair;
//#UC START# *4FA52C7A027C_4F2B767D015E_var*
var
 l_Index: Integer;
//#UC END# *4FA52C7A027C_4F2B767D015E_var*
begin
//#UC START# *4FA52C7A027C_4F2B767D015E_impl*
 if f_HeadAlignment then
 begin
  Result := f_CellsOffsetPairList[f_Index];
  Result.Clear;
 end // if f_HeadAlignment then
 else
 begin
  Result := TevCellsOffsetsPair.Create;
  l_Index := f_CellsOffsetPairList.Add(Result);
  SaveRowType(Result);
  SaveCellsTypeList(GetIterator, Result);
  if CurrentRowType in edSingleCell then
   GetRowsWithSingleCell.Add(l_Index);
 end;
//#UC END# *4FA52C7A027C_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.AddevCellsOffsetsPair

procedure TevCellsWidthCorrecter.CheckRowsWithSingleCell;
//#UC START# *4FA530670256_4F2B767D015E_var*

 function lp_CheckItem(aData: PInteger; anIndex: Integer): Boolean;
 var
  l_Index     : Integer;
  l_PrevWidth : TevCellsOffsetsPair;
 begin
  l_Index := aData^;
  if l_Index > 0 then
  begin
   l_PrevWidth := f_CellsOffsetPairList[l_Index - 1];
   f_CellsOffsetPairList[l_Index].AlignByPrevious(l_PrevWidth);
  end; // if l_PrevIndex > 0 then
  Result := True;
 end;

//#UC END# *4FA530670256_4F2B767D015E_var*
begin
//#UC START# *4FA530670256_4F2B767D015E_impl*
 if f_RowsWithSingleCell <> nil then
  f_RowsWithSingleCell.IterateAllF(l3L2IA(@lp_CheckItem));
//#UC END# *4FA530670256_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.CheckRowsWithSingleCell

function TevCellsWidthCorrecter.GetSuitableList(out aFoundType: TevFoundSuitebleType): TevCellsOffsetsPair;
//#UC START# *4FC5D31C000E_4F2B767D015E_var*
var
 l_CellIterator: IedCellsIterator;
//#UC END# *4FC5D31C000E_4F2B767D015E_var*
begin
//#UC START# *4FC5D31C000E_4F2B767D015E_impl*
 aFoundType := ev_fstNone;
 Result := CheckPreparrePriorityTemplate(aFoundType);
 if Result = nil then
 begin
  l_CellIterator := GetIterator;
  try
   Result := FindSuitableListInPrevious(l_CellIterator, aFoundType);
   if FoundPriorityTemplate and (f_PriorityTemplateRow = Result) then
    aFoundType := ev_fstTemplate;
  finally
   l_CellIterator := nil;
  end;
 end; // if Result = nil then
//#UC END# *4FC5D31C000E_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.GetSuitableList

procedure TevCellsWidthCorrecter.CopyFromSuitableList(const aList: TevCellsOffsetsPair;
 aFoundType: TevFoundSuitebleType);
//#UC START# *4FC5D4D2033A_4F2B767D015E_var*
var
 l_WidthList   : TevCellsOffsetsPair;
 l_CellIterator: IedCellsIterator;
//#UC END# *4FC5D4D2033A_4F2B767D015E_var*
begin
//#UC START# *4FC5D4D2033A_4F2B767D015E_impl*
 l_CellIterator := GetIterator;
 l_WidthList := AddevCellsOffsetsPair(l_CellIterator);
 try  
  l_WidthList.CopyData(aList, l_CellIterator);
  if aFoundType = ev_fstTemplate then // Если нашли такую, то используем именно её
   f_PriorityTemplateRow := f_CellsOffsetPairList.Last;
 finally
  if not f_HeadAlignment then
   l3Free(l_WidthList);
  l_CellIterator := nil;
 end;
//#UC END# *4FC5D4D2033A_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.CopyFromSuitableList

function TevCellsWidthCorrecter.GetIterator: IedCellsIterator;
//#UC START# *4FC5EA5B0165_4F2B767D015E_var*
//#UC END# *4FC5EA5B0165_4F2B767D015E_var*
begin
//#UC START# *4FC5EA5B0165_4F2B767D015E_impl*
 if f_Row = nil then
  Result := nil
 else
  Result := f_Row.CellsIterator;
//#UC END# *4FC5EA5B0165_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.GetIterator

function TevCellsWidthCorrecter.CheckPreparrePriorityTemplate(out aFoundType: TevFoundSuitebleType): TevCellsOffsetsPair;
 {* Инициализация шаблона строк таблицы с проверокой. Шаблон строк может потребовать дополнительного выравнивани или просто не подходить для выравнивания. }
//#UC START# *4FC5FBF401A8_4F2B767D015E_var*
//#UC END# *4FC5FBF401A8_4F2B767D015E_var*
begin
//#UC START# *4FC5FBF401A8_4F2B767D015E_impl*
 Result := nil;
 aFoundType := ev_fstNone;
 if not FoundPriorityTemplate then
 begin
  if CurrentRowType = ed_NumericCels then
  begin
   Result := f_CellsOffsetPairList.Last;
   aFoundType := ev_fstTemplate; // Строку с номерами ячеек лучше выровнять по предыдущей
  end // if f_CurrentRowType = ed_NumericCels then
  else
   if TableStyle <> ed_tsForm then
   begin
    if (CurrentRowType in edSingleCell) and (GetPrevRowType in edAllowCellInHeadRow) then
    begin
     f_PriorityTemplateRow := f_CellsOffsetPairList.Last;
     aFoundType := ev_fstInList;
    end // if (CurrentRowType in edSingleCell) and (GetPrevRowType in edAllowCellInHeadRow) then
    else
     if (GetPrevRowType = ed_HasMergedCell) and (CurrentRowType = ed_SimpleCells) then
     begin
      f_PriorityTemplateRow := f_CellsOffsetPairList.Last;
      aFoundType := ev_fstTemplate;
     end; // if (GetPrevRowType = ed_HasMergedCell) and (f_CurrentRowType = ed_SimpleCells) then
   end; // if f_TableStyle <> ev_tsForm then
 end;
//#UC END# *4FC5FBF401A8_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.CheckPreparrePriorityTemplate

procedure TevCellsWidthCorrecter.CheckLog;
//#UC START# *4FC72703007E_4F2B767D015E_var*
//#UC END# *4FC72703007E_4F2B767D015E_var*
begin
//#UC START# *4FC72703007E_4F2B767D015E_impl*
 if TevCellWidthCorrecterSpy.Exists and TevCellWidthCorrecterSpy.Instance.NeedLog then
  f_LogSpy := TevCellWidthCorrecterSpy.Instance
 else
  f_LogSpy := nil;
//#UC END# *4FC72703007E_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.CheckLog

function TevCellsWidthCorrecter.FoundPriorityTemplate: Boolean;
//#UC START# *4FC8655F01B4_4F2B767D015E_var*
//#UC END# *4FC8655F01B4_4F2B767D015E_var*
begin
//#UC START# *4FC8655F01B4_4F2B767D015E_impl*
 Result := f_PriorityTemplateRow <> nil;
//#UC END# *4FC8655F01B4_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.FoundPriorityTemplate

procedure TevCellsWidthCorrecter.AlighHeader;
 {* Повторное выравнивание заголовка. }
//#UC START# *4FC86F1E023D_4F2B767D015E_var*
var
 l_OldRow    : IedRow;
 l_PrevWidth : Integer;

 procedure lp_PushOldParams;
 begin
  l_PrevWidth := f_PrevRowWidth;
  l_OldRow := f_Row;
 end;

 procedure lp_PopOldParams;
 begin
  f_PrevRowWidth := l_PrevWidth;
  f_Row := l_OldRow;
 end;

var
 l_Row         : IedRow;
 l_StartIndex  : Integer;
 l_RecalcCount : Integer;
 l_RowIterator : IedRowsIterator;

 procedure lp_InitStartIndex;
 var
  i : Integer;
 begin
  // Анализируем случай, когда таблица сложная - фактически две или более таблиц в одной...
  l_StartIndex := l_RecalcCount;
  for i := l_RecalcCount downto 0 do
   if (f_CellsOffsetPairList[i].RowType in [ed_NumericCels, ed_SingleCell, ed_PsevdoSingleCells, ev_FormCells, ed_SimpleEmptyCells]) then
    Break;
  l_StartIndex := i + 1;
  if l_StartIndex > 0 then
   for i := 0 to l_StartIndex - 1 do
    l_Row := l_RowIterator.Next;
 end;

var
 l_Index: Integer;
//#UC END# *4FC86F1E023D_4F2B767D015E_var*
begin
//#UC START# *4FC86F1E023D_4F2B767D015E_impl*
 l_RecalcCount := f_CellsOffsetPairList.Count - 2;
 l_RowIterator := f_Row.Table.RowsIterator;
 l_Row := l_RowIterator.First;
 f_HeadAlignment := True;
 lp_PushOldParams;
 try
  lp_InitStartIndex;
  for l_Index := l_StartIndex to l_RecalcCount do
  begin
   f_Index := l_Index;
   CorrectCells(l_Row);
   l_Row := l_RowIterator.Next;
  end; // for l_Index := 0 to l_RecalcCount do
 finally
  lp_PopOldParams;
  l_RowIterator := nil;
  f_HeadAlignment := False;
 end;
//#UC END# *4FC86F1E023D_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.AlighHeader

class function TevCellsWidthCorrecter.DoCorrection(const aTable: IedTable;
 const aForegnTemplates: TevCellsOffsetsList;
 aSeparateOp: Boolean;
 const aProgress: Il3Progress = nil): Boolean;
//#UC START# *50923EED0279_4F2B767D015E_var*
var
 l_Index    : Integer;
 l_Correct  : Boolean;
 l_RowCount : Integer;

 procedure lp_IniProgress;
 begin
  if aProgress <> nil then
  begin
   l_RowCount := aTable.RowCount;
   aProgress.Start(l_RowCount * 2, l3CStr('Выравнивание границ ячеек.'));
  end; // if aProgress <> nil then
 end;

 procedure lp_CheckProgress;
 begin
  if aProgress <> nil then
  begin
   aProgress.Progress(l_RowCount * Ord(l_Correct) + l_Index);
   if (l_Index > 0) then
    if l_RowCount < 100 then
    begin
     if (l_Index mod 20) = 0 then
      afw.ProcessMessages;
    end // if l_RowCount < 100 then
    else
     if (l_Index mod 100) = 0 then
      afw.ProcessMessages;
  end; // if aProgress <> nil then
 end;

 procedure lp_DeinitProgress;
 begin
  if aProgress <> nil then
   aProgress.Finish;
 end;

var
 l_Op        : InevOp;
 l_Processor : InevProcessor;

 procedure lp_Hack;
 begin
   // V - хакерский трюк для потабличной откатки.
  if aSeparateOp then
  begin
   l_Op := l_Processor.StartOp;
   try
    Tk2Op.ToUndo(l_Op);
   finally
    l_Op := nil;
   end;
  end; // if aSeparateOp then
 end;

var
 l_Row           : IedRow;
 l_RowsIterator  : IedRowsIterator;
 l_CellCorrector : TevCellsWidthCorrecter;
//#UC END# *50923EED0279_4F2B767D015E_var*
begin
//#UC START# *50923EED0279_4F2B767D015E_impl*
 Result := False;
 if (aTable <> nil) then
 begin
  l_Processor := aTable.Processor;
  l_Op := l_Processor.StartOp(ev_msgChangeParam);
  try
   l_RowsIterator := aTable.RowsIterator;
   if (l_RowsIterator <> nil) then
   begin
    Result := True;
    lp_IniProgress;
    l_CellCorrector := TevCellsWidthCorrecter.Create(aForegnTemplates);
    try
     l_CellCorrector.CheckLog;
     for l_Correct := False to True do
     begin
      l_Index := 0;
      l_Row := l_RowsIterator.First;
      while (l_Row <> nil) do
      begin
       if l_Correct then
        l_CellCorrector.ApplyChanges2Row(l_Op, l_Row, l_Index = 0)
       else
        l_CellCorrector.CorrectCells(l_Row);
       lp_CheckProgress;
       l_Row := l_RowsIterator.Next;
       Inc(l_Index);
      end;//while (l_Row <> nil)
      if not l_Correct then
       l_CellCorrector.CheckRowsWithSingleCell;
     end; // for l_Correct := True to False do
    finally
     lp_DeinitProgress;
     l3Free(l_CellCorrector);
    end;
   end;//l_RowsIterator <> nil
  finally
   l_Op := nil;
  end;
  lp_Hack;
 end;//aTable <> nil
//#UC END# *50923EED0279_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.DoCorrection

function TevCellsWidthCorrecter.TryToCopyForeignList: Boolean;
//#UC START# *5092588F021F_4F2B767D015E_var*
var
 l_Found        : TevCellsCharOffsets;
 l_WidthList    : TevCellsOffsetsPair;
 l_CellIterator : IedCellsIterator;
//#UC END# *5092588F021F_4F2B767D015E_var*
begin
//#UC START# *5092588F021F_4F2B767D015E_impl*
 Result := False;
 if not f_HeadAlignment and (f_ForegnTemplates <> nil) then
 begin
  l_Found := nil;
  l_CellIterator := GetIterator;
  if f_ForegnTemplates.Count > 0 then
   l_Found := f_ForegnTemplates.FindList(l_CellIterator, False); //IterateAllF(l3L2IA(@lp_CheckItem));
  if l_Found <> nil then
  begin
   l_WidthList := AddevCellsOffsetsPair(l_CellIterator);
   try
    l_WidthList.CopyData(l_Found, l_CellIterator);
    Result := True;
   finally
    l3Free(l_WidthList);
   end;
  end; // if l_Found <> nil then
 end; // if f_PriorityTemplateRow = nil then
//#UC END# *5092588F021F_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.TryToCopyForeignList

function TevCellsWidthCorrecter.FindSuitableListInPrevious(const anIterator: IedCellsIterator;
 out aFoundType: TevFoundSuitebleType): TevCellsOffsetsPair;
//#UC START# *4F2FA52C00EC_4F2B767D015E_var*

 function lp_CheckItem(aData: PObject; anIndex: Integer): Boolean;
 begin
  Result := not TevCellsOffsetsPair(aData^).EqualCells(anIterator);
  if not Result then
   FindSuitableListInPrevious := TevCellsOffsetsPair(aData^);
 end;

var
 l_CellIteraor: IedCellsIterator;
//#UC END# *4F2FA52C00EC_4F2B767D015E_var*
begin
//#UC START# *4F2FA52C00EC_4F2B767D015E_impl*
 Result := nil;
 if FoundPriorityTemplate and f_PriorityTemplateRow.EqualCells(anIterator) then
 begin
  Result := f_PriorityTemplateRow;
  aFoundType := ev_fstTemplate;
 end // if FoundPriorityTemplate and f_PriorityTemplateRow.EqualCells(anIterator) then
 else
 begin
  if not f_HeadAlignment then
  begin
   if f_CellsOffsetPairList.Count > 0 then
    f_CellsOffsetPairList.IterateBackF(f_CellsOffsetPairList.Hi, f_CellsOffsetPairList.Lo, l3L2IA(@lp_CheckItem));
   if Result <> nil then
    aFoundType := ev_fstInList;
  end // if f_PriorityTemplateRow = nil then
 end;
//#UC END# *4F2FA52C00EC_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.FindSuitableListInPrevious

procedure TevCellsWidthCorrecter.SaveCellsTypeList(const aCellIterator: IedCellsIterator;
 const aCellOffsetPair: TevCellsOffsetsPair);
//#UC START# *528DDD5B0275_4F2B767D015E_var*
var
 l_Cell                 : IedCell;
 l_CurrentCellsTypeList : TedCellTypesList;
//#UC END# *528DDD5B0275_4F2B767D015E_var*
begin
//#UC START# *528DDD5B0275_4F2B767D015E_impl*
 l_Cell := aCellIterator.First(False);
 l_CurrentCellsTypeList := TedCellTypesList.Create;
 try
  while l_Cell <> nil do
  begin
   l_CurrentCellsTypeList.Add(l_Cell.GetCellType);
   l_Cell := aCellIterator.Next;
  end; // while l_Cell <> nil do
  aCellIterator.First(False); // Не надо "портить" итератор.
  aCellOffsetPair.CellsType := l_CurrentCellsTypeList;
 finally
  l_CurrentCellsTypeList := nil;
 end;
//#UC END# *528DDD5B0275_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.SaveCellsTypeList

procedure TevCellsWidthCorrecter.CorrectCells(const aRow: IedRow);
//#UC START# *4F2BC62D00FE_4F2B767D015E_var*
var
 l_WidthList : TevCellsOffsetsPair;

 procedure lp_CheckAndRememberPrevWidth;
 var
  l_CurrWidth : Integer;
 begin
  l_CurrWidth := l_WidthList.GetOffset(True);
  if not f_HeadAlignment and (f_PrevRowWidth > 0) and not f_WasNotEqualRows then
   f_WasNotEqualRows := l_CurrWidth <> f_PrevRowWidth;
  f_PrevRowWidth := l_CurrWidth;
 end;

var
 l_Cell         : IedCell;
 l_Index        : Integer;
 l_NewWidth     : Integer;
 l_OldCellWidth : Integer;

 procedure lp_InitWidth;
 (*var
  l_NeedDelete: Boolean;*)
 begin
  l_OldCellWidth := l_Cell.Width;
  l_NewWidth := evCheckCellWidth(l_OldCellWidth, True);
  l_WidthList.SetWidthPair(l_NewWidth, l_Cell.Width);
  (*l_NeedDelete := (l_NewWidth <= 3 * evGetMinimalCellWidth) and (l_Index = l_WidthList.CellsType.Count - 1) and
                  (l_WidthList.CellsType[l_Index] = ed_EmptyAndNotFramed);
  if l_NeedDelete then
   l_WidthList.CellsType[l_Index] := ed_NeedDelete;*)
 end;

var
 l_NeedBreak     : Boolean;
 l_PrevWidthList : TevCellsOffsetsPair;

 procedure lp_CheckPrevList;
 var
  l_CellPos: TedCellPosType;
 begin
  if l_PrevWidthList <> nil then
  begin
   l_CellPos := ed_cpNone;
   if l_Cell = nil then
   begin
    l_CellPos := ed_cpLast;
    if FoundPriorityTemplate then
     l_CellPos := ed_cpIgnoreLast;
   end; // if l_Cell = nil then
   l_PrevWidthList.CheckCurrentRow(l_WidthList, l_NewWidth, l_OldCellWidth, f_PrevRowWidth, l_CellPos, l_NeedBreak);
  end; // if l_PrevWidthList <> nil then
 end;

var
 l_PrevList     : TevCellsOffsetsPair;
 l_CellIterator : IedCellsIterator;
//#UC END# *4F2BC62D00FE_4F2B767D015E_var*
begin
//#UC START# *4F2BC62D00FE_4F2B767D015E_impl*
 f_Row := aRow;
 try
  l_CellIterator := GetIterator;
  if l_CellIterator <> nil then
   try
    if not f_HeadAlignment then
     AnalizeRowType(f_Row);
    l_Cell := l_CellIterator.First(False);
    if (l_Cell <> nil) then
    begin
     if not TryToCopyForeignList then
      if not TryToCopyFromSuitableList then
      begin
       if f_CellsOffsetPairList.Count > 0 then
        l_PrevList := f_CellsOffsetPairList.Last
       else
        l_PrevList := nil; 
       l_WidthList := AddevCellsOffsetsPair(l_CellIterator);
       try
        l_Index := 0;
        l_PrevWidthList := GetTemplate;
        l_NeedBreak := False;
        while (l_Cell <> nil) do
        begin
         lp_InitWidth;
         l_Cell := l_CellIterator.Next;
         lp_CheckPrevList;
         if l_NeedBreak then Break;
         l_WidthList.AddCellWidthAndRecalc;
         Inc(l_Index);
        end; // while (l_Cell <> nil)
        if not f_HeadAlignment then
         l_WidthList.CheckPrevAlignment(l_PrevList);
        lp_CheckAndRememberPrevWidth;
       finally
        if not f_HeadAlignment then
         l3Free(l_WidthList);
       end;
      end; // if not TryToCopyFromSuitableList then
    end; // if l_Cell <> nil then
   finally
    l_CellIterator := nil;
   end;
 finally
  f_Row := nil;
 end;
//#UC END# *4F2BC62D00FE_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.CorrectCells

procedure TevCellsWidthCorrecter.ApplyChanges2Row(const anOp: InevOp;
 const aRow: IedRow;
 aFirst: Boolean);
//#UC START# *4F2BC6810005_4F2B767D015E_var*
var
 l_CellIterator: IedCellsIterator;
//#UC END# *4F2BC6810005_4F2B767D015E_var*
begin
//#UC START# *4F2BC6810005_4F2B767D015E_impl*
 l_CellIterator := aRow.CellsIterator;
 if l_CellIterator <> nil then
 begin
  if aFirst then
   f_Index := 0
  else
   Inc(f_Index);
  ApplyChanges(anOp, l_CellIterator.BackIterator, l_CellIterator.CellsCount);
 end; // if l_CellIterator <> nil then
//#UC END# *4F2BC6810005_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.ApplyChanges2Row

function TevCellsWidthCorrecter.GetPrevRowType: TedRowType;
//#UC START# *5114D749037C_4F2B767D015E_var*
//#UC END# *5114D749037C_4F2B767D015E_var*
begin
//#UC START# *5114D749037C_4F2B767D015E_impl*
 Result := f_CellsOffsetPairList.Last.RowType;
//#UC END# *5114D749037C_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.GetPrevRowType

function TevCellsWidthCorrecter.GetCellsCountInPreviousRow: Integer;
 {* Возвращает число ячеек в последней выравненной строке }
//#UC START# *5152D812036E_4F2B767D015E_var*
//#UC END# *5152D812036E_4F2B767D015E_var*
begin
//#UC START# *5152D812036E_4F2B767D015E_impl*
 if (f_CellsOffsetPairList = nil) or (f_CellsOffsetPairList.Count = 0) then
  Result := 0
 else
  Result := f_CellsOffsetPairList.Last.CellsType.Count;
//#UC END# *5152D812036E_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.GetCellsCountInPreviousRow

procedure TevCellsWidthCorrecter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F2B767D015E_var*
//#UC END# *479731C50290_4F2B767D015E_var*
begin
//#UC START# *479731C50290_4F2B767D015E_impl*
 f_ForegnTemplates := nil;
 if f_RowsWithSingleCell <> nil then
  f_RowsWithSingleCell.Clear;
 l3Free(f_RowsWithSingleCell);
 f_PriorityTemplateRow := nil;
 if f_CellsOffsetPairList <> nil then
  f_CellsOffsetPairList.Clear;
 l3Free(f_CellsOffsetPairList);
 f_PrevRowWidth := 0;
 f_WasNotEqualRows := False;
 f_HeadAlignment := False;
 f_Row := nil;
 f_NumbericData := nil;
 inherited;
//#UC END# *479731C50290_4F2B767D015E_impl*
end;//TevCellsWidthCorrecter.Cleanup

end.
