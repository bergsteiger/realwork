{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSServerReg;

interface

uses ToolsAPI, DSSource, DesignEditors, DesignIntf;

type

  TPEMFilePropertyEditor = class(TStringProperty)
  protected
    function GetFilter: string; virtual;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TPEMKeyFilePropertyEditor = class(TPEMFilePropertyEditor)
  protected
    function GetFilter: string; override;
  end;

procedure Register;

implementation

uses
  Classes, SysUtils, DSServer, DSHTTP, DSNames,
  Windows, DMForm, DSCommonServer, DbxTransport, StrEdit, DSHTTPCommon,
  InetReg, DBXPlatform, Controls, DBXCommon, DSCommonReg, DSService, DSAuth,
  DSServerDsnResStrs, Dialogs, Forms, InetDesignResStrs, PlatformAPI, TypInfo;

type
  TDSLifeCycleProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TDSServerTransportEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TDSCustomRoleItemProperty = class(TStringListProperty)
  public
    function GetValue: string; override;
  end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(UnicodeString), TDSServerClass, 'LifeCycle', TDSLifeCycleProperty);
  RegisterComponents(rsDatasnapServer, [TDSServer, TDSServerClass, TDSCertFiles,
                                        TDSAuthenticationManager]);

  RegisterPropertyEditor(TypeInfo(TStrings), TDSCustomRoleItem, '', TDSCustomRoleItemProperty);
  RegisterSelectionEditor(TDSServerTransport, TDSServerTransportEditor);

  RegisterPropertyEditor(TypeInfo(string), TDSCustomCertFiles, 'RootCertFile',
    TPEMFilePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TDSCustomCertFiles, 'CertFile',
    TPEMFilePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TDSCustomCertFiles, 'KeyFile',
    TPEMKeyFilePropertyEditor);
end;

{ TLifeCycleProperty }

function TDSLifeCycleProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDSLifeCycleProperty.GetValues(Proc: TGetStrProc);
begin
  Proc(TDSLifeCycle.Server);
  Proc(TDSLifeCycle.Session);
  Proc(TDSLifeCycle.Invocation);
//  Proc(TDSLifeCycle.Pool);
end;

{ TDSServerTransportEditor }

procedure TDSServerTransportEditor.RequiresUnits(Proc: TGetStrProc);
var
  i, j: Integer;
  FilterUnit: string;
  LIPImplementationID: string;
  Transport: TDSServerTransport;
  TransportFilter: TTransportFilter;
begin
  for i := 0 to Designer.Root.ComponentCount - 1 do
  begin
    if Designer.Root.Components[i] is TDSServerTransport then
    begin
      Transport := TDSServerTransport(Designer.Root.Components[i]);
      LIPImplementationID := Transport.IPImplementationID;
      if LIPImplementationID = '' then
        Proc('IPPeerServer')
      else
        Proc(LIPImplementationID);
      for j := 0 to Transport.Filters.Count - 1 do
      begin
        TransportFilter := Transport.Filters.GetFilter(j);
        if TransportFilter <> nil then
        begin
          FilterUnit := TransportFilter.GetParameterValue('FilterUnit');
          if FilterUnit <> EmptyStr then
            Proc(FilterUnit);
        end;
      end;

      if Designer.Root.Components[i] is TCustomDSRESTServerTransport then
      begin
        if Assigned(GetMethodProp(Transport, 'OnFormatResult').Code) then
        begin
          Proc('System.JSON');
          Proc('Data.DBXCommon');
        end;
        if Assigned(GetMethodProp(Transport, 'OnHTTPTrace').Code) then
          Proc('Datasnap.DSHTTPCommon');
      end;
    end;
  end;
end;

{ TCustomRoleItemProperty }

function TDSCustomRoleItemProperty.GetValue: string;
var
  LStrings: TStrings;
begin
  LStrings := GetStrings;
  // Display value in object inspector
  Result := LStrings.DelimitedText;
end;

{ TPEMFilePropertyEditor }


procedure TPEMFilePropertyEditor.Edit;
var
  Dialog: Dialogs.TOpenDialog;
begin
  Dialog := Dialogs.TOpenDialog.Create(Application);
  with Dialog do
  try
    Title := sPEMOpenFileTitle;
    Filename := GetValue;
    Filter := GetFilter;
    HelpContext := 0;                         
    Options := Options + [ofShowHelp, ofPathMustExist, ofHideReadonly, ofFileMustExist];
    if Dialog.Execute then
      SetValue(Filename);
  finally
    Free;
  end;
end;

function TPEMFilePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable, paVCL];
end;

function TPEMFilePropertyEditor.GetFilter: string;
begin
  Result := sPEMFileFilter;
end;

{ TPEMKeyFilePropertyEditor }

function TPEMKeyFilePropertyEditor.GetFilter: string;
begin
  Result := sPEMKeyFileFilter;
end;

end.
