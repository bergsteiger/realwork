unit evMemoContextMenu;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evMemoContextMenu - }
{ Начат: 03.06.2008 12:26 }
{ $Id: evMemoContextMenu.pas,v 1.4 2010/03/02 13:34:35 lulin Exp $ }

// $Log: evMemoContextMenu.pas,v $
// Revision 1.4  2010/03/02 13:34:35  lulin
// {RequestLink:193823544}.
//
// Revision 1.3  2010/03/01 15:11:56  lulin
// {RequestLink:193823544}.
// - шаг третий.
//
// Revision 1.2  2008/07/10 13:21:00  lulin
// - bug fix: в БП не показывалось VCM'ное меню.
//
// Revision 1.1  2008/06/03 08:38:25  lulin
// - контекстное меню выделено в отдельный модуль.
//

{$Include evDefine.inc }

interface

uses
  Menus
  ;

type
  TevMemoContextMenu = class(TPopupMenu)
    private
    // internal fields
      FmnuCopy: TMenuItem;
      FmnuCut: TMenuItem;
      FmnuDelete: TMenuItem;
      FmnuPaste: TMenuItem;
      FmnuUndo: TMenuItem;
    private
    // internal methods
      procedure DoProcessClick(Sender: TObject);
        {-}
      procedure SetMenuState(Sender: TObject);
        {-}
    public
    // public methods
      constructor Create;
        reintroduce;
        {-}
  end;//TevMemoContextMenu

function MemoContextMenu: TevMemoContextMenu;

implementation

uses
  SysUtils,
  
  Forms,
  Clipbrd,

  l3Base,
  l3Interfaces,
  l3String,

  evCustomMemo,

  nevInterfaces
  ;


var
 g_MemoContextMenu: TevMemoContextMenu = nil;

procedure FreeMemoContextMenu;
begin
// FreeAndNil(g_MemoContextMenu);
end;

function MemoContextMenu: TevMemoContextMenu;
begin
 if (g_MemoContextMenu = nil) then
 begin
  g_MemoContextMenu := TevMemoContextMenu.Create;
  l3System.AddExitProc(FreeMemoContextMenu);
 end;//g_MemoContextMenu = nil
 Result := g_MemoContextMenu;
end;

// start class TevMemoContextMenu

constructor TevMemoContextMenu.Create;
var
 TmpItem: TMenuItem;
begin
 inherited Create(Application);
 OnPopup := SetMenuState;
 FmnuUndo := TMenuItem.Create(Self);
  FmnuUndo.Caption := str_nevmcmUndo.AsStr;
 FmnuUndo.OnClick := DoProcessClick;
 Items.Add(FmnuUndo);
 TmpItem := TMenuItem.Create(Self);
 TmpItem.Caption := '-';
 Items.Add(TmpItem);
 FmnuCut := TMenuItem.Create(Self);
  FmnuCut.Caption := str_nevmcmCut.AsStr;
 FmnuCut.OnClick := DoProcessClick;
 Items.Add(FmnuCut);
 FmnuCopy := TMenuItem.Create(Self);
  FmnuCopy.Caption := str_nevmcmCopy.AsStr;
 FmnuCopy.OnClick := DoProcessClick;
 Items.Add(FmnuCopy);
 FmnuPaste := TMenuItem.Create(Self);
  FmnuPaste.Caption := str_nevmcmPaste.AsStr;
 FmnuPaste.OnClick := DoProcessClick;
 Items.Add(FmnuPaste);
 FmnuDelete := TMenuItem.Create(Self);
  FmnuDelete.Caption := str_nevmcmDelete.AsStr;
 FmnuDelete.OnClick := DoProcessClick;
 Items.Add(FmnuDelete);
end;

procedure TevMemoContextMenu.DoProcessClick(Sender: TObject);
var
 lMemo: TevCustomMemo;
begin
 lMemo := TevCustomMemo(TevMemoContextMenu(TMenuItem(Sender).Owner).PopupComponent);
 if lMemo <> nil then
 begin
  if Sender = FmnuCopy then
   lMemo.Copy;
  if Sender = FmnuCut then
   lMemo.Cut;
  if Sender = FmnuDelete then
   lMemo.Range.Delete;
  if Sender = FmnuPaste then
   lMemo.Paste;
  if Sender = FmnuUndo then
   lMemo.Processor.Undo;
 end; {if..}
end;

type
  THackMemo = class(TevCustomMemo);
  
procedure TevMemoContextMenu.SetMenuState(Sender: TObject);
var
 I: Integer;
 Fmt: Tl3ClipboardFormats;
 lMemo : THackMemo;
begin
 lMemo := THackMemo(TevMemoContextMenu(Sender).PopupComponent);
 with lMemo do
 begin
  FmnuUndo.Enabled := CanUndo;
  FmnuCut.Enabled := HasSelection;
  FmnuCopy.Enabled := HasSelection;
  FmnuPaste.Enabled := False;
  if Enabled and not ReadOnly then
  begin
   Fmt := GetAcceptableFormats;
   for I := Low(Fmt) to High(Fmt) do
    if Clipboard.HasFormat(Fmt[I]) then
    begin
     FmnuPaste.Enabled := True;
     Break;
    end;//Clipboard.HasFormat(Fmt[I])
  end;//Enabled..
  FmnuDelete.Enabled := HasSelection and Enabled and not ReadOnly;
 end;//with lMemo..
end;

end.

