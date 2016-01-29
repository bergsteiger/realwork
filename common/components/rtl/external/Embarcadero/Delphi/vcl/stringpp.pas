{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit StringPP;

interface

uses System.SysUtils, Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Forms, System.Win.ComServ, System.Win.ComObj, Vcl.AxCtrls, Winapi.ActiveX, StdMain;

type
  TStringsPropPage = class(TPropertyPage)
    ClearBtn: TButton;
    StaticText2: TStaticText;
    PropName: TComboBox;
    StringMemo: TMemo;
    Label1: TLabel;
    procedure ClearBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PropNameChange(Sender: TObject);
    procedure PropNameClick(Sender: TObject);
  private
    ApplyList: TPropApplyList;
  public
    procedure UpdatePropertyPage; override;
    procedure UpdateObject; override;
  end;

implementation

uses System.Win.StdVCL;

{$R *.dfm}

procedure TStringsPropPage.UpdatePropertyPage;
begin
  EnumCtlProps(IStrings, PropName.Items);
  PropName.Enabled := PropName.Items.Count <> 0;
  if PropName.Enabled then
  begin
    PropName.ItemIndex := 0;
    PropNameChange(Self);
  end
  else begin
    StringMemo.Enabled := False;
    ClearBtn.Enabled := False;
  end;
end;

procedure TStringsPropPage.UpdateObject;
var
  i: Integer;
begin
  PropNameClick(Self);
  for i := 0 to ApplyList.Count - 1 do
    SetDispatchPropValue(IUnknown(OleObject) as IDispatch, ApplyList.Props[i]^.PropId,
      ApplyList.Props[i]^.PropValue);
  ApplyList.ClearProps;
end;

procedure TStringsPropPage.ClearBtnClick(Sender: TObject);
begin
  StringMemo.Lines.Clear;
  Modified;
end;

procedure TStringsPropPage.PropNameChange(Sender: TObject);
var
  Strs: IStrings;
begin
  Strs := IUnknown(GetDispatchPropValue(IUnknown(OleObject) as IDispatch,
    Integer(PropName.Items.Objects[PropName.ItemIndex]))) as IStrings;
  SetOleStrings(StringMemo.Lines, Strs);
end;

procedure TStringsPropPage.PropNameClick(Sender: TObject);
var
  Strs: IStrings;
begin
  GetOleStrings(StringMemo.Lines, Strs);
  ApplyList.AddProp(Integer(PropName.Items.Objects[PropName.ItemIndex]), Strs);
  Modified;
end;

procedure TStringsPropPage.FormCreate(Sender: TObject);
begin
  ApplyList := TPropApplyList.Create;
end;

procedure TStringsPropPage.FormDestroy(Sender: TObject);
begin
  ApplyList.Free;
end;

initialization
  TActiveXPropertyPageFactory.Create(
    ComServer,
    TStringsPropPage,
    Class_DStringPropPage);
end.
