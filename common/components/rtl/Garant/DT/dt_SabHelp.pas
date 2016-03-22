unit dt_SabHelp;
{Хелперы для ISab}
{ $Id: dt_SabHelp.pas,v 1.4 2016/01/22 12:18:59 lukyanets Exp $ }

// $Log: dt_SabHelp.pas,v $
// Revision 1.4  2016/01/22 12:18:59  lukyanets
// Переосмысливаем мигратор
//
// Revision 1.3  2015/09/10 15:04:43  voba
// no message
//
// Revision 1.2  2014/04/17 13:04:32  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.1  2009/04/22 14:24:52  voba
// no message
//

interface
 uses
  SysUtils,
  l3Types,
  l3Interfaces,
  l3Filer,
  dtIntf, dt_Sab;

 procedure OutValueSab2File(const aSab : ISab; const aFileName : TFileName);

 procedure OutValueSab2Stream(const aSab : ISab; const aStream : IStream);

 procedure OutRecSabToFile(const aSab : ISab; const aFileName : AnsiString; aQuote : Char = '"'; aDelimiter : Char = #9; AddEmtryTailColumnCount: Integer = 0);

implementation
uses
 l3Stream,
 l3Chars,
 m2ComLib,
 DT_Types;

type
 PInteger = ^Integer;

procedure OutValueSab2File(const aSab : ISab; const aFileName : TFileName);
begin
 OutValueSab2Stream(aSab, Tl3FileStream.Make(aFileName, l3_fmWrite));
end;

procedure PutLine(const aStream : IStream; const Str: string);
const
 lEOL : PChar = cc_EOL;
begin
 if Str <> '' then
  m2COMWriteBuffer(aStream, Str[1], Length(Str));
 m2COMWriteBuffer(aStream, lEOL^, 2);
end;

procedure OutValueSab2Stream(const aSab : ISab; const aStream : IStream);

 function lIterator(aPDocID : PInteger) : Boolean;
 begin
  Result := True;
  PutLine(aStream, InttoStr(aPDocID^));
 end;

var
 lRAProcStub : TdtRecAccessProc;

begin
 lRAProcStub := L2RecAccessProc(@lIterator);
 try
  aSab.IterateRecords(lRAProcStub);
 finally
  FreeRecAccessProc(lRAProcStub);
 end;
end;

procedure OutRecSabToFile(const aSab : ISab; const aFileName : AnsiString; aQuote : Char = '"'; aDelimiter : Char = #9; AddEmtryTailColumnCount: Integer = 0);
var
 lRAProcStub : TdtRecAccessProc;
 l_Filer : Tl3DOSFiler;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  l_Filer.Writeln(aSab.Table.GenRecStr(aItemPtr, AddEmtryTailColumnCount));
 end;

begin
 aSab.Table.SetTextDecor(aDelimiter, aQuote);

 lRAProcStub := L2RecAccessProc(@lRecAccessProc);
 try
  l_Filer := Tl3DOSFiler.Make(aFileName, l3_fmCreateReadWrite);
  try
   l_Filer.Open;
   try
    aSab.IterateRecords(lRAProcStub, []);
   finally
    l_Filer.Close;
   end;
  finally
   FreeAndNil(l_Filer);
  end;
 finally
  FreeRecAccessProc(lRAProcStub);
 end;

end;

end.
