{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.EdgeListeners;

{$HPPEMIT LINKUNIT}
interface

uses System.SysUtils, System.Classes, System.Generics.Collections,
  EMSHosting.EdgeService;

type
  TEMSEdgeListenerFactory = class
  protected
    function DoCreateListener(const AOwner: TComponent; const AProtocolName: string): TEMSEdgeListener; virtual; abstract;
  public
    function CreateListener(const AOwner: TComponent; const AProtocolName: string): TEMSEdgeListener;
  end;

  TEMSEdgeListenerFactories = class
  private
    class var FInstance: TEMSEdgeListenerFactories;
  public type
    TProtocolPair = TPair<string, TEMSEdgeListenerFactory>;
  private
    FUnitNames: TDictionary<string, string>;
    FItems: TDictionary<string, TEMSEdgeListenerFactory>;
    function GetNames: TArray<string>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const AProtocolName, AUnitName: string; const AFactory: TEMSEdgeListenerFactory);
    procedure Remove(const AName: string);
    function TryGetFactory(const AName: string; out AFactory: TEMSEdgeListenerFactory): Boolean;
    function TryGetUnitName(const AName: string; out AUnitName: string): Boolean;
    property Names: TArray<string> read GetNames;
    class property Instance: TEMSEdgeListenerFactories read FInstance;
  end;

implementation

{ TEMSEdgeListenerFactories }

procedure TEMSEdgeListenerFactories.Add(const AProtocolName, AUnitName: string;
  const AFactory: TEMSEdgeListenerFactory);
begin
  FItems.Add(AProtocolName, AFactory);
  FUnitNames.Add(AProtocolName, AUnitName);
end;

constructor TEMSEdgeListenerFactories.Create;
begin
  FUnitNames := TDictionary<string, string>.Create;
  FItems := TObjectDictionary<string, TEMSEdgeListenerFactory>.Create([doOwnsValues]);
end;

destructor TEMSEdgeListenerFactories.Destroy;
begin
  FItems.Free;
  FUnitNames.Free;
  inherited;
end;

function TEMSEdgeListenerFactories.GetNames: TArray<string>;
begin
  Result := FItems.Keys.ToArray;
end;

procedure TEMSEdgeListenerFactories.Remove(const AName: string);
begin
  FItems.Remove(AName);
  FUnitNames.Remove(AName);
end;

function TEMSEdgeListenerFactories.TryGetFactory(const AName: string;
  out AFactory: TEMSEdgeListenerFactory): Boolean;
begin
  Result := FItems.TryGetValue(AName, AFactory);
end;

function TEMSEdgeListenerFactories.TryGetUnitName(const AName: string;
  out AUnitName: string): Boolean;
begin
  Result := FUnitNames.TryGetValue(AName, AUnitName);
end;

{ TEMSEdgeListenerFactory }

function TEMSEdgeListenerFactory.CreateListener(const AOwner: TComponent;
  const AProtocolName: string): TEMSEdgeListener;
begin
  Result := DoCreateListener(AOwner, AProtocolName);
end;

initialization
  TEMSEdgeListenerFactories.FInstance := TEMSEdgeListenerFactories.Create;
finalization
  FreeAndNil(TEMSEdgeListenerFactories.FInstance);
end.
