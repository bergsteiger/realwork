unit evRowAndTableTypeSupport;
 {* Примесь для классификации таблиц и строк }

// Модуль: "w:\common\components\gui\Garant\Everest\evRowAndTableTypeSupport.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevRowAndTableTypeSupport" MUID: (5112379700A6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evEditorInterfaces
 , evEditorInterfacesTypes
 , evCellsOffsetsPair
;

type
 TevRowAndTableTypeSupport = class(Tl3ProtoObject)
  {* Примесь для классификации таблиц и строк }
  private
   f_TableStyle: TedTabelType;
    {* Стиль таблицы. Устанавливается в процессе анализа таблицы. В зависимости от него изменяется алгоритм выравнивания границ. }
   f_CurrentRowType: TedRowType;
    {* Тип текущей строки. }
  private
   procedure AnalizeTableStyle;
   procedure CheckRowType(const aRow: IedRow);
  protected
   procedure AnalizeRowType(const aRow: IedRow);
   procedure SaveRowType(const aPairList: TevCellsOffsetsPair);
   function GetPrevRowType: TedRowType; virtual; abstract;
   function GetCellsCountInPreviousRow: Integer; virtual; abstract;
    {* Возвращает число ячеек в последней выравненной строке }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   property TableStyle: TedTabelType
    read f_TableStyle;
    {* Стиль таблицы. Устанавливается в процессе анализа таблицы. В зависимости от него изменяется алгоритм выравнивания границ. }
   property CurrentRowType: TedRowType
    read f_CurrentRowType;
    {* Тип текущей строки. }
 end;//TevRowAndTableTypeSupport

implementation

uses
 l3ImplUses
 //#UC START# *5112379700A6impl_uses*
 //#UC END# *5112379700A6impl_uses*
;

procedure TevRowAndTableTypeSupport.AnalizeTableStyle;
//#UC START# *5076B24B0038_5112379700A6_var*
//#UC END# *5076B24B0038_5112379700A6_var*
begin
//#UC START# *5076B24B0038_5112379700A6_impl*
 case f_CurrentRowType of
  ed_rtNumericCels:
   f_TableStyle := ed_tsWithHeader;
  ev_rtFormCells:
   f_TableStyle := ed_tsForm;
  ed_rtChessTableRow:
   f_TableStyle := ed_tsChessTable;
 end; // case f_CurrentRowType of
//#UC END# *5076B24B0038_5112379700A6_impl*
end;//TevRowAndTableTypeSupport.AnalizeTableStyle

procedure TevRowAndTableTypeSupport.AnalizeRowType(const aRow: IedRow);
//#UC START# *511240880262_5112379700A6_var*
//#UC END# *511240880262_5112379700A6_var*
begin
//#UC START# *511240880262_5112379700A6_impl*
 f_CurrentRowType := aRow.AnalizeRowCells;
 CheckRowType(aRow);
 AnalizeTableStyle;
//#UC END# *511240880262_5112379700A6_impl*
end;//TevRowAndTableTypeSupport.AnalizeRowType

procedure TevRowAndTableTypeSupport.SaveRowType(const aPairList: TevCellsOffsetsPair);
//#UC START# *51124284008E_5112379700A6_var*
//#UC END# *51124284008E_5112379700A6_var*
begin
//#UC START# *51124284008E_5112379700A6_impl*
 aPairList.RowType := f_CurrentRowType;
//#UC END# *51124284008E_5112379700A6_impl*
end;//TevRowAndTableTypeSupport.SaveRowType

procedure TevRowAndTableTypeSupport.CheckRowType(const aRow: IedRow);
//#UC START# *5152CEDE0255_5112379700A6_var*
//#UC END# *5152CEDE0255_5112379700A6_var*
begin
//#UC START# *5152CEDE0255_5112379700A6_impl*
 if f_CurrentRowType = ed_rtNumericCels then
 begin
  if aRow.CellsIterator.CellsCount <> GetCellsCountInPreviousRow then
   f_CurrentRowType := ed_rtSimpleWithoutEmpty;
 end; // if f_CurrentRowType = ed_NumericCels then
//#UC END# *5152CEDE0255_5112379700A6_impl*
end;//TevRowAndTableTypeSupport.CheckRowType

procedure TevRowAndTableTypeSupport.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5112379700A6_var*
//#UC END# *479731C50290_5112379700A6_var*
begin
//#UC START# *479731C50290_5112379700A6_impl*
 f_TableStyle := ed_tsNone;
 inherited;
//#UC END# *479731C50290_5112379700A6_impl*
end;//TevRowAndTableTypeSupport.Cleanup

procedure TevRowAndTableTypeSupport.InitFields;
//#UC START# *47A042E100E2_5112379700A6_var*
//#UC END# *47A042E100E2_5112379700A6_var*
begin
//#UC START# *47A042E100E2_5112379700A6_impl*
 f_TableStyle := ed_tsNone;
 inherited;
//#UC END# *47A042E100E2_5112379700A6_impl*
end;//TevRowAndTableTypeSupport.InitFields

end.
