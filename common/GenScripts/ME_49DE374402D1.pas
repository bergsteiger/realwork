unit nevBasePoint.imp;

interface

uses
 l3IntfUses
 , k2TagPointer
 , nevTools
 , nevBase
;

type
 _nevBasePoint_ = class(Tk2TagPointer)
  {* "Самая базовая" точка }
  function DoMove(const aView: InevView;
   aCode: Integer;
   const anOp: InevOp;
   aCount: Integer): TnevMoveResult;
  function Move(const aView: InevView;
   aCode: Cardinal;
   const anOp: InevOp;
   aCount: Integer): Boolean;
  procedure Refresh;
  procedure SetEntryPointPrim(Value: Integer;
   const Context: IevCursorContext);
  procedure SetEntryPoint(Value: Integer;
   const Context: IevCursorContext); overload;
  procedure SetEntryPoint(aValue: Integer;
   const aContext: InevOp); overload;
  function ToBottomChild(const aView: InevView): InevBasePoint;
  function PositionW: TnevPosition;
   {* позиция. }
  procedure SetAtEnd(const aView: InevView;
   aValue: Boolean);
  procedure SetAtStart(const aView: InevView;
   aValue: Boolean);
  function Obj: PInevObject;
 end;//_nevBasePoint_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
