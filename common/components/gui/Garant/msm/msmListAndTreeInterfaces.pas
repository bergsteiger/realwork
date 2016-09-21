unit msmListAndTreeInterfaces;

// Модуль: "w:\common\components\gui\Garant\msm\msmListAndTreeInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmListAndTreeInterfaces" MUID: (57C99A680247)

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
    {* Метод получения экземпляра синглетона ActionElementEvent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//ActionElementEvent

 CurrentElementChangedEvent = class(TmsmModelEvent)
  public
   class function Instance: CurrentElementChangedEvent;
    {* Метод получения экземпляра синглетона CurrentElementChangedEvent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//CurrentElementChangedEvent

 ListChangedEvent = class(TmsmModelEvent)
  public
   class function Instance: ListChangedEvent;
    {* Метод получения экземпляра синглетона ListChangedEvent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//ListChangedEvent

 ListContentChangedEvent = {final} class(TmsmModelEvent)
  public
   class function Instance: ListContentChangedEvent;
    {* Метод получения экземпляра синглетона ListContentChangedEvent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//ListContentChangedEvent

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_ActionElementEvent: ActionElementEvent = nil;
 {* Экземпляр синглетона ActionElementEvent }
var g_CurrentElementChangedEvent: CurrentElementChangedEvent = nil;
 {* Экземпляр синглетона CurrentElementChangedEvent }
var g_ListChangedEvent: ListChangedEvent = nil;
 {* Экземпляр синглетона ListChangedEvent }
var g_ListContentChangedEvent: ListContentChangedEvent = nil;
 {* Экземпляр синглетона ListContentChangedEvent }

procedure ActionElementEventFree;
 {* Метод освобождения экземпляра синглетона ActionElementEvent }
begin
 l3Free(g_ActionElementEvent);
end;//ActionElementEventFree

procedure CurrentElementChangedEventFree;
 {* Метод освобождения экземпляра синглетона CurrentElementChangedEvent }
begin
 l3Free(g_CurrentElementChangedEvent);
end;//CurrentElementChangedEventFree

procedure ListChangedEventFree;
 {* Метод освобождения экземпляра синглетона ListChangedEvent }
begin
 l3Free(g_ListChangedEvent);
end;//ListChangedEventFree

procedure ListContentChangedEventFree;
 {* Метод освобождения экземпляра синглетона ListContentChangedEvent }
begin
 l3Free(g_ListContentChangedEvent);
end;//ListContentChangedEventFree

class function ActionElementEvent.Instance: ActionElementEvent;
 {* Метод получения экземпляра синглетона ActionElementEvent }
begin
 if (g_ActionElementEvent = nil) then
 begin
  l3System.AddExitProc(ActionElementEventFree);
  g_ActionElementEvent := Create;
 end;
 Result := g_ActionElementEvent;
end;//ActionElementEvent.Instance

class function ActionElementEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_ActionElementEvent <> nil;
end;//ActionElementEvent.Exists

class function CurrentElementChangedEvent.Instance: CurrentElementChangedEvent;
 {* Метод получения экземпляра синглетона CurrentElementChangedEvent }
begin
 if (g_CurrentElementChangedEvent = nil) then
 begin
  l3System.AddExitProc(CurrentElementChangedEventFree);
  g_CurrentElementChangedEvent := Create;
 end;
 Result := g_CurrentElementChangedEvent;
end;//CurrentElementChangedEvent.Instance

class function CurrentElementChangedEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_CurrentElementChangedEvent <> nil;
end;//CurrentElementChangedEvent.Exists

class function ListChangedEvent.Instance: ListChangedEvent;
 {* Метод получения экземпляра синглетона ListChangedEvent }
begin
 if (g_ListChangedEvent = nil) then
 begin
  l3System.AddExitProc(ListChangedEventFree);
  g_ListChangedEvent := Create;
 end;
 Result := g_ListChangedEvent;
end;//ListChangedEvent.Instance

class function ListChangedEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_ListChangedEvent <> nil;
end;//ListChangedEvent.Exists

class function ListContentChangedEvent.Instance: ListContentChangedEvent;
 {* Метод получения экземпляра синглетона ListContentChangedEvent }
begin
 if (g_ListContentChangedEvent = nil) then
 begin
  l3System.AddExitProc(ListContentChangedEventFree);
  g_ListContentChangedEvent := Create;
 end;
 Result := g_ListContentChangedEvent;
end;//ListContentChangedEvent.Instance

class function ListContentChangedEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_ListContentChangedEvent <> nil;
end;//ListContentChangedEvent.Exists

end.
