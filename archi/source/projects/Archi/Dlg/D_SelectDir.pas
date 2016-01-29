unit D_SelectDir;

{ $Id: D_SelectDir.pas,v 1.2 2007/11/15 15:43:06 fireton Exp $ }

// $Log: D_SelectDir.pas,v $
// Revision 1.2  2007/11/15 15:43:06  fireton
// - редизайн :)
//
// Revision 1.1  2007/11/15 12:52:53  fireton
// - переделка диалога экспорта документов
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ShellCtrls, BtnDlg, StdCtrls, Buttons, ExtCtrls,
  vtCtrls;

type
  TarDirSelectDlg = class(TBtnDlg)
    DirTree: TShellTreeView;
    FileList: TShellListView;
    vtSplitter1: TvtSplitter;
  private
    function pm_GetPath: string;
    procedure pm_SetPath(const Value: string);
    { Private declarations }
  public
    property Path: string read pm_GetPath write pm_SetPath;
    { Public declarations }
  end;

var
  arDirSelectDlg: TarDirSelectDlg;

implementation

{$R *.dfm}

function TarDirSelectDlg.pm_GetPath: string;
begin
 Result := DirTree.Path;
end;

procedure TarDirSelectDlg.pm_SetPath(const Value: string);
begin
 if DirectoryExists(Value) then
  DirTree.Path := Value;
end;

end.
