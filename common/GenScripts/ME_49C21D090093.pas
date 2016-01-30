unit evMergedCellFilter;
 {* фильтр для преобразования "подвисших" ячеек объединения в нормальный вид. }

// Модуль: "w:\common\components\gui\Garant\Everest\evMergedCellFilter.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , evCellsOffsets
 , evdTypes
 , k2Base
 , l3Variant
;

type
 TevNeedAddTextPara = (
  ev_natNo
  , ev_natYes
  , ev_natWaitMergeStatus
 );//TevNeedAddTextPara

 TevMergedCellFilter = class(Tk2TagFilter)
  {* фильтр для преобразования "подвисших" ячеек объединения в нормальный вид. }
  private
   f_CellsOffsets: TevCellsOffsets;
    {* Смещения для поиска ячеек. }
   f_MergeStatus: TevMergeStatus;
   f_HasChild: Boolean;
    {* Есть ли у ячейки хоть один дочерний. }
   f_CorrectedWidth: Boolean;
    {* Ширина была изменена. }
   f_NewWidth: Integer;
    {* Новая ширина ячейки. }
   f_NeedAddTextPara: TevNeedAddTextPara;
    {* Нужно ли проверять дочерние. }
  private
   function CellsOffsets: TevCellsOffsets;
   function IsTableCell: Boolean;
   procedure CheckCellWidth;
    {* Проверяет ширину ячейки и, если надо корректирует её. }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoStartChild(TypeID: Tk2Type); override;
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   procedure DoCloseStructure(NeedUndo: Boolean); override;
 end;//TevMergedCellFilter

implementation

uses
 l3ImplUses
 , l3Base
 , Table_Const
 , TableRow_Const
 , TableCell_Const
 , k2Tags
 , SBSCell_Const
 , l3UnitsTools
;

function TevMergedCellFilter.CellsOffsets: TevCellsOffsets;
//#UC START# *4E4517310268_49C21D090093_var*
//#UC END# *4E4517310268_49C21D090093_var*
begin
//#UC START# *4E4517310268_49C21D090093_impl*
 if f_CellsOffsets = nil then
  f_CellsOffsets := TevCellsOffsets.Create;
 Result := f_CellsOffsets;
//#UC END# *4E4517310268_49C21D090093_impl*
end;//TevMergedCellFilter.CellsOffsets

function TevMergedCellFilter.IsTableCell: Boolean;
//#UC START# *4FA3B42B01C6_49C21D090093_var*
//#UC END# *4FA3B42B01C6_49C21D090093_var*
begin
//#UC START# *4FA3B42B01C6_49C21D090093_impl*
 Result := CurrentType.IsKindOf(k2_typTableCell) and not CurrentType.IsKindOf(k2_typSBSCell);
//#UC END# *4FA3B42B01C6_49C21D090093_impl*
end;//TevMergedCellFilter.IsTableCell

procedure TevMergedCellFilter.CheckCellWidth;
 {* Проверяет ширину ячейки и, если надо корректирует её. }
//#UC START# *517E60E501A8_49C21D090093_var*
//#UC END# *517E60E501A8_49C21D090093_var*
begin
//#UC START# *517E60E501A8_49C21D090093_impl*
 // Делаем шире слишком тонкие ячейки:
 f_CorrectedWidth := (f_NewWidth > 0) and (f_NewWidth < evCellWidthEpsilon);
 if f_CorrectedWidth then
  f_NewWidth := evCellWidthEpsilon;
 // С отрицательной шириной поступаем также, как и в Немезисе - пусть юристы видят реальную картину! 
 if not f_CorrectedWidth then
 begin
  f_CorrectedWidth := (f_NewWidth < 0);
  if f_CorrectedWidth then
   f_NewWidth := -f_NewWidth;
 end; // if not f_CorrectedWidth then
//#UC END# *517E60E501A8_49C21D090093_impl*
end;//TevMergedCellFilter.CheckCellWidth

procedure TevMergedCellFilter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49C21D090093_var*
//#UC END# *479731C50290_49C21D090093_var*
begin
//#UC START# *479731C50290_49C21D090093_impl*
 l3Free(f_CellsOffsets);
 inherited;
//#UC END# *479731C50290_49C21D090093_impl*
end;//TevMergedCellFilter.Cleanup

procedure TevMergedCellFilter.DoStartChild(TypeID: Tk2Type);
//#UC START# *4A2D1217037A_49C21D090093_var*
//#UC END# *4A2D1217037A_49C21D090093_var*
begin
//#UC START# *4A2D1217037A_49C21D090093_impl*
 if (TypeID = k2_typTable) then
 begin
  if (f_CellsOffsets <> nil) then
   f_CellsOffsets.Clear;
 end;
 if (TypeID = k2_typTableRow) then
 begin
  f_MergeStatus := ev_msNone;
  CellsOffsets.ClearOffset;
  f_HasChild := False;
 end; // if (TypeID = k2_idTableRow) then
 if (TypeID = k2_typTableCell) then
 begin
  f_MergeStatus := ev_msNone;
  f_NeedAddTextPara := ev_natNo;
  f_HasChild := False;
  f_NewWidth := 0;
 end; // if (TypeID = k2_idTableCell) then
 if TopType[1].IsKindOf(k2_typTableCell) then
  f_HasChild := True;
 inherited;
//#UC END# *4A2D1217037A_49C21D090093_impl*
end;//TevMergedCellFilter.DoStartChild

procedure TevMergedCellFilter.DoAddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_49C21D090093_var*

 procedure lp_CheckOffset;
 begin
  f_NeedAddTextPara := ev_natNo;
  if f_CellsOffsets <> nil then
   f_CellsOffsets.CheckOffset(False);
 end;

 procedure lp_CheckNeedAddText;
 begin
  if f_NewWidth <> 0 then
  begin
   f_NeedAddTextPara := TevNeedAddTextPara(Ord(f_CellsOffsets = nil));
   if f_NeedAddTextPara = ev_natNo then
    f_NeedAddTextPara := TevNeedAddTextPara(Ord(f_CellsOffsets.CheckParam));
  end // if f_NewWidth = 0 then
  else
   f_NeedAddTextPara := ev_natWaitMergeStatus;
 end;

//#UC END# *4A2D1634025B_49C21D090093_var*
begin
//#UC START# *4A2D1634025B_49C21D090093_impl*
 if IsTableCell then
 begin
  if (AtomIndex = k2_tiWidth) then
  begin
   f_NewWidth := Value.AsInteger;
   CheckCellWidth;
   CellsOffsets.SetWidth(f_NewWidth);
   if f_NeedAddTextPara = ev_natWaitMergeStatus then
    lp_CheckNeedAddText;
   if f_CorrectedWidth then Exit;
  end; // if (AtomIndex = k2_tiWidth) then
  if (AtomIndex = k2_tiMergeStatus) then
  begin
   f_MergeStatus := TevMergeStatus(VariantAsInteger(AtomIndex, Value));
   case f_MergeStatus of
    ev_msHead: begin
       lp_CheckOffset;
       CellsOffsets.AddCellWidth;
      end; // ev_msHead
    ev_msNone: lp_CheckOffset;
    ev_msContinue: begin
     lp_CheckNeedAddText;
     if f_NeedAddTextPara = ev_natYes then Exit;
    end; // ev_msContinue: begin
   end; // case l_MergeStatus of
  end; // if (AtomIndex = k2_tiMergeStatus) then
  if (AtomIndex = k2_tiChildren) and (f_NeedAddTextPara = ev_natYes) then
   f_NeedAddTextPara := TevNeedAddTextPara(Ord(Value.AsInteger = 0));
 end; // if CurrentType.IsKindOf(k2_typTableCell) then
 inherited;
//#UC END# *4A2D1634025B_49C21D090093_impl*
end;//TevMergedCellFilter.DoAddAtomEx

procedure TevMergedCellFilter.DoCloseStructure(NeedUndo: Boolean);
//#UC START# *4E45166B0156_49C21D090093_var*

 function lp_NeedAddChildTextPara: Boolean;
 begin
  Result := (f_NeedAddTextPara = ev_natYes) or ((f_MergeStatus = ev_msHead) and not f_HasChild);
 end;                                                                          

//#UC END# *4E45166B0156_49C21D090093_var*
begin
//#UC START# *4E45166B0156_49C21D090093_impl*
 if IsTableCell then
 begin
  if f_CorrectedWidth then
   Generator.AddIntegerAtom(k2_tiWidth, f_NewWidth);
  if lp_NeedAddChildTextPara and (Generator <> nil) then
  begin
   Generator.StartDefaultChild;
   try
    Generator.AddStringAtom(k2_tiText, '');
   finally
    Generator.Finish;
    f_NeedAddTextPara := ev_natNo;
   end;
  end; // if f_CheckChildren and (Generator <> nil) then
  CellsOffsets.RecalcOffset;
 end; // if CurrentType.IsKindOf(k2_typTableCell) then
 inherited;
//#UC END# *4E45166B0156_49C21D090093_impl*
end;//TevMergedCellFilter.DoCloseStructure

end.
