unit DocAttrTypes;

{ $Id: DocAttrTypes.pas,v 1.2 2011/02/02 13:49:37 voba Exp $ }
{$I l3Define.inc}
{$R-}
interface
uses
 l3Interfaces,
 l3Date,
 Dt_Types
 ;

type
 PDNAttrRec = ^TDNAttrRec;
 TDNAttrRec = record
               //rID      : TDictID;
               rDate    : TStDate;
               rNum     : Il3CString;
               rType    : TDNType;
               rComment : Il3CString;
               rLDocID  : TDocID;
              end;

function MakeDateNumRec(aDate : TStDate; aNum : String; aType : TDNType; aComment : String = '') : TDNAttrRec;

implementation
uses
 Dt_Const,
 l3Base
 ;

function MakeDateNumRec(aDate : TStDate; aNum : String; aType : TDNType; aComment : String = '') : TDNAttrRec;
begin
 with Result do
 begin
  //rID := cUndefDictID;
  rDate := aDate;
  rType := aType;
  rNum  := l3CStr(aNum);
  rComment := l3CStr(aComment);
  rLDocID := 0;
 end;

end;

end.

