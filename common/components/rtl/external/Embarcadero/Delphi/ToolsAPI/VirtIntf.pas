{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit VirtIntf deprecated;

interface

type
  TInterface = class
  private
    FRefCount: Longint;
  public
    constructor Create;
    procedure Free;
    function AddRef: Longint; virtual; stdcall;
    function Release: Longint; virtual; stdcall;
    function GetVersion: Integer; virtual; stdcall;
  end;

function ReleaseException: string;

implementation

uses System.SysUtils;

{ TInterface }

constructor TInterface.Create;
begin
  inherited Create;
  FRefCount := 1;
end;

procedure TInterface.Free;
begin
  if Self <> nil then Release;
end;

function TInterface.AddRef: Longint;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TInterface.Release: Longint;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if FRefCount = 0 then Destroy;
end;

function TInterface.GetVersion: Integer;
begin
  Result := 3;
end;

{ Exception handling }

function ReleaseException: string;
begin
  Result := Exception(ExceptObject).Message;
end;

end.
