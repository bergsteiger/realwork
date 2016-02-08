unit l3MessagesService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3MessagesService.pas"
// Стереотип: "Service"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3MessagesService = interface
  {* Контракт сервиса Tl3MessagesService }
  procedure ProcessMessages;
 end;//Ml3MessagesService
 *)

type
 Il3MessagesService = interface
  {* Интерфейс сервиса Tl3MessagesService }
  ['{8169CB3B-D3C5-412F-82E9-1473799C89FD}']
  procedure ProcessMessages;
 end;//Il3MessagesService

 Tl3MessagesService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3MessagesService;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3MessagesService);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   procedure ProcessMessages;
   class function Instance: Tl3MessagesService;
    {* Метод получения экземпляра синглетона Tl3MessagesService }
  public
   property Alien: Il3MessagesService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3MessagesService }
 end;//Tl3MessagesService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3MessagesService: Tl3MessagesService = nil;
 {* Экземпляр синглетона Tl3MessagesService }

procedure Tl3MessagesServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3MessagesService }
begin
 l3Free(g_Tl3MessagesService);
end;//Tl3MessagesServiceFree

procedure Tl3MessagesService.pm_SetAlien(const aValue: Il3MessagesService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3MessagesService.pm_SetAlien

class function Tl3MessagesService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3MessagesService <> nil;
end;//Tl3MessagesService.Exists

procedure Tl3MessagesService.ProcessMessages;
//#UC START# *B6C92677BBF7_5506D3B202FA_var*
//#UC END# *B6C92677BBF7_5506D3B202FA_var*
begin
//#UC START# *B6C92677BBF7_5506D3B202FA_impl*
 if (f_Alien <> nil) then
  f_Alien.ProcessMessages;
//#UC END# *B6C92677BBF7_5506D3B202FA_impl*
end;//Tl3MessagesService.ProcessMessages

class function Tl3MessagesService.Instance: Tl3MessagesService;
 {* Метод получения экземпляра синглетона Tl3MessagesService }
begin
 if (g_Tl3MessagesService = nil) then
 begin
  l3System.AddExitProc(Tl3MessagesServiceFree);
  g_Tl3MessagesService := Create;
 end;
 Result := g_Tl3MessagesService;
end;//Tl3MessagesService.Instance

procedure Tl3MessagesService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3MessagesService.ClearFields

end.
