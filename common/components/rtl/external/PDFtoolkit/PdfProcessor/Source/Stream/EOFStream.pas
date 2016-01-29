unit EOFStream;

interface

uses
  Classes, Stream, FilterStream, gtTypes;

type
  TgtEOFStream = class(TgtFilterStream)
  public
    constructor Create(AStream: TgtStream);
    destructor Destroy; override;
    procedure Reset; override;
    function GetChar: Integer; override;
    function LookChar: Integer; override;
    function Read(var Buffer: Bytes; Count: Cardinal): Cardinal; override;
    function Write(const Buffer: Bytes; Count: Cardinal): Cardinal; override;
    function GetType: TgtStreamType; override;
    function GetSize: Cardinal; override;
  end;

implementation

uses
  StreamConsts;

constructor TgtEOFStream.Create(AStream: TgtStream);
begin
  FStream := AStream;
end;

destructor TgtEOFStream.Destroy;
begin

  inherited;
end;

function TgtEOFStream.LookChar: Integer;
begin
  Result := EndofFile;
end;

function TgtEOFStream.Read(var Buffer: Bytes; Count: Cardinal): Cardinal;
begin
  Result := 0;
end;

function TgtEOFStream.GetChar: Integer;
begin
  Result := FStream.GetChar;
end;

function TgtEOFStream.GetSize: Cardinal;
begin
  Result := 0;
end;

function TgtEOFStream.GetType: TgtStreamType;
begin
  Result := stWeird;
end;

procedure TgtEOFStream.Reset;
begin
  FStream.Reset;
end;

function TgtEOFStream.Write(const Buffer: Bytes; Count: Cardinal): Cardinal;
begin
  Result := 0;
end;

end.
