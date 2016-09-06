unit IterateableService;

// Модуль: "w:\common\components\SandBox\IterateableService.pas"
// Стереотип: "Service"
// Элемент модели: "TIterateableService" MUID: (5519611903CF)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Classes
;

type
 MIterateableService_IterateF_Action = function(anItem: TComponent): Boolean;
  {* Тип подитеративной функции для MIterateableService.IterateF }

 (*
 MIterateableService = interface
  {* Контракт сервиса TIterateableService }
  procedure IterateF(anAction: MIterateableService_IterateF_Action;
   anOwner: TComponent);
 end;//MIterateableService
 *)

 IIterateableService = interface
  {* Интерфейс сервиса TIterateableService }
  procedure IterateF(anAction: MIterateableService_IterateF_Action;
   anOwner: TComponent);
 end;//IIterateableService

 TIterateableService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IIterateableService;
    {* Внешняя реализация сервиса IIterateableService }
  protected
   procedure pm_SetAlien(const aValue: IIterateableService);
   procedure ClearFields; override;
  public
   procedure IterateF(anAction: MIterateableService_IterateF_Action;
    anOwner: TComponent);
   class function Instance: TIterateableService;
    {* Метод получения экземпляра синглетона TIterateableService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IIterateableService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IIterateableService }
 end;//TIterateableService

function L2MIterateableServiceIterateFAction(anAction: Pointer): MIterateableService_IterateF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для MIterateableService.IterateF }

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *5519611903CFimpl_uses*
 //#UC END# *5519611903CFimpl_uses*
;

var g_TIterateableService: TIterateableService = nil;
 {* Экземпляр синглетона TIterateableService }

function L2MIterateableServiceIterateFAction(anAction: Pointer): MIterateableService_IterateF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для MIterateableService.IterateF }
asm
 jmp l3LocalStub
end;//L2MIterateableServiceIterateFAction

procedure TIterateableServiceFree;
 {* Метод освобождения экземпляра синглетона TIterateableService }
begin
 l3Free(g_TIterateableService);
end;//TIterateableServiceFree

procedure TIterateableService.pm_SetAlien(const aValue: IIterateableService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TIterateableService.pm_SetAlien

procedure TIterateableService.IterateF(anAction: MIterateableService_IterateF_Action;
 anOwner: TComponent);
//#UC START# *A44911B9A95D_5519611903CF_var*
var
 Hack : Pointer absolute anAction;
//#UC END# *A44911B9A95D_5519611903CF_var*
begin
//#UC START# *A44911B9A95D_5519611903CF_impl*
 if (f_Alien <> nil) then
  f_Alien.IterateF(anAction, anOwner)
 else
 begin
  try
   //anAction(nil);
  finally
   l3FreeLocalStub(Hack);
  end;//try..finally
 end;//f_Alien <> nil
//#UC END# *A44911B9A95D_5519611903CF_impl*
end;//TIterateableService.IterateF

class function TIterateableService.Instance: TIterateableService;
 {* Метод получения экземпляра синглетона TIterateableService }
begin
 if (g_TIterateableService = nil) then
 begin
  l3System.AddExitProc(TIterateableServiceFree);
  g_TIterateableService := Create;
 end;
 Result := g_TIterateableService;
end;//TIterateableService.Instance

class function TIterateableService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TIterateableService <> nil;
end;//TIterateableService.Exists

procedure TIterateableService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TIterateableService.ClearFields

end.
