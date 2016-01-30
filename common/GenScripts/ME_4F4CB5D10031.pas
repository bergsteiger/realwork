unit m3EndingReplaceList;

// ћодуль: "w:\common\components\rtl\Garant\m3\m3EndingReplaceList.pas"
// —тереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3EndingReplaceListPrim
 , l3Interfaces
 , Classes
 , l3Types
;

type
 TByteArrayOfChar = array [Byte] of AnsiChar;

 _FindDataType_ = Tl3WString;
 _l3Searcher_Parent_ = Tm3EndingReplaceListPrim;
 {$Include l3Searcher.imp.pas}
 Tm3EndingReplaceList = class(_l3Searcher_)
  public
   procedure Load(aStream: TStream);
   function MakeNorm(var aCheckStr: Tl3WString): Boolean;
 end;//Tm3EndingReplaceList

implementation

uses
 l3ImplUses
 , l3String
 , l3Chars
 , SysUtils
 , l3Parser
;

var cBuff: TByteArrayOfChar;

const
 cNoTrunc = High(Byte);

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer; override;
 {* —равнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_4F4CB5D10031_var*

 function lCheckWrongRest : boolean;
  {ѕоверка что остались гласна€ и согласна€}
 var
  I : Integer;
  lVowelPresent : boolean;
  lConsonantPresent : boolean;
 begin
  Result := True;
  for I := 0 to Pred(aData.SLen - Length(anItem.rEndingFind)) do
  begin
   if aData.S[I] in cc_RusVowels then
    lVowelPresent := true
   else
    lConsonantPresent := true;
   if lVowelPresent and lConsonantPresent then
   begin
    Result := False;
    Exit;
   end;
  end;
 end;

//#UC END# *47B9BAFD01F4_4F4CB5D10031_var*
begin
//#UC START# *47B9BAFD01F4_4F4CB5D10031_impl*
 Result := Tm3EndingReplaceListPrim.CompareStrings(l3PCharLen(anItem.rEndingFind), aData);
 if (Result = 0) and lCheckWrongRest then Result := -1;
//#UC END# *47B9BAFD01F4_4F4CB5D10031_impl*
end;//CompareItemWithData

type _Instance_R_ = Tm3EndingReplaceList;

{$Include l3Searcher.imp.pas}

procedure Tm3EndingReplaceList.Load(aStream: TStream);
//#UC START# *5089072C0220_4F4CB5D10031_var*
var
 lListItem : Tm3EndingReplaceItem;
 lParser   : Tl3Parser;
//#UC END# *5089072C0220_4F4CB5D10031_var*
begin
//#UC START# *5089072C0220_4F4CB5D10031_impl*
 // грузит список замен окончаний из текстового потока со строками вида "ичу - ич"
 lParser := Tl3Parser.Create;
 try
  lParser.NullAsEOF := True;
  lParser.CheckFloat := False;
  lParser.WordChars := cc_ANSILetter;
  lParser.WhiteSpace := ['-', ' '];
  lParser.CheckFiler.Stream := aStream;
  while lParser.TokenType <> l3_ttEOF do
  begin
   lParser.NextToken;
   lListItem.rEndingFind := AnsiUpperCase(lParser.TokenString);
   lParser.NextToken;
   lListItem.rEndingReplace := AnsiUpperCase(lParser.TokenString);
   if (Length(lListItem.rEndingReplace) <= Length(lListItem.rEndingFind)) and
      (Copy(lListItem.rEndingFind, 0, Length(lListItem.rEndingReplace)) = lListItem.rEndingReplace) then
    lListItem.rExcessChars := Length(lListItem.rEndingFind) - Length(lListItem.rEndingReplace)
   else
    lListItem.rExcessChars := cNoTrunc;
   Add(lListItem);
   lParser.Filer.ReadLn;
  end;
 finally
  FreeAndNil(lParser);
 end;
 Sorted := True;
//#UC END# *5089072C0220_4F4CB5D10031_impl*
end;//Tm3EndingReplaceList.Load

function Tm3EndingReplaceList.MakeNorm(var aCheckStr: Tl3WString): Boolean;
//#UC START# *5089074500A3_4F4CB5D10031_var*
var
 lIndex : Integer;
 lConstLen : integer;
//#UC END# *5089074500A3_4F4CB5D10031_var*
begin
//#UC START# *5089074500A3_4F4CB5D10031_impl*
 Result := FindData(aCheckStr, lIndex);
 if Result then
  with Items[lIndex] do
   if rExcessChars = cNoTrunc then
   begin
    lConstLen := aCheckStr.SLen - Length(rEndingFind);
    System.Move(aCheckStr.S[0], cBuff, lConstLen);
    System.Move(rEndingReplace[1], cBuff[lConstLen], Length(rEndingReplace));
    aCheckStr := l3PCharLen(PAnsiChar(@cBuff), lConstLen + Length(rEndingReplace));
   end
   else
    aCheckStr.SLen := aCheckStr.SLen - rExcessChars;
//#UC END# *5089074500A3_4F4CB5D10031_impl*
end;//Tm3EndingReplaceList.MakeNorm

end.
