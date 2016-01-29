unit D_Params;

{ $Id: d_params.PAS,v 1.4 2001/02/20 13:29:04 voba Exp $ }

// $Log: d_params.PAS,v $
// Revision 1.4  2001/02/20 13:29:04  voba
// Заменил rxSpin на vtSpin
//
// Revision 1.3  2000/12/15 16:21:58  law
// - вставлены директивы Log.
//

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, vtSpin, ExtCtrls;

type
  TBorderParamDlg = class(TForm)
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    spinTop: TvtSpinEdit;
    Label3: TLabel;
    spinBottom: TvtSpinEdit;
    Label4: TLabel;
    spinLeft: TvtSpinEdit;
    Label5: TLabel;
    SpinRight: TvtSpinEdit;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
    procedure SetTopIndent(Value: Integer);
    function GetTopIndent: Integer;
    procedure SetBottomIndent(Value: Integer);
    function GetBottomIndent: Integer;
    procedure SetLeftIndent(Value: Integer);
    function GetLeftIndent: Integer;
    procedure SetRightIndent(Value: Integer);
    function GetRightIndent: Integer;
  public
    { Public declarations }
    property TopIndent: Integer
      read GetTopIndent write SetTopIndent;
    property BottomIndent: Integer
      read GetBottomIndent write SetBottomIndent;
    property LeftIndent: Integer
      read GetLeftIndent write SetLeftIndent;
    property RightIndent: Integer
      read GetRightIndent write SetRightIndent;
  end;

var
  BorderParamDlg: TBorderParamDlg;

implementation

{$R *.DFM}

procedure TBorderParamDlg.SetTopIndent(Value: Integer);
begin
  if spinTop.AsInteger <> Value then
    spinTop.AsInteger:= Value;
end;

function TBorderParamDlg.GetTopIndent: Integer;
begin
  Result:= spinTop.AsInteger;
end;

procedure TBorderParamDlg.SetBottomIndent(Value: Integer);
begin
  if spinBottom.AsInteger <> Value then
    spinBottom.AsInteger:= Value;
end;

function TBorderParamDlg.GetBottomIndent: Integer;
begin
  Result:= spinBottom.AsInteger;
end;

procedure TBorderParamDlg.SetLeftIndent(Value: Integer);
begin
  if spinLeft.AsInteger <> Value then
    spinLeft.AsInteger:= Value;
end;

function TBorderParamDlg.GetLeftIndent: Integer;
begin
  Result:= spinLeft.AsInteger;
end;

procedure TBorderParamDlg.SetRightIndent(Value: Integer);
begin
  if spinRight.AsInteger <> Value then
    spinRight.AsInteger:= Value;
end;

function TBorderParamDlg.GetRightIndent: Integer;
begin
  Result:= spinRight.AsInteger;
end;



end.
