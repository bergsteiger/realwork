{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dSize;
{$I dc.inc}
interface

uses
  dcsystem,SysUtils, windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,dcgen, dccommon, dcdreamlib,
  dcconsts, consts;

type
  TSizeForm = class(TForm)
    HorizontalSize: TRadioGroup;
    SizeWidth: TEdit;
    VerticalSize: TRadioGroup;
    SizeHeight: TEdit;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    procedure SizeWidthEnter(Sender: TObject);
    procedure SizeHeightEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SizeForm: TSizeForm;

Function SizeWasChanged(Var xsizechange, ysizechange:Integer):Boolean;

implementation
{$R *.DFM}

{---------------------------------------------------------}

const
  sizing : array [0 .. 2] of integer = (scNoChange, scShrinkToSmallest, scGrowToLargest);

Function SizeWasChanged(Var xsizechange, ysizechange:Integer):Boolean;
begin
  xsizechange:=scNoChange;
  ysizechange:=scNoChange;

  with TSizeForm.Create(Application) do
  begin
    HorizontalSize.ItemIndex := 0;
    VerticalSize.ItemIndex := 0;
    Result:=(ShowModal = idOK);
    if Result then
      try
        if SizeWidth.Text = '' then SizeWidth.Text := '0';
        if SizeHeight.Text = '' then SizeHeight.Text := '0';

        if HorizontalSize.ItemIndex = 3 then
          xsizechange := StrToInt(SizeWidth.Text)
        else
          xsizechange := sizing[HorizontalSize.ItemIndex];

        if VerticalSize.ItemIndex = 3 then
          ysizechange := StrToInt(SizeHeight.Text)
        else
          ysizechange := sizing[VerticalSize.ItemIndex];
      finally
        Free;
      end;
  end;
end;

{---------------------------------------------------------}

procedure TSizeForm.SizeWidthEnter(Sender: TObject);
begin
  HorizontalSize.ItemIndex := 3;
end;

{---------------------------------------------------------}

procedure TSizeForm.SizeHeightEnter(Sender: TObject);
begin
  VerticalSize.ItemIndex := 3;
end;

procedure TSizeForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  Caption :=  SSize ;
  with HorizontalSize do
  begin
    Caption := SWidth;
    Items.Text := SHorizontalSize;
  end;
  with VerticalSize do
  begin
    Caption := SHeight;
    Items.Text := SVerticalSize;
  end;
  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
end;

end.
