unit k2OperationContainer;

interface

uses
 l3IntfUses
 , k2OpRefList
 , k2Prim
 , l3Variant
 , k2Op
 , l3StringIDEx
;

type
 Ik2OpPackInternal = interface
  {* "Кишки" пачки операций. }
  procedure Put(Op: Tk2Op;
   Modify: Boolean);
   {* положить операцию. }
 end;//Ik2OpPackInternal
 
 Tk2OperationContainer = class(Tk2OpRefList, Ik2OpPackInternal, Il3OpPack)
  function CheckWasExceptionInFreeInOwner: Boolean;
   {* Проверяет было ли исключение FreeInOwner и сбрасывает этот флаг }
  function GetSaveUndo: Boolean;
  function GetNeedOptimize: Boolean;
  function DoUndo(const aProcessor: Ik2Processor): Integer;
  function DoRedo(const aProcessor: Ik2Processor): Integer;
  procedure FreeInOwner;
  procedure Add(anItem: Tk2Op);
  procedure Create(anOwner: TObject);
  procedure DoSetOwner(Value: TObject);
   {* метод для установки "владельца" объекта. Для перекрытия в потомках. }
  procedure MarkModified(aTarget: Tl3Variant);
  procedure InvertModified;
  function GetModified: Boolean;
  function InUndo: Boolean;
  function SaveUndo: Boolean;
  function DeleteMapped: Boolean;
  function Optimize: Boolean;
  function InIOProcess: Boolean;
  function Processor: Ik2Processor;
   {* процессор операций в контексте которого выполняется данная пачка. }
  function Undo(const aProcessor: Ik2Processor): Integer;
   {* откатывает все операции и возвращает их количество. }
  function Redo(const aProcessor: Ik2Processor): Integer;
   {* возвращает все операции и возвращает их количество. }
  procedure Lock;
   {* закрыть. }
  procedure Unlock;
   {* открыть. }
  function Code: Integer;
   {* Код операции }
  procedure Put(Op: Tk2Op;
   Modify: Boolean);
   {* положить операцию. }
  procedure CheckReadOnly;
  procedure DisableReadonly;
   {* Выключает режим проверки ReadOnly }
  procedure EnableReadOnly;
   {* Включает режим проверки ReadOnly }
  function ReadOnly: Boolean;
  procedure CheckOn;
  procedure CheckOff;
  function IsCheckOff: Boolean;
 end;//Tk2OperationContainer
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3IntegerValueMapManager
 , l3Base
 , l3Const
 , l3Interfaces
 , k2NilOp
 , l3MessageID
;

end.
