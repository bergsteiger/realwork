unit vtProportionalPanel;

{ Библиотека VT   }
{ Автор: Лукьянец Р.В. ©     }
{ Модуль: vtProportionalPanel -   }
{ Начат: 31.01.2008 16:00 }
{ $Id: vtProportionalPanel.pas,v 1.9 2013/01/22 15:51:48 kostitsin Exp $ }

// $Log: vtProportionalPanel.pas,v $
// Revision 1.9  2013/01/22 15:51:48  kostitsin
// [$424399029]
//
// Revision 1.8  2012/08/10 13:47:18  kostitsin
// [$382421266]
//
// Revision 1.7  2009/12/21 12:12:07  oman
// - fix: {RequestLink:174719194}
//
// Revision 1.6  2009/08/06 16:08:21  lulin
// {RequestLink:159352843}.
//
// Revision 1.5  2009/03/19 14:20:27  oman
// - fix: Сохраняем размеры пропорциональных панелей (К-139441130)
//
// Revision 1.4  2008/01/29 07:44:23  oman
// - new: Умеем выключать подгонку размеров (cq28306)
//
// Revision 1.3  2008/01/25 07:47:11  oman
// - fix: Было возможно деление на ноль
//
// Revision 1.2  2008/01/24 10:59:11  oman
// - new: Реализуем пропорциональную коррекцию размеров (cq24598)
//
// Revision 1.1  2008/01/23 13:18:10  oman
// - new: Новый компонент vtProportionalPanel (cq24598)
//

{$Include vtDefine.inc }

interface

uses
 Windows,
 Controls,
 Classes,

 afwInterfaces,

 vtPanel
 ;

type
  // Если на ней лежит ровно 2 компонента:
  // Один с Align = alClient, второй с Align in (alLeft, alRight, alTop, alBottom)
  // то при изменении размеров, будет также пропорционально корректироваться размер
  // второго.
  // На TSplitter сознательно забиваем, учитывая использование vtSizeablePanel.
  TvtProportionalCustomPanel = class(TvtCustomPanel, IafwProportionalControl)
  private
   f_AdjustSize: Boolean;
   f_WidthProportion: Double;
   f_HeightProportion: Double;
   f_SizingControl: TControl;
   f_SmartSizing: Boolean;
  protected
   //IafwProportionalControl
   procedure NotifyLoaded;
     {-}
  private
   procedure pm_SetSmartSizing(const Value: Boolean);
     {-}
  private
   function FindProportionalSizedControl: TControl;
     {-}
   procedure UpdateSizingControl;
     {-}
  protected
   procedure AlignControls(AControl: TControl; var Rect: TRect);
    override;
     {-}
   procedure Notification(AComponent: TComponent; Operation: TOperation);
    override;
     {-}
   procedure Loaded;
    override;
     {-}
  public
   constructor Create(aOwner: TComponent);
    override;
     {-}
   procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
    override;
     {-}
  public
   property SmartSizing: Boolean
       read f_SmartSizing
      write pm_SetSmartSizing
    default True;
     {-}
  end;//TvtProportionalCustomPanel

  TvtProportionalPanel = class(TvtProportionalCustomPanel)
  public
    property DockManager;
  published
    property Align
      default alClient;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property ParentBiDiMode;
    {$IfDef Delphi7}
    property ParentBackground;
    {$EndIf}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;//TvtProportionalPanel

implementation

uses
 Forms,
 SysUtils,

 afwFacade
 ;

{ TvtProportionalCustomPanel }

const
 c_WidthAlignment = [alLeft, alRight];
 c_HeightAlignment = [alTop, alBottom];
 c_WidthHeightAlignemnt = c_WidthAlignment + c_HeightAlignment;

procedure TvtProportionalCustomPanel.AlignControls(AControl: TControl;
  var Rect: TRect);
begin
 inherited AlignControls(aControl, Rect);
 UpdateSizingControl;
end;

constructor TvtProportionalCustomPanel.Create(aOwner: TComponent);
begin
 inherited Create(aOwner);
 f_SmartSizing := True;
 Align := alClient;
end;

function TvtProportionalCustomPanel.FindProportionalSizedControl: TControl;
begin
 Result := nil;
 if f_SmartSizing and (ControlCount = 2) and ((Controls[0].Align = alClient) or (Controls[1].Align = alClient)) then
 begin
  if Controls[0].Align in c_WidthHeightAlignemnt then
   Result := Controls[0]
  else
   if Controls[1].Align in c_WidthHeightAlignemnt then
    Result := Controls[1];
 end;
end;

procedure TvtProportionalCustomPanel.Loaded;
begin
 inherited Loaded;
 UpdateSizingControl;
end;

procedure TvtProportionalCustomPanel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
 inherited Notification(aComponent, Operation);
 if (Operation = opRemove) and (aComponent = f_SizingControl) then
  f_SizingControl := nil;
end;

procedure TvtProportionalCustomPanel.NotifyLoaded;
begin
 UpdateSizingControl;
end;

procedure TvtProportionalCustomPanel.pm_SetSmartSizing(
  const Value: Boolean);
begin
 if f_SmartSizing <> Value then
 begin
  f_SmartSizing := Value;
  UpdateSizingControl;
 end;
end;

procedure TvtProportionalCustomPanel.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
var
 l_OldWidth: Integer;
 l_OldHeight: Integer;
 l_NewSize: Integer;
begin
 l_OldWidth := Width;
 l_OldHeight := Height;
 f_AdjustSize := True;
 try
  inherited SetBounds(aLeft, aTop, aWidth, aHeight);
  if Assigned(f_SizingControl) and not (csLoading in ComponentState) then
  begin
   if (f_SizingControl.Align in c_WidthAlignment) and (l_OldWidth <> Width) then
   begin
    l_NewSize := Round(f_WidthProportion * Width);
    case f_SizingControl.Align of
     alLeft:
      f_SizingControl.SetBounds(0, f_SizingControl.Top, l_NewSize, f_SizingControl.Height);
     alRight:
      f_SizingControl.SetBounds(Width - l_NewSize, f_SizingControl.Top, l_NewSize, f_SizingControl.Height);
    end;
   end;
   if (f_SizingControl.Align in c_HeightAlignment) and (l_OldHeight <> Height) then
   begin
    l_NewSize := Round(f_HeightProportion * Height);
    case f_SizingControl.Align of
     alTop:
      f_SizingControl.SetBounds(f_SizingControl.Left, 0, f_SizingControl.Width, l_NewSize);
     alBottom:
      f_SizingControl.SetBounds(f_SizingControl.Left, Height - l_NewSize, f_SizingControl.Width, l_NewSize);
    end;
   end;
  end;
 finally
  f_AdjustSize := False;
 end;
end;

procedure TvtProportionalCustomPanel.UpdateSizingControl;
begin
 f_SizingControl := FindProportionalSizedControl;
 if Assigned(f_SizingControl) then
 begin
  if not f_AdjustSize then
  begin
   if Width > 0 then
    f_WidthProportion := f_SizingControl.Width/Width
   else
    f_WidthProportion := 0.3;
   if Height > 0 then
    f_HeightProportion := f_SizingControl.Height/Height
   else
    f_HeightProportion := 0.3;
  end;
 end
 else
 begin
  f_WidthProportion := 0;
  f_HeightProportion := 0;
 end;
end;

end.
