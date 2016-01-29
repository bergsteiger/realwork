unit ddValueList;
// Список значений, умеющий загружать себя из файла

{ $Id: ddValueList.pas,v 1.5 2013/04/11 16:46:29 lulin Exp $ }
// $Log: ddValueList.pas,v $
// Revision 1.5  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.4  2011/09/07 11:41:03  narry
// Логирование изменений CVS
//

interface

uses l3ValLst;

type
 TddValueList = class(Tl3ValueList)
 public
  procedure LoadFromFile(const aFileName: AnsiString; const aDelimeter: AnsiString = '=');
 end;

implementation

uses
 SysUtils, l3Stream, l3Types;

procedure TddValueList.LoadFromFile(const aFileName: AnsiString; const aDelimeter: AnsiString = '=');
var
 l_S: ShortString;
 l_Delim: Integer;
begin
 Clear;
 if (aFileName <> '') and FileExists(aFileName) then
  with Tl3TextStream.Create(aFileName, l3_fmRead) do
  try
   while not IsEOF do
   begin
    l_S:= AnsiUpperCase(GetLine);
    l_Delim:= Pos(aDelimeter, l_S);
    if l_Delim > 0 then
     Values[Trim(Copy(l_S, 1, Pred(l_Delim)))]:= Trim(Copy(l_S, Succ(l_Delim), Length(l_S)));
   end;
  finally
   Free;
  end; // (FileName <> '') and FileExists(aFileName)
end;

end.
