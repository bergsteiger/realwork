unit evUndoB;

interface

uses
 l3IntfUses
 , l3Variant
;

type
 TevCustomUndoBuffer = class(Ik2UndoBuffer)
  {* Базовый класс для реализации Undo-буфера. }
  function GetActiveObject(aSucc: Boolean): TObject;
  procedure ExecutedOperation(aContainer: TObject);
   {* нотификация буферу о новой пачке операций. }
  function Undo(const aProcessor: Ik2Processor): Boolean;
   {* отменить предыдущую операцию. }
  function Redo(const aProcessor: Ik2Processor): Boolean;
   {* вернуть отмененную операцию. }
  procedure Clear;
   {* Очистить буфер операций. }
  function CanUndo: Boolean;
   {* можно ли отменить операцию? }
  function CanRedo: Boolean;
   {* можно ли вернуть операцию? }
  function Last: TObject;
  function Empty: Boolean;
   {* объект "пустой"? }
  function Disabled: Boolean;
 end;//TevCustomUndoBuffer
 
 TevUndoBuffer = class(TevCustomUndoBuffer)
  {* Класс для реализации Undo-буфера. }
 end;//TevUndoBuffer
 
implementation

uses
 l3ImplUses
 , evStandardActions
;

end.
