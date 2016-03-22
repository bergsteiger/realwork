unit ddExceptionHandler;

// Модуль: "w:\common\components\rtl\Garant\dd\ddExceptionHandler.pas"
// Стереотип: "ServiceImplementation"
// Элемент модели: "TddExceptionHandler" MUID: (55893A8B0110)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ExceptionHandler
;

type
 TddExceptionHandler = {final} class(Tl3ProtoObject, Il3ExceptionHandler)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   procedure HandleException(Sender: TObject);
   class function Instance: TddExceptionHandler;
    {* Метод получения экземпляра синглетона TddExceptionHandler }
 end;//TddExceptionHandler

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3Base
;

var g_TddExceptionHandler: TddExceptionHandler = nil;
 {* Экземпляр синглетона TddExceptionHandler }

procedure TddExceptionHandlerFree;
 {* Метод освобождения экземпляра синглетона TddExceptionHandler }
begin
 l3Free(g_TddExceptionHandler);
end;//TddExceptionHandlerFree

class function TddExceptionHandler.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TddExceptionHandler <> nil;
end;//TddExceptionHandler.Exists

procedure TddExceptionHandler.HandleException(Sender: TObject);
//#UC START# *9B9F43B530B0_55893A8B0110_var*
//#UC END# *9B9F43B530B0_55893A8B0110_var*
begin
//#UC START# *9B9F43B530B0_55893A8B0110_impl*
 Application.HandleException(Sender);
//#UC END# *9B9F43B530B0_55893A8B0110_impl*
end;//TddExceptionHandler.HandleException

class function TddExceptionHandler.Instance: TddExceptionHandler;
 {* Метод получения экземпляра синглетона TddExceptionHandler }
begin
 if (g_TddExceptionHandler = nil) then
 begin
  l3System.AddExitProc(TddExceptionHandlerFree);
  g_TddExceptionHandler := Create;
 end;
 Result := g_TddExceptionHandler;
end;//TddExceptionHandler.Instance

initialization
 Tl3ExceptionHandler.Instance.Alien := TddExceptionHandler.Instance;
 {* Регистрация TddExceptionHandler }

end.
