{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Platform.Common;

interface

{$SCOPEDENUMS ON}

/// <summary> This method is called at application startup to register currently available platform services that are
/// common to two or more platforms. </summary>
procedure RegisterCommonPlatformServices;

implementation

uses
  System.SysUtils, System.Math, FMX.Platform;

type
  TCommonRenderingSetup = class(TInterfacedObject, IFMXRenderingSetupService)
  private
    FRenderingSetupCallback: TRenderingSetupCallback;
    [Weak] FRenderingSetupContext: TObject;
    class var FCurrent: TCommonRenderingSetup;
  public
    procedure Subscribe(const Callback: TRenderingSetupCallback; const Context: TObject = nil);
    procedure Unsubscribe;
    procedure Invoke(var ColorBits, DepthBits: Integer; var Stencil: Boolean; var Multisamples: Integer);
    class property Current: TCommonRenderingSetup read FCurrent;
  end;

procedure TCommonRenderingSetup.Subscribe(const Callback: TRenderingSetupCallback; const Context: TObject);
begin
  FRenderingSetupCallback := Callback;
  FRenderingSetupContext := Context;
end;

procedure TCommonRenderingSetup.Unsubscribe;
begin
  FRenderingSetupContext := nil;
  FRenderingSetupCallback := nil;
end;

procedure TCommonRenderingSetup.Invoke(var ColorBits, DepthBits: Integer; var Stencil: Boolean;
  var Multisamples: Integer);

  function EnsureRangeSteps(const Value, MinRange, MaxRange, Steps: Integer): Integer; inline;
  begin
    if Value > 0 then
      Result := Round(EnsureRange(Value, MinRange, MaxRange) / Steps) * Steps
    else
      Result := 0;
  end;

begin
  if Assigned(FRenderingSetupCallback) then
    FRenderingSetupCallback(Self, FRenderingSetupContext, ColorBits, DepthBits, Stencil, Multisamples);

  ColorBits := EnsureRangeSteps(ColorBits, 16, 32, 8);
  DepthBits := EnsureRangeSteps(DepthBits, 16, 32, 8);
  Multisamples := EnsureRangeSteps(Multisamples, 0, 16, 2);
end;

procedure RegisterCommonPlatformServices;
begin
  TCommonRenderingSetup.FCurrent := TCommonRenderingSetup.Create;
  TPlatformServices.Current.AddPlatformService(IFMXRenderingSetupService, TCommonRenderingSetup.FCurrent);
end;

end.
