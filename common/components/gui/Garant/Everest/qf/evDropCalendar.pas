unit evDropCalendar;

{* Реализация выпадающего календаря. }

{ Библиотека "Эверест"    }
{ Начал: Инишев Д.А.       }
{ Модуль: evDropTree - }
{ Начат: 15.11.2004 18:29 }
{ $Id: evDropCalendar.pas,v 1.3 2015/05/29 11:53:50 kostitsin Exp $ }

// $Log: evDropCalendar.pas,v $
// Revision 1.3  2015/05/29 11:53:50  kostitsin
// no message
//
// Revision 1.2  2015/05/26 17:00:16  kostitsin
// {requestlink: 598131971 }
//
// Revision 1.1  2010/09/28 08:07:22  dinishev
// [$235057525]. Не компилировались тесты.
//
// Revision 1.22  2010/02/17 13:00:21  lulin
// - выкидываем ненужное.
//
// Revision 1.21  2008/03/06 18:50:22  lulin
// - <K> 86477264.
//
// Revision 1.20  2007/12/04 12:47:01  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.14.14.12  2006/06/07 08:59:26  dinishev
// Вычистил ненужные модули
//
// Revision 1.14.14.11  2006/05/22 14:38:16  dinishev
// Выбор даты по "быстрому" двойному щелчку в календаре.
//
// Revision 1.14.14.10  2005/11/11 17:28:42  dinishev
// Вставлены директивы CVS
//

interface

uses
 Windows,

 Classes,
 Types,
 Messages,
 
 vtDateEdit,
 
 l3Base,

 ExtCtrls,
 Buttons,
 Controls,
 Menus,
 Forms,

 //evInternalInterfaces,
 //evQueryCardInt,

 vtCalendarPanel
 ;

type

 TevDropCalendar = class(TDblClickPopupCalendar)
 private
  FOnChooseDate: TNotifyEvent;
    {-}
  FOnCancelDate: TNotifyEvent;
    {-}
  FOnNeedCloseTree: TNotifyEvent;
    {-}
  FWasSelected : Boolean;  
    {-}
 protected
  procedure CalendarMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer); 
    {-}
  procedure WndProc(var Message: TMessage); override;
    {-}
  procedure CancelClick(Sender: TObject); override;
    {-}
  procedure ClickToday(Sender: TObject); override;
    {-}
  procedure OKClick(Sender: TObject); override;
    {-}
  procedure CalendarMouseUp(Sender: TObject; Button: TMouseButton; 
   Shift: TShiftState; X, Y: Integer); override;
    {-} 
  procedure CreateParams(var Params: TCreateParams); override;  
    {-}
 public
  constructor Create(AOwner: TComponent); override;
   {-}
  property OnChooseDate: TNotifyEvent 
   read FOnChooseDate 
   write FOnChooseDate;
    {-}
  property OnCancelDate: TNotifyEvent 
   read FOnCancelDate 
   write FOnCancelDate;
    {-}
  property OnNeedCloseTree: TNotifyEvent 
   read FOnNeedCloseTree 
   write FOnNeedCloseTree;
    {-}
 end;

implementation

uses
 SysUtils,
 DateUtils,
 Graphics,
 StdCtrls,
 
 l3Date,

 vtCombo
 ;

type
 THackCalendarPanel = class(TvtCalendarPanel); 

{ TPopupCalendar }

procedure TevDropCalendar.CalendarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 MenuOpen := False;
 if (Button = mbLeft) and (Shift = [ssLeft, ssDouble]) then
 begin
  if (THackCalendarPanel(f_Calendar).GetDayFromPoint(Point(X,Y)) > 0) then
   if Assigned(FOnChooseDate) then
   begin
    FOnChooseDate(Self);
    FWasSelected := True;
   end; 
 end;
end;

procedure TevDropCalendar.CalendarMouseUp(Sender: TObject;
 Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if FWasSelected then 
 begin
  FWasSelected := False;
  Exit;
 end; 
 MenuOpen := False;
 if (Button = mbLeft) and (Shift = []) then
  begin
   if (THackCalendarPanel(f_Calendar).GetDayFromPoint(Point(X,Y)) > 0) and
      (THackCalendarPanel(f_Calendar).GetDayFromPoint(Point(X,Y)) = THackCalendarPanel(f_Calendar).OldDay)
    then
      if Assigned(FOnChooseDate) then
       FOnChooseDate(Self);
  end;
end;

procedure TevDropCalendar.CancelClick(Sender: TObject);
begin
 if Assigned(FOnCancelDate) then
   FOnCancelDate(Self);
end;

procedure TevDropCalendar.ClickToday(Sender: TObject);
begin
 f_Calendar.Date := Trunc(Now);
 if Assigned(FOnChooseDate) then
  FOnChooseDate(Self);
end;                          

constructor TevDropCalendar.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 f_Calendar.OnMouseDown := CalendarMouseDown;
 FWasSelected := False;
end;

procedure TevDropCalendar.CreateParams(var Params: TCreateParams);
begin
 inherited;
 with Params do
  WndParent := GetDesktopWindow;
end;

procedure TevDropCalendar.OKClick(Sender: TObject);
begin
 if Assigned(FOnChooseDate) then
  FOnChooseDate(Self);
end;

procedure TevDropCalendar.WndProc(var Message: TMessage);
begin
 if (Message.Msg = WM_RBUTTONDOWN) then 
  if Assigned(FOnNeedCloseTree) then
   FOnNeedCloseTree(nil);
 inherited;
end;

end.
