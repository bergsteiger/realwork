unit D_MDILst;

{ $Id: D_MDILST.PAS,v 1.11 2007/12/05 13:51:29 lulin Exp $ }

// $Log: D_MDILST.PAS,v $
// Revision 1.11  2007/12/05 13:51:29  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.9.2.1  2006/12/21 16:22:30  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.9  2005/05/30 14:13:56  lulin
// - bug fix: не компилировалось.
//
// Revision 1.8  2005/05/27 14:44:27  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.7  2004/03/15 14:22:46  law
// - change: переделки в связи с изменением библиотек компонентов.
//
// Revision 1.6  2002/11/22 15:01:21  law
// - tuning.
//
// Revision 1.5  2002/07/16 15:45:54  law
// - some refactoring.
//
// Revision 1.4  2002/04/06 11:33:55  law
// - Delphi 6.0.
//
// Revision 1.3.2.1  2001/10/03 06:29:37  law
// - new project: EverestLite 2001.
//
// Revision 1.3  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, OvcBase, vtLister,  D_Base, vtStringLister,
  afwControl, afwInputControl;

type
  TMDIListDlg = class(TBaseDlg)
    lstMDIChildren: TvtStringLister;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure lstMDIChildrenActionElement(Sender: TObject; Index: Longint);
    function lstMDIChildrenGetItemImageIndex(Sender: TObject;
      Index: Integer): Integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure Execute;

implementation

uses
  Messages,
  l3Base,

  MainEditor
  ;

procedure Execute;
var
 D : TMDIListDlg;
begin
 D := TMDIListDlg.Create(Application);
 try
  D.ShowModal;
 finally
  l3Free(D);
 end;{try..finally}
end;

{$R *.DFM}

procedure TMDIListDlg.FormCreate(Sender: TObject);
var
 i : LongInt;
begin
 if (MainForm.MDIChildCount > 0) then for i := 0 to Pred(MainForm.MDIChildCount) do begin
  lstMDIChildren.Items.Add(MainForm.MDIChildren[i].Caption);
 end;
end;

procedure TMDIListDlg.FormShow(Sender: TObject);
begin
 lstMDIChildren.SetFocus;
end;

procedure TMDIListDlg.btOKClick(Sender: TObject);
begin
 inherited;
 if (MainForm.MDIChildCount > 0) then
  PostMessage(MainForm.ClientHandle, wm_MDIActivate,
              MainForm.MDIChildren[lstMDIChildren.Current].Handle, 0);
end;

procedure TMDIListDlg.lstMDIChildrenActionElement(Sender: TObject; Index: Longint);
begin
 btOKClick(Self);
 ModalResult := mrOk;
end;

function TMDIListDlg.lstMDIChildrenGetItemImageIndex(Sender: TObject;
  Index: Integer): Integer;
begin
 inherited;
 Result := 1;
end;

end.
