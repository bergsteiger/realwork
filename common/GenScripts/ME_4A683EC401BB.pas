unit bsChatDispatcher;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\bsChatDispatcher.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , bsChatDispatcherPrim
 , ChatInterfaces
;

type
 TbsChatDispatcher = class(TbsChatDispatcherPrim)
  public
   class function Make: IbsChatDispatcher; reintroduce;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TbsChatDispatcher
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TbsChatDispatcher: Pointer = nil;
 {* Экземпляр синглетона TbsChatDispatcher }

procedure TbsChatDispatcherFree;
 {* Метод освобождения экземпляра синглетона TbsChatDispatcher }
begin
 IUnknown(g_TbsChatDispatcher) := nil;
end;//TbsChatDispatcherFree

class function TbsChatDispatcher.Make: IbsChatDispatcher;
begin
 if (g_TbsChatDispatcher = nil) then
 begin
  l3System.AddExitProc(TbsChatDispatcherFree);
  IbsChatDispatcher(g_TbsChatDispatcher) := inherited Make;
 end;
 Result := IbsChatDispatcher(g_TbsChatDispatcher);
end;//TbsChatDispatcher.Make

class function TbsChatDispatcher.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TbsChatDispatcher <> nil;
end;//TbsChatDispatcher.Exists
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
