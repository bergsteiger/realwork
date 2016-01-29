{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit EncodeIntf;

interface

uses
  gtTypes, gtObject, Stream;

type
  TgtEncodeBase = class(TgtObject)
  public
    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; overload;
      virtual; abstract;
    function Write(Buffer: AnsiString; Count: Cardinal): Cardinal; overload; virtual;
  end;

(**
 * Base class for all stream Encoding
 *)

  TgtEncode = class(TgtEncodeBase)
  public
    destructor Destroy; override;
    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; overload; override;
    function Write(Buffer: AnsiString; Count: Cardinal): Cardinal; overload; override;
  end;

implementation

{ TgtEncode }

destructor TgtEncode.Destroy;
begin

  inherited;
end;

function TgtEncode.Write(Buffer: AnsiString; Count: Cardinal): Cardinal;
begin
  Result := 0;
end;

function TgtEncode.Write(OutStream: TgtStream; Count: Cardinal): Cardinal;
begin
  Result := 0;
end;

{ TgtEncodeBase }

function TgtEncodeBase.Write(Buffer: AnsiString; Count: Cardinal): Cardinal;
begin
  Result := 0;
end;

end.
