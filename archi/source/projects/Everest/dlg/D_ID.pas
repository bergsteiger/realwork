unit D_ID;

{ �����: ����� �.�. �     }
{ ������: D_ID -          }
{ �����: 24.10.2000 17:55 }
{ $Id: D_ID.pas,v 1.5 2001/05/24 14:29:52 law Exp $ }

// $Log: D_ID.pas,v $
// Revision 1.5  2001/05/24 14:29:52  law
// - new behavior: �������������� ��� ��������� ������, ������������ PopupWindow.
//
// Revision 1.4  2001/05/07 08:54:36  law
// - new behavior: Tl3Tree ->Il3RootNode.
// - cleanup: ������ �������� ������ �� RXSpin.
//
// Revision 1.3  2001/02/21 12:27:19  law
// - �������� ������ �� ���������� ���������.
//
// Revision 1.2  2000/12/15 16:22:06  law
// - ��������� ��������� Log.
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
