program Everest2Everest;

{ $Id: everest2everest.dpr,v 1.11 2014/10/15 13:11:09 lulin Exp $ }

{$Include evDefine.inc}

uses
  SysUtils,

  l3Types,
  l3Base,
  l3Filer,
  l3Clipboard,
                                                                          
  evdSchema,

  evdWriter,

  evTypes,
  evEvdRd
  ;

{$R *.RES}
{$R versioninfo.res}

var
 l_Clip : Boolean;
 InFiler  : Tl3CustomFiler;
 OutFiler : Tl3DOSFiler;
 EverestReader : TevEvdReader;
 EverestWriter : TevdNativeWriter;
 l_S : Tl3ClipboardStream;
const
 cUsage = 'usage: everest2everest inFileName | clip: outFileName [-b] [-a]';
begin
 if (ParamCount < 1) then
 begin
  WriteLn(cUsage);
  Exit;
 end;//ParamCount < 1
 l_Clip := AnsiSameText(ParamStr(1), 'clip:');
 if not l_Clip then
  if not FileExists(ParamStr(1)) then
  begin
   ExitCode := 2;
   WriteLn(Format('The input file %s does not exists. Please specify a different filename.', [ParamStr(1)]));
   WriteLn(cUsage);
   Exit;
  end; // if FileExists(ParmStr(2)) then
 if SameFileName(ParamStr(1), ParamStr(2)) then
 begin
  ExitCode := 1;
  WriteLn('Wrong file name!');
  WriteLn(cUsage);
  Exit;
 end; // if SameFileName(ParamStr(1), ParamStr(2)) then
 if NOT (((ParamCount >= 3) AND (ParamStr(3) = '-a')) OR
         ((ParamCount >= 4) AND (ParamStr(4) = '-a'))) then
 if FileExists(ParamStr(2)) then
 begin
  ExitCode := 2;
  WriteLn(Format('A file %s already exists. Please specify a different filename.', [ParamStr(2)]));
  WriteLn(cUsage);
  Exit;
 end; // if FileExists(ParmStr(2)) then
 if l_Clip then
  InFiler := Tl3CustomFiler.Create
 else
  InFiler := Tl3DOSFiler.Make(ParamStr(1), l3_fmRead, false);
 try
  if l_Clip then
  begin
   l_S := Tl3ClipboardStream.Create(l3_fmRead, cf_EverestBin);
   try
    InFiler.Mode := l3_fmRead;
    InFiler.Stream := l_S;
   finally
    FreeAndNil(l_S);
   end;//try..finally

  end;//l_Clip
  OutFiler := Tl3DOSFiler.Create;
  try
   //InFiler.FileName := ParamStr(1);
   OutFiler.FileName := ParamStr(2);
   EverestReader := TevEvdReader.Create;
   try
    EverestWriter := TevdNativeWriter.Create;
    try
     EverestReader.Filer := InFiler;
     EverestWriter.Filer := OutFiler;
     EverestReader.Generator := EverestWriter;
     EverestWriter.Binary := ((ParamCount >= 3) AND (ParamStr(3) = '-b')) OR
                             ((ParamCount >= 4) AND (ParamStr(4) = '-b'));
     EverestReader.Execute;
    finally
     l3Free(EverestWriter);
    end;{try..finally}
   finally
    l3Free(EverestReader);
   end;{try..finally}
  finally
   l3Free(OutFiler);
  end;{try..finally}
  if l_Clip then
   InFiler.Stream := nil;
 finally
  l3Free(InFiler);
 end;{try..finally}
end.
