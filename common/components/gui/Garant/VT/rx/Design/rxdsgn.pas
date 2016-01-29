{*******************************************************}
{                                                       }
{         Delphi VCL Extensions (RX)                    }
{                                                       }
{         Copyright (c) 1998 Master-Bank                }
{                                                       }
{ Patched by Polaris Software                           }
{*******************************************************}

unit RxDsgn;

{$I RX.INC}

interface

uses {$IFDEF WIN32} Windows, {$ELSE} WinTypes, {$ENDIF} Classes, SysUtils,
  Controls, Graphics, ExtCtrls, Menus, Forms,
  {$IFDEF RX_D6} DesignIntf, DesignEditors {$ELSE} DsgnIntf {$ENDIF}; // Polaris
  
type
{$IFNDEF RX_D4}
  IDesigner = TDesigner;
  IFormDesigner = TFormDesigner;
{$ENDIF}

{$IFNDEF RX_D5}
  TDesignerSelectionList = TComponentList;
{$ENDIF}

{ TFilenameProperty }

  TFilenameProperty = class(TStringProperty)
  protected
    function GetFilter: string; virtual;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

{ TDirnameProperty }

  TDirnameProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

implementation

uses
  Consts, Dialogs, RxCConst, VclUtils, 
  l3FileUtils,

  rxDialogs
  ;

{ TFilenameProperty }

function TFilenameProperty.GetFilter: string;
begin
  Result := LoadStr(SDefaultFilter);
end;

procedure TFilenameProperty.Edit;
var
  FileOpen: TOpenDialog;
begin
  FileOpen := TOpenDialog.Create(Application);
  try
    FileOpen.Filename := GetValue;
    FileOpen.InitialDir := ExtractFilePath(FileOpen.Filename);
    if (ExtractFileName(FileOpen.Filename) = '') or not
      ValidFileName(ExtractFileName(FileOpen.Filename)) then
      FileOpen.Filename := '';
    FileOpen.Filter := GetFilter;
    FileOpen.Options := FileOpen.Options + [ofHideReadOnly];
    if FileOpen.Execute then SetValue(FileOpen.Filename);
  finally
    FileOpen.Free;
  end;
end;

function TFilenameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog {$IFDEF WIN32}, paRevertable {$ENDIF}];
end;

{ TDirnameProperty }

procedure TDirnameProperty.Edit;
var
  FolderName: string;
begin
  FolderName := GetValue;
  if BrowseDirectory(FolderName, ResStr(SSelectDirCap), 0) then
    SetValue(FolderName);
end;

function TDirnameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog {$IFDEF WIN32}, paRevertable {$ENDIF}];
end;

end.
