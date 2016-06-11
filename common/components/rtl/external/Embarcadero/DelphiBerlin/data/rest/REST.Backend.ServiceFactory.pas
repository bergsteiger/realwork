{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.ServiceFactory;

interface

uses
  System.Classes,
  System.SysUtils,
  REST.Backend.Providers;

type
  TProviderServiceFactory = class
  private
    FProviderID: string;
    FUnitNames: TArray<string>;
  protected
    function CreateService(const AProvider: IBackendProvider; const IID: TGUID): IBackendService; virtual; abstract;
    function GetServiceIID: TGUID; virtual; abstract;
  public
  public
    constructor Create(const AProviderID: string); overload;
    constructor Create(const AProviderID, AUnitName: string); overload;
    procedure Register;
    procedure Unregister;
  end;

  TProviderServiceFactory<T: IBackendService> = class(TProviderServiceFactory)
  protected
    function GetServiceIID: TGUID; override;
  end;

implementation

uses
  System.TypInfo;

{ TProviderServiceFactory }

procedure TProviderServiceFactory.Register;
begin
  TBackendProviders.Instance.RegisterService(FProviderID, GetServiceIID,
    CreateService,
    FUnitNames);
end;

procedure TProviderServiceFactory.Unregister;
begin
  TBackendProviders.Instance.UnregisterService(FProviderID, GetServiceIID);
end;


constructor TProviderServiceFactory.Create(const AProviderID: string);
begin
  FProviderID := AProviderID;
end;

constructor TProviderServiceFactory.Create(const AProviderID, AUnitName: string);
begin
  Create(AProviderID);
  FUnitNames := TArray<string>.Create(AUnitName);
end;

function TProviderServiceFactory<T>.GetServiceIID: TGUID;
begin
  Result := GetTypeData(TypeInfo(T))^.Guid;
end;


end.
