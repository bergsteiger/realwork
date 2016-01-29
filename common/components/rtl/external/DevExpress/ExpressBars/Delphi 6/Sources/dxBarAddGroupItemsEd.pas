
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars choose group item form                          }
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

unit dxBarAddGroupItemsEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, dxBar;

type
  TfrmAddGroupItems = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    lbGroupItems: TListBox;
    Panel1: TPanel;
    Panel5: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lbGroupItemsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbGroupItemsMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
  private
    FGroup: TdxBarGroup;
    PrevListBoxWndProc: TWndMethod;
    procedure SetGroup(Value: TdxBarGroup);
    procedure ListBoxWndProc(var Message: TMessage);
  public
    GroupItems: TList;
    property Group: TdxBarGroup read FGroup write SetGroup;
  end;

function dxBarChooseGroupItem(AGroup: TdxBarGroup; AGroupItems: TList): Boolean;

implementation

{$R *.DFM}

function dxBarChooseGroupItem(AGroup: TdxBarGroup; AGroupItems: TList): Boolean;
begin
  with TfrmAddGroupItems.Create(nil) do
    try
      Group := AGroup;
      GroupItems := AGroupItems;
      Result := ShowModal = mrOk;
    finally
      Free;
    end;
end;

procedure TfrmAddGroupItems.FormCreate(Sender: TObject);
begin
  with lbGroupItems do
  begin
    SetClassLong(Handle, GCL_STYLE, GetClassLong(Handle, GCL_STYLE) or CS_HREDRAW);
    PrevListBoxWndProc := WindowProc;
    WindowProc := ListBoxWndProc;
  end;
end;

procedure TfrmAddGroupItems.FormDestroy(Sender: TObject);
begin
  with lbGroupItems do
    WindowProc := PrevListBoxWndProc;
end;

procedure TfrmAddGroupItems.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  I: Integer;
begin
  if ModalResult = mrOK then
    with lbGroupItems, Items do
      for I := 0 to Count - 1 do
        if Selected[I] then
          GroupItems.Add(Objects[I]);
end;

procedure TfrmAddGroupItems.lbGroupItemsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  S: string;
  Item: TComponent;
  R: TRect;
  LineColor: COLORREF;
begin
  with TListBox(Control), Canvas do
  begin
    S := Items[Index];
    if (Length(S) <> 0) and (S[1] = '~') then
    begin
      Delete(S, 1, 1);
      Font.Color := clBtnText;
      Brush.Color := clBtnFace;
      with Rect do
        ExtTextOut(Handle, Left + 2, Top + 1, ETO_OPAQUE, @Rect,
          PChar(S), Length(S), nil);
    end
    else
    begin
      Item := TComponent(Items.Objects[Index]);
      S := '   ' + S;
      R := Rect;
      if Item is TdxBarItem then
        with R do
          Right := (Left + Right) div 2 - 1;
      if Group.IndexOf(Item) <> -1 then
      begin
        Font.Color := clBtnFace;
        Brush.Color := clWindow;
      end;
      FillRect(R);
      SetBkMode(Handle, TRANSPARENT);
      DrawText(Handle, PChar(S), Length(S), R, DT_SINGLELINE or DT_VCENTER);
      SetBkMode(Handle, OPAQUE);

      if Item is TdxBarItem then
      begin
        R.Left := R.Right;
        Inc(R.Right);
        if Brush.Color = clHighlight then
          LineColor := COLOR_HIGHLIGHTTEXT
        else
          LineColor := COLOR_WINDOWTEXT;
        Windows.FillRect(Handle, R, LineColor + 1);

        R.Left := R.Right;
        R.Right := Rect.Right;
        S := Item.Name;
        with R do
          ExtTextOut(Handle, Left + 2, Top + 1, ETO_OPAQUE, @R,
            PChar(S), Length(S), nil);
      end;
    end;
    if Index = Items.Count - 1 then
    begin
      Rect.Top := Rect.Bottom;
      Rect.Bottom := ClientHeight;
      Windows.FillRect(Handle, Rect, COLOR_BTNFACE + 1);
    end;
  end;
end;

procedure TfrmAddGroupItems.lbGroupItemsMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  Height := TListBox(Control).Canvas.TextHeight('Qq') + 2;
end;

procedure TfrmAddGroupItems.SetGroup(Value: TdxBarGroup);
var
  List: TList;
  I, J: Integer;
begin
  FGroup := Value;
  with lbGroupItems.Items do
  begin
    List := TList.Create;
    BeginUpdate;
    try
      if Group.BarManager.GroupCount > 1 then
      begin
        Add('~< Groups >');
        with Group.BarManager do
          for I := 0 to GroupCount - 1 do
            if Groups[I] <> Group then
              AddObject(Groups[I].Name, Groups[I]);
      end;
      for I := 0 to Group.BarManager.Categories.Count - 1 do
      begin
        J := Group.BarManager.GetItemsByCategory(I, List);
        if J <> 0 then
        begin
          Add('~' + Group.BarManager.Categories[I]);
          for J := 0 to J - 1 do
            with TdxBarItem(List[J]) do
              AddObject(Caption, List[J]);
        end;
      end;
    finally
      EndUpdate;
      List.Free;
    end;
  end;
end;

procedure TfrmAddGroupItems.ListBoxWndProc(var Message: TMessage);
begin
  with Message do
    if Msg = WM_ERASEBKGND then
    begin
      Result := 1;
      Exit;
    end;
  PrevListBoxWndProc(Message);
end;

end.
