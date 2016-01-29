{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dAlign;
{$I dc.inc}
interface

uses
  dcsystem, dcconsts, consts, SysUtils, windows, Messages, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, dcgen, dccommon, dcdreamlib;

type
  TAlignmentForm = class(TForm)
    HorizontalAlignment: TRadioGroup;
    VerticalAlignment: TRadioGroup;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AlignmentForm: TAlignmentForm;

Function AlignWasChanged(Var HorAlign,VertAlign:TAlignControls):Boolean;

implementation
{$R *.DFM}

{------------------------------------------------------------------}

const
  horzaligns : array [0 .. 5] of TAlignControls = (acNoChange, acLefts, acCenters, acRights, acSpaceEqually, acCenterInWindow);
  vertaligns : array [0 .. 5] of TAlignControls = (acNoChange, acTops,  acCenters, acBottoms, acSpaceEqually, acCenterInWindow);

Function AlignWasChanged(Var HorAlign,VertAlign:TAlignControls):Boolean;
begin
  With TAlignmentForm.Create(Application) do
  try
    Result:=ShowModal=idOk;
    HorAlign:=HorzAligns[HorizontalAlignment.ItemIndex];
    VertAlign:=VertAligns[VerticalAlignment.ItemIndex];
  finally
    Free;
  end;
end;

{------------------------------------------------------------------}

procedure TAlignmentForm.FormShow(Sender: TObject);
begin
  HorizontalAlignment.ItemIndex := 0;
  VerticalAlignment.ItemIndex := 0;
end;

{------------------------------------------------------------------}

procedure TAlignmentForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  Caption := SAlignment;
  with HorizontalAlignment do
  begin
    Caption := SHorizontal;
    Items.Text := SHorizontalAlignment;
  end;
  with VerticalAlignment do
  begin
    Caption := SVertical;
    Items.Text := SVerticalAlignment;
  end;
  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
end;

end.
