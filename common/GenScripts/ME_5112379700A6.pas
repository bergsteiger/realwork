unit evRowAndTableTypeSupport;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evEditorInterfaces
 , evCellsOffsetsPair
;

type
 TevRowAndTableTypeSupport = class(Tl3ProtoObject)
  {* Примесь для классификации таблиц и строк }
  procedure AnalizeTableStyle;
  procedure AnalizeRowType(const aRow: IedRow);
  procedure SaveRowType(const aPairList: TevCellsOffsetsPair);
  function GetPrevRowType: TedRowType;
  procedure CheckRowType(const aRow: IedRow);
  function GetCellsCountInPreviousRow: Integer;
   {* Возвращает число ячеек в последней выравненной строке }
 end;//TevRowAndTableTypeSupport
 
implementation

uses
 l3ImplUses
;

end.
