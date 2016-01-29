unit IterateableService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "IterateableService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Service::Class Shared Delphi Sand Box::SandBox::Services::TIterateableService
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbDefine.inc}

interface

uses
  Classes,
  l3ProtoObject
  ;

type
  MIterateableService_IterateF_Action = function (anItem: TComponent): Boolean;
   {* Тип подитеративной функции для MIterateableService.IterateF }

(*
 MIterateableService = PureMixIn
  {* Контракт сервиса TIterateableService }
   {iterator} procedure IterateF(anAction: MIterateableService_IterateF_Action;
    anOwner: TComponent);
 end;//MIterateableService
*)

 IIterateableService = interface(IUnknown)
  {* Интерфейс сервиса TIterateableService }
   ['{9584416D-CD11-42E9-A82D-87DFA5441AA3}']
  // MIterateableService
   {iterator} procedure IterateF(anAction: MIterateableService_IterateF_Action;
    anOwner: TComponent);
 end;//IIterateableService

 TIterateableService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : IIterateableService;
    {* Поле для свойства Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: IIterateableService);
 public
 // realized methods
   {iterator} procedure IterateF(anAction: MIterateableService_IterateF_Action;
     anOwner: TComponent);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property Alien: IIterateableService
     write pm_SetAlien;
     {* Внешняя реализация сервиса IIterateableService }
 public
 // singleton factory method
   class function Instance: TIterateableService;
    {- возвращает экземпляр синглетона. }
 end;//TIterateableService
function L2MIterateableServiceIterateFAction(anAction: pointer): MIterateableService_IterateF_Action;
   {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для MIterateableService.IterateF }

implementation

uses
  l3Base {a}
  ;


// start class TIterateableService

var g_TIterateableService : TIterateableService = nil;

procedure TIterateableServiceFree;
begin
 l3Free(g_TIterateableService);
end;

class function TIterateableService.Instance: TIterateableService;
begin
 if (g_TIterateableService = nil) then
 begin
  l3System.AddExitProc(TIterateableServiceFree);
  g_TIterateableService := Create;
 end;
 Result := g_TIterateableService;
end;


function L2MIterateableServiceIterateFAction(anAction: pointer): MIterateableService_IterateF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2MIterateableServiceIterateFAction

procedure TIterateableService.pm_SetAlien(const aValue: IIterateableService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TIterateableService.pm_SetAlien

class function TIterateableService.Exists: Boolean;
 {-}
begin
 Result := g_TIterateableService <> nil;
end;//TIterateableService.Exists

{iterator} procedure TIterateableService.IterateF(anAction: MIterateableService_IterateF_Action;
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

procedure TIterateableService.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//TIterateableService.ClearFields

end.