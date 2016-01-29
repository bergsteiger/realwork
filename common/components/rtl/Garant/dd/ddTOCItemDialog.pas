//..........................................................................................................................................................................................................................................................
unit ddTOCItemDialog;

{* Окошко для редактирования элемента оглавления }

// $Id: ddTOCItemDialog.pas,v 1.3 2005/02/16 17:10:41 narry Exp $

// $Log: ddTOCItemDialog.pas,v $
// Revision 1.3  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.2  2003/04/19 12:30:38  law
// - new file: ddDefine.inc.
//
// Revision 1.1  2002/10/01 12:21:39  narry
// Окошко редактирования элемента оглавления
//

{$I ddDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TTOCItemEditDlg = class(TForm)
    memoItemEdit: TMemo;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
   function Execute: Boolean;
  end;

var
  TOCItemEditDlg: TTOCItemEditDlg;

implementation

{$R *.dfm}

function TTOCItemEditDlg.Execute: Boolean;
begin
 Result:= ShowModal = mrOk
end;

end.
