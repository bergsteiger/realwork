{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ *************************************************************************** }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit Web.WebReq;

interface

uses
  System.SyncObjs, System.SysUtils, System.Classes, Web.HTTPApp, System.Generics.Collections;

type
  TRequestNotification = (rnActivateModule, rnDeactivateModule, rnCreateModule, rnFreeModule,
    rnStartRequest, rnFinishRequest);

  TWebRequestHandler = class(TComponent)
  private
    FCriticalSection: TCriticalSection;
    FActiveWebModules: TList<TComponent>;
    FAddingActiveModules: Integer;
    FInactiveWebModules: TList<TComponent>;
    FMaxConnections: Integer;
    FCacheConnections: Boolean;
    FWebModuleClass: TComponentClass;

    function GetActiveCount: Integer;
    function GetInactiveCount: Integer;
    procedure SetCacheConnections(Value: Boolean);
  protected
    function ActivateWebModules: TComponent;
    procedure DeactivateWebModules(WebModules: TComponent);
    function HandleRequest(Request: TWebRequest; Response: TWebResponse): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FreeModules; virtual;
    procedure HandleException(Sender: TObject);
    property WebModuleClass: TComponentClass read FWebModuleClass write FWebModuleClass;
    property ActiveCount: Integer read GetActiveCount;
    property CacheConnections: Boolean read FCacheConnections write SetCacheConnections;
    property InactiveCount: Integer read GetInactiveCount;
    property MaxConnections: Integer read FMaxConnections write FMaxConnections;
  end;

  function WebRequestHandler: TWebRequestHandler;
  procedure FreeWebModules;

var
  WebRequestHandlerProc: function: TWebRequestHandler = nil;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  Web.BrkrConst, Web.WebConst, System.Types;

procedure FreeWebModules;
begin
  if Assigned(WebRequestHandlerProc) and (WebRequestHandlerProc <> nil) then
    WebRequestHandlerProc.FreeModules;
end;


function WebRequestHandler: TWebRequestHandler;
begin
  if Assigned(WebRequestHandlerProc) then
    Result := WebRequestHandlerProc
  else
    Result := nil;
end;

{ TWebRequestHandler }

constructor TWebRequestHandler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCriticalSection := TCriticalSection.Create;
  FActiveWebModules := TList<TComponent>.Create;
  FInactiveWebModules := TList<TComponent>.Create;
  FMaxConnections := 32;
  FCacheConnections := True;
end;

destructor TWebRequestHandler.Destroy;
begin
  FreeModules;
  FActiveWebModules.Free;
  FInactiveWebModules.Free;
  FCriticalSection.Free;
  inherited Destroy;
end;

procedure TWebRequestHandler.FreeModules;
var
  I: Integer;
begin
  FCriticalSection.Enter;
  try
    for I := 0 to FActiveWebModules.Count - 1 do
      TObject(FActiveWebModules[I]).Free;
    FActiveWebModules.Clear;
    for I := 0 to FInactiveWebModules.Count - 1 do
      TObject(FInactiveWebModules[I]).Free;
    FInactiveWebModules.Clear;
  finally
    FCriticalSection.Leave;
  end;
end;

function IsUniqueGlobalWebComponentName(const Name: string): Boolean;
begin
  // Prevent rename of data modules
  Result := True;
end;

function TWebRequestHandler.ActivateWebModules: TComponent;
begin
  if (FMaxConnections > 0) and (FAddingActiveModules >= FMaxConnections) then
    raise EWebBrokerException.CreateRes(@sTooManyActiveConnections);

  FCriticalSection.Enter;
  try
    FAddingActiveModules := FActiveWebModules.Count + 1;
    try
      Result := nil;
      if (FMaxConnections > 0) and (FActiveWebModules.Count >= FMaxConnections) then
        raise EWebBrokerException.CreateRes(@sTooManyActiveConnections);
      if FInactiveWebModules.Count > 0 then
      begin
        Result := FInactiveWebModules[0];
        FInactiveWebModules.Delete(0);
        FActiveWebModules.Add(Result);
      end
      else
      begin
        if WebModuleClass <> nil then
        begin
          Result := WebModuleClass.Create(nil);
          FActiveWebModules.Add(Result);
        end
        else
          raise EWebBrokerException.CreateRes(@sNoDataModulesRegistered);
      end;
    finally
      FAddingActiveModules := 0;
    end;
  finally
    FCriticalSection.Leave;
  end;
end;

procedure TWebRequestHandler.DeactivateWebModules(WebModules: TComponent);
begin
  FCriticalSection.Enter;
  try
    FActiveWebModules.Remove(WebModules);
    if FCacheConnections then
      FInactiveWebModules.Add(WebModules)
    else
      WebModules.Free;
  finally
    FCriticalSection.Leave;
  end;
end;

function TWebRequestHandler.GetActiveCount: Integer;
begin
  FCriticalSection.Enter;
  try
    Result := FActiveWebModules.Count;
  finally
    FCriticalSection.Leave;
  end;
end;

function TWebRequestHandler.GetInactiveCount: Integer;
begin
  FCriticalSection.Enter;
  try
    Result := FInactiveWebModules.Count;
  finally
    FCriticalSection.Leave;
  end;
end;

function TWebRequestHandler.HandleRequest(Request: TWebRequest;
  Response: TWebResponse): Boolean;
var
  I: Integer;
  LWebModule: TComponent;
  LWebAppServices: IWebAppServices;
  LGetWebAppServices: IGetWebAppServices;
  LComponent: TComponent;
begin
  Result := False;
  LWebModule := ActivateWebModules;
  if Assigned(LWebModule) then
  try
    try
      if Supports(IInterface(LWebModule), IGetWebAppServices, LGetWebAppServices) then
        LWebAppServices := LGetWebAppServices.GetWebAppServices;
      if LWebAppServices = nil then
        for I := 0 to LWebModule.ComponentCount - 1 do
        begin
          LComponent := LWebModule.Components[I];
          if Supports(LComponent, IWebAppServices, LWebAppServices) then
            if LWebAppServices.Active then
              break
            else
              LWebAppServices := nil;
        end;
      if LWebAppServices = nil then
        LWebAppServices := TDefaultWebAppServices.Create;
      LWebAppServices.InitContext(LWebModule, Request, Response);
      try
        try
          Result := LWebAppServices.HandleRequest;
        except
          ApplicationHandleException(LWebAppServices.ExceptionHandler);
        end;
      finally
        LWebAppServices.FinishContext;
      end;
      if Result and not Response.Sent then
        Response.SendResponse;
    except
      ApplicationHandleException(LWebAppServices.ExceptionHandler);
    end;
  finally
    DeactivateWebModules(LWebModule);
  end;
end;

procedure TWebRequestHandler.SetCacheConnections(Value: Boolean);
var
  I: Integer;
begin
  if Value <> FCacheConnections then
  begin
    FCacheConnections := Value;
    if not Value then
    begin
      FCriticalSection.Enter;
      try
        for I := 0 to FInactiveWebModules.Count - 1 do
          TObject(FInactiveWebModules[I]).Free;
        FInactiveWebModules.Clear;
      finally
        FCriticalSection.Leave;
      end;
    end;
  end;
end;

procedure TWebRequestHandler.HandleException(Sender: TObject);
var
  Handled: Boolean;
  Intf: IWebExceptionHandler;
begin
  Handled := False;
  if ExceptObject is Exception and
    Supports(Sender, IWebExceptionHandler, Intf) then
    try
      Intf.HandleException(Exception(ExceptObject), Handled);
    except
      Handled := True;
      System.SysUtils.ShowException(ExceptObject, ExceptAddr);
    end;
  if (not Handled) then
    System.SysUtils.ShowException(ExceptObject, ExceptAddr);
end;

function ImplGetModuleFileName: string;
begin
  Result := GetModuleName(hinstance);
end;

initialization
  if not Assigned(GetModuleFileNameProc) then
    GetModuleFileNameProc := ImplGetModuleFileName;
end.
