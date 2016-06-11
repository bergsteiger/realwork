{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{         FireDAC pool standard implementation          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Stan.Pool;

interface

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, System.SyncObjs,
  FireDAC.Stan.Intf, FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Error, FireDAC.Stan.Factory;

type
  TFDResourcePoolGC = class;
  TFDResourcePool = class;

  TFDResourcePoolItem = class(TObject)
  private
    FObj: IFDStanObject;
    FInUse: Boolean;
    FLastUsed: Cardinal;
  public
    property Obj: IFDStanObject read FObj;
    property InUse: Boolean read FInUse;
    property LastUsed: Cardinal read FLastUsed;
  end;

  TFDResourcePoolGC = class(TThread)
  private
    FPool: TFDResourcePool;
    FEvent: TEvent;
  protected
    procedure Execute; override;
  public
    constructor Create(APool: TFDResourcePool);
    destructor Destroy; override;
  end;

  TFDResourcePool = class(TFDObject, IFDStanObjectFactory)
  private
    FHost: IFDStanObjectHost;
    FList: TFDObjList;
    FLock: TCriticalSection;
    FGC: TFDResourcePoolGC;
    FCleanupTimeout: Cardinal;
    FExpireTimeout: Cardinal;
    FMaximumItems: Integer;
    FBusyItems: Cardinal;
    FCloseTimeout: Cardinal;
    procedure DoCleanup;
    procedure InternalRelease(const AObject: IFDStanObject);
  protected
    // IFDStanObjectFactory
    procedure Open(const AHost: IFDStanObjectHost; const ADef: IFDStanDefinition);
    procedure Close;
    procedure Acquire(out AObject: IFDStanObject);
    procedure Release(const AObject: IFDStanObject);
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

{ ---------------------------------------------------------------------------- }
{ TFDResourcePoolGC                                                            }
{ ---------------------------------------------------------------------------- }
constructor TFDResourcePoolGC.Create(APool: TFDResourcePool);
begin
  inherited Create;
  FPool := APool;
  FEvent := TEvent.Create(nil, False, False, '');
end;

{ ---------------------------------------------------------------------------- }
destructor TFDResourcePoolGC.Destroy;
begin
  FEvent.SetEvent;
  inherited Destroy;
  FPool := nil;
  FDFreeAndNil(FEvent);
end;

{ ---------------------------------------------------------------------------- }
procedure TFDResourcePoolGC.Execute;
begin
  while not Terminated do
    case FEvent.WaitFor(FPool.FCleanupTimeout) of
    wrTimeout: FPool.DoCleanup;
    else       Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
{ TFDResourcePool                                                              }
{ ---------------------------------------------------------------------------- }
procedure TFDResourcePool.Initialize;
begin
  inherited Initialize;
  FCleanupTimeout := C_FD_PoolCleanupTimeout;
  FExpireTimeout := C_FD_PoolExpireTimeout;
  FCloseTimeout := C_FD_PoolCloseTimeout;
  FMaximumItems := C_FD_PoolMaximumItems;
  FList := TFDObjList.Create;
  FLock := TCriticalSection.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TFDResourcePool.Destroy;
begin
  Close;
  FDFreeAndNil(FList);
  FDFreeAndNil(FLock);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDResourcePool.DoCleanup;
var
  i: integer;
  oList: TFDObjList;
begin
  if FLock.TryEnter then begin
    oList := TFDObjList.Create;
    try
      try
        for i := FList.Count - 1 downto 0 do
          if not TFDResourcePoolItem(FList[i]).InUse and
             FDTimeout(TFDResourcePoolItem(FList[i]).LastUsed, FExpireTimeout) then begin
            oList.Add(FList[i]);
            FList.Delete(i);
          end;
      finally
        FLock.Leave;
      end;
      for i := 0 to oList.Count - 1 do
        FDFree(TFDResourcePoolItem(oList[i]));
    finally
      FDFree(oList);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDResourcePool.Acquire(out AObject: IFDStanObject);
var
  i, iCreate: integer;
  oItem: TFDResourcePoolItem;
begin
  AObject := nil;
  FLock.Enter;
  try
    ASSERT(FHost <> nil);
    for i := 0 to FList.Count - 1 do begin
      oItem := TFDResourcePoolItem(FList[i]);
      if not oItem.InUse then begin
        AObject := oItem.Obj;
        oItem.FInUse := True;
        Inc(FBusyItems);
        Break;
      end;
    end;
    if AObject = nil then begin
      if (FMaximumItems > 0) and (FMaximumItems <= FList.Count) then
        FDException(Self, [S_FD_LStan], er_FD_StanPoolTooManyItems, [FMaximumItems]);
      iCreate := 5;
      oItem := nil;
      if (FMaximumItems > 0) and (iCreate > FMaximumItems - FList.Count) then
        iCreate := FMaximumItems - FList.Count;
      while iCreate > 0 do begin
        oItem := TFDResourcePoolItem.Create;
        try
          oItem.FLastUsed := TThread.GetTickCount;
          FHost.CreateObject(oItem.FObj);
        except
          FDFree(oItem);
          raise;
        end;
        FList.Add(oItem);
        Dec(iCreate);
      end;
      ASSERT((oItem <> nil) and not oItem.FInUse and (oItem.FObj <> nil));
      AObject := oItem.FObj;
      oItem.FInUse := True;
      Inc(FBusyItems);
    end;
  finally
    FLock.Leave;
  end;
  try
    AObject.BeforeReuse;
  except
    InternalRelease(AObject);
    AObject := nil;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDResourcePool.InternalRelease(const AObject: IFDStanObject);
var
  i: integer;
  oItem: TFDResourcePoolItem;
begin
  FLock.Enter;
  try
    for i := 0 to FList.Count - 1 do begin
      oItem := TFDResourcePoolItem(FList[i]);
      if oItem.Obj = AObject then begin
        oItem.FInUse := False;
        oItem.FLastUsed := TThread.GetTickCount;
        Dec(FBusyItems);
        Exit;
      end;
    end;
  finally
    FLock.Leave;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDResourcePool.Release(const AObject: IFDStanObject);
begin
  try
    AObject.AfterReuse;
  finally
    InternalRelease(AObject);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourcePool.Open(const AHost: IFDStanObjectHost; const ADef: IFDStanDefinition);

  function Def(AValue, ADef: Integer): Integer;
  begin
    if AValue = 0 then
      Result := ADef
    else
      Result := AValue;
  end;

begin
  FLock.Enter;
  try
    ASSERT(FHost = nil);
    if ADef <> nil then begin
      FCleanupTimeout := Cardinal(Def(ADef.AsInteger[S_FD_ConnParam_Common_Pool_CleanupTimeout], C_FD_PoolCleanupTimeout));
      FExpireTimeout := Cardinal(Def(ADef.AsInteger[S_FD_ConnParam_Common_Pool_ExpireTimeout], C_FD_PoolExpireTimeout));
      FMaximumItems := Def(ADef.AsInteger[S_FD_ConnParam_Common_Pool_MaximumItems], C_FD_PoolMaximumItems);
    end;
    FHost := AHost;
    FGC := TFDResourcePoolGC.Create(Self);
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourcePool.Close;
var
  i: Integer;
  iStartTime: Cardinal;
begin
  if FHost <> nil then begin
    FHost := nil;
    iStartTime := TThread.GetTickCount;
    while (FBusyItems > 0) and not FDTimeout(iStartTime, FCloseTimeout) do
      Sleep(1);
    FLock.Enter;
    try
      FDFreeAndNil(FGC);
      for i := 0 to FList.Count - 1 do
        FDFree(TFDResourcePoolItem(FList[i]));
      FList.Clear;
    finally
      FLock.Leave;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDMultyInstanceFactory.Create(TFDResourcePool, IFDStanObjectFactory);

finalization
  FDReleaseFactory(oFact);

end.
