{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.PhoneDialer.Actions;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Actions,
  FMX.Types, FMX.PhoneDialer, FMX.ActnList, FMX.StdActns, FMX.Consts;

type

  TPhoneCallAction = class (TSysCommonAction)
  strict private
    FPhoneDialerService: IFMXPhoneDialerService;
    FTelephoneNumber: string;
  protected
    function IsSupportedInterface: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property TelephoneNumber: string read FTelephoneNumber write FTelephoneNumber;
  end;

implementation

uses
  FMX.Platform;

{ TTakePhotoFromCameraAction }

constructor TPhoneCallAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService, FPhoneDialerService);
end;

destructor TPhoneCallAction.Destroy;
begin
  FPhoneDialerService := nil;
  inherited Destroy;
end;

procedure TPhoneCallAction.ExecuteTarget(Target: TObject);
begin
  if IsSupportedInterface then
    FPhoneDialerService.Call(TelephoneNumber);
end;

function TPhoneCallAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := Supported;
end;

function TPhoneCallAction.IsSupportedInterface: Boolean;
begin
   Result := FPhoneDialerService <> nil;
end;

end.
