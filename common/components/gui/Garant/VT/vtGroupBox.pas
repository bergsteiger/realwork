unit vtGroupBox;

{ $Id: vtGroupBox.pas,v 1.10 2012/05/12 16:33:27 kostitsin Exp $ }

// $Log: vtGroupBox.pas,v $
// Revision 1.10  2012/05/12 16:33:27  kostitsin
// [$362130929]
//
// Revision 1.9  2009/01/30 12:07:27  oman
// - fix: Добавляем пробелы в Caption (К-136255491)
//
// Revision 1.8  2009/01/21 14:43:57  lulin
// - боремся с родительским шрифтом (подробности у Вована).
//
// Revision 1.7  2007/02/16 15:41:43  lulin
// - cleanup.
//
// Revision 1.6  2006/12/06 10:16:41  lulin
// - выделен шаблонный метод.
//
// Revision 1.5  2006/12/06 10:02:01  lulin
// - создаем свой, "более умный" шрифт.
//
// Revision 1.4  2006/11/22 14:42:48  lulin
// - cleanup.
//
// Revision 1.3  2006/11/22 14:05:30  lulin
// - cleanup.
//
// Revision 1.2  2005/10/03 14:11:28  dinishev
// Bug fix: не рисовались заголовки групп контролов в КЗ 5.x
//
// Revision 1.1  2005/05/30 11:35:47  lulin
// - new unit: vtGroupBox.
//

{$Include vtDefine.inc }

interface

uses
 Classes,
 Controls,
 Windows,
 Graphics,
 StdCtrls,
 Messages,

 l3Base,
 l3WinControlCanvas
 ;

type
  TvtCustomGroupBox = class(TCustomGroupBox)
  private
   f_evCanvas: Tl3WinControlCanvas;
  private
   procedure WMSetText(var Message: TWMSetText);
    message WM_SETTEXT;
    {-}
  protected
   procedure Paint;
     override;
  public
   constructor Create(AOwner: TComponent);
     override;
   destructor Destroy;
     override;
    protected
      property ParentFont
        default false;
        {-}    
  end;//TvtCustomGroupBox

  TvtGroupBox = class(TvtCustomGroupBox)
  published
   property Align;
   property Anchors;
   property AutoSize;
   property BiDiMode;
   property Caption;
   property Color nodefault;
   property Constraints;
   property Ctl3D;
   property DragCursor;
   property DragKind;
   property DragMode;
   property Enabled;
   property Font;
   property ParentBiDiMode;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ShowHint;
   property TabOrder;
   property Visible;
   property OnClick;
   property OnContextPopup;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnEndDock;
   property OnEndDrag;
   property OnMouseDown;
   property OnMouseMove;
   property OnMouseUp;
   property OnStartDock;
   property OnStartDrag;
  end;//TvtGroupBox

implementation

uses
  SysUtils,
  
  l3Types,
  l3Chars,
  l3String,

  afwFont,
  afwVCL,

  l3CustomControlCanvas
  ;

// start class TvtCustomGroupBox

constructor TvtCustomGroupBox.Create(AOwner: TComponent);
begin
 inherited;
 afwHackControlFont(Self);
 f_evCanvas := Tl3CustomControlCanvas.Create(Self);
end;

destructor TvtCustomGroupBox.Destroy;
begin
 l3Free(f_evCanvas);
 inherited;
end;

procedure TvtCustomGroupBox.Paint;
var
 H: Integer;
 R: TRect;
 Flags: Longint;
 ll3Text : Tl3PCharLen;
begin
 with Canvas do
 begin
  Font := Self.Font;
  f_evCanvas.BeginPaint;
  f_evCanvas.DrawEnabled := true;
  try
   H := TextHeight('0');
   R := Rect(0, H div 2 - 1, Width, Height);
   if Ctl3D then
   begin
     Inc(R.Left);
     Inc(R.Top);
     Brush.Color := clBtnHighlight;
     FrameRect(R);
     OffsetRect(R, -1, -1);
     Brush.Color := clBtnShadow;
   end else
     Brush.Color := clWindowFrame;
   FrameRect(R);
   if Text <> '' then
   begin
     ll3Text := l3PCharLen(Text);

     if not UseRightToLeftAlignment then
       R := Rect(8, 0, 0, H)
     else
       R := Rect(R.Right - Canvas.TextWidth(Text) - 8, 0, 0, H);
     Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
     f_evCanvas.DrawText(lL3Text, R, Flags or DT_CALCRECT);
     Brush.Color := Color;
     f_evCanvas.DrawText(ll3Text, R, Flags);
   end;
  finally
   f_evCanvas.EndPaint;  
  end;
 end;
end;

procedure TvtCustomGroupBox.WMSetText(var Message: TWMSetText);
var
 l_Caption: String;

 function lp_FixCaption(const aCaption: PChar): String;
 begin
  Result := aCaption;
  if Result <> '' then
  begin
   if Result[1] <> ' ' then
    Insert(' ', Result, 1);
   if Result[Length(Result)] <> ' ' then
    Result := Result + ' ';
  end;
 end;

begin
 l_Caption := lp_FixCaption(Message.Text);
 Message.Text := PChar(l_Caption);
 inherited;
end;

end.
