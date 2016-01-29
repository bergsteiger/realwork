unit ElXPThemedControl;

{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Copyright (c) 2001, Akzhan Abdulin               }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$I ElPack.inc}

{ $Id: ElXPThemedControl.pas,v 1.5 2008/05/13 13:15:41 lulin Exp $ }

// $Log: ElXPThemedControl.pas,v $
// Revision 1.5  2008/05/13 13:15:41  lulin
// - чистка в рамках <K>: 90441490.
//
// Revision 1.4  2008/02/07 11:59:51  lulin
// - распилили наследие ElPack'а по двум библиотекам.
//
// Revision 1.3  2007/04/16 08:01:04  lulin
// - cleanup.
//
// Revision 1.2  2007/03/21 11:27:52  lulin
// - все Ёлѕаковские контролы насленуем от кошерного предка.
//
(*

Version History

09/21/2001 (c) Akzhan Abdulin

  Now nonclient area size will be recalculated after theme changes

09/17/2001 (c) Akzhan Abdulin

  Initiated.
  Themed control fully supports one theme per control paradigm.
  Bevel is drawn using Theme API.

  Developer note: You must override in descendants only one method named
  GetThemedClassName.

*)

interface

uses
  ElVCLUtils,
  ElUxTheme,
  ElTmSchema,
  Classes,
  Controls,
  Forms,
{$ifdef VCL_6_USED}
  Types,
{$endif}
  Messages,

  afwCustomCommonControl
  ;

type
  TElXPThemedControl = class(TafwCustomCommonControl)
  private
    FUseXPThemes: Boolean;
    FTheme: HTheme;
  {$IFDEF MSWINDOWS}
  protected
     FPreventStyleChange :Boolean;
     procedure WMStyleChanging(var Message: TMessage); message WM_STYLECHANGING;
     procedure WMStyleChanged(var Message: TMessage); message WM_STYLECHANGED;
     procedure WMSetRedraw(var Message: TWMSetRedraw); message WM_SETREDRAW;
  {$ENDIF}
  protected
    procedure SetUseXPThemes(const Value: Boolean); virtual;
    function GetThemedClassName: WideString; virtual; abstract;
{$ifdef MSWINDOWS}
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure WMIsThemedControl(var Message: TMessage); message WM_ISTHEMEDCONTROL;
    procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
{$endif}
    procedure FreeThemeHandle; virtual;
    procedure CreateThemeHandle; virtual;

    property UseXPThemes: Boolean read FUseXPThemes write SetUseXPThemes default True;
  public
    constructor Create(AOwner : TComponent); override;
    function IsThemeApplied: Boolean;
    property Theme: HTheme read FTheme;
  end;//TElXPThemedControl

implementation

{$ifndef ELPACK_EXCLUDE_MANIFEST}
{$r *.res}
{$endif}

{$ifdef MSWINDOWS}
uses
  Windows;
{$endif}

{ TElXPThemedControl }

constructor TElXPThemedControl.Create(AOwner: TComponent);
begin
  inherited;
  FUseXPThemes := True;
end;

procedure TElXPThemedControl.CreateThemeHandle;
begin
  if ThemesAvailable then
    FTheme := OpenThemeData(Handle, PWideChar(GetThemedClassName))
  else
    FTheme := 0;
end;

{$ifdef MSWINDOWS}

procedure TElXPThemedControl.CreateWnd;
begin
  inherited;
  if UseXPThemes and (not IsThemeApplied) then
  begin
    CreateThemeHandle;
  end;
end;

procedure TElXPThemedControl.DestroyWnd;
begin
  inherited;
  if UseXPThemes and IsThemeApplied then
  begin
    FreeThemeHandle;
  end;
end;
{$endif}

procedure TElXPThemedControl.FreeThemeHandle;
begin
  {$ifdef MSWINDOWS}
  if ThemesAvailable then
    CloseThemeData(FTheme);
  {$endif}
  FTheme := 0;
end;

function TElXPThemedControl.IsThemeApplied: Boolean;
begin
  Result := UseXPThemes and (FTheme <> 0);
end;

{$IFDEF MSWINDOWS}
procedure TElXPThemedControl.WMStyleChanging(var Message: TMessage);
begin
  if not FPreventStyleChange then
    inherited
  else
    Message.Result := 0;
end;

procedure TElXPThemedControl.WMStyleChanged(var Message: TMessage);
begin
  if not FPreventStyleChange then
    inherited
  else
    Message.Result := 0;
end;

procedure TElXPThemedControl.WMSetRedraw(var Message: TWMSetRedraw);
var
  SI:TScrollInfo;
begin
  inherited;
  if Visible and LongBool(TWMSetRedraw(Message).Redraw)=True then
  begin
    if (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL)<>0 then
    begin
      SI.cbSize := SizeOf(TScrollInfo);
      SI.fMask := SIF_POS;
      if GetScrollInfo( Handle, SB_HORZ, SI) then
        SetScrollInfo( Handle, SB_HORZ, SI, True);
    end;
    if (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL)<>0 then
    begin
      SI.cbSize := SizeOf(TScrollInfo);
      SI.fMask := SIF_POS;
      if GetScrollInfo( Handle, SB_VERT, SI) then
        SetScrollInfo( Handle, SB_VERT, SI, True);
    end;
  end;
end;

{$ENDIF IFDEF MSWINDOWS}

procedure TElXPThemedControl.SetUseXPThemes(const Value: Boolean);
begin
  if FUseXPThemes <> Value then
  begin
    FUseXPThemes := Value;
    {$ifdef MSWINDOWS}
    if ThemesAvailable and HandleAllocated and not (csDestroying in ComponentState) then
    begin
      if FUseXPThemes then
      begin
        CreateThemeHandle;
      end
      else
      begin
        FreeThemeHandle;
      end;
      RecreateWnd;
    end;
    {$endif}
  end;
end;

procedure TElXPThemedControl.WMNCPaint(var Message: TMessage);
{$ifdef VCL_4_USED}
const
  InnerStyles: array[TBevelCut] of Integer = (0, BDR_SUNKENINNER, BDR_RAISEDINNER, 0);
  OuterStyles: array[TBevelCut] of Integer = (0, BDR_SUNKENOUTER, BDR_RAISEDOUTER, 0);
  EdgeStyles: array[TBevelKind] of Integer = (0, 0, BF_SOFT, BF_FLAT);
  Ctl3DStyles: array[Boolean] of Integer = (BF_MONO, 0);
var
  DC: HDC;
  RC, RW, SaveRW: TRect;
  EdgeSize: Integer;
  WinStyle: Longint;
{$endif}
begin
  {$ifdef VCL_4_USED}
  if IsThemeApplied then
  begin
    { Get window DC that is clipped to the non-client area }
    if (BevelKind <> bkNone) or (BorderWidth > 0) then
    begin
      DC := GetWindowDC(Handle);
      try
        Windows.GetClientRect(Handle, RC);
        GetWindowRect(Handle, RW);
        MapWindowPoints(0, Handle, RW, 2);
        OffsetRect(RC, -RW.Left, -RW.Top);
        ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
        { Draw borders in non-client area }
        SaveRW := RW;
        InflateRect(RC, BorderWidth, BorderWidth);
        RW := RC;
        if BevelKind <> bkNone then
        begin
          EdgeSize := 0;
          if BevelInner <> bvNone then Inc(EdgeSize, BevelWidth);
          if BevelOuter <> bvNone then Inc(EdgeSize, BevelWidth);

          with RW do
          begin
            WinStyle := GetWindowLong(Handle, GWL_STYLE);
            if beLeft in BevelEdges then Dec(Left, EdgeSize);
            if beTop in BevelEdges then Dec(Top, EdgeSize);
            if beRight in BevelEdges then Inc(Right, EdgeSize);
            if (WinStyle and WS_VSCROLL) <> 0 then Inc(Right, GetSystemMetrics(SM_CYVSCROLL));
            if beBottom in BevelEdges then Inc(Bottom, EdgeSize);
            if (WinStyle and WS_HSCROLL) <> 0 then Inc(Bottom, GetSystemMetrics(SM_CXHSCROLL));
          end;
          DrawThemeEdge(FTheme, DC, 0, 0, RW, InnerStyles[BevelInner] or OuterStyles[BevelOuter],
            Byte(BevelEdges) or EdgeStyles[BevelKind] or Ctl3DStyles[Ctl3D] or BF_ADJUST, @RC);
        end;
        IntersectClipRect(DC, RW.Left, RW.Top, RW.Right, RW.Bottom);
//        RW := SaveRW;
        { Erase parts not drawn }
//        OffsetRect(RW, -RW.Left, -RW.Top);
        DrawThemeBackground(FTheme, DC, 0, 0, RC, nil);
      finally
        ReleaseDC(Handle, DC);
      end;
    end;
    DefaultHandler(Message);
  end
  else
  {$endif}
  begin
    Inherited;
  end;
end;

procedure TElXPThemedControl.WMIsThemedControl(var Message: TMessage);
begin
  Message.Result := Theme;
end;

procedure TElXPThemedControl.ELThemeChanged(var Message: TMessage);
begin
  if ThemesAvailable and UseXPThemes then
  begin
    FreeThemeHandle;
    CreateThemeHandle;
    // Recalculate frame size
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
    // Repaint frame
    RedrawWindow(Handle, nil, 0, {RDW_FRAME or }RDW_INVALIDATE or RDW_ERASE);
  end;
  Message.Result := 1;
end;

end.
