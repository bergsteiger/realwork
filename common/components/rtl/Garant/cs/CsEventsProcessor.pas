unit CsEventsProcessor;

{ $Id: CsEventsProcessor.pas,v 1.7 2014/07/25 09:45:57 lukyanets Exp $ }

// $Log: CsEventsProcessor.pas,v $
// Revision 1.7  2014/07/25 09:45:57  lukyanets
// {Requestlink:557844282}. ѕодружили dt_mail с ассистентом
//
// Revision 1.6  2014/07/10 11:37:28  lukyanets
// {Requestlink:553422280}. KeepAlive + остановка сервера
//
// Revision 1.5  2013/04/24 09:35:37  lulin
// - портируем.
//
// Revision 1.4  2006/03/10 09:29:12  voba
// - enh. убрал CsFree etc.
//
// Revision 1.3  2006/02/08 17:24:29  step
// выполнение запросов перенесено из классов-потомков в процедуры объектов
//

{$I CsDefine.inc}

interface

uses
 Classes, Windows, Messages, SyncObjs,
 CsObject, CsConst;

const
 WM_ProcessEvent  = WM_USER + 1;
 // фиксированные
 c_WrongProtocolVersion     = 1;
 c_ClientLogedInEvent       = 2;
 c_ClientLogedOutEvent      = 3;
 c_UnregisteredQuery        = 4;
 c_ServerListenerError      = 5;

 // минимальное пользовательское (использовать аналогично WM_USER)
 c_UserEvent = 100;

type
 TOnCsEventProc = procedure(aEventId: Integer;
                            aData: Integer) of object;

 TCsEventsProcessor = class(TCsObject)
 private
{$IFNDEF ServerAssistantSide}
  f_CriticalSection: TCriticalSection;
  f_Handle: HWND;
{$ENDIF ServerAssistantSide}
  f_OnEventProc: TOnCsEventProc;
{$IFNDEF ServerAssistantSide}
  procedure WndProc(var Message: TMessage);
  procedure OnMessage(var aMessage: TMessage); message WM_ProcessEvent;
{$ENDIF ServerAssistantSide}
 protected
{$IFNDEF ServerAssistantSide}
  procedure Cleanup; override;
{$ENDIF ServerAssistantSide}
 public
  constructor Create(aEventProc: TOnCsEventProc = nil); reintroduce;
  procedure ProcessEvent(aEventId: Integer = 0; aData: Integer = 0);
  property EventProc: TOnCsEventProc read f_OnEventProc write f_OnEventProc;
 end;

implementation

uses
 l3Base;

{ TCsEventsProcessor }

{$IFNDEF ServerAssistantSide}
procedure TCsEventsProcessor.Cleanup;
begin
 DeallocateHWnd(f_Handle);
 l3Free(f_CriticalSection);
 inherited;
end;
{$ENDIF ServerAssistantSide}

constructor TCsEventsProcessor.Create(aEventProc: TOnCsEventProc = nil);
begin
 inherited Create;
{$IFNDEF ServerAssistantSide}
 f_CriticalSection := TCriticalSection.Create;
 f_Handle := AllocateHWnd(WndProc);
{$ENDIF ServerAssistantSide}
 f_OnEventProc := aEventProc;
end;

{$IFNDEF ServerAssistantSide}
procedure TCsEventsProcessor.OnMessage(var aMessage: TMessage);
begin
 if Assigned(f_OnEventProc) then
  f_OnEventProc(aMessage.WParam, aMessage.LParam);
end;
{$ENDIF ServerAssistantSide}

procedure TCsEventsProcessor.ProcessEvent(aEventId: Integer = 0;
                                          aData: Integer = 0);
begin
{$IFNDEF ServerAssistantSide}
 f_CriticalSection.Enter;
 try
  if Assigned(f_OnEventProc) then
   PostMessage(f_Handle, WM_ProcessEvent, aEventId, aData);
 finally
  f_CriticalSection.Leave;
 end;       
{$ELSE ServerAssistantSide}
 if Assigned(f_OnEventProc) then
  f_OnEventProc(aEventId, aData);
{$ENDIF ServerAssistantSide}
end;

{$IFNDEF ServerAssistantSide}
procedure TCsEventsProcessor.WndProc(var Message: TMessage);
begin
 Dispatch(Message);
end;
{$ENDIF ServerAssistantSide}

end.


