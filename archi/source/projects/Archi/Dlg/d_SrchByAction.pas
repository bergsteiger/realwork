unit d_SrchByAction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Mask, vtCombo, vtDateEdit, Buttons,
  ExtCtrls;

type
  TSrchByActionDlg = class(TBottomBtnDlg)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    edtLowDate: TvtDateEdit;
    edtHighDate: TvtDateEdit;
  public
    constructor Create(aOwner : TComponent; aCaption : String); reintroduce;
  end;

implementation

{$R *.dfm}

 constructor TSrchByActionDlg.Create(aOwner : TComponent; aCaption : String); 
 begin
  Inherited Create(aOwner);
  if aCaption <> '' then
   Caption := aCaption;
 end;
end.
