unit vtBndLabel;

// TvtBoundedLabel - метка с прив€зкой к другому контролу

{  $Id: vtBndLabel.pas,v 1.9 2012/04/02 10:41:36 kostitsin Exp $}

// $Log: vtBndLabel.pas,v $
// Revision 1.9  2012/04/02 10:41:36  kostitsin
// vtBndLabel
//
// Revision 1.8  2008/02/06 09:30:42  lulin
// - базовые списки объектов выдел€ем в отдельные файлы.
//
// Revision 1.7  2007/03/02 12:08:04  voba
// - bug fix
//
// Revision 1.6  2005/05/30 09:55:58  lulin
// - метки переехали в библиотеку VT.
//
// Revision 1.5  2005/05/27 09:44:28  lulin
// - базова€ канва вывода переехала из Ёвереста в L3.
//
// Revision 1.4  2004/12/23 08:40:36  lulin
// - вычищен ненужный модуль.
//
// Revision 1.3  2004/07/07 14:34:56  fireton
// - bug fix: проблемы с хуком на NT4
//
// Revision 1.2  2004/06/09 09:17:24  fireton
// - add: добавлено свойство Indent
//
// Revision 1.1  2004/06/08 13:16:58  fireton
// - new component: TvtBoundedLabel
//

interface

uses
  Windows,
  Classes,
  Controls,
  Messages,
  StdCtrls,
  ExtCtrls,

  vtLabel,

  l3Interfaces
  ;

type
  TvtBoundedLabel = class(TvtCustomLabel,
                          Il3WndProcRetListener)
   private
    FBoundedControl: TWinControl;
    FCorrectControl: Boolean;
    FPosition: TLabelPosition;
    FSpacing: Integer;
    FUpdatingPosition: Boolean;
    FIndent: Integer;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure SetBoundedControl(const Value: TWinControl);
    procedure SetCorrectControl(const Value: Boolean);
    procedure SetIndent(const Value: Integer);
    procedure SetPosition(const Value: TLabelPosition);
    procedure SetSpacing(const Value: Integer);
    // Il3WndProcRetListener
    procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
                                       var theResult: Tl3HookProcResult);
   protected
    procedure UpdatePosition; virtual;
   public
    constructor Create(aOwner: TComponent); override;
    procedure Cleanup; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
   published
    property Alignment;
    property Autosize;
    property BoundedControl: TWinControl read FBoundedControl write SetBoundedControl;
    property Caption;
    property CorrectControl: Boolean read FCorrectControl write SetCorrectControl default False;
    property Indent: Integer read FIndent write SetIndent default 0;
    property Layout;
    property Position: TLabelPosition read FPosition write SetPosition default lpLeft;
    property Spacing: Integer read FSpacing write SetSpacing default 5;
    property Transparent;
    property WordWrap;
  end;//TvtBoundedLabel

implementation

uses
  SysUtils,

  l3Base,
  l3ListenersManager
  ;

// start class TvtBoundedLabel

constructor TvtBoundedLabel.Create(aOwner: TComponent);
begin
 inherited Create(aOwner);
 FBoundedControl := nil;
 FPosition := lpLeft;
 FSpacing := 5;
 FCorrectControl := False;
 FUpdatingPosition := False;
 FIndent := 0;
end;

procedure TvtBoundedLabel.Cleanup;
begin
 Tl3ListenersManager.RemoveWndProcRetListener(Self);
 inherited;
end;

procedure TvtBoundedLabel.CMParentFontChanged(var Message: TMessage);
begin
 inherited;
 UpdatePosition;
end;

procedure TvtBoundedLabel.SetBoundedControl(const Value: TWinControl);
begin
 if FBoundedControl <> Value then
 begin
  FBoundedControl := Value;

  if Assigned(FBoundedControl)
   then Tl3ListenersManager.AddWndProcRetListener(Self)
   else Tl3ListenersManager.RemoveWndProcRetListener(Self);

  UpdatePosition;
 end;
end;

procedure TvtBoundedLabel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
 if not Assigned(FBoundedControl) or FUpdatingPosition then
  inherited SetBounds(ALeft, ATop, AWidth, AHeight)
 else
 begin
  inherited SetBounds(Left, Top, AWidth, AHeight);
  UpdatePosition;
 end;
end;

procedure TvtBoundedLabel.SetCorrectControl(const Value: Boolean);
begin
 if FCorrectControl <> Value then
 begin
  FCorrectControl := Value;
  UpdatePosition;
 end;
end;

procedure TvtBoundedLabel.SetIndent(const Value: Integer);
begin
 if FIndent <> Value then
 begin
  FIndent := Value;
  UpdatePosition;
 end;
end;

procedure TvtBoundedLabel.SetPosition(const Value: TLabelPosition);
begin
 if FPosition <> Value then
 begin
  FPosition := Value;
  UpdatePosition;
 end;
end;

procedure TvtBoundedLabel.SetSpacing(const Value: Integer);
begin
 if FSpacing <> Value then
 begin
  FSpacing := Value;
  UpdatePosition;
 end;
end;

procedure TvtBoundedLabel.UpdatePosition;
var
 NewCTop: Integer;
 NewCLeft: Integer;
 P: TPoint;
begin
 if Assigned(FBoundedControl) then
 begin
  with FBoundedControl do
  begin
   case FPosition of
    lpAbove: P := Point(Left+FIndent, Top - Self.Height - FSpacing);
    lpBelow: P := Point(Left+FIndent, Top + Height + FSpacing);
    lpLeft : P := Point(Left - Self.Width - FSpacing,
                    Top+FIndent + ((Height - Self.Height) div 2));
    lpRight: P := Point(Left + Width + FSpacing,
                    Top+FIndent + ((Height - Self.Height) div 2));
   end;
  end;
  if ((P.X < FSpacing) or (P.Y < FSpacing)) and FCorrectControl then
  begin
   if P.X < FSpacing then
    NewCLeft := FBoundedControl.Left + -P.X + FSpacing
   else
    NewCLeft := FBoundedControl.Left;
   if P.Y < FSpacing then
    NewCTop := FBoundedControl.Top + -P.Y + FSpacing
   else
    NewCTop := FBoundedControl.Top;
   with FBoundedControl do
    SetBounds(NewCLeft, NewCTop, Width, Height);
  end
  else
  begin
   FUpdatingPosition := True;
   try
    SetBounds(P.x, P.y, Width, Height);
   finally
    FUpdatingPosition := False;
   end; {try..finally}
  end;
 end;
end;

procedure TvtBoundedLabel.WndProcRetListenerNotify(Msg: PCWPRetStruct; var theResult: Tl3HookProcResult);
begin
 if Msg.message = WM_MOVE then
  if Assigned(FBoundedControl) and (Msg.hwnd = FBoundedControl.Handle) then
   UpdatePosition;
end;

end.
