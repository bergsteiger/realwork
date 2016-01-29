unit D_ID;

{ Автор: Люлин А.В. ©     }
{ Модуль: D_ID -          }
{ Начат: 24.10.2000 17:55 }
{ $Id: D_ID.pas,v 1.5 2001/05/24 14:29:52 law Exp $ }

// $Log: D_ID.pas,v $
// Revision 1.5  2001/05/24 14:29:52  law
// - new behavior: подстраиваемся под изменения Вована, относительно PopupWindow.
//
// Revision 1.4  2001/05/07 08:54:36  law
// - new behavior: Tl3Tree ->Il3RootNode.
// - cleanup: убраны ненужные ссылки на RXSpin.
//
// Revision 1.3  2001/02/21 12:27:19  law
// - добавлен диалог со свойствами документа.
//
// Revision 1.2  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, OvcBase, l3Types, vtSpin, D_Base;

type
  TIDDlg = class(TBaseDlg)
    edtNum: TvtSpinEdit;
    Label2: TLabel;
  private

  public
  
  end;

implementation

{$R *.DFM}

end.
