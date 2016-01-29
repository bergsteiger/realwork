unit ddDocStructBase;

{ $Id: ddDocStructBase.pas,v 1.1 2014/06/20 12:50:47 fireton Exp $ }

interface
uses
 l3Interfaces, l3FieldSortRecList,
 DT_Types;

type
 TddElementNumRec = record
  rNum      : Word;
  rSubnum   : Word;
  rSubSubNum: Word;
 end;

 TddStructType = (stEntry, stHead, stPart, stChapter); // статья, глава, часть, раздел

 TddDocStructElementRec = record
  rType    : TddStructType;
  rEntry   : TddElementNumRec;
  rItem    : TddElementNumRec;
  rSubItem : TddElementNumRec;
 end;

 PddDocEntryAddrRec = ^TddDocEntryAddrRec;
 TddDocEntryAddrRec = record
  rAddress: TddDocStructElementRec;
  rSubID  : Integer;
 end;

 PddDocBlocksRec = ^TddDocBlocksRec;
 TddDocBlocksRec = record
  rDocID: TDocID;
  rCache: Tl3FieldSortRecList;
 end;

const
 cRomanNumChars: TCharSet = ['C','D','I','V','X','L','M','c','d','i','v','x','l','m'];

procedure FillOutEntryNum(var NumRec: TddElementNumRec; const aNumStr, aSubnumStr, aSubSubnumStr: Tl3WString);


implementation
uses
 l3Chars, l3String;

procedure FillOutEntryNum(var NumRec: TddElementNumRec; const aNumStr, aSubnumStr, aSubSubnumStr: Tl3WString);
 procedure FillOne(const aStr: Tl3WString; var theNum: Word);
 var
  l_Char: AnsiChar;
 begin
  if l3AllCharsInCharSet(aStr, ['0'..'9']) then
  begin
   if aStr.SLen <= 5 then
    try
     theNum := l3StrToInt(aStr)
    except
     theNum := 0;
    end
   else
    theNum:= 0;
  end
  else
   if l3AllCharsInCharSet(aStr, cRomanNumChars) then
   begin
    try
     theNum := l3RomanToInt(aStr)
    except
     theNum := 0;
    end;
   end
   else
    if (aStr.SLen = 1)  then
    begin
     l_Char := l3Char(aStr, 0);
     l3MakeUpperCase(@l_Char, 1, CP_RussianWin);
     if l_Char in ['А'..'Я'] then
     begin
      theNum := $8000 or (Ord(l_Char) - Ord('А'));
     end
     else
      theNum := 0;
    end
    else
     theNum := 0;
 end;
begin
 FillOne(aNumStr, NumRec.rNum);
 if not l3IsNil(aSubnumStr) then
  FillOne(aSubnumStr, NumRec.rSubnum)
 else
  NumRec.rSubnum := 0;
 if not l3IsNil(aSubSubnumStr) then
  FillOne(aSubSubnumStr, NumRec.rSubSubnum)
 else
  NumRec.rSubSubnum := 0;
end;


end.