unit evCursor.imp;

interface

uses
 l3IntfUses
 , evLocation
 , nevTools
 , nevBase
 , l3Core
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 _evCursor_ = class(TevLocation)
  {* "Совсем базовый" курсор }
  procedure DoAssignPoint(const aView: InevView;
   const aPoint: InevBasePoint);
  procedure SetInner(const aValue: InevBasePoint);
  procedure DoSetEntryPointPrim(Value: Integer;
   const Context: IevCursorContext);
  procedure DoSetEntryPoint(aValue: Integer;
   const anOp: IevCursorContext);
  function IsLeaf: Boolean;
   {* Курсор от листьевого параграфа }
  function DoMovePrim(const aView: InevView;
   aCode: Integer;
   const anOp: InevOp;
   aCount: Integer): TnevMoveResult;
  procedure DoSetAtEnd(const aView: InevView;
   aValue: Boolean);
  function DoProcessMessage(const aView: InevControlView;
   var aMessage: TMessage;
   aTime: Cardinal): Boolean;
  function GetNeedWindowsCaret: Boolean;
  function GetAtStart: Boolean;
  function GetAtEnd(const aView: InevView): Boolean;
  procedure DoCheckPos(const anOp: InevOp);
  function GetVertPosition(const aView: InevView;
   aMap: TnevFormatInfoPrim): TnevParaIndex;
  function GetReadOnly: Boolean;
  function GetDeltaX(const aView: InevView;
   const aMap: InevMap): Integer;
  function DoCompare(const aPoint: InevBasePoint): Integer;
  function GetInner: InevBasePoint;
  procedure DoDisableListener;
  procedure DoEnableListener;
  procedure DoAssignPointInt(const aView: InevView;
   const aPoint: InevBasePoint);
  procedure AssignPoint(const aView: InevView;
   const aPoint: InevBasePoint);
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
  procedure DisableListener;
   {* Отключает нотификацию об изменении }
  procedure EnableListener;
   {* Включает нотификацию об изменении }
 end;//_evCursor_
 
implementation

uses
 l3ImplUses
 , k2Base
 , l3InterfacesMisc
 , evOp
 , SysUtils
 , k2Tags
 , evdTypes
 , k2Const
;

end.
