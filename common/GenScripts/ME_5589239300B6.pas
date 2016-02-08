unit l3ExceptionHandler;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ExceptionHandler.pas"
// Стереотип: "Service"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3ExceptionHandler = interface
  {* Контракт сервиса Tl3ExceptionHandler }
  procedure HandleException(Sender: TObject);
 end;//Ml3ExceptionHandler
 *)

type
 Il3ExceptionHandler = interface
  {* Интерфейс сервиса Tl3ExceptionHandler }
  ['{85F70758-7234-4849-BCCC-261AAAA9117F}']
  procedure HandleException(Sender: TObject);
 end;//Il3ExceptionHandler

 Tl3ExceptionHandler = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3ExceptionHandler;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3ExceptionHandler);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   procedure HandleException(Sender: TObject);
   class function Instance: Tl3ExceptionHandler;
    {* Метод получения экземпляра синглетона Tl3ExceptionHandler }
  public
   property Alien: Il3ExceptionHandler
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3ExceptionHandler }
 end;//Tl3ExceptionHandler

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

var g_Tl3ExceptionHandler: Tl3ExceptionHandler = nil;
 {* Экземпляр синглетона Tl3ExceptionHandler }

procedure Tl3ExceptionHandlerFree;
 {* Метод освобождения экземпляра синглетона Tl3ExceptionHandler }
begin
 l3Free(g_Tl3ExceptionHandler);
end;//Tl3ExceptionHandlerFree

procedure Tl3ExceptionHandler.pm_SetAlien(const aValue: Il3ExceptionHandler);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3ExceptionHandler.pm_SetAlien

class function Tl3ExceptionHandler.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3ExceptionHandler <> nil;
end;//Tl3ExceptionHandler.Exists

procedure Tl3ExceptionHandler.HandleException(Sender: TObject);
//#UC START# *9B9F43B530B0_5589239300B6_var*
//#UC END# *9B9F43B530B0_5589239300B6_var*
begin
//#UC START# *9B9F43B530B0_5589239300B6_impl*
 if Assigned(f_Alien) then
  f_Alien.HandleException(Sender);
//#UC END# *9B9F43B530B0_5589239300B6_impl*
end;//Tl3ExceptionHandler.HandleException

class function Tl3ExceptionHandler.Instance: Tl3ExceptionHandler;
 {* Метод получения экземпляра синглетона Tl3ExceptionHandler }
begin
 if (g_Tl3ExceptionHandler = nil) then
 begin
  l3System.AddExitProc(Tl3ExceptionHandlerFree);
  g_Tl3ExceptionHandler := Create;
 end;
 Result := g_Tl3ExceptionHandler;
end;//Tl3ExceptionHandler.Instance

procedure Tl3ExceptionHandler.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3ExceptionHandler.ClearFields

end.
