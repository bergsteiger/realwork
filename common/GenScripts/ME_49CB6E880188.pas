unit evCellsOffsets;
 {* работа со смещениями ячеек }

// Модуль: "w:\common\components\gui\Garant\Everest\evCellsOffsets.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evEpsilonLongIntList
;

type
 TevCellsOffsets = class(Tl3ProtoObject)
  {* работа со смещениями ячеек }
  private
   f_Offsets: TevEpsilonLongIntList;
    {* Смещения ячеек }
   f_Widths: TevEpsilonLongIntList;
    {* Ширина ячеек по этому смещению }
   f_Width: Integer;
    {* Текущая ширина ячейки }
   f_Offset: Integer;
    {* Текущее смещение }
   f_CheckChildren: Boolean;
    {* Нужно ли проверять дочерние }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Clear;
   procedure AddCellWidth;
   procedure CheckOffset(aCheckWidth: Boolean);
   function CheckParam: Boolean;
   procedure RecalcOffset;
   procedure ClearOffset;
   procedure SetWidth(aWidth: Integer);
 end;//TevCellsOffsets

implementation

uses
 l3ImplUses
 , SysUtils
 , evConst
;

procedure TevCellsOffsets.Clear;
//#UC START# *4A562C3A013E_49CB6E880188_var*
//#UC END# *4A562C3A013E_49CB6E880188_var*
begin
//#UC START# *4A562C3A013E_49CB6E880188_impl*
 if (f_Offsets <> nil) then
 begin
  f_Offsets.Clear;
  f_Widths.Clear;
  f_Offset := 0;
  f_Width := 0;
 end; // if (f_Offsets <> nil) then
//#UC END# *4A562C3A013E_49CB6E880188_impl*
end;//TevCellsOffsets.Clear

procedure TevCellsOffsets.AddCellWidth;
//#UC START# *4A562C5301A5_49CB6E880188_var*
//#UC END# *4A562C5301A5_49CB6E880188_var*
begin
//#UC START# *4A562C5301A5_49CB6E880188_impl*
 if f_Offsets = nil then
 begin
  f_Offsets := TevEpsilonLongIntList.Make;
  f_Widths := TevEpsilonLongIntList.Make;
 end; // if f_Offsets = nil then
 f_Offsets.Add(f_Offset);
 f_Widths.Add(f_Width);
//#UC END# *4A562C5301A5_49CB6E880188_impl*
end;//TevCellsOffsets.AddCellWidth

procedure TevCellsOffsets.CheckOffset(aCheckWidth: Boolean);
//#UC START# *4A562C6C00A6_49CB6E880188_var*
//#UC END# *4A562C6C00A6_49CB6E880188_var*
begin
//#UC START# *4A562C6C00A6_49CB6E880188_impl*
 if (f_Offsets <> nil) and f_Offsets.FindData(f_Offset, l_Index) then
  if not aCheckWidth or (Abs(f_Widths[l_Index] - f_Width) <= evFindCellDelta) then
  begin
   f_Offsets.Delete(l_Index);
   f_Widths.Delete(l_Index);
  end; // if Abs(f_Widths[l_Index]...
//#UC END# *4A562C6C00A6_49CB6E880188_impl*
end;//TevCellsOffsets.CheckOffset

function TevCellsOffsets.CheckParam: Boolean;
//#UC START# *4A562C85014A_49CB6E880188_var*
//#UC END# *4A562C85014A_49CB6E880188_var*
begin
//#UC START# *4A562C85014A_49CB6E880188_impl*
 Result := f_Offsets = nil; // Result = True - не нашли!
 if not Result then
  Result := not (f_Offsets.FindData(f_Offset, l_Index) and (Abs(f_Widths[l_Index] - f_Width) <= evFindCellDelta));
//#UC END# *4A562C85014A_49CB6E880188_impl*
end;//TevCellsOffsets.CheckParam

procedure TevCellsOffsets.RecalcOffset;
//#UC START# *4A562C9902F5_49CB6E880188_var*
//#UC END# *4A562C9902F5_49CB6E880188_var*
begin
//#UC START# *4A562C9902F5_49CB6E880188_impl*
 Inc(f_Offset, f_Width);
//#UC END# *4A562C9902F5_49CB6E880188_impl*
end;//TevCellsOffsets.RecalcOffset

procedure TevCellsOffsets.ClearOffset;
//#UC START# *4A562CA901FA_49CB6E880188_var*
//#UC END# *4A562CA901FA_49CB6E880188_var*
begin
//#UC START# *4A562CA901FA_49CB6E880188_impl*
 f_Offset := 0;
 f_Width := 0;
//#UC END# *4A562CA901FA_49CB6E880188_impl*
end;//TevCellsOffsets.ClearOffset

procedure TevCellsOffsets.SetWidth(aWidth: Integer);
//#UC START# *4A562CBD0279_49CB6E880188_var*
//#UC END# *4A562CBD0279_49CB6E880188_var*
begin
//#UC START# *4A562CBD0279_49CB6E880188_impl*
 f_Width := aWidth;
//#UC END# *4A562CBD0279_49CB6E880188_impl*
end;//TevCellsOffsets.SetWidth

procedure TevCellsOffsets.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49CB6E880188_var*
//#UC END# *479731C50290_49CB6E880188_var*
begin
//#UC START# *479731C50290_49CB6E880188_impl*
 FreeAndNil(f_Offsets);
 FreeAndNil(f_Widths);
 inherited;
//#UC END# *479731C50290_49CB6E880188_impl*
end;//TevCellsOffsets.Cleanup

end.
