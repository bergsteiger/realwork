{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit ColorPP;

interface

uses System.SysUtils, Winapi.ActiveX, Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Forms, System.Win.ComServ, System.Win.ComObj, Vcl.AxCtrls, Vcl.ColorGrd, Vcl.Dialogs, StdMain;

type
  TColorPropPage = class(TPropertyPage)
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    PropName: TComboBox;
    SysColor: TComboBox;
    ColorBtn: TButton;
    ColorDialog1: TColorDialog;
    Panel1: TPanel;
    procedure ColorBtnClick(Sender: TObject);
    procedure SysColorChange(Sender: TObject);
    procedure PropNameChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ApplyList: TPropApplyList;
  public
    procedure UpdatePropertyPage; override;
    procedure UpdateObject; override;
  end;

implementation

{$R *.dfm}

const
  TColorArray: array[0..24] of TColor = (
    clScrollBar,
    clBackground,
    clActiveCaption,
    clInactiveCaption,
    clMenu,
    clWindow,
    clWindowFrame,
    clMenuText,
    clWindowText,
    clCaptionText,
    clActiveBorder,
    clInactiveBorder,
    clAppWorkSpace,
    clHighlight,
    clHighlightText,
    clBtnFace,
    clBtnShadow,
    clGrayText,
    clBtnText,
    clInactiveCaptionText,
    clBtnHighlight,
    cl3DDkShadow,
    cl3DLight,
    clInfoText,
    clInfoBk);

procedure TColorPropPage.UpdatePropertyPage;
begin
  EnumCtlProps(GUID_OLE_COLOR, PropName.Items);
  PropName.Enabled := PropName.Items.Count > 0;
  if PropName.Enabled then
  begin
    PropName.ItemIndex := 0;
    PropNameChange(Self);
  end
  else begin
    SysColor.Enabled := False;
    ColorBtn.Enabled := False;
  end;
end;

procedure TColorPropPage.UpdateObject;
var
  i: Integer;
begin
  for i := 0 to ApplyList.Count - 1 do
    SetDispatchPropValue(IUnknown(OleObject) as IDispatch, ApplyList.Props[i]^.PropId,
      ApplyList.Props[i]^.PropValue);
  ApplyList.ClearProps;
end;

procedure TColorPropPage.ColorBtnClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    Panel1.Color:= ColorDialog1.Color;
    SysColor.Text:= '';
    ApplyList.AddProp(Integer(PropName.Items.Objects[PropName.ItemIndex]),
      Panel1.Color);
    Modified;
  end;
end;

procedure TColorPropPage.SysColorChange(Sender: TObject);
begin
  if SysColor.Text <> '' then
  begin
    Panel1.Color:= TColorArray[SysColor.ItemIndex];
    ApplyList.AddProp(Integer(PropName.Items.Objects[PropName.ItemIndex]),
      Panel1.Color);
    Modified;
  end;
end;

procedure TColorPropPage.PropNameChange(Sender: TObject);
begin
  Panel1.Color := GetDispatchPropValue(IUnknown(OleObject) as IDispatch,
    Integer(PropName.Items.Objects[PropName.ItemIndex]));
end;

procedure TColorPropPage.FormCreate(Sender: TObject);
begin
  ApplyList := TPropApplyList.Create;
end;

procedure TColorPropPage.FormDestroy(Sender: TObject);
begin
  ApplyList.Free;
end;

initialization
  TActiveXPropertyPageFactory.Create(
    ComServer,
    TColorPropPage,
    Class_DColorPropPage);
end.
