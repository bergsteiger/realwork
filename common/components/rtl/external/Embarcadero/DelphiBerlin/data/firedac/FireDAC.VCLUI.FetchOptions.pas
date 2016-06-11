{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC fetch options editing frame          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.FetchOptions;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Option, 
  FireDAC.VCLUI.Controls;

type
  TfrmFDGUIxFormsFetchOptions = class(TFrame)
    fo_gbItems: TPanel;
    fo_cbIBlobs: TCheckBox;
    fo_cbIDetails: TCheckBox;
    fo_cbIMeta: TCheckBox;
    fo_gbCache: TPanel;
    fo_cbCBlobs: TCheckBox;
    fo_cbCDetails: TCheckBox;
    fo_cbCMeta: TCheckBox;
    fo_GroupBox1: TPanel;
    fo_Label1: TLabel;
    fo_Label3: TLabel;
    fo_Label2: TLabel;
    fo_edtRecsMax: TEdit;
    fo_edtRowSetSize: TEdit;
    fo_cbxMode: TComboBox;
    fo_cbAutoClose: TCheckBox;
    fo_Label4: TLabel;
    fo_cbxRecordCountMode: TComboBox;
    fo_cbUnidirectional: TCheckBox;
    Label1: TLabel;
    fo_cbxCursor: TComboBox;
    fo_cbxFetchAll: TComboBox;
    fo_Label5: TLabel;
    fo_gbMasterDetail: TPanel;
    Label2: TLabel;
    fo_edtDetailDelay: TEdit;
    fo_cbDetailOptimize: TCheckBox;
    fo_cbDetailCascade: TCheckBox;
    fo_gbLiveDataWindow: TPanel;
    fo_cbLiveWindowParanoic: TCheckBox;
    fo_cbLiveWindowFastFirst: TCheckBox;
    procedure fo_Change(Sender: TObject);
  private
    FOnModified: TNotifyEvent;
    FModifiedLocked: Boolean;
  public
    procedure LoadFrom(AOpts: TFDFetchOptions);
    procedure SaveTo(AOpts: TFDFetchOptions);
  published
    property OnModified: TNotifyEvent read FOnModified write FOnModified;
  end;

implementation

{$R *.dfm}

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFetchOptions.LoadFrom(AOpts: TFDFetchOptions);
begin
  FModifiedLocked := True;
  try
    fo_cbxMode.ItemIndex := Integer(AOpts.Mode);
    fo_cbxCursor.ItemIndex := Integer(AOpts.CursorKind);
    fo_cbUnidirectional.Checked := AOpts.Unidirectional;
    fo_edtRowSetSize.Text := IntToStr(AOpts.RowsetSize);
    fo_edtRecsMax.Text := IntToStr(AOpts.RecsMax);
    fo_cbAutoClose.Checked := AOpts.AutoClose;
    fo_cbxFetchAll.ItemIndex := Integer(AOpts.AutoFetchAll);
    fo_cbxRecordCountMode.ItemIndex := Integer(AOpts.RecordCountMode);
    fo_cbIBlobs.Checked := fiBlobs in AOpts.Items;
    fo_cbIDetails.Checked := fiDetails in AOpts.Items;
    fo_cbIMeta.Checked := fiMeta in AOpts.Items;
    fo_cbCBlobs.Checked := fiBlobs in AOpts.Cache;
    fo_cbCDetails.Checked := fiDetails in AOpts.Cache;
    fo_cbCMeta.Checked := fiMeta in AOpts.Cache;
    fo_edtDetailDelay.Text := IntToStr(AOpts.DetailDelay);
    fo_cbDetailOptimize.Checked := AOpts.DetailOptimize;
    fo_cbDetailCascade.Checked := AOpts.DetailCascade;
    fo_cbLiveWindowParanoic.Checked := AOpts.LiveWindowParanoic;
    fo_cbLiveWindowFastFirst.Checked := AOpts.LiveWindowFastFirst;
  finally
    FModifiedLocked := False;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFetchOptions.SaveTo(AOpts: TFDFetchOptions);
var
  i: TFDFetchItems;
  j: Integer;
begin
  if AOpts.Mode <> TFDFetchMode(fo_cbxMode.ItemIndex) then
    AOpts.Mode := TFDFetchMode(fo_cbxMode.ItemIndex);
  if AOpts.CursorKind <> TFDCursorKind(fo_cbxCursor.ItemIndex) then
    AOpts.CursorKind := TFDCursorKind(fo_cbxCursor.ItemIndex);
  if AOpts.Unidirectional <> fo_cbUnidirectional.Checked then
    AOpts.Unidirectional := fo_cbUnidirectional.Checked;
  j := StrToInt(fo_edtRowSetSize.Text);
  if AOpts.RowsetSize <> j then
    AOpts.RowsetSize := j;
  j := StrToInt(fo_edtRecsMax.Text);
  if AOpts.RecsMax <> j then
    AOpts.RecsMax := j;
  if AOpts.AutoClose <> fo_cbAutoClose.Checked then
    AOpts.AutoClose := fo_cbAutoClose.Checked;
  if AOpts.AutoFetchAll <> TFDAutoFetchAll(fo_cbxFetchAll.ItemIndex) then
    AOpts.AutoFetchAll := TFDAutoFetchAll(fo_cbxFetchAll.ItemIndex);
  if AOpts.RecordCountMode <> TFDRecordCountMode(fo_cbxRecordCountMode.ItemIndex) then
    AOpts.RecordCountMode := TFDRecordCountMode(fo_cbxRecordCountMode.ItemIndex);
  i := [];
  if fo_cbIBlobs.Checked then
    Include(i, fiBlobs);
  if fo_cbIDetails.Checked then
    Include(i, fiDetails);
  if fo_cbIMeta.Checked then
    Include(i, fiMeta);
  if AOpts.Items <> i then
    AOpts.Items := i;
  i := [];
  if fo_cbCBlobs.Checked then
    Include(i, fiBlobs);
  if fo_cbCDetails.Checked then
    Include(i, fiDetails);
  if fo_cbCMeta.Checked then
    Include(i, fiMeta);
  if AOpts.Cache <> i then
    AOpts.Cache := i;
  j := StrToInt(fo_edtDetailDelay.Text);
  if AOpts.DetailDelay <> j then
    AOpts.DetailDelay := j;
  if AOpts.DetailOptimize <> fo_cbDetailOptimize.Checked then
    AOpts.DetailOptimize := fo_cbDetailOptimize.Checked;
  if AOpts.DetailCascade <> fo_cbDetailCascade.Checked then
    AOpts.DetailCascade := fo_cbDetailCascade.Checked;
  if AOpts.LiveWindowParanoic <> fo_cbLiveWindowParanoic.Checked then
    AOpts.LiveWindowParanoic := fo_cbLiveWindowParanoic.Checked;
  if AOpts.LiveWindowFastFirst <> fo_cbLiveWindowFastFirst.Checked then
    AOpts.LiveWindowFastFirst := fo_cbLiveWindowFastFirst.Checked;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFetchOptions.fo_Change(Sender: TObject);
begin
  if not FModifiedLocked and Assigned(FOnModified) then
    FOnModified(Self);
end;

end.
