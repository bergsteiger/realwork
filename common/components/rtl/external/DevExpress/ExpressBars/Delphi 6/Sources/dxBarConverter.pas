
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars converter component                             }
{                                                                   }
{       Copyright (c) 1998-2001 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxBarConverter;

{$I dxBarVer.inc}

interface

uses
  Classes, Menus,{$IFDEF DELPHI6} DesignIntf, DesignEditors,{$ELSE} DsgnIntf,{$ENDIF} dxBar;

type
  TCurDesigner =
    {$IFDEF DELPHI6}IDesigner{$ELSE}{$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}{$ENDIF};

  TdxBarConverter = class(TComponent)
  private
    FBarManager: TdxBarManager;
    FConverting: Boolean;
    FExecute: Boolean;
    FMenu: TMenu;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure Convert(ADesigner: TCurDesigner);
  published
    property BarManager: TdxBarManager read FBarManager write FBarManager;
    property Menu: TMenu read FMenu write FMenu;
    property Execute: Boolean read FExecute write FExecute;
  end;

procedure Register;

implementation

uses
  SysUtils, Controls, Forms, dxBarCustForm;

procedure TdxBarConverter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FBarManager then BarManager := nil;
    if AComponent = FMenu then Menu := nil;
  end;
end;

procedure TdxBarConverter.Convert(ADesigner: TCurDesigner);
var
  AForm: TCustomForm;
  ACategoryName, APopupMenuName: string;
  ACategory: Integer;
  APopupMenu: TdxBarPopupMenu;
  AItemLinks: TdxBarItemLinks;

  function FindItem(const ACaption: string; AOnClick: Pointer): TdxBarItem;
  var
    I: Integer;
  begin
    Result := nil;
    with BarManager do
      for I := 0 to ItemCount - 1 do
        with Items[I] do
          if (Items[I] is TdxBarButton) and
            (Caption = ACaption) and (@OnClick = AOnClick) then
          begin
            Result := Items[I];
            Break;
          end;
  end;

  function ConvertItem(AMenuItem: TMenuItem; ACategory: Integer; CreateCategory: Boolean): TdxBarItem;
  var
    AItem, AChildItem: TdxBarItem;
    AItemLink: TdxBarItemLink;
    ABeginGroup: Boolean;
    AMenuItemName: string;
  begin
    if AMenuItem.Parent = nil then AItem := nil
    else
    begin
      if AMenuItem.Count > 0 then AItem := TdxBarSubItem.Create(AForm)
      else
      begin
        AItem := FindItem(AMenuItem.Caption, @AMenuItem.OnClick);
        if AItem <> nil then
        begin
          AMenuItem.Free;
          Result := AItem;
          Exit;
        end;
        AItem := TdxBarButton.Create(AForm);
      end;
      AItem.Category := ACategory;
    end;

    with AMenuItem do
    begin
      if Parent <> nil then
      begin
      {$IFDEF DELPHI4}
        AItem.Action := Action;
        AItem.ImageIndex := ImageIndex;
      {$ENDIF}
        AItem.Caption := Caption;
        AItem.Enabled := Enabled;
        AItem.HelpContext := HelpContext;
        AItem.Hint := Hint;
        AItem.ShortCut := ShortCut;
        AItem.Tag := Tag;
        AItem.OnClick := OnClick;
        if AItem is TdxBarButton then
          with TdxBarButton(AItem) do
          begin
            if Checked or RadioItem then ButtonStyle := bsChecked;
            if RadioItem then GroupIndex := AMenuItem.GroupIndex;
            Down := Checked;
          end;

        if (Count > 0) and CreateCategory then
          with BarManager.Categories do
          begin
            ACategoryName := GetTextOf(Caption);
            if IndexOf(ACategoryName) < 0 then Add(ACategoryName);
            ACategory := IndexOf(ACategoryName);
          end;
      end;

      ABeginGroup := False;
      while Count > 0 do
        if Items[0].Caption = '-' then
        begin
          ABeginGroup := True;
          Items[0].Free;
        end
        else
        begin
          AChildItem := ConvertItem(Items[0], ACategory,
            (Parent = nil) and (Menu is TMainMenu));
          if Parent = nil then AItemLink := AItemLinks.Add
          else
            AItemLink := TdxBarSubItem(AItem).ItemLinks.Add;
          AItemLink.Item := AChildItem;
          if ABeginGroup then
          begin
            AItemLink.BeginGroup := True;
            ABeginGroup := False;
          end;
        end;
    end;

    with AMenuItem do
    begin
      AMenuItemName := Name;
      if Parent <> nil then Free;
    end;
    if AItem <> nil then AItem.Name := AMenuItemName;

    Result := AItem;
  end;

begin
  if FConverting or not (csDesigning in ComponentState) or (BarManager = nil) or
    ((dxBarCustomizingForm <> nil) and (dxBarCustomizingForm.BarManager = BarManager)) or
    (Menu = nil) or (Menu.Items.Count = 0) then Exit;
  Screen.Cursor := crHourGlass;
  FConverting := True;
  try
    AForm := BarManager.MainForm;
    if Menu is TMainMenu then
    begin
      ACategoryName := 'Menus';
      APopupMenu := nil;
      if BarManager.MainMenuBar = nil then
        with BarManager.Bars.Add do
        begin
          Caption := 'Main Menu';
          DockingStyle := dsTop;
          IsMainMenu := True;
          Visible := True;
        end;
      AItemLinks := BarManager.MainMenuBar.ItemLinks;
    end
    else
    begin
      APopupMenuName := Menu.Name;
      ACategoryName := APopupMenuName;
      with ADesigner, LongRec(Self.Menu.DesignInfo) do
        APopupMenu := TdxBarPopupMenu(CreateComponent(TdxBarPopupMenu, AForm, Lo, Hi, 1, 1));
      APopupMenu.OnPopup := TPopupMenu(Menu).OnPopup;
      AItemLinks := APopupMenu.ItemLinks;
    end;
  {$IFDEF DELPHI4}
    if BarManager.Images = nil then BarManager.Images := Menu.Images;
  {$ENDIF}
    with BarManager.Categories do
    begin
      if IndexOf(ACategoryName) < 0 then Add(ACategoryName);
      ACategory := IndexOf(ACategoryName);
    end;

    if Menu is TMainMenu then
      BarManager.MainMenuBar.LockUpdate := True;
    try
      ConvertItem(Menu.Items, ACategory, False);
    finally
      if Menu is TMainMenu then
        BarManager.MainMenuBar.LockUpdate := False;
    end;

    Menu.Free;
    with BarManager.Categories do
      Move(ACategory, Count - 1);
    if APopupMenu <> nil then APopupMenu.Name := APopupMenuName;
  finally
    FConverting := False;
    Screen.Cursor := crDefault;
  end;
end;

type
  TdxConverterExecutePropertyEditor = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

procedure TdxConverterExecutePropertyEditor.Edit;
begin
  TdxBarConverter(GetComponent(0)).Convert(Designer);
end;

function TdxConverterExecutePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TdxConverterExecutePropertyEditor.GetValue: string;
begin
  Result := 'Press to Convert';
end;

procedure Register;
begin
  RegisterComponents('ExpressBars', [TdxBarConverter]);
  RegisterPropertyEditor(TypeInfo(Boolean), TdxBarConverter, 'Execute',
    TdxConverterExecutePropertyEditor);
end;

end.
