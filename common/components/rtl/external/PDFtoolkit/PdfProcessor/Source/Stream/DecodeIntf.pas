{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit DecodeIntf;

interface

uses
  gtTypes, gtObject, Stream, EncryptionSettings;

type
  TgtDecodeBase = class(TgtObject)
  public
    function LookChar: Integer; virtual; abstract;
    function GetChar: Integer; virtual; abstract;
    function GetPosition: Int64; virtual; abstract;
    function ReadRawChar: Integer; virtual; abstract;
    procedure Reset; virtual; abstract;
  end;

 (**
  * This class is base class for all stream Decoding classes
  *)

  TgtDecode = class(TgtDecodeBase)
  public
    destructor Destroy; override;
    function LookChar: Integer; override;
    function GetChar: Integer; override;
    function GetPosition: Int64; override;
    function ReadRawChar: Integer; override;
    procedure Reset; override;
    function CheckPassword(var Settings: TgtEncryptionSettings;
      Password: AnsiString): Boolean; virtual;
  end;

implementation

uses gtLogger, StreamConsts;

{ TgtDecode }

function TgtDecode.CheckPassword(var Settings: TgtEncryptionSettings;
  Password: AnsiString): Boolean;
begin
  Result := False;
end;

destructor TgtDecode.Destroy;
begin

  inherited;
end;

function TgtDecode.GetChar: Integer;
begin
  Result := 0;
end;

function TgtDecode.GetPosition: Int64;
begin
  Result := ENDOFFILE;
{$IFDEF DEBUG}
  Logger.LogError('Internal: Cannot call GetPosition on a non-predictor stream');
{$ENDIF}
end;

function TgtDecode.LookChar: Integer;
begin
  Result := 0;
end;

function TgtDecode.ReadRawChar: Integer;
begin
  Result := ENDOFFILE;
{$IFDEF DEBUG}
  Logger.LogError('Internal: Cannot call ReadRawChar on a non-predictor stream');
{$ENDIF}
end;

procedure TgtDecode.Reset;
begin

end;

end.
