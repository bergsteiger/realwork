{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit FilterStream;

interface

uses
  Classes, Stream, EncodeIntf, DecodeIntf, gtTypes, EncryptionSettings;

type

 (**
  * This class is base class for all filter class like Flate, RunLength etc
  *)

  TgtFilterStream = class(TgtStream)
  protected
    FEncoder: TgtEncode;
    FDecoder: TgtDecode;
    FStream: TgtStream;
    FStreamOwned: Boolean;
  public
    destructor Destroy; override;
    procedure Close; override;
    function GetPosition: Int64; override;
    procedure SetPosition(APosition: LongInt; ADirection: TSeekOrigin); override;
    function GetBaseStream: TgtStream; override;
    function GetNextStream: TgtStream;
    function GetUndecodedStream: TgtStream; override;
    function CheckPassword(var Settings: TgtEncryptionSettings;
      Password: AnsiString): Boolean; virtual;

    function GetTStream: TStream; override;

    procedure Reset; override;
    function GetChar: Integer; override;
    function LookChar: Integer; override;
    function ReadRawChar: Integer; override;
    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; overload; override;
    function Write(const Buffer: AnsiString): Cardinal; overload; override;
  end;

implementation

{$IFDEF DEBUG}
uses
  gtLogger;
{$ENDIF}

{ TgtFilterStream }

function TgtFilterStream.CheckPassword(var Settings: TgtEncryptionSettings;
  Password: AnsiString): Boolean;
begin
  Result := FDecoder.CheckPassword(Settings, Password);
end;

procedure TgtFilterStream.Close;
begin
  FStream.Close;
end;

destructor TgtFilterStream.Destroy;
begin
  if FStreamOwned then
    FStream.Free;
  inherited;
end;

function TgtFilterStream.GetBaseStream: TgtStream;
begin
  Result := FStream.GetBaseStream;
end;

function TgtFilterStream.GetChar: Integer;
begin
  Result := FDecoder.GetChar;
end;

function TgtFilterStream.GetNextStream: TgtStream;
begin
  Result := FStream;
end;

function TgtFilterStream.GetPosition: Int64;
begin
  Result := FStream.GetPosition;
end;

function TgtFilterStream.GetTStream: TStream;
begin
  Result := FStream.GetTStream;
end;

function TgtFilterStream.GetUndecodedStream: TgtStream;
begin
  Result := FStream.GetUndecodedStream;
end;

function TgtFilterStream.LookChar: Integer;
begin
  Result := FDecoder.LookChar;
end;

function TgtFilterStream.ReadRawChar: Integer;
begin
  Result := FDecoder.ReadRawChar;
end;

procedure TgtFilterStream.Reset;
begin
  FDecoder.Reset;
end;

procedure TgtFilterStream.SetPosition(APosition: Integer;
  ADirection: TSeekOrigin);
begin
{$IFDEF DEBUG}
  Logger.LogError('Internal: called setPos() on FilterStream');
{$ENDIF}
end;

function TgtFilterStream.Write(const Buffer: AnsiString): Cardinal;
begin
  Result := FEncoder.Write(Buffer, Length(Buffer));
end;

function TgtFilterStream.Write(OutStream: TgtStream; Count: Cardinal): Cardinal;
begin
  Result := FEncoder.Write(OutStream, Count);
end;

end.
