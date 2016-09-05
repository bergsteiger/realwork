unit D_SrchIncludeDoc2;

{ $Id: D_SrchIncludeDoc2.pas,v 1.3 2016/08/11 10:41:58 lukyanets Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, ToolEdit, vtHeader, vtCombo, vtDateEdit;

type
  TSrchIncludeDoc2Dlg = class(TForm)
    pnlButtons: TPanel;
    pnlButtonsRight: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    edtLowDate: TvtDateEdit;
    edtHighDate: TvtDateEdit;
    GroupBox2: TGroupBox;
    cbxAttach: TCheckBox;
    cbxAttachArh: TCheckBox;
    cbxChanged: TCheckBox;
    cbxAttachArhMos: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
