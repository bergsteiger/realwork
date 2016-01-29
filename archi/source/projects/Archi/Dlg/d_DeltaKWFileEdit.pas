unit d_DeltaKWFileEdit;

{ $Id: d_DeltaKWFileEdit.pas,v 1.2 2013/04/19 13:05:03 lulin Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, StdCtrls, vtSpin, Buttons, ExtCtrls, Mask, ToolEdit;

type
  TDeltaKWFileEditDlg = class(TBottomBtnDlg)
    lblText: TLabel;
    edtDeltaFileName: TFilenameEdit;
    Label1: TLabel;
    edtKillFileName: TFilenameEdit;
   private
   public
  end;

function RequestDeltaKWFileNames(aOwner: TComponent; var DeltaKW, KillKW: AnsiString): Boolean;

implementation

{$R *.DFM}

function RequestDeltaKWFileNames(aOwner: TComponent; var DeltaKW, KillKW: AnsiString): Boolean;

begin
 with TDeltaKWFileEditDlg.Create(AOwner) do
 try
   Result := Execute and (edtDeltaFileName.Text <> '') and (edtKillFileName.Text <> '');
   if Result then
   begin
    DeltaKW := edtDeltaFileName.Text;
    KillKW := edtKillFileName.Text;
   end; // Result
 finally
   Free;
 end;
end;

end.
