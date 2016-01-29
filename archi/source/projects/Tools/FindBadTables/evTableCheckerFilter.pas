unit evTableCheckerFilter;

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  evdTypes,
  evCellsOffsets,
  k2TagFilter,
  k2Types
  ;

type
 TevTableCheckerFilter = class(Tk2TagFilter)
  {* фильтр для преобразования "подвисших" ячеек объединения в нормальный вид. }
 private
  f_TableStrID: AnsiString;
  {* - текст первой строки таблицы для идентификации. }
  f_TablesStart: Integer;
  {* - таблиц открыто (вложенные не поддерживаются, пока. }
  f_PrevRowWindth : Integer;
  {* - ширина предыдущей строки. }
  f_CurrRowWidth  : Integer;
  {* - текущая ширина строки. }
  f_NeedSave      : Boolean;
  {* - Нужно сохранять в лог. }
 protected
 // overridden protected methods
  procedure InitFields; override;
    {-}
  procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  procedure DoStartChild(TypeID: Integer); override;
   {-}
  procedure DoAddAtomEx(AtomIndex: Integer; const Value: Tk2Variant); override;
   {-}
  procedure DoCloseStructure(NeedUndo: Boolean); override;
   {-}
 end;//TevMergedCellFilter

 procedure g_SetDocName(const aDocName: AnsiString);

implementation

uses
  l3Base,
  Table_Const,
  TableRow_Const,
  TableCell_Const,
  k2Tags,
  SBSCell_Const,
  evTableCellUtils,
  l3UnitsTools
  ;

var
 g_DocName: AnsiString = '';
  {* - имя документа. }    

// start class TevTableCheckerFilter

procedure TevTableCheckerFilter.Cleanup;
begin
 f_TablesStart := 0;
 f_PrevRowWindth := 0;
 f_CurrRowWidth := 0;
 f_NeedSave := False;
 f_TableStrID := '';
 inherited;
end;//TevTableCheckerFilter.Cleanup

procedure TevTableCheckerFilter.DoStartChild(TypeID: Integer);
begin
 if (TypeID = k2_idTable) then
 begin
  f_PrevRowWindth := 0;
  f_CurrRowWidth := 0;
  Inc(f_TablesStart);
  f_TableStrID := '';
  f_NeedSave := False;
 end; // if (TypeID = k2_idTable) then
 if (TypeID = k2_idTableRow) then
  f_CurrRowWidth := 0;
 inherited;
end;//TevTableCheckerFilter.DoStartChild

procedure TevTableCheckerFilter.DoAddAtomEx(AtomIndex: Integer;
  const Value: Tk2Variant);
begin
 if f_TablesStart = 1 then
 begin
  if (AtomIndex = k2_tiWidth) then
   Inc(f_CurrRowWidth, Value.AsInteger);
  if (AtomIndex = k2_tiText) and (f_PrevRowWindth = 0) then
   f_TableStrID := f_TableStrID + Value.AsString.AsString;
 end; // if CurrentType.InheritsFrom(k2_idTableCell) then
 inherited;
end;//TevTableCheckerFilter.DoAddAtomEx

procedure TevTableCheckerFilter.DoCloseStructure(NeedUndo: Boolean);
begin
 if CurrentType.InheritsFrom(k2_idTableRow) then
 begin
  if (f_PrevRowWindth > 0) then
  begin
   if not evEqualOffset(f_CurrRowWidth, f_PrevRowWindth) then
    f_NeedSave := True;
  end; // if CurrentType.InheritsFrom(k2_idRow) and (f_PrevRowWindth > 0) then
  f_PrevRowWindth := f_CurrRowWidth;
 end; // if CurrentType.InheritsFrom(k2_idTableRow) then
 if CurrentType.InheritsFrom(k2_idTable) then
 begin
  if f_NeedSave then
  begin
   l3System.Msg2Log(g_DocName);
   l3System.Msg2Log(f_TableStrID);
   l3System.Msg2Log('_________________________________________');
  end; // if CurrentType.InheritsFrom(k2_idTable) and f_NeedSave then
  if f_TablesStart > 0 then
   Dec(f_TablesStart);
 end; // if CurrentType.InheritsFrom(k2_idTable) then
 inherited;
end;//TevTableCheckerFilter.DoCloseStructure

procedure TevTableCheckerFilter.InitFields;
begin
 inherited;
 f_TablesStart := 0;
end;

procedure g_SetDocName(const aDocName: AnsiString);
begin
 g_DocName := aDocName;
end;

end.