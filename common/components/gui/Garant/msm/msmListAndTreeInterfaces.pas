unit msmListAndTreeInterfaces;

// ������: "w:\common\components\gui\Garant\msm\msmListAndTreeInterfaces.pas"
// ���������: "Interfaces"
// ������� ������: "msmListAndTreeInterfaces" MUID: (57C99A680247)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmControllers
;

type
 ActionElementEvent = class(TmsmModelEvent)
  public
   class function Instance: ActionElementEvent;
    {* ����� ��������� ���������� ���������� ActionElementEvent }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//ActionElementEvent

 CurrentElementChangedEvent = class(TmsmModelEvent)
  public
   class function Instance: CurrentElementChangedEvent;
    {* ����� ��������� ���������� ���������� CurrentElementChangedEvent }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//CurrentElementChangedEvent

 ListChangedEvent = class(TmsmModelEvent)
  public
   class function Instance: ListChangedEvent;
    {* ����� ��������� ���������� ���������� ListChangedEvent }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//ListChangedEvent

 ListContentChangedEvent = {final} class(TmsmModelEvent)
  public
   class function Instance: ListContentChangedEvent;
    {* ����� ��������� ���������� ���������� ListContentChangedEvent }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//ListContentChangedEvent

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_ActionElementEvent: ActionElementEvent = nil;
 {* ��������� ���������� ActionElementEvent }
var g_CurrentElementChangedEvent: CurrentElementChangedEvent = nil;
 {* ��������� ���������� CurrentElementChangedEvent }
var g_ListChangedEvent: ListChangedEvent = nil;
 {* ��������� ���������� ListChangedEvent }
var g_ListContentChangedEvent: ListContentChangedEvent = nil;
 {* ��������� ���������� ListContentChangedEvent }

procedure ActionElementEventFree;
 {* ����� ������������ ���������� ���������� ActionElementEvent }
begin
 l3Free(g_ActionElementEvent);
end;//ActionElementEventFree

procedure CurrentElementChangedEventFree;
 {* ����� ������������ ���������� ���������� CurrentElementChangedEvent }
begin
 l3Free(g_CurrentElementChangedEvent);
end;//CurrentElementChangedEventFree

procedure ListChangedEventFree;
 {* ����� ������������ ���������� ���������� ListChangedEvent }
begin
 l3Free(g_ListChangedEvent);
end;//ListChangedEventFree

procedure ListContentChangedEventFree;
 {* ����� ������������ ���������� ���������� ListContentChangedEvent }
begin
 l3Free(g_ListContentChangedEvent);
end;//ListContentChangedEventFree

class function ActionElementEvent.Instance: ActionElementEvent;
 {* ����� ��������� ���������� ���������� ActionElementEvent }
begin
 if (g_ActionElementEvent = nil) then
 begin
  l3System.AddExitProc(ActionElementEventFree);
  g_ActionElementEvent := Create;
 end;
 Result := g_ActionElementEvent;
end;//ActionElementEvent.Instance

class function ActionElementEvent.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_ActionElementEvent <> nil;
end;//ActionElementEvent.Exists

class function CurrentElementChangedEvent.Instance: CurrentElementChangedEvent;
 {* ����� ��������� ���������� ���������� CurrentElementChangedEvent }
begin
 if (g_CurrentElementChangedEvent = nil) then
 begin
  l3System.AddExitProc(CurrentElementChangedEventFree);
  g_CurrentElementChangedEvent := Create;
 end;
 Result := g_CurrentElementChangedEvent;
end;//CurrentElementChangedEvent.Instance

class function CurrentElementChangedEvent.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_CurrentElementChangedEvent <> nil;
end;//CurrentElementChangedEvent.Exists

class function ListChangedEvent.Instance: ListChangedEvent;
 {* ����� ��������� ���������� ���������� ListChangedEvent }
begin
 if (g_ListChangedEvent = nil) then
 begin
  l3System.AddExitProc(ListChangedEventFree);
  g_ListChangedEvent := Create;
 end;
 Result := g_ListChangedEvent;
end;//ListChangedEvent.Instance

class function ListChangedEvent.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_ListChangedEvent <> nil;
end;//ListChangedEvent.Exists

class function ListContentChangedEvent.Instance: ListContentChangedEvent;
 {* ����� ��������� ���������� ���������� ListContentChangedEvent }
begin
 if (g_ListContentChangedEvent = nil) then
 begin
  l3System.AddExitProc(ListContentChangedEventFree);
  g_ListContentChangedEvent := Create;
 end;
 Result := g_ListContentChangedEvent;
end;//ListContentChangedEvent.Instance

class function ListContentChangedEvent.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_ListContentChangedEvent <> nil;
end;//ListContentChangedEvent.Exists

end.
