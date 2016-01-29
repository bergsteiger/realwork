unit vcmDockTree;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmDockTree -           }
{ Начат: 28.03.2011 14:39 }
{ $Id: vcmDockTree.pas,v 1.2 2012/10/25 18:51:01 lulin Exp $ }

// $Log: vcmDockTree.pas,v $
// Revision 1.2  2012/10/25 18:51:01  lulin
// {RequestLink:406489593}
//
// Revision 1.1  2012/06/01 12:33:45  lulin
// - чиним за Мишей.
//
// Revision 1.2  2011/06/17 11:59:02  lulin
// {RequestLink:228688486}.
//
// Revision 1.1  2011/03/28 12:15:25  lulin
// {RequestLink:259169894}.
//

{$Include vcmDefine.inc }

interface

uses
  Types,
  
  Graphics,
  Controls,

  l3DockTree,

  vcmInterfaces
  ;

type
  TvcmDockTree = class(Tl3DockTree)
    private
    // property fields
      f_CanUndock : Boolean;
      f_CanClose  : TvcmCanClose;
    protected
    // internal methods
      procedure PaintDockFrame(Canvas      : TCanvas;
                               aControl    : TControl;
                               const ARect : TRect);
        override;
        {-}
      procedure AdjustDockRect(aControl: TControl; var ARect: TRect);
        override;
        {-}
      function  NeedDrawCaption(aControl: TControl): Boolean;
        {-}
      function  IsMainObjectForm(aControl: TControl): Boolean;
        {-}
      function InternalHitTest(const MousePos: TPoint; out HTFlag: Integer): Tl3DockZone;
        override;
        {-}
    public
    // public properties
      property CanUndock : Boolean
        read f_CanUndock
        write f_CanUndock;
        {-}
      property CanClose : TvcmCanClose
        read f_CanClose
        write f_CanClose;
        {-}
  end;//TvcmDockTree

implementation

uses
  Windows,

  Forms,

  l3Defaults,

  vtPanel,

  vcmEntityForm

  {$IfNDef NoVGScene}
  ,
  vtPopupForm
  {$EndIf  NoVGScene}
  ;

const
  GrabberSize = 12;

procedure TvcmDockTree.PaintDockFrame(Canvas      : TCanvas;
                                      aControl    : TControl;
                                      const ARect : TRect);
  //override;
  {-}

  procedure DrawCloseButton(Left, Top: Integer);
  begin//DrawCloseButton
   DrawFrameControl(Canvas.Handle, Rect(Left, Top, Left+GrabberSize-2,
     Top+GrabberSize-2), DFC_CAPTION, DFCS_CAPTIONCLOSE);
  end;//DrawCloseButton

var
 l_Rect: TRect;
 l_OldColor: TColor;
begin
 if CanUndock then
  inherited
  //CanUndock
 else
 if (CanClose = vcm_ccEnable) then
 begin
  with ARect do
   if (DockSite.Align in [alTop, alBottom]) then
    DrawCloseButton(Left+1, Top+1)
   else
    DrawCloseButton(Right-GrabberSize+1, Top+1);
 end//CanClose
 else
 if NeedDrawCaption(aControl) then
 begin
  with Canvas do
  begin
   Font.Color := clWindowText;
   Brush.Color := cGarant2011BackColor{clBtnFace};
   l_Rect := ARect;
   DrawText(Canvas.Handle, PChar(TCustomForm(aControl).Caption),
            Length(TCustomForm(aControl).Caption), l_Rect, DT_END_ELLIPSIS);

   DrawText(Canvas.Handle, PChar(TCustomForm(aControl).Caption),
   	        Length(TCustomForm(aControl).Caption), l_Rect, DT_CALCRECT);
            
   l_OldColor := Canvas.Pen.Color;
   Canvas.Pen.Color := clBtnShadow;
   try
    Canvas.MoveTo(ARect.Left, l_Rect.Bottom);
    Canvas.LineTo(ARect.Right, l_Rect.Bottom);
   finally
    Canvas.Pen.Color := l_OldColor;
   end;
   if (Canvas is TControlCanvas) and
      ((Canvas as TControlCanvas).Control <> nil) then
    if l_Rect.Right > ARect.Right then
    begin
     (Canvas as TControlCanvas).Control.Hint := TCustomForm(aControl).Caption;
     (Canvas as TControlCanvas).Control.ShowHint := true;
    end
    else
    begin
     (Canvas as TControlCanvas).Control.Hint := '';
     (Canvas as TControlCanvas).Control.ShowHint := false;
    end;
  end;//with Canvas
 end;//(DockSite.Align in [alTop, alBottom, alClient])
end;

procedure TvcmDockTree.AdjustDockRect(aControl: TControl; var ARect: TRect);
  //override;
  {-}
var
 lPanel: TvtPanel;
begin
 if CanUndock OR (CanClose = vcm_ccEnable) then
  inherited
 else
 begin
  // учитываем рамочки от панелей
  if (DockSite is TvtPanel) then
  begin
   lPanel := TvtPanel(DockSite);
   if lPanel.BevelOuter <> bvNone then
    InflateRect(ARect, -1, -1);
   if lPanel.BevelInner <> bvNone then
    InflateRect(ARect, -1, -1);
  end;//DockSite is TvtPanel
  if NeedDrawCaption(aControl) then
  begin
   with TCustomForm(aControl).Canvas do
   begin
    Font.Size := 8;
    Inc(aRect.Top, TextExtent(TCustomForm(aControl).Caption).cY + 1);
   end;//TCustomForm(aControl).Canvas
  end;//NeedDrawCaption(aControl) 
 end;
end;

function TvcmDockTree.NeedDrawCaption(aControl: TControl): Boolean;
  {-}
begin
 Result := {(DockSite.Align in [alTop, alBottom, alClient]) AND}
           (aControl Is TCustomForm) AND
           (TCustomForm(aControl).Caption <> '') AND
           not IsMainObjectForm(aControl);
 if Result then
 begin
  if (aControl Is TvcmEntityForm) then
  begin
   if not TvcmEntityForm(aControl).NeedDrawCaption then
    Result := false;
   {$IfNDef NoVGScene}
   if Result then
    if (aControl.Parent <> nil) AND
       (aControl.Parent.Owner Is TvtPopupForm) then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=259170982&focusedCommentId=259170984&#comment-259170984
     Result := false;
   {$EndIf  NoVGScene}
  end;//aControl Is TvcmEntityForm
 end;//Result
end;

function TvcmDockTree.IsMainObjectForm(aControl: TControl): Boolean;
  {-}
begin
 Result := (aControl Is TvcmEntityForm) AND TvcmEntityForm(aControl).IsMainObjectForm;
end;

function TvcmDockTree.InternalHitTest(const MousePos: TPoint; out HTFlag: Integer): Tl3DockZone;
  //override;
  {-}
begin
 Result := inherited InternalHitTest(MousePos, HTFlag);
 if (HTFlag = HTClose) AND (CanClose <> vcm_ccEnable) then
  HTFlag := HTCaption;
end;

end.

