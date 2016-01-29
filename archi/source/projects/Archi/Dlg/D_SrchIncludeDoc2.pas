unit D_SrchIncludeDoc2;

{ $Id: D_SrchIncludeDoc2.pas,v 1.2 2005/05/30 10:28:39 lulin Exp $ }

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

Uses
  DT_User;

end.
