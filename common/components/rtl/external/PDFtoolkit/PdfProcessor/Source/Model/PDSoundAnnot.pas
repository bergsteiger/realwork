unit PDSoundAnnot;

interface

uses
  Classes, gtObject, PDElement, PDBaseObject, PDAnnot;

type
  //The name of an icon to be used in displaying the annotation.
  TgtSoundAnnotIcon = (siSpeaker, siMic);

  //The encoding format for the sample data:
  TgtSoundEncoding = (seRaw, seSigned, semuLaw, seALaw);

  TgtPDSoundAnnot = class(TgtPDAnnot)
  private
    FSoundStream: TStream;
    FIconName: TgtSoundAnnotIcon;
    FSamplingRate: Double;
    FNoOfSoundChannels: Integer;
    FNoOfBitsPerSample: Integer;
    FSoundEncoding: TgtSoundEncoding;
    //FSoundCompression: AnsiString;
    //OptionalCompression: Varient

    function GetSoundStream: TStream;
    function GetIConName: TgtSoundAnnotIcon;
    function GetSampleRate: Double;
    function GetNoOfSoundChannels: Integer;
    function GetNoOfBitsPerSample: Integer;
    function GetSoundEncoding: TgtSoundEncoding;

    procedure SetSoundStream(Value: TStream);
    procedure SetIconName(const Value: TgtSoundAnnotIcon);
    procedure SetSampleRate(value: Double);
    procedure SetNoOfSoundChannels(Value: Integer);
    procedure SetNoOfBitsPerSample(Value: Integer);
    procedure SetSoundEncoding(Value: TgtSoundEncoding);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    property SoundStream: TStream read GetSoundStream write SetSoundStream;
    property IconName: TgtSoundAnnotIcon read GetIConName write SetIconName;
    property SampleRate: Double read GetSampleRate write SetSampleRate;
    property NoOfSoundChannels: Integer read GetNoOfSoundChannels
      write SetNoOfSoundChannels default 1;
    property NoOfBitsPerSample: Integer read GetNoOfBitsPerSample
      write SetNoOfBitsPerSample default 8;
    property SoundEncoding: TgtSoundEncoding read GetSoundEncoding
      write SetSoundEncoding default seRaw;
  end;

implementation

{ TgtPDSoundAnnot }

constructor TgtPDSoundAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotSound;
end;

destructor TgtPDSoundAnnot.Destroy;
begin

  inherited;
end;

function TgtPDSoundAnnot.GetIConName: TgtSoundAnnotIcon;
begin
  Result := FIconName;
end;

function TgtPDSoundAnnot.GetNoOfBitsPerSample: Integer;
begin
  Result := FNoOfBitsPerSample;
end;

function TgtPDSoundAnnot.GetNoOfSoundChannels: Integer;
begin
  Result := FNoOfSoundChannels;
end;

function TgtPDSoundAnnot.GetSampleRate: Double;
begin
  Result := FSamplingRate;
end;

function TgtPDSoundAnnot.GetSoundEncoding: TgtSoundEncoding;
begin
  Result := FSoundEncoding;
end;

function TgtPDSoundAnnot.GetSoundStream: TStream;
begin
  Result := FSoundStream;
end;

procedure TgtPDSoundAnnot.SetIconName(const Value: TgtSoundAnnotIcon);
begin

end;

procedure TgtPDSoundAnnot.SetNoOfBitsPerSample(Value: Integer);
begin

end;

procedure TgtPDSoundAnnot.SetNoOfSoundChannels(Value: Integer);
begin

end;

procedure TgtPDSoundAnnot.SetSampleRate(value: Double);
begin

end;

procedure TgtPDSoundAnnot.SetSoundEncoding(Value: TgtSoundEncoding);
begin

end;

procedure TgtPDSoundAnnot.SetSoundStream(Value: TStream);
begin

end;

end.
