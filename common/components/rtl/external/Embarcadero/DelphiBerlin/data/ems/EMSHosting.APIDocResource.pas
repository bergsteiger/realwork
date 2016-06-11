{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.APIDocResource;

interface

uses System.SysUtils, System.Classes, System.JSON,
  EMS.ResourceAPI, EMS.ResourceTypes, System.JSON.Writers,
  EMSHosting.APIDocConsts;

const
  sAPIDoc = 'API';
  sAPIDocYAML = 'GetAPIYAMLFormat';
  sAPIDocJSON = 'GetAPIJSONFormat';
  sYAMLSuffix = 'apidoc.yaml';
  sJSONSuffix = 'apidoc.json';
type
  [ResourceName(sAPIDoc)]
  {$METHODINFO ON}
  TAPIDocResource = class
  private
    procedure GetAPIDoc(const AAPIDoc: TAPIDoc; const LoadJSONDefinitions: Boolean; const ASegmentPath: string = '');
  published
    [EndpointName(sAPIDoc)]
    [EndPointRequestSummary(cAPIDocTag, cGetAPITitle, cGetAPIDesc, cApplicationJSON, '')]
    [EndPointResponseDetails(200, cResponseOK, TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure GetDoc(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndpointName(sAPIDocYAML + ' EndPoint')]
    [ResourceSuffix('{item}/' + sYAMLSuffix)]
    [EndPointRequestSummary(cAPIDocTag, cGetOneAPITitle, cGetOneAPIDesc, cApplicationJSON, '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', cEndPointPath, true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spNull, '', '')]
    [EndPointResponseDetails(200, cResponseOK, TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure GetDocYamlItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndpointName(sAPIDocYAML)]
    [ResourceSuffix(sYAMLSuffix)]
    [EndPointRequestSummary(cAPIDocTag, cGetAPIYAMLTitle, cGetAPIYAMLDesc, '', '')]
    [EndPointResponseDetails(200, cResponseOK, TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure GetYamlDoc(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndpointName(sAPIDocJSON)]
    [ResourceSuffix(sJSONSuffix)]
    [EndPointRequestSummary(cAPIDocTag, cGetAPIJSONTitle, cGetAPIJSONDesc, '', '')]
    [EndPointResponseDetails(200, cResponseOK, TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure GetJSONDoc(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;
  {$METHODINFO OFF}

procedure RegisterAPIDocResource;

implementation

uses EMSHosting.Helpers, System.JSON.Builders,
    Generics.Defaults, Generics.Collections, System.Variants;

procedure RegisterAPIDocResource;
begin
  RegisterResource(TypeInfo(TAPIDocResource));
end;

{ TVersionResource }

procedure TAPIDocResource.GetAPIDoc(const AAPIDoc: TAPIDoc; const LoadJSONDefinitions: Boolean; const ASegmentPath: string);
var
  LEMSEndpointManager: TEMSEndpointManager;
  LEMSResource: TEMSResource;
  LEMSTypeInfoResource: TEMSTypeInfoResource;
  LAPIDocPath: TAPIDocPath;
  LDefinitions: string;
  LJSONObject: TJSONObject;
  LAddDefinitions: Boolean;
begin
  LEMSEndpointManager := TEMSEndpointManager.Instance;
  for LEMSResource in LEMSEndpointManager.Resources do
    if LEMSResource is TEMSTypeInfoResource then
    begin
      LEMSTypeInfoResource := TEMSTypeInfoResource(LEMSResource);
      LAddDefinitions := False;
      for LAPIDocPath in LEMSTypeInfoResource.APIDocPaths do
        if (ASegmentPath = '') or (LAPIDocPath.Path.StartsWith('/' + ASegmentPath)) then
        begin
          AAPIDoc.AddPath(LAPIDocPath);
          LAddDefinitions := True;
        end;
      if LAddDefinitions then
      begin
        if not LoadJSONDefinitions then
          AAPIDoc.Definitions := AAPIDoc.Definitions + LEMSTypeInfoResource.YAMLDefinitions
        else
            if LEMSTypeInfoResource.JSONDefinitions <> '' then
            begin
              LJSONObject :=  TJSONObject.ParseJSONValue(LEMSTypeInfoResource.JSONDefinitions) as TJSONObject;
              if LJSONObject = nil then
                raise Exception.Create('Wrong deinitions. Invalid JSON Objects')
              else
                LJSONObject.Free;

              LDefinitions := LEMSTypeInfoResource.JSONDefinitions.Trim;
              LDefinitions := LDefinitions.Remove(0,1);
              LDefinitions := LDefinitions.Remove(LDefinitions.Length -1, 1);
              if AAPIDoc.Definitions = '' then
                AAPIDoc.Definitions := LDefinitions
              else
                AAPIDoc.Definitions := AAPIDoc.Definitions + ',' + sLineBreak + LDefinitions;
           end;
      end;
    end;

  AAPIDoc.SortPaths;
end;


procedure TAPIDocResource.GetDoc(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LBuilderArray: TJSONArrayBuilder;
begin
  LBuilderArray := TJSONArrayBuilder.Create(AResponse.Body.JSONWriter);
  try
    LBuilderArray.BeginArray;

    LBuilderArray.ParentArray.BeginObject;
    LBuilderArray.ParentObject.Add('apicall',sYAMLSuffix);
    LBuilderArray.ParentObject.EndObject;
    LBuilderArray.ParentArray.BeginObject;
    LBuilderArray.ParentObject.Add('apicall',sJSONSuffix);
    LBuilderArray.ParentObject.EndObject;

    LBuilderArray.ParentArray.EndArray;
  finally
    LBuilderArray.Free;
  end;
end;

procedure TAPIDocResource.GetJSONDoc(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LAPIDoc: TAPIDoc;
  LHost, LBasePath: string;
begin
  LBasePath := ARequest.BasePath;
  LHost :=  ARequest.ServerHost;
  LAPIDoc := TAPIDoc.Create(LHost, LBasePath);
  try
    GetAPIDoc(LAPIDoc, True);
    LAPIDoc.WriteAPIDocJson(AResponse.Body.JSONWriter);
  finally
    LAPIDoc.Free;
  end;
end;

procedure TAPIDocResource.GetYamlDoc(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LAPIDoc: TAPIDoc;
  LHost, LBasePath: string;
  LItem: string;
begin
  ARequest.Params.TryGetValue('item', LItem);
  LBasePath := ARequest.BasePath;
  LHost :=  ARequest.ServerHost;
  LAPIDoc := TAPIDoc.Create(LHost, LBasePath);
  try
    GetAPIDoc(LAPIDoc, False, LItem);
    AResponse.Body.SetStream(TStringStream.Create(LAPIDoc.GetAPIDocYaml), 'text/plain', true);
//    //AResponse.Body.SetStream(TStringStream.Create(LAPIDoc.GetAPIDocYaml), 'application/yaml', False);
  finally
    LAPIDoc.Free;
  end;
end;

procedure TAPIDocResource.GetDocYamlItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest;
  const AResponse: TEndpointResponse);
begin
  GetYamlDoc(AContext, ARequest, AResponse);
end;

initialization
  TResourceStringsTable.Add(cResponseOK, sResponseOK);
  TResourceStringsTable.Add(cGetAPITitle, sGetAPITitle);
  TResourceStringsTable.Add(cGetAPIDesc, sGetAPIDesc);
  TResourceStringsTable.Add(cGetAPIYAMLTitle, sGetAPIYAMLTitle);
  TResourceStringsTable.Add(cGetAPIJSONTitle, sGetAPIJSONTitle);
  TResourceStringsTable.Add(cGetAPIYAMLDesc, sGetAPIYAMLDesc);
  TResourceStringsTable.Add(cGetAPIJSONDesc, sGetAPIJSONDesc);
  TResourceStringsTable.Add(cGetOneAPITitle, sGetOneAPITitle);
  TResourceStringsTable.Add(cGetOneAPIDesc, sGetOneAPIDesc);
  TResourceStringsTable.Add(cEndPointPath, sEndPointPath);
end.
