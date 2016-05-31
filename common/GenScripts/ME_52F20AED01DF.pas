unit evTextParaStringImpl;

// Модуль: "w:\common\components\gui\Garant\Everest\new\evTextParaStringImpl.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTextParaStringImpl" MUID: (52F20AED01DF)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , k2TagTool
 , l3Interfaces
 , l3Core
 , l3Variant
;

type
 TevWordDirection = (
  ev_wdStart
  , ev_wdFinish
  , ev_wdRight
  , ev_wdLeft
 );//TevWordDirection

 TevTextParaStringImpl = class(Tk2TagTool, Il3WordsSeq)
  private
   function DoMove(aPos: Integer;
    aMoveType: TevWordDirection): Tl3Position;
  protected
   function WordStart(Pos: Tl3Position): Tl3Position;
   function WordLeft(Pos: Tl3Position): Tl3Position;
   function WordFinish(Pos: Tl3Position): Tl3Position;
   function WordRight(Pos: Tl3Position): Tl3Position;
  public
   class function Make(aPara: Tl3Variant): Il3WordsSeq;
 end;//TevTextParaStringImpl
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , l3Base
 , k2Tags
 , l3String
;

class function TevTextParaStringImpl.Make(aPara: Tl3Variant): Il3WordsSeq;
//#UC START# *52F20B6C012E_52F20AED01DF_var*
var
 l_A : TevTextParaStringImpl;
//#UC END# *52F20B6C012E_52F20AED01DF_var*
begin
//#UC START# *52F20B6C012E_52F20AED01DF_impl*
 l_A := Create(aPara);
 try
  Result := l_A;
 finally
  l3Free(l_A);
 end;//try..finally
//#UC END# *52F20B6C012E_52F20AED01DF_impl*
end;//TevTextParaStringImpl.Make

function TevTextParaStringImpl.DoMove(aPos: Integer;
 aMoveType: TevWordDirection): Tl3Position;
//#UC START# *52F21CB700B6_52F20AED01DF_var*
var
 _St       : PAnsiChar;
 l_CharSet : Integer;

 function lp_WordDelim(anIndex: Tl3Position): Boolean;
 begin
  if (l_CharSet = CP_Unicode) then
   Result := l3IsWordDelim(PWideChar(_St)[anIndex])
  else
   Result := l3IsWordDelim(_St[anIndex], l_CharSet);
 end;

const
 cIncSet = [ev_wdFinish, ev_wdRight];
var
 _StLen: Integer;
//#UC END# *52F21CB700B6_52F20AED01DF_var*
begin
//#UC START# *52F21CB700B6_52F20AED01DF_impl*
 Result := aPos;
 with GetRedirect.PCharLenA[k2_tiText] do
 begin
  _St := S;
  _StLen := SLen;
  l_CharSet := SCodePage;
  if (_St = nil) then
   Exit;
 end;//GetRedirect.PCharLenA[k2_tiText]
 if aMoveType in cIncSet then
 begin
  while (Result < _StLen) and not lp_WordDelim(Result) do
   Inc(Result);
  if aMoveType = ev_wdRight then
   while (Result < _StLen) and lp_WordDelim(Result) do
    Inc(Result);
 end // if aMoveType in cIncSet then
 else
 begin
  if aMoveType = ev_wdLeft then
   while (Result > 0) and lp_WordDelim(Result - 1) do
    Dec(Result);
  while (Result > 0) and not lp_WordDelim(Result - 1) do
   Dec(Result);
 end;
//#UC END# *52F21CB700B6_52F20AED01DF_impl*
end;//TevTextParaStringImpl.DoMove

function TevTextParaStringImpl.WordStart(Pos: Tl3Position): Tl3Position;
//#UC START# *476FC5CB038B_52F20AED01DF_var*
//#UC END# *476FC5CB038B_52F20AED01DF_var*
begin
//#UC START# *476FC5CB038B_52F20AED01DF_impl*
 Result := DoMove(Pos, ev_wdStart);
//#UC END# *476FC5CB038B_52F20AED01DF_impl*
end;//TevTextParaStringImpl.WordStart

function TevTextParaStringImpl.WordLeft(Pos: Tl3Position): Tl3Position;
//#UC START# *476FC5D2025C_52F20AED01DF_var*
//#UC END# *476FC5D2025C_52F20AED01DF_var*
begin
//#UC START# *476FC5D2025C_52F20AED01DF_impl*
 Result := DoMove(Pos, ev_wdLeft);
//#UC END# *476FC5D2025C_52F20AED01DF_impl*
end;//TevTextParaStringImpl.WordLeft

function TevTextParaStringImpl.WordFinish(Pos: Tl3Position): Tl3Position;
//#UC START# *476FC5DB0289_52F20AED01DF_var*
//#UC END# *476FC5DB0289_52F20AED01DF_var*
begin
//#UC START# *476FC5DB0289_52F20AED01DF_impl*
 Result := DoMove(Pos, ev_wdFinish);
//#UC END# *476FC5DB0289_52F20AED01DF_impl*
end;//TevTextParaStringImpl.WordFinish

function TevTextParaStringImpl.WordRight(Pos: Tl3Position): Tl3Position;
//#UC START# *476FC5E102C5_52F20AED01DF_var*
//#UC END# *476FC5E102C5_52F20AED01DF_var*
begin
//#UC START# *476FC5E102C5_52F20AED01DF_impl*
 Result := DoMove(Pos, ev_wdRight);
//#UC END# *476FC5E102C5_52F20AED01DF_impl*
end;//TevTextParaStringImpl.WordRight
{$IfEnd} // Defined(k2ForEditor)

end.
