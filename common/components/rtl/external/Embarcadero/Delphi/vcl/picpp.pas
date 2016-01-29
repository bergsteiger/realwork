{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit PicPP;

interface

uses System.SysUtils, Winapi.ActiveX, Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Forms, System.Win.ComServ, System.Win.ComObj, Vcl.AxCtrls, Vcl.FileCtrl, Vcl.Dialogs,
  Vcl.ExtDlgs, StdMain;

type
  TPicturePropPage = class(TPropertyPage)
    StaticText1: TStaticText;
    PropName: TComboBox;
    BrowseBtn: TButton;
    StaticText2: TStaticText;
    Bevel1: TBevel;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure BrowseBtnClick(Sender: TObject);
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

procedure TPicturePropPage.UpdatePropertyPage;
begin
  EnumCtlProps(IPictureDisp, PropName.Items);
  PropName.Enabled := PropName.Items.Count <> 0;
  if PropName.Enabled then
  begin
    PropName.ItemIndex := 0;
    PropNameChange(Self);
  end
  else
    BrowseBtn.Enabled := False;
end;

procedure TPicturePropPage.UpdateObject;
var
  i: Integer;
begin
  for i := 0 to ApplyList.Count - 1 do
    SetDispatchPropValue(IUnknown(OleObject) as IDispatch, ApplyList.Props[i]^.PropId,
      ApplyList.Props[i]^.PropValue);
  ApplyList.ClearProps;
end;

procedure TPicturePropPage.BrowseBtnClick(Sender: TObject);
var
  Pic: IPictureDisp;
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    GetOlePicture(Image1.Picture, Pic);
    ApplyList.AddProp(Integer(PropName.Items.Objects[PropName.ItemIndex]), Pic);
    Modified;
  end;
end;

procedure TPicturePropPage.PropNameChange(Sender: TObject);
var
  Pic: IPictureDisp;
begin
  Pic := IUnknown(GetDispatchPropValue(IUnknown(OleObject) as IDispatch,
    Integer(PropName.Items.Objects[PropName.ItemIndex]))) as IPictureDisp;
  SetOlePicture(Image1.Picture, Pic);
end;

procedure TPicturePropPage.FormCreate(Sender: TObject);
begin
  ApplyList := TPropApplyList.Create;
end;

procedure TPicturePropPage.FormDestroy(Sender: TObject);
begin
  ApplyList.Free;
end;

initialization
  TActiveXPropertyPageFactory.Create(
    ComServer,
    TPicturePropPage,
    Class_DPicturePropPage);
end.
