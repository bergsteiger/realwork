unit

 d_GetContents;

{ $Id: d_GetContents.pas,v 1.9 2012/06/05 07:54:22 dinishev Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, StdCtrls, vtSpin, Buttons, ExtCtrls;

type
  TContentsEditDlg = class(TBottomBtnDlg)
    edtValue6: TvtSpinEdit;
    lblText: TLabel;
    Label1: TLabel;                                                                       
    edtCompareContentsLevel: TvtSpinEdit;
   private
    function  GetValue6 : Integer;
    function pm_GetCompareContentsLevel: Integer;
    procedure pm_SetCompareContentsLevel(const Value: Integer);
    procedure SetValue6(aValue : Integer);
   public
    property CompareContentsLevel: Integer read pm_GetCompareContentsLevel write pm_SetCompareContentsLevel;
    property Level6 : Integer read GetValue6 write SetValue6;
  end;

function RequestContents(var theLevel6, theCompareContentsLevel : Integer; aOwner: TComponent): Boolean;

implementation

uses
 l3Types;

{$R *.DFM}

function RequestContents(var theLevel6, theCompareContentsLevel : Integer; aOwner: TComponent): Boolean;
begin
 with TContentsEditDlg.Create(AOwner) do
  try
   Level6 := theLevel6;
   CompareContentsLevel := theCompareContentsLevel;
   Result := Execute;
   if Result then
   begin
    theLevel6 := Level6;
    theCompareContentsLevel := CompareContentsLevel;
   end;
  finally
   Free;
  end;
end;

function  TContentsEditDlg.GetValue6 : Integer;
begin
 Result := edtValue6.AsInteger;
end;

function TContentsEditDlg.pm_GetCompareContentsLevel: Integer;
begin
 Result := edtCompareContentsLevel.AsInteger;
end;

procedure TContentsEditDlg.pm_SetCompareContentsLevel(const Value: Integer);
begin
 if Value > 0 then
  edtCompareContentsLevel.Value := Value
 else
  edtCompareContentsLevel.Text := '';
end;

procedure TContentsEditDlg.SetValue6(aValue : Integer);
begin
 if aValue <> Pred(High(Long)) then
  edtValue6.Value := aValue
 else
  edtValue6.Text := '';
end;

end.
