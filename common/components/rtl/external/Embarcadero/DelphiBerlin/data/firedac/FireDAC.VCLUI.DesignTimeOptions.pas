{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{           FireDAC design time setup dialog            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.DesignTimeOptions;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
    Vcl.ComCtrls,
  FireDAC.VCLUI.OptsBase, FireDAC.Stan.Intf, FireDAC.Phys.Intf;

type
  TfrmFDGUIxFormsDesignTimeOptions = class(TfrmFDGUIxFormsOptsBase)
    btnRefreshMetadata: TButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtCatalog: TEdit;
    edtSchema: TEdit;
    GroupBox2: TGroupBox;
    cbMy: TCheckBox;
    cbSystem: TCheckBox;
    cbOther: TCheckBox;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    edtMask: TEdit;
    GroupBox4: TGroupBox;
    cbTable: TCheckBox;
    cbView: TCheckBox;
    cbSynonym: TCheckBox;
    cbTempTable: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox5: TGroupBox;
    cbTraceDT: TCheckBox;
    GroupBox6: TGroupBox;
    cbDClickFE: TCheckBox;
    cbFullName: TCheckBox;
    procedure btnRefreshMetadataClick(Sender: TObject);
  public
    class function Execute: Boolean;
  end;

var
  GADDTCatalog, GADDTSchema: String;
  GADDTScope: TFDPhysObjectScopes;
  GADDTMask: String;
  GADDTTableKinds: TFDPhysTableKinds;
  GADDTFullName: Boolean;
  GADMoniEnabled: Boolean;
  GADDCFieldsEditor: Boolean;

implementation

{$R *.dfm}

uses
  FireDAC.Stan.Consts, FireDAC.Stan.Util,
  FireDAC.Comp.Client;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsDesignTimeOptions.btnRefreshMetadataClick(Sender: TObject);
begin
  FDManager.RefreshMetadataCache;
end;

{ --------------------------------------------------------------------------- }
class function TfrmFDGUIxFormsDesignTimeOptions.Execute: Boolean;
var
  oOpts: TfrmFDGUIxFormsDesignTimeOptions;
  oConf: TFDConfigFile;
begin
  oOpts := TfrmFDGUIxFormsDesignTimeOptions.Create(nil);
  try
    oOpts.edtCatalog.Text := GADDTCatalog;
    oOpts.edtSchema.Text := GADDTSchema;
    oOpts.cbMy.Checked := osMy in GADDTScope;
    oOpts.cbSystem.Checked := osSystem in GADDTScope;
    oOpts.cbOther.Checked := osOther in GADDTScope;
    oOpts.edtMask.Text := GADDTMask;
    oOpts.cbTable.Checked := tkTable in GADDTTableKinds;
    oOpts.cbView.Checked := tkView in GADDTTableKinds;
    oOpts.cbSynonym.Checked := tkSynonym in GADDTTableKinds;
    oOpts.cbTempTable.Checked := tkTempTable in GADDTTableKinds;
    oOpts.cbFullName.Checked := GADDTFullName;
    oOpts.cbTraceDT.Checked := GADMoniEnabled;
    oOpts.cbDClickFE.Checked := GADDCFieldsEditor;
    Result := oOpts.ShowModal = mrOk;
    if Result then begin
      GADDTCatalog := oOpts.edtCatalog.Text;
      GADDTSchema := oOpts.edtSchema.Text;
      GADDTScope := [];
      if oOpts.cbMy.Checked then
        Include(GADDTScope, osMy);
      if oOpts.cbSystem.Checked then
        Include(GADDTScope, osSystem);
      if oOpts.cbOther.Checked then
        Include(GADDTScope, osOther);
      GADDTMask := oOpts.edtMask.Text;
      GADDTTableKinds := [];
      if oOpts.cbTable.Checked then
        Include(GADDTTableKinds, tkTable);
      if oOpts.cbView.Checked then
        Include(GADDTTableKinds, tkView);
      if oOpts.cbSynonym.Checked then
        Include(GADDTTableKinds, tkSynonym);
      if oOpts.cbTempTable.Checked then
        Include(GADDTTableKinds, tkTempTable);
      GADDTFullName := oOpts.cbFullName.Checked;
      GADMoniEnabled := oOpts.cbTraceDT.Checked;
      GADDCFieldsEditor := oOpts.cbDClickFE.Checked;
      oConf := TFDConfigFile.Create(False);
      try
        oConf.WriteString(S_FD_DesignTime, S_FD_DTCatalog, GADDTCatalog);
        oConf.WriteString(S_FD_DesignTime, S_FD_DTSchema, GADDTSchema);
        oConf.WriteInteger(S_FD_DesignTime, S_FD_DTScope, Longword(Pointer(@GADDTScope)^));
        oConf.WriteString(S_FD_DesignTime, S_FD_DTMask, GADDTMask);
        oConf.WriteInteger(S_FD_DesignTime, S_FD_DTTableKinds, Longword(Pointer(@GADDTTableKinds)^));
        oConf.WriteBool(S_FD_DesignTime, S_FD_DTFullName, GADDTFullName);
        oConf.WriteBool(S_FD_DesignTime, S_FD_DTTracing, GADMoniEnabled);
        oConf.WriteBool(S_FD_DesignTime, S_FD_DTDCFieldsEditor, GADDCFieldsEditor);
      finally
        FDFree(oConf);
      end;
    end;
  finally
    FDFree(oOpts);
  end;
end;

{ --------------------------------------------------------------------------- }
procedure Init;
var
  i: Integer;
  oConf: TFDConfigFile;
begin
  oConf := TFDConfigFile.Create(True);
  try
    if oConf.SectionExists(S_FD_DesignTime) then begin
      GADDTCatalog := oConf.ReadString(S_FD_DesignTime, S_FD_DTCatalog, '');
      GADDTSchema := oConf.ReadString(S_FD_DesignTime, S_FD_DTSchema, '');
      i := oConf.ReadInteger(S_FD_DesignTime, S_FD_DTScope, 0);
      GADDTScope := TFDPhysObjectScopes(Pointer(@i)^);
      GADDTMask := oConf.ReadString(S_FD_DesignTime, S_FD_DTMask, '');
      i := oConf.ReadInteger(S_FD_DesignTime, S_FD_DTTableKinds, 0);
      GADDTTableKinds := TFDPhysTableKinds(Pointer(@i)^);
      GADDTFullName := oConf.ReadBool(S_FD_DesignTime, S_FD_DTFullName, True);
      GADMoniEnabled := oConf.ReadBool(S_FD_DesignTime, S_FD_DTTracing, False);
      GADDCFieldsEditor := oConf.ReadBool(S_FD_DesignTime, S_FD_DTDCFieldsEditor, False);
    end
    else begin
      GADDTCatalog := '';
      GADDTSchema := '';
      GADDTScope := [osMy, osOther];
      GADDTMask := '';
      GADDTTableKinds := [tkSynonym, tkTable, tkView];
      GADDTFullName := True;
      GADMoniEnabled := False;
      GADDCFieldsEditor := False;
    end;
  finally
    FDFree(oConf);
  end;
end;

{ --------------------------------------------------------------------------- }
initialization
  Init;

end.
