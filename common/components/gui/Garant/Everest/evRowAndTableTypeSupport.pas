unit evRowAndTableTypeSupport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evRowAndTableTypeSupport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::CellUtils::TevRowAndTableTypeSupport
//
// Примесь для классификации таблиц и строк
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evEditorInterfaces,
  l3ProtoObject,
  evCellsOffsetsPair
  ;

type
 TevRowAndTableTypeSupport = class(Tl3ProtoObject)
  {* Примесь для классификации таблиц и строк }
 private
 // private fields
   f_TableStyle : TedTabelType;
    {* Поле для свойства TableStyle}
   f_CurrentRowType : TedRowType;
    {* Поле для свойства CurrentRowType}
 private
 // private methods
   procedure AnalizeTableStyle;
   procedure CheckRowType(const aRow: IedRow);
     {* Дополнительная проверка получившегося типа строки. }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 protected
 // protected methods
   procedure AnalizeRowType(const aRow: IedRow);
   procedure SaveRowType(const aPairList: TevCellsOffsetsPair);
   function GetPrevRowType: TedRowType; virtual; abstract;
   function GetCellsCountInPreviousRow: Integer; virtual; abstract;
     {* Возвращает число ячеек в последней выравненной строке }
 public
 // public properties
   property TableStyle: TedTabelType
     read f_TableStyle;
     {* Стиль таблицы. Устанавливается в процессе анализа таблицы. В зависимости от него изменяется алгоритм выравнивания границ. }
   property CurrentRowType: TedRowType
     read f_CurrentRowType;
     {* Тип текущей строки. }
 end;//TevRowAndTableTypeSupport

implementation

// start class TevRowAndTableTypeSupport

procedure TevRowAndTableTypeSupport.AnalizeTableStyle;
//#UC START# *5076B24B0038_5112379700A6_var*
//#UC END# *5076B24B0038_5112379700A6_var*
begin
//#UC START# *5076B24B0038_5112379700A6_impl*
 case f_CurrentRowType of
  ed_NumericCels: f_TableStyle := ed_tsWithHeader;
  ev_FormCells: f_TableStyle := ed_tsForm;
  ed_ChessTableRow: f_TableStyle := ed_tsChessTable;
 end; // case f_CurrentRowType of
//#UC END# *5076B24B0038_5112379700A6_impl*
end;//TevRowAndTableTypeSupport.AnalizeTableStyle

procedure TevRowAndTableTypeSupport.CheckRowType(const aRow: IedRow);
//#UC START# *5152CEDE0255_5112379700A6_var*
//#UC END# *5152CEDE0255_5112379700A6_var*
begin
//#UC START# *5152CEDE0255_5112379700A6_impl*
 if f_CurrentRowType = ed_NumericCels then
 begin
  if aRow.CellsIterator.CellsCount <> GetCellsCountInPreviousRow then
   f_CurrentRowType := ed_SimpleWithoutEmpty;
 end; // if f_CurrentRowType = ed_NumericCels then
//#UC END# *5152CEDE0255_5112379700A6_impl*
end;//TevRowAndTableTypeSupport.CheckRowType

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

procedure TevRowAndTableTypeSupport.Cleanup;
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