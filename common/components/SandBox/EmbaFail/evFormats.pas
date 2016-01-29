unit evFormats;

interface

type
  Tl3ClipboardFormat = Cardinal;
  Tl3ClipboardFormats = array of Tl3ClipboardFormat;

var
  evAllFormats : Tl3ClipboardFormats = nil;

implementation

uses
  Windows
  ;

function l3FormatArray(const anArray: array of Tl3ClipboardFormat): Tl3ClipboardFormats;
  {-}
var
 l_Len   : Integer;
 l_Index : Integer;
begin
 l_Len := Length(anArray);
 SetLength(Result, l_Len);
 for l_Index := 0 to Pred(l_Len) do
  Result[l_Index] := anArray[l_Index];
end;

var
 cf_EverestBin : Tl3ClipboardFormat = 1;
 cf_EverestTxt : Tl3ClipboardFormat = 1;

initialization
 evAllFormats := l3FormatArray([cf_EverestBin, cf_EverestTxt,
                                cf_UnicodeText, cf_Text, cf_OEMText,
                                cf_hDrop]);

finalization
 evAllFormats := nil;

end.

