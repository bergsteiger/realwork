{*********************************************************}
{*                  STPROPED.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

unit StPropEd;

interface

uses
  Dialogs,
  DsgnIntf,
  Forms,
  {$IFDEF VERSION3}
  StNotif0,
  StShlCtl,
  {$ENDIF}
  Controls;

type
  TStFileNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TStGenericFileNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

{$IFDEF VERSION3}
TStShellNotificationEditor = class(TComponentEditor)
  public
    procedure Edit; override;
  end;
{$ENDIF}

implementation

function TStFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TStFileNameProperty.Edit;
var
  Dlg : TOpenDialog;
begin
  Dlg := TOpenDialog.Create(Application);
  try
    Dlg.DefaultExt := '*.exe';
    Dlg.Filter := 'Executable Files (*.exe)|*.exe' +
                  '|Dynamic Link Libraries (*.dll)|*.dll';
    Dlg.FilterIndex := 0;
    Dlg.Options := [];
    {$IFDEF VERSION2}                                                  
    if GetName = 'ShortcutFileName' then                               
      Dlg.Options := [ofNoDereferenceLinks];                           
    {$ENDIF}                                                           
    Dlg.FileName := Value;
    if Dlg.Execute then
      Value := Dlg.FileName;
  finally
    Dlg.Free;
  end;
end;


function TStGenericFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TStGenericFileNameProperty.Edit;
var
  Dlg : TOpenDialog;
begin
  Dlg := TOpenDialog.Create(Application);
  try
    Dlg.DefaultExt := '*.*';
    Dlg.Filter := 'Text files (*.txt)|*.txt' +
                  '|Pascal files (.pas)|*.pas' +
                  '|C++ files (*.cpp)|*.cpp' +
                  '|All files (*.*)|*.*';
    Dlg.FilterIndex := 0;
    Dlg.Options := [];
    Dlg.FileName := Value;
    if Dlg.Execute then
      Value := Dlg.FileName;
  finally
    Dlg.Free;
  end;
end;

{$IFDEF VERSION3}
{ TStShellNotificationEditor }
procedure TStShellNotificationEditor.Edit;
var
  Form : TShellNotifyEditorForm;
  Res  : Integer;
begin
  inherited;
  Form := TShellNotifyEditorForm.Create(nil);
  with Component as TStShellNotification do begin
    Form.AssociationCb.Checked := (neAssociationChange in NotifyEvents);
    Form.AttributeCb.Checked := (neAttributesChange in NotifyEvents);
    Form.FileCreateCb.Checked := (neFileCreate in NotifyEvents);
    Form.FileDeleteCb.Checked := (neFileDelete in NotifyEvents);
    Form.FileRenameCb.Checked := (neFileRename in NotifyEvents);
    Form.FileChangeCb.Checked := (neFileChange in NotifyEvents);
    Form.FolderCreateCb.Checked := (neFolderCreate in NotifyEvents);
    Form.FolderDeleteCb.Checked := (neFolderDelete in NotifyEvents);
    Form.FolderRenameCb.Checked := (neFolderRename in NotifyEvents);
    Form.FolderChangeCb.Checked := (neFolderUpdate in NotifyEvents);
    Form.DriveAddCb.Checked := (neDriveAdd in NotifyEvents);
    Form.DriveRemoveCb.Checked := (neDriveRemove in NotifyEvents);
    Form.ShellDriveAddCb.Checked := (neShellDriveAdd in NotifyEvents);
    Form.NetShareCb.Checked := (neNetShare in NotifyEvents);
    Form.NetUnShareCb.Checked := (neNetUnShare in NotifyEvents);
    Form.ServerDisconnectCb.Checked := (neServerDisconnect in NotifyEvents);
    Form.MediaInsertCb.Checked := (neMediaInsert in NotifyEvents);
    Form.MediaRemoveCb.Checked := (neMediaRemove in NotifyEvents);
    Form.FreeSpaceCb.Checked := (neDriveSpaceChange in NotifyEvents);
    Form.ImageListChangeCb.Checked := (neImageListChange in NotifyEvents);
    Form.ActiveCb.Checked := Active;
    Form.WatchSubFoldersCb.Checked := WatchSubFolders;
  end;
  Res := Form.ShowModal;
  if Res = mrOk	then
    with Component as TStShellNotification do begin
      NotifyEvents := Form.Events;
      Active := Form.ActiveCb.Checked;
      WatchSubFolders := Form.WatchSubFoldersCb.Checked;
      if (Form.ShellTreeView.Selected <> nil) then
        if Form.ShellTreeView.SelectedFolder.IsFileFolder then
          WatchFolder := Form.ShellTreeView.SelectedFolder.Path;
      Designer.Modified;
    end;
  Form.Free;
end;
{$ENDIF}

end.