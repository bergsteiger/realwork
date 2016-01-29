program SBS2Table;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  l3Filer,
  ddCmdLineUtils,
  ddNSRC_r,
  ddNSRC_W,
  ddFileIterator,
  evdSchema,
  k2TagGen,
  evSimpleTextPainter,
  evEmptyTableEliminator;

type
 TConfig = class(TddCmdLine)
 private
  f_Destination: string;
  f_Source: string;
 public
  procedure Init; override;
  property Destination: string read f_Destination write f_Destination;
  property Source: string read f_Source write f_Source;
 end;

procedure TConfig.Init;
begin
 Source:= ExtractFileDir(ParamStr(0));
 Destination:= Source + '\done';
 AddDir('/S', 'Source folder', f_Source);
 AddString('/D', 'Destination folder', f_Destination);
 inherited;
end;

var
 gConfig: TConfig;
 gFiles: TddFileIterator;

function ConvertFile(const aFileName: String): Boolean;
var
 l_G: Tk2TagGenerator;
begin
 Result:= True;
 l_G:= nil;
 try
  TddNSRCGenerator.SetTo(l_G, gConfig.Destination+'\'+ExtractFileName(aFileName));
  TevSimpleTextPainter.SetTo(l_G);
  TevEmptyTableEliminator.SetTo(l_G);
  TCustomNSRCReader.SetTo(l_G, aFileName);
  TCustomNSRCReader(l_G).Execute;
  Write('.');
 finally
  FreeAndNil(l_G);
 end
end;

begin
 gConfig:= TConfig.Create;
 try
  ForceDirectories(gConfig.Destination);
  gFiles:= TddFileIterator.Make(gConfig.Source, '*.nsr');
  try
   gFiles.IterateFiles(ConvertFile);
  finally
   FreeAndNil(gFiles);
  end;
 finally
  FreeAndNil(gConfig);
 end;
end.
