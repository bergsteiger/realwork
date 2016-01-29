unit WinList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs,
  vtForm, OvcBase,  vtlister, Menus, ComCtrls, vtStatusBar, vtStringLister,
  afwControl, afwInputControl, afwControlPrim, afwBaseControl;

type
  TWinList = class(TvtForm)
    lstWinSet: TvtStringlister;
    PopupMenu1: TPopupMenu;
    miGoto: TMenuItem;
    miDel: TMenuItem;
    ListFooter: TvtStatusBar;
    procedure lstWinSetCurrentChanged(Sender: TObject; aNewCurrent, aOldCurrent: Integer);
    procedure lstWinSetActionElement(Sender: TObject; Index: Integer);
    procedure miDelClick(Sender: TObject);
    procedure miGotoClick(Sender: TObject);

  protected
    procedure ReadPlacement; override;
    procedure WritePlacement; override;

    function  DefaultCloseAction : TCloseAction; override;
  public
  end;

procedure RunSwitchWindow;

implementation

{$R *.dfm}

Uses
 l3IniFile, IniShop,
 StrShop,
 Main;

const
 cWinName = 'WinList';

procedure RunSwitchWindow;
var
 I     : Integer;
 aForm : TCustomForm;
begin
 with TWinList.Create(MainForm) do
 try
  for I := 0 to Pred(MainForm.MDIChildCount) do
  begin
   aForm := MainForm.MDIChildren[I];
   lstWinSet.Items.AddObject(aForm.Caption, aForm);
  end;
  if Execute then
  begin
   if lstWinSet.Items.Count = 0 then Exit;
   aForm := TForm(lstWinSet.Items.Objects[lstWinSet.Current]);
   PostMessage(MainForm.ClientHandle, WM_MDIActivate, Longint(aForm.Handle), 0);
   if (aForm.WindowState = wsMinimized) then aForm.WindowState := wsNormal;
  end; // if Execute then
 finally
  Free;
 end;
end;

function TWinList.DefaultCloseAction : TCloseAction;
begin
 Result := caHide;
end;

procedure TWinList.ReadPlacement;
begin
 if UserConfig = nil then Exit;
 UserConfig.Section := FormPlacement;
 UserConfig.ReadFormPlace(cWinName, Self);
end;

procedure TWinList.WritePlacement;
begin
 if UserConfig = nil then Exit;
 UserConfig.Section := FormPlacement;
 UserConfig.WriteFormPlace(cWinName, Self);
end;

procedure TWinList.lstWinSetCurrentChanged(Sender: TObject; aNewCurrent, aOldCurrent: Integer);
begin
 if lstWinSet.Total > 0 then
  ListFooter.Panels[0].Text := Format(scFmtFuterCounter,[Succ(aNewCurrent),lstWinSet.Total])
 else
  ListFooter.Panels[0].Text := '';
end;

procedure TWinList.lstWinSetActionElement(Sender: TObject; Index: Integer);
begin
 ModalResult := mrOk;
end;

procedure TWinList.miDelClick(Sender: TObject);
var
 lCurForm : TForm;
begin
 if (lstWinSet.Current < 0) then Exit;
 lCurForm := TForm(lstWinSet.Items.Objects[lstWinSet.Current]);
 lstWinSet.Items.Delete(lstWinSet.Current);
 lCurForm.Close;
end;

procedure TWinList.miGotoClick(Sender: TObject);
begin
 lstWinSetActionElement(Sender, lstWinSet.Current);
end;

end.
