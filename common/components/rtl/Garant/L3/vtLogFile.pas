unit vtLogFile;

{$I vtDefine.inc }

interface
 uses
  Sysutils;

 procedure AppendToLogLN(aFileName : TFileName; aText : String);
 procedure AppendToLog(aFileName : TFileName; aText : String);

implementation
 uses
  l3Types, l3Stream;

procedure AppendToLogLN(aFileName : TFileName; aText : String);
 begin
  AppendToLog(aFileName, aText+#13#10);
 end;

procedure AppendToLog(aFileName : TFileName; aText : String);
 var
  lStream       : Tl3FileStream;
 begin
  lStream := Tl3FileStream.Create(aFileName,l3_fmExclusiveAppend);
  try
   lStream.Write(aText[1],Length(aText));
  finally
   lStream.Free;
  end;
 end;

end.
