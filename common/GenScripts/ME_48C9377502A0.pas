unit evTablePainter;

interface

uses
 l3IntfUses
 , evFramedParaListPainter
 , nevRealTools
 , evCellsOffsets
 , l3Variant
 , nevTools
;

type
 TevTablePainter = class(TevFramedParaListPainter, IevTablePainter)
  {* Реализация интерфейса IevPainter для таблицы }
  function CellsOffsets: TevCellsOffsets;
  procedure CheckCell(aPara: Tl3Tag;
   aCheckType: TnevCheckType);
  procedure CalcOffset;
   {* Пересчитать смещение для следующей ячейки }
  function WasPainted(aPara: Tl3Tag;
   anPID: Integer;
   aForLines: Boolean): Boolean;
   {* Проверка была ли отрисована начальная ячейка объединения. }
  function NeedLog: Boolean;
   {* Поддерживает ли табличный объект запись в лог для тестов. }
  function HasOwnStyle: Boolean;
 end;//TevTablePainter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , SysUtils
 , evParaTools
;

end.
