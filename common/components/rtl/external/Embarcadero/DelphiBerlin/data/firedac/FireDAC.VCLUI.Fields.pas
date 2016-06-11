{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC GUIx Field list editor             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.Fields;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  FireDAC.VCLUI.OptsBase, FireDAC.VCLUI.Controls;

type
  TfrmFDGUIxFormsFields = class(TfrmFDGUIxFormsOptsBase)
    lbFields: TFDGUIxFormsDblListBox;
  private
    function GetFields: String;
    procedure SetDSFields(ADataSet: TDataSet; AFields: String);
  public
    class function EditFields(var AFields: String; ADataSet: TDataSet;
      ACaption: String): Boolean;
  end;

var
  frmFDGUIxFormsFields: TfrmFDGUIxFormsFields;

implementation

uses
  FireDAC.Stan.Util;

{$R *.dfm}

{-------------------------------------------------------------------------------}
function TfrmFDGUIxFormsFields.GetFields: String;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to lbFields.DstItems.Count - 1 do begin
    if Result <> '' then
      Result := Result + ';';
    Result := Result + lbFields.DstItems[i];
  end;
end;

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
procedure TfrmFDGUIxFormsFields.SetDSFields(ADataSet: TDataSet; AFields: String);
var
  j, i: Integer;
  s: String;
begin
  lbFields.DstItems.BeginUpdate;
  lbFields.SrcItems.BeginUpdate;
  try
    lbFields.DstItems.Clear;
    lbFields.SrcItems.Clear;
    if ADataSet <> nil then begin
      ADataSet.GetFieldNames(lbFields.SrcItems);
      i := 1;
      while i <= Length(AFields) do begin
        s := ExtractFieldName(AFields, i);
        j := lbFields.SrcItems.IndexOf(s);
        if j <> -1 then begin
          lbFields.SrcItems.Delete(j);
          lbFields.DstItems.Add(s);
        end;
      end;
    end;
  finally
    lbFields.DstItems.EndUpdate;
    lbFields.SrcItems.EndUpdate;
  end;
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
class function TfrmFDGUIxFormsFields.EditFields(var AFields: String;
  ADataSet: TDataSet; ACaption: String): Boolean;
var
  oFrm: TfrmFDGUIxFormsFields;
begin
  oFrm := TfrmFDGUIxFormsFields.Create(nil);
  try
    oFrm.SetDSFields(ADataSet, AFields);
    oFrm.lblPrompt.Caption := ACaption;
    Result := oFrm.ShowModal = mrOK;
    if Result then
      AFields := oFrm.GetFields;
  finally
    FDFree(oFrm);
  end;
end;

end.
