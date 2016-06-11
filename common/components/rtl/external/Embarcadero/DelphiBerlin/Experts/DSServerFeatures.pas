{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSServerFeatures;

interface

type

  TDSWizardType = (wtAll, wtStandAlone, wtWebBroker, wtWebBrokerRest);
  TDSWizardTypes = set of TDSWizardType;

  TDSServerProjectType = (ptConsole, ptService, ptVCL);
  TDSServerProjectTypes = set of TDSServerProjectType;

  TDSServerFeature = (dsNull, dsProtocols, dsFilters, dsServerModule,
    dsTCPProtocol, dsHTTPProtocol, dsHTTPSProtocol, dsAuthentication, dsServerMethodClass,
    dsSampleMethods, dsAuthorization, dsRSAFilter, dsPC1Filter, dsZLibFilter, dsProjectLocation, dsWebServerPort,
    dsWebFiles, dsSampleWebFiles, dsEncryptionFilters, dsCompressionFilter, dsHTTPSCertFiles, dsConnectors, dsRESTDispatcher,
    dsCustom1, dsCustom2, dsCustom3, dsCustom4, dsCustom5, dsCustom6, dsCustom7, dsCustom8, dsCustom9, dsCustom10);

  TDSServerFeatures = set of TDSServerFeature;

  TDSServerClassName = (scComponent, scDataModule, scDSServerModule);

function GetAncestorClass(AValue: TDSServerClassName): string;
function GetForceDSRESTDispatcher: Boolean;
function GetForceNoWebBrokerConnectors: Boolean;

var
  SupportedWizardTypes: TDSWizardTypes = [];

implementation

uses System.Classes, IdentityAPI, System.SysUtils;

function GetForceDSRESTDispatcher: Boolean;
begin
  // If TDSHTTPWebDispatcher not registered then use TDSRESTWebDispatcher.  Appmethod use case.
//  Result := GetClass('TDSHTTPWebDispatcher') = nil; // Do not localize
  Result := True;
  if Identity <> nil then
    if Identity.SupportsString(TBaseIdentity.ID) then
      if SameText(Identity.IdentityString[TBaseIdentity.ID], 'RADSTUDIO') then
        Result := False;
end;

function GetForceNoWebBrokerConnectors: Boolean;
begin
  Result := GetClass('TDSProxyDispatcher') = nil; // Do not localize
end;


// 'T' prefix not included
function GetAncestorClass(AValue: TDSServerClassName): string;
begin
  case AValue of
    scComponent: Result := 'Component';
    scDataModule: Result := 'DataModule';
    scDSServerModule: Result := 'DSServerModule';
  else
    Assert(False);
  end;
end;

end.
