unit evOperationDispatcherEx;

// Модуль: "w:\common\components\gui\Garant\Everest\evOperationDispatcherEx.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevOperationDispatcherEx" MUID: (4DD4F7060070)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evDisp
;

type
 TevOperationDispatcherEx = class(TevOperationDispatcher)
  public
   class function Instance: TevOperationDispatcherEx;
    {* Метод получения экземпляра синглетона TevOperationDispatcherEx }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
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

class function TevOperationDispatcherEx.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TevOperationDispatcherEx <> nil;
end;//TevOperationDispatcherEx.Exists

end.
