unit msmOperations;

// Модуль: "w:\common\components\gui\Garant\msm\msmOperations.pas"
// Стереотип: "InternalInterfaces"
// Элемент модели: "msmOperations" MUID: (57CEABF60269)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmEvents
;

type
 ImsmOperation = interface
  ['{09BB18A4-33A4-4074-9845-273279C761A7}']
  function Caption: AnsiString;
  procedure DoIt;
 end;//ImsmOperation

 ImsmOperationsList = interface
  ['{0DB0874B-D6F3-44CD-A483-083C7D487BFB}']
  function Get_Count: Integer;
  function Get_Items(anIndex: Integer): ImsmOperation;
  property Count: Integer
   read Get_Count;
  property Items[anIndex: Integer]: ImsmOperation
   read Get_Items;
   default;
 end;//ImsmOperationsList

 (*
 MmsmOperationsManaging = interface
  function Get_Operations: ImsmOperationsList;
  procedure AddOperation(const anOp: ImsmOperation);
  property Operations: ImsmOperationsList
   read Get_Operations;
 end;//MmsmOperationsManaging
 *)

implementation

uses
 l3ImplUses
;

end.
