unit fccustomdraw;
{
//
// Components : None
//
// Copyright (c) 1999 by Woll2Woll Software
}

interface

uses windows, commctrl;

{$i fcIfDef.pas}

const
  {$ifdef fcDelphi3Only}
  LVM_SETICONSPACING      = LVM_FIRST + 53;
  LVM_SCROLL              = LVM_FIRST + 20;

  NM_CUSTOMDRAW =          NM_FIRST - 12;
  CDDS_PREPAINT =          $00000001;
  CDDS_POSTPAINT =         $00000002;
  CDDS_PREERASE =          $00000003;
  CDDS_POSTERASE =         $00000004;
  LVS_OWNERDRAWFIXED =     $0400;

  // the 0x000010000 bit means it's individual item specific
  CDDS_ITEM =              $00010000;
  CDDS_ITEMPREPAINT =      (CDDS_ITEM or CDDS_PREPAINT);
  CDDS_ITEMPOSTPAINT =     (CDDS_ITEM or CDDS_POSTPAINT);
  CDDS_ITEMPREERASE =      (CDDS_ITEM or CDDS_PREERASE);
  CDDS_ITEMPOSTERASE =     (CDDS_ITEM or CDDS_POSTERASE);
  CDDS_SUBITEM =           $00020000;
  CDRF_DODEFAULT =         $00000000;
  CDRF_NEWFONT =           $00000002;
  CDRF_SKIPDEFAULT =       $00000004;
  CDRF_NOTIFYPOSTPAINT =   $00000010;
  CDRF_NOTIFYITEMDRAW =    $00000020;
  CDRF_NOTIFYSUBITEMDRAW = $00000020;
  CDRF_NOTIFYPOSTERASE =   $00000040;

  CDIS_SELECTED =          $0001;
  CDIS_GRAYED =            $0002;
  CDIS_DISABLED =          $0004;
  CDIS_CHECKED =           $0008;
  CDIS_FOCUS =             $0010;
  CDIS_DEFAULT =           $0020;
  CDIS_HOT =               $0040;
  CDIS_MARKED =            $0080;
  CDIS_INDETERMINATE =     $0100;

  TVIF_INTEGRAL =          $0080;

  TVS_CHECKBOXES =         $0100;

  TVM_GETITEMHEIGHT =      (TV_FIRST + 28);
  TVM_SETITEMHEIGHT =      (TV_FIRST + 27);
  TVM_SETINSERTMARK =      (TV_FIRST + 26);
  TVM_SETINSERTMARKCOLOR = (TV_FIRST + 37);
  TVM_GETINSERTMARKCOLOR = (TV_FIRST + 38);
  TVM_SETSCROLLTIME =      (TV_FIRST + 33);
  TVM_GETSCROLLTIME =      (TV_FIRST + 34);
  {$endif}

  wwItemStates: array[0..8] of LongInt = (
    CDIS_SELECTED, CDIS_GRAYED, CDIS_DISABLED, CDIS_CHECKED, CDIS_FOCUS,
    CDIS_DEFAULT, CDIS_HOT, CDIS_MARKED, CDIS_INDETERMINATE
  );

type
  TNMCustomDraw = packed record
    hdr: TNMHDR;
    dwDrawStage: DWORD;
    dc: HDC;
    rc: TRect;
    dwItemSpec: DWORD;
    uItemState: UINT;
    lItemlParam: LPARAM;
  end;
  PNMCustomDraw = ^TNMCustomDraw;

  TNMLVCustomDraw = packed record
    nmcd: TNMCustomDraw;
    clrText: COLORREF;
    clrTextBk: COLORREF;
    iSubItem: Integer;
  end;
  PNMLVCustomDraw = ^TNMLVCustomDraw;

  TNMTVCustomDraw = packed record
    nmcd: TNMCustomDraw;
    clrText: COLORREF;
    clrTextBk: COLORREF;
    iLevel: Integer;
  end;
  PNMTVCustomDraw = ^TNMTVCustomDraw;

  TNMTTCustomDraw = packed record
    nmcd: TNMCustomDraw;
    uDrawFlags: UINT;
  end;
  PNMTTCustomDraw = ^TNMTTCustomDraw;

  TNMTTDispInfo = packed record
    hdr: TNMHdr;
    lpszText: PAnsiChar;
    szText: array[0..79] of AnsiChar;
    hinst: HINST;
    uFlags: UINT;
    lParam: LPARAM;
  end;
  PNMTTDispInfo = ^TNMTTDispInfo;

  TTVItemEx = packed record
    mask: UINT;
    hItem: HTREEITEM;
    state: UINT;
    stateMask: UINT;
    pszText: PChar;
    cchTextMax: Integer;
    iImage: Integer;
    iSelectedImage: Integer;
    cChildren: Integer;
    lParam: LPARAM;
    iIntegral: Integer;
  end;
  PTVItemEx = ^TTVItemEx;

{$ifdef fcDelphi3Only}
function TreeView_GetItemHeight(Handle: HWND): Integer;
function TreeView_SetItemHeight(Handle: HWND; cyItem: SmallInt): Integer;
function TreeView_GetInsertMarkColor(Handle: HWND): COLORREF;
function TreeView_SetInsertMarkColor(Handle: HWND; Clr: COLORREF): COLORREF;
function TreeView_SetInsertMark(Handle: HWND; hItem: HTREEITEM; fAfter: Boolean): Boolean;
function TreeView_SetScrollTime(Handle: HWND; uTime: UINT): UINT;
function TreeView_GetScrollTime(Handle: HWND): UINT;
{$endif}

implementation

{$ifdef fcDelphi3}
function TreeView_GetItemHeight(Handle: HWND): Integer;
begin
  result := SendMessage(Handle, TVM_GETITEMHEIGHT, 0, 0);
end;

function TreeView_SetItemHeight(Handle: HWND; cyItem: SmallInt): Integer;
begin
  result := SendMessage(Handle, TVM_SETITEMHEIGHT, cyItem, 0);
end;

function TreeView_GetInsertMarkColor(Handle: HWND): COLORREF;
begin
  result := COLORREF(SendMessage(Handle, TVM_GETINSERTMARKCOLOR, 0, 0));
end;

function TreeView_SetInsertMarkColor(Handle: HWND; Clr: COLORREF): COLORREF;
begin
  result := COLORREF(SendMessage(Handle, TVM_SETINSERTMARKCOLOR, 0, LParam(Clr)));
end;

function TreeView_SetInsertMark(Handle: HWND; hItem: HTREEITEM; fAfter: Boolean): Boolean;
begin
  result := Boolean(SendMessage(Handle, TVM_SETINSERTMARK, WParam(fAfter), LParam(hItem)));
end;

function TreeView_SetScrollTime(Handle: HWND; uTime: UINT): UINT;
begin
  result := UINT(SendMessage(Handle, TVM_SETSCROLLTIME, uTime, 0));
end;

function TreeView_GetScrollTime(Handle: HWND): UINT;
begin
  result := UINT(SendMessage(Handle, TVM_GETSCROLLTIME, 0, 0));
end;
{$endif}

end.
