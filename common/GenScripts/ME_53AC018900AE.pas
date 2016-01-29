unit ddTaskItemPrim;

interface

uses
 l3IntfUses
 , l3Variant
 , Task_Const
 , evdTaskTypes
 , Classes
 , k2Base
;

type
 TddTaskItemPrim = class(Tl3Tag)
  function ReadBoolean(aStream: TStream): Boolean;
  function ReadInteger(aStream: TStream): Integer;
  procedure WriteBoolean(aStream: TStream;
   aValue: Boolean);
  procedure WriteInteger(aStream: TStream;
   aValue: Integer);
  function ReadDateTime(aStream: TStream): TDateTime;
  procedure WriteDateTime(aStream: TStream;
   aValue: TDateTime);
  function ReadCardinal(aStream: TStream): Cardinal;
  procedure WriteCardinal(aStream: TStream;
   aValue: Cardinal);
  procedure Changed(aStatus: TcsTaskStatus);
  function TaskTaggedDataType: Tk2Type;
  function CanAsyncRun: Boolean;
  function GetTaggedDataType: Tk2Type;
 end;//TddTaskItemPrim
 
implementation

uses
 l3ImplUses
 , csTaskListening
 , SysUtils
;

end.
