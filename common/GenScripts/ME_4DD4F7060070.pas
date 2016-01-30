unit evOperationDispatcherEx;

// Модуль: "w:\common\components\gui\Garant\Everest\evOperationDispatcherEx.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evDisp
;

type
 TevOperationDispatcherEx = class(TevOperationDispatcher)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TevOperationDispatcherEx;
    {* Метод получения экземпляра синглетона TevOperationDispatcherEx }
 end;//TevOperationDispatcherEx

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TevOperationDispatcherEx: TevOperationDispatcherEx = nil;
 {* Экземпляр синглетона TevOperationDispatcherEx }

procedure TevOperationDispatcherExFree;
 {* Метод освобождения экземпляра синглетона TevOperationDispatcherEx }
begin
 l3Free(g_TevOperationDispatcherEx);
end;//TevOperationDispatcherExFree

class function TevOperationDispatcherEx.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TevOperationDispatcherEx <> nil;
end;//TevOperationDispatcherEx.Exists

class function TevOperationDispatcherEx.Instance: TevOperationDispatcherEx;
 {* Метод получения экземпляра синглетона TevOperationDispatcherEx }
begin
 if (g_TevOperationDispatcherEx = nil) then
 begin
  l3System.AddExitProc(TevOperationDispatcherExFree);
  g_TevOperationDispatcherEx := Create;
 end;
 Result := g_TevOperationDispatcherEx;
end;//TevOperationDispatcherEx.Instance

end.
