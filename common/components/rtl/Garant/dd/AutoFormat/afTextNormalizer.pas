unit afTextNormalizer;
{ Убирает разрядку пробелами из слов  }
// $Id: afTextNormalizer.pas,v 1.4 2014/04/29 14:06:19 lulin Exp $

// $Log: afTextNormalizer.pas,v $
// Revision 1.4  2014/04/29 14:06:19  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.3  2014/04/11 15:30:52  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.2  2013/04/16 09:30:55  fireton
// - не собиралось
//
// Revision 1.1  2013/04/16 08:09:55  narry
// Автоматические форматировщики
//


interface

uses
  dd_lcTextFormatter2, k2Interfaces, evdLeafParaFilter;

type
 TafTextNormalizer = class(Tdd_lcBaseFormatter)
 private
  procedure NormalizeText(aLeaf: Tl3Tag);
 protected
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 end;

type
 TlukEmptyParaEliminator = class(TevdLeafParaFilter)
 protected
  function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
 end;

implementation

uses
  l3String, SysUtils, k2Tags, l3RegEx, l3Chars;

function TafTextNormalizer.EnableWrite(aPara: Tl3Tag): Tdd_lcTextReaction;
begin
 Result:= lcWrite;
 NormalizeText(aPara);
end;

procedure TafTextNormalizer.NormalizeText(aLeaf: Tl3Tag);
var
 i: Integer;
 l_Text, l_AllText: String;
 l_Pos: Tl3MatchPosition;
const
 cPattern = '>\c\s(\c\s)+\c';
begin
 l_Text:= '';
 RegSearcher.SearchPattern:= cPattern;
 if RegSearcher.SearchInString(aLeaf.PCharLenA[k2_tiText], l_Pos) then
 begin
  l_Text:= Copy(aLeaf.StrA[k2_tiText], Succ(l_Pos.StartPos), l_Pos.Length);
  if Length(l_Text) > 6 then
  begin
   l_AllText:= aLeaf.StrA[k2_tiText];
   Delete(l_AllText, Succ(l_Pos.StartPos), l_Pos.Length);
   i:= 2;
   while i < Length(l_Text) do
   begin
    if l_Text[i] in [cc_HardSpace, cc_SoftSpace] then
     Delete(l_Text, i, 1);
    Inc(i);
   end; // while
   Insert(l_Text, l_AllText, l_Pos.StartPos+1);
   aLeaf.StrW[k2_tiText, nil]:= l_AllText;
  end; // Length(l_Text) > 6
 end; // RegSearcher.SearchInString
end;

function TlukEmptyParaEliminator.NeedWritePara(aLeaf: Tl3Tag): Boolean;
begin
 Result:= aLeaf.Attr[k2_tiText].IsValid and (aLeaf.Attr[k2_tiText].AsPCharLen.SLen > 0)
end;

end.
