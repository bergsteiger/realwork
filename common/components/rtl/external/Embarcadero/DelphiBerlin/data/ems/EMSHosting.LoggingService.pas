{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.LoggingService;

{$HPPEMIT LINKUNIT}

interface

uses
  System.SysUtils, System.Classes, EMS.Services,
  System.Generics.Collections, System.JSON;

type
  TEMSLoggingService = class(TInterfacedObject, IEMSLoggingService)
  public type
    TLogProc = reference to procedure(const ACategory: string; const AJSON: TJSONObject);
  private
    class var FLogProc: TLogProc;
    class var FLoggingEnabledProc: TFunc<Boolean>;
  public
    function GetLoggingEnabled: Boolean;
    procedure Log(const ACategory: string; const AJSON: TJSONObject);
    class property OnLog: TLogProc read FLogProc write FLogProc;
    class property OnLoggingEnabled: TFunc<Boolean> read FLoggingEnabledProc write FLoggingEnabledProc;
  end;

implementation

uses EMSHosting.ExtensionsServices, EMSHosting.Helpers;


{ TEMSLoggingService }


function TEMSLoggingService.GetLoggingEnabled: Boolean;
begin
  Result := Assigned(FLogProc);
  if Result then
    if Assigned(FLoggingEnabledProc) then
      Result := FLoggingEnabledProc
end;

procedure TEMSLoggingService.Log(const ACategory: string;
  const AJSON: TJSONObject);
var
  LJSON: TJSONObject;
begin
  if Assigned(FLogProc) then
  begin
    LJSON := AJSON.Clone as TJSONObject;
    try
      LJSON.AddPair(TLogObjectNames.Thread, TJSONNumber.Create(TThread.CurrentThread.ThreadID));
      FLogProc(ACategory, AJSON);
    finally
      LJSON.Free;
    end;
  end;
end;

var
  LIndex: Integer;
initialization
   LIndex := AddService(TEMSLoggingService.Create as IEMSLoggingService);
finalization
   RemoveService(LIndex);
end.
