{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

// Manage list of project features
unit DSServerFeatureManager;

interface

uses
  SysUtils, Classes, DSServerFeatures, WizardAPI, ExpertsUIWizard, DSServerDsnResStrs;

type

  TFeatureDescription = record
  public
    Group: TDSServerFeature;
    Feature: TDSServerFeature;
    Name: string;
    Description: string;
    WizardTypes: TDSWizardTypes;
    constructor Create(AGroup: TDSServerFeature; AFeature: TDSServerFeature;
      const AName: string; const ADescription: string;
      const AWizardTypes: TDSWizardTypes);
  end;


//   (Feature: dsFilters; Name: sFiltersFeatureName; Description: sFiltersFeatureDescription),
//   (Feature: dsEncryptionFilters; Name: sEncryptionFeatureName; Description: sEncryptionFeatureDescription),
//   (Feature: dsCompressionFilter; Name: sCompressionFeatureName; Description: sCompressionFeatureDescription)

procedure AddFeature(AFeaturesPage: TCustomExpertsFeaturesWizardPage; AFeatureDescription: TFeatureDescription);
procedure EnumFeatures(AFeatureDescriptions: TArray<TFeatureDescription>; AFilter: TFunc<TFeatureDescription, Boolean>; AEnum: TProc<TFeatureDescription>);
procedure EnumApplicationFeatures(AFeatureDescriptions: TArray<TFeatureDescription>; AType: TDSWizardType; AEnum: TProc<TFeatureDescription>);
procedure CheckFeature(AFeaturesPage: TCustomExpertsFeaturesWizardPage; AFeature: TDSServerFeature; AChecked: Boolean);
procedure CheckFeatures(AFeatureDescriptions: TArray<TFeatureDescription>; AFeaturesPage: TCustomExpertsFeaturesWizardPage; AType: TDSWizardType; AFeatures: TDSServerFeatures);
procedure AddFeatures(AFeatureDescriptions: TArray<TFeatureDescription>; AFeaturesPage: TCustomExpertsFeaturesWizardPage; AType: TDSWizardType);
procedure UpdateFeatures(AFeatureDescriptions: TArray<TFeatureDescription>; AFeaturesPage: TCustomExpertsFeaturesWizardPage; AType: TDSWizardType;
  var AFeatures: TDSServerFeatures);
function DefaultFeatureDescriptions: TArray<TFeatureDescription>;

implementation

uses Generics.Collections;

  // Standalone DataSnap server features
  const GDefaultFeatureDescriptions: array[0..15] of TFeatureDescription =
    ((Group: dsProtocols; Feature: dsNull; Name: sProtocolFeatureName; Description: sProtocolFeatureDescription; WizardTypes: [wtStandAlone]),
    (Group: dsProtocols; Feature: dsTCPProtocol; Name: sTCPProtocolFeatureName; Description: sTCPProtocolFeatureDescription; WizardTypes: [wtStandAlone]),
    (Group: dsProtocols; Feature: dsHTTPProtocol; Name: sHTTPProtocolFeatureName; Description: sHTTPProtocolFeatureDescription; WizardTypes: [wtStandAlone]),
    (Group: dsProtocols; Feature: dsHTTPSProtocol; Name: sHTTPSProtocolFeatureName; Description: sHTTPSProtocolFeatureDescription; WizardTypes: [wtStandAlone]),
    (Group: dsNull; Feature: dsAuthentication; Name: sAuthenticationFeatureName; Description: sAuthenticationFeatureDescription; WizardTypes: [wtAll]),
    (Group: dsAuthentication; Feature: dsAuthorization; Name: sAuthorizationFeatureName; Description: sAuthorizationFeatureDescription; WizardTypes: [wtAll]),
    (Group: dsNull; Feature: dsServerMethodClass; Name: sServerMethodClassFeatureName; Description: sSampleMethodsFeatureDescription; WizardTypes: [wtAll]),
    (Group: dsServerMethodClass; Feature: dsSampleMethods; Name: sSampleMethodsFeatureName; Description: sSampleMethodsFeatureDescription; WizardTypes: [wtAll]),
    (Group: dsServerMethodClass; Feature: dsSampleWebFiles; Name: sSampleWebFilesFeatureName; Description: sSampleWebFilesFeatureDescription; WizardTypes: [wtWebBrokerRest]),
    (Group: dsFilters; Feature: dsNull; Name: sFiltersFeatureName; Description: sFiltersFeatureDescription; WizardTypes: [wtStandAlone, wtWebBroker]),
    (Group: dsFilters; Feature: dsEncryptionFilters; Name: sEncryptionFeatureName; Description: sEncryptionFeatureDescription; WizardTypes: [wtStandAlone, wtWebBroker]),
    (Group: dsFilters; Feature: dsCompressionFilter; Name: sCompressionFeatureName; Description: sCompressionFeatureDescription; WizardTypes: [wtStandAlone, wtWebBroker]),
    (Group: dsNull; Feature: dsWebFiles; Name: sWebFilesFeatureName; Description: sWebFilesFeatureDescription; WizardTypes: [wtStandAlone]),
    (Group: dsNull; Feature: dsRESTDispatcher; Name: sRESTDispatcherFeatureName; Description: sRESTDispatcherFeatureDescription; WizardTypes: [wtWebBrokerRest]),
    (Group: dsNull; Feature: dsConnectors; Name: sConnectorsFeatureName; Description: sConnectorsFeatureDescription; WizardTypes: [wtAll]),
    (Group: dsNull; Feature: dsServerModule; Name: sServerModuleFeatureName; Description: sServerModuleFeatureDescription; WizardTypes: [wtWebBroker, wtWebBrokerRest])
    );

function DefaultFeatureDescriptions: TArray<TFeatureDescription>;
var
  LList: TList<TFeatureDescription>;
  LItem: TFeatureDescription;
begin
  LList := TList<TFeatureDescription>.Create;
  try
    for LItem in GDefaultFeatureDescriptions do
    begin
      if LItem.Feature = dsRESTDispatcher then
        if GetForceDSRESTDispatcher then
          continue;  // Don't add choice for REST dispatcher.  It will always be selected.

      LList.Add(LItem);
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

procedure AddFeature(AFeaturesPage: TCustomExpertsFeaturesWizardPage; AFeatureDescription: TFeatureDescription);
begin
  if AFeatureDescription.Feature = dsNull then
    with AFeatureDescription do
      AFeaturesPage.AddFeatureGroup(Integer(Group), Name, Description)
  else if AFeatureDescription.Group = dsNull then
    with AFeatureDescription do
      AFeaturesPage.AddFeature(Integer(Feature), Name, Description)
  else
    with AFeatureDescription do
      AFeaturesPage.AddFeature(Integer(Group), Integer(Feature), Name, Description)
end;

procedure EnumFeatures(AFeatureDescriptions: TArray<TFeatureDescription>; AFilter: TFunc<TFeatureDescription, Boolean>; AEnum: TProc<TFeatureDescription>);
var
  LDescription: TFeatureDescription;
begin
  for LDescription in AFeatureDescriptions do
    if AFilter(LDescription) then
    begin
      AEnum(LDescription);
    end;
end;

procedure EnumApplicationFeatures(AFeatureDescriptions: TArray<TFeatureDescription>; AType: TDSWizardType; AEnum: TProc<TFeatureDescription>);
begin
  EnumFeatures(AFeatureDescriptions,
    function(ADescription: TFeatureDescription): Boolean
    begin
      Result := (ADescription.WizardTypes * [AType, wtAll]) <> []
    end, AEnum);
end;

procedure CheckFeature(AFeaturesPage: TCustomExpertsFeaturesWizardPage; AFeature: TDSServerFeature; AChecked: Boolean);
begin
  AFeaturesPage.Checked[Integer(AFeature)] := AChecked;
end;

procedure CheckFeatures(AFeatureDescriptions: TArray<TFeatureDescription>; AFeaturesPage: TCustomExpertsFeaturesWizardPage; AType: TDSWizardType; AFeatures: TDSServerFeatures);
begin
  EnumApplicationFeatures(AFeatureDescriptions, AType,
   procedure(ADescription: TFeatureDescription)
   begin
      if ADescription.Feature <> dsNull then
        CheckFeature(AFeaturesPage, ADescription.Feature,
          (AFeatures * [ADescription.Feature]) <> []);
   end)
end;

procedure AddFeatures(AFeatureDescriptions: TArray<TFeatureDescription>; AFeaturesPage: TCustomExpertsFeaturesWizardPage; AType: TDSWizardType);
begin
  EnumApplicationFeatures(AFeatureDescriptions, AType,
   procedure(ADescription: TFeatureDescription)
   begin
      AddFeature(AFeaturesPage, ADescription);
   end)
end;

procedure UpdateFeatures(AFeatureDescriptions: TArray<TFeatureDescription>; AFeaturesPage: TCustomExpertsFeaturesWizardPage; AType: TDSWizardType;
  var AFeatures: TDSServerFeatures);
var
  LFeatures: TDSServerFeatures;
begin
  LFeatures := AFeatures;
  EnumApplicationFeatures(AFeatureDescriptions, AType,
    procedure(ADescription: TFeatureDescription)
    begin
      if ADescription.Feature <> dsNull then
      begin
        if AFeaturesPage.Checked[Integer(ADescription.Feature)] then
          Include(LFeatures, ADescription.Feature)
        else
          Exclude(LFeatures, ADescription.Feature)
      end;
    end);
  AFeatures := LFeatures;
end;


{ TFeatureDescription }

constructor TFeatureDescription.Create(AGroup, AFeature: TDSServerFeature;
  const AName, ADescription: string; const AWizardTypes: TDSWizardTypes);
begin
  Group := AGroup;
  Feature := AFeature;
  Name := AName;
  Description := ADescription;
  WizardTypes := AWizardTypes;
end;

end.
