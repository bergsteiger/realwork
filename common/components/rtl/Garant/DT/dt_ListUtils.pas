unit dt_ListUtils;
{ Разнообразные функции по работе со списками документов }


{ $Id: dt_ListUtils.pas,v 1.5 2015/11/26 08:45:44 lukyanets Exp $ }

// $Log: dt_ListUtils.pas,v $
// Revision 1.5  2015/11/26 08:45:44  lukyanets
// КОнстанты переехали
//
// Revision 1.4  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.3  2012/11/20 13:19:22  narry
// Обновление
//
// Revision 1.2  2012/01/11 10:25:21  narry
// - LoadNumbers возвращает Nil, если файл не существует
//
// Revision 1.1  2011/07/05 13:00:03  narry
// Сервисные функции
//


interface

Uses
 dtIntf, dt_Sab;

function LoadDocNumbers(const aFileName: String): ISab;

implementation

Uses
 l3Stream, l3Parser, l3Types, daSchemeConsts, DT_LinkServ, DT_Doc, DT_Const, DT_Renum,
 SysUtils, l3Memory, l3FileUtils, dt_AttrSchema;

function LoadDocNumbers(const aFileName: String): ISab;
var
 lStream : Tl3FileStream;
 lTmpStream : Tl3MemoryStream;
 lParser : Tl3Parser;
 lHasAdded : Boolean;
 lCurNum : Integer;
 l_Renum : Boolean;
begin
 Result:= nil;
 if FileExists(aFileName) then
 begin
  lStream := Tl3FileStream.Create(aFileName, l3_fmRead);
  try
   lHasAdded := False;
   lTmpStream := Tl3MemoryStream.Create;
   try
    lTmpStream.Size := 0;
    lParser := Tl3Parser.Create;
    try
     lParser.CheckFloat := false;
     lParser.CheckFiler.Stream := lStream;
     lParser.NextTokenSp;
     if (lParser.TokenType = l3_ttSingleChar) and (lParser.TokenChar = '#') then
     begin
      lParser.Filer.ReadLn;
      lParser.NextTokenSp;
      l_Renum := False;
     end
     else
      l_Renum := True;

     While lParser.TokenType <> l3_ttEOF do
     begin
      If lParser.TokenType = l3_ttInteger then
      begin
       try
        lCurNum := lParser.TokenInt; {- 100000};
        lTmpStream.Write(lCurNum, SizeOf(Integer));
        lHasAdded:=True;
       except
       end;
      end;
      lParser.Filer.ReadLn;
      lParser.NextTokenSp;
     end;
     If lHasAdded then
     begin
      lTmpStream.Seek(0,0);

      if l_Renum then
      begin
       Result:= MakeValueSet(LinkServer(CurrentFamily).Attribute[atRenum],
                            rnImportID_fld, lTmpStream);
       Result.RecordsByKey;
       Result.ValuesOfKey(rnRealID_fld);
       Result.TransferToPhoto(fID_fld, DocumentServer(CurrentFamily).FileTbl);
      end // l_Renum
      else
       Result:= MakeValueSet(DocumentServer(CurrentFamily).FileTbl, fID_fld, lTmpStream);

     end
     else
      Result:= nil;
    finally
     FreeAndNil(lParser);
    end;
   finally
    FreeAndNil(lTmpStream);
   end;
  finally
   FreeAndNil(lStream);
  end;
 end;
end;

end.
