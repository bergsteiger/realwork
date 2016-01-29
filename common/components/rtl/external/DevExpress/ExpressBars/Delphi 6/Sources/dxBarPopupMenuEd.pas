
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars popupmenu editor                                }
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

unit dxBarPopupMenuEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, dxBar;

type
  TdxBarSubMenuEditor = class(TForm)
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FItemLinks: TdxBarItemLinks;
    FSubMenuWidth: Integer;
    procedure SetItemLinks(Value: TdxBarItemLinks);
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    property ItemLinks: TdxBarItemLinks read FItemLinks write SetItemLinks;
  end;

procedure ShowdxBarSubMenuEditor(AItemLinks: TdxBarItemLinks);

function dxBarSubMenuEditor: TdxBarSubMenuEditor;

implementation

{$R *.DFM}

uses
  dxBarCustForm, dxBarStrs;

var
  FdxBarSubMenuEditor: TdxBarSubMenuEditor;

procedure ShowdxBarSubMenuEditor(AItemLinks: TdxBarItemLinks);
begin
  AItemLinks.BarManager.Customizing(True);
  if AItemLinks.BarManager.IsCustomizing then
    with dxBarCustomizingForm do
      PageControl.ActivePage := Tabsheet2;
  if FdxBarSubMenuEditor = nil then
    FdxBarSubMenuEditor := TdxBarSubMenuEditor.Create(nil);
  with FdxBarSubMenuEditor do
  begin
    ClientHeight := 0;
    ItemLinks := AItemLinks;
    ProcessMouseMessages;
    Show;
  end;
end;

function dxBarSubMenuEditor: TdxBarSubMenuEditor;
begin
  Result := FdxBarSubMenuEditor;
end;

{ TdxBarSubMenuEditor }

constructor TdxBarSubMenuEditor.Create(AOwner: TComponent);
begin
  inherited;
  Caption := LoadStr(DXBAR_SUBMENUEDITORCAPTION);
end;

procedure TdxBarSubMenuEditor.SetItemLinks(Value: TdxBarItemLinks);
begin
  if FItemLinks <> Value then
  begin
    FItemLinks := Value;
    if FItemLinks = nil then
      Free
    else
      if FItemLinks.Owner is TComponent then
        TComponent(FItemLinks.Owner).FreeNotification(Self);
  end;
end;

procedure TdxBarSubMenuEditor.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  with Message.MinMaxInfo^ do
  begin
    ptMaxSize.Y := Height;
    ptMinTrackSize.Y := Height;
    ptMaxTrackSize.Y := Height;
    if (ItemLinks <> nil) and (ItemLinks.BarControl <> nil) then
      FSubMenuWidth := ItemLinks.BarControl.Width;
    ptMaxSize.X := FSubMenuWidth;
    ptMinTrackSize.X := FSubMenuWidth;
    ptMaxTrackSize.X := FSubMenuWidth;
  end;
end;

procedure TdxBarSubMenuEditor.WMMove(var Message: TWMMove);
begin
  inherited;
  if (ItemLinks <> nil) and (ItemLinks.BarControl <> nil) then
    SetWindowPos(ItemLinks.BarControl.Handle, 0, Left, Top + Height, 0, 0,
      SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE or swp_showwindow);
end;

procedure TdxBarSubMenuEditor.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  inherited;
  if Message.Hittest <> HTCLOSE then Activate
  else
    if ItemLinks.BarControl <> nil then
      TdxBarSubMenuControl(ItemLinks.BarControl).Hide;
end;

procedure TdxBarSubMenuEditor.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_POPUP or WS_CLIPSIBLINGS or WS_SYSMENU or WS_CAPTION;
    ExStyle := WS_EX_DLGMODALFRAME or WS_EX_WINDOWEDGE;
    WindowClass.Style := CS_OWNDC or CS_SAVEBITS;
    WndParent := GetParent(dxBarCustomizingForm.Handle);
  end;
end;

procedure TdxBarSubMenuEditor.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and
    (ItemLinks <> nil) and (AComponent = ItemLinks.Owner) then
    ItemLinks := nil;
end;

procedure TdxBarSubMenuEditor.FormDestroy(Sender: TObject);
begin
  if (ItemLinks <> nil) and (ItemLinks.BarControl <> nil) then
    TdxBarSubMenuControl(ItemLinks.BarControl).Hide;
  FdxBarSubMenuEditor := nil;
end;

type
  TDummyBarManager = class(TdxBarManager);

procedure TdxBarSubMenuEditor.FormActivate(Sender: TObject);
begin
  with TDummyBarManager(ItemLinks.BarManager) do
    if Dragging and (ItemLinks.Owner is TCustomdxBarSubItem) and not
      TCustomdxBarSubItem(ItemLinks.Owner).CanContainItem(DraggingItem) then Exit;
  if ItemLinks.BarControl = nil then
  begin
    ItemLinks.CreateBarControl;
    ItemLinks.BarControl.Left := Left;
    ItemLinks.BarControl.Top := Top + Height;
    with TdxBarSubMenuControl(ItemLinks.BarControl) do
    begin
      OwnerHeight := Self.Height;
      Show;
    end;
  end;
  Width := ItemLinks.BarControl.Width;
end;

procedure TdxBarSubMenuEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
