unit gtZipPackage;

interface

uses Classes, SysUtils, gtAbArcTyp, gtAbZipTyp, gtAbExcept, gtAbZipPrc;

type
  TgtTargetMode = (tmodInternal, tmodExternal);

  TgtHelper = class
  public
    procedure ZipFromStreamProc(Sender: TObject; Item: TAbArchiveItem;
      aOutStream, aInStream: TStream);
    procedure ZipProc(Sender: TObject; Item: TAbArchiveItem;
      OutStream: TStream);
  end;

  TgtZipPackage = class
  private
    LZipArchive: TAbZipArchive;
    LHelper: TgtHelper;
  public
    property ZipArchive: TAbZipArchive read LZipArchive write LZipArchive;
    constructor CreateFromStream(aStream: TStream; const aArchiveName: String);
    procedure CreateParts(URI: String; aStream: TStream);
    procedure Save;
  end;

implementation

constructor TgtZipPackage.CreateFromStream(aStream: TStream;
  const aArchiveName: String);
begin
  LZipArchive := TAbZipArchive.CreateFromStream(aStream, aArchiveName);
  LHelper := TgtHelper.Create;
  LZipArchive.InsertHelper := LHelper.ZipProc;
  LZipArchive.InsertFromStreamHelper := LHelper.ZipFromStreamProc;
  LZipArchive.AutoSave := true;
  LZipArchive.Logging := true;
end;

procedure TgtHelper.ZipFromStreamProc(Sender: TObject; Item: TAbArchiveItem;
  aOutStream, aInStream: TStream);
begin
  if Assigned(aInStream) then
    AbZipFromStream(TAbZipArchive(Sender), TAbZipItem(Item), aOutStream,
      aInStream)
  else
    raise EAbZipNoInsertion.Create;
end;

procedure TgtHelper.ZipProc(Sender: TObject; Item: TAbArchiveItem;
  OutStream: TStream);
begin
  AbZip(TAbZipArchive(Sender), TAbZipItem(Item), OutStream);
end;

procedure TgtZipPackage.CreateParts(URI: String; aStream: TStream);
begin
  aStream.Position := 0;
  LZipArchive.AddFromStream(URI, aStream);
end;

procedure TgtZipPackage.Save;
begin
  LZipArchive.Save;
end;

end.
