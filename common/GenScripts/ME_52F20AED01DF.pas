unit evTextParaStringImpl;

interface

uses
 l3IntfUses
 , k2TagTool
 , l3Interfaces
 , l3Variant
 , l3Core
;

type
 TevWordDirection = (
  ev_wdStart
  , ev_wdFinish
  , ev_wdRight
  , ev_wdLeft
 );//TevWordDirection
 
 TevTextParaStringImpl = class(Tk2TagTool, Il3WordsSeq)
  function Make(aPara: Tl3Variant): Il3WordsSeq;
  function DoMove(aPos: Integer;
   aMoveType: TevWordDirection): Tl3Position;
  function WordStart(Pos: Tl3Position): Tl3Position;
  function WordLeft(Pos: Tl3Position): Tl3Position;
  function WordFinish(Pos: Tl3Position): Tl3Position;
  function WordRight(Pos: Tl3Position): Tl3Position;
 end;//TevTextParaStringImpl
 
implementation

uses
 l3ImplUses
 , l3Base
 , k2Tags
 , l3String
;

end.
