program RTF2PlainText;

{ $Id: rtf2plaintext.dpr,v 1.2 2004/05/14 17:28:00 law Exp $ }

{$I evDefine.inc}

uses
  l3Base,
  l3Filer,
  evDocGen,
  evPlainTextGenerator,
  Readers
  ;

{$R *.RES}

var
 InFiler,
 OutFiler   : TevDOSFiler;
 RTFReader  : TRTFReader;
 PlainTextWriter : TevPlainTextGenerator;
begin
 InFiler := TevDOSFiler.Create(nil);
 try
  OutFiler := TevDOSFiler.Create(nil);
  try
   InFiler.FileName := ParamStr(1);
   OutFiler.FileName := ParamStr(2);
   RTFReader := TRTFReader.Create(nil);
   try
    PlainTextWriter := TevPlainTextGenerator.Create(nil);
    try
     RTFReader.Filer := InFiler;
     PlainTextWriter.Filer := OutFiler;
     RTFReader.Generator := PlainTextWriter;
     RTFReader.Execute;
    finally
     l3Free(PlainTextWriter);
    end;{try..finally}
   finally
    l3Free(RTFReader);
   end;{try..finally}
  finally
   l3Free(OutFiler);
  end;{try..finally}
 finally
  l3Free(InFiler);
 end;{try..finally}
end.
