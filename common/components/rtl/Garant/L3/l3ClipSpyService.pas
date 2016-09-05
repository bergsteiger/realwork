unit l3ClipSpyService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ClipSpyService.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3ClipSpyService" MUID: (57762BA20039)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ClipboardSpy
;

 (*
 Ml3ClipSpyService = interface
  {* Контракт сервиса Tl3ClipSpyService }
  procedure Subscribe(const aListner: Il3ClipListner);
  procedure Unsubscribe(const aListner: Il3ClipListner);
 end;//Ml3ClipSpyService
 *)

type
 Il3ClipSpyService = interface
  {* Интерфейс сервиса Tl3ClipSpyService }
  procedure Subscribe(const aListner: Il3ClipListner);
  procedure Unsubscribe(const aListner: Il3ClipListner);
 end;//Il3ClipSpyService

 Tl3ClipSpyService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3ClipSpyService;
    {* Внешняя реализация сервиса Il3ClipSpyService }
  protected
   procedure pm_SetAlien(const aValue: Il3ClipSpyService);
   procedure ClearFields; override;
  public
   procedure Subscribe(const aListner: Il3ClipListner);
   procedure Unsubscribe(const aListner: Il3ClipListner);
   class function Instance: Tl3ClipSpyService;
    {* Метод получения экземпляра синглетона Tl3ClipSpyService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3ClipSpyService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3ClipSpyService }
 end;//Tl3ClipSpyService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57762BA20039impl_uses*
 //#UC END# *57762BA20039impl_uses*
;

var g_Tl3ClipSpyService: Tl3ClipSpyService = nil;
 {* Экземпляр синглетона Tl3ClipSpyService }

procedure Tl3ClipSpyServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3ClipSpyService }
begin
 l3Free(g_Tl3ClipSpyService);
end;//Tl3ClipSpyServiceFree

procedure Tl3ClipSpyService.pm_SetAlien(const aValue: Il3ClipSpyService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3ClipSpyService.pm_SetAlien

procedure Tl3ClipSpyService.Subscribe(const aListner: Il3ClipListner);
//#UC START# *105C5A110DDA_57762BA20039_var*
//#UC END# *105C5A110DDA_57762BA20039_var*
begin
//#UC START# *105C5A110DDA_57762BA20039_impl*
 if f_Alien <> nil then
  f_Alien.Subscribe(aListner);
//#UC END# *105C5A110DDA_57762BA20039_impl*
end;//Tl3ClipSpyService.Subscribe

procedure Tl3ClipSpyService.Unsubscribe(const aListner: Il3ClipListner);
//#UC START# *6EE9F044CA79_57762BA20039_var*
//#UC END# *6EE9F044CA79_57762BA20039_var*
begin
//#UC START# *6EE9F044CA79_57762BA20039_impl*
 if f_Alien <> nil then
  f_Alien.Unsubscribe(aListner);
//#UC END# *6EE9F044CA79_57762BA20039_impl*
end;//Tl3ClipSpyService.Unsubscribe

class function Tl3ClipSpyService.Instance: Tl3ClipSpyService;
 {* Метод получения экземпляра синглетона Tl3ClipSpyService }
begin
 if (g_Tl3ClipSpyService = nil) then
 begin
  l3System.AddExitProc(Tl3ClipSpyServiceFree);
  g_Tl3ClipSpyService := Create;
 end;
 Result := g_Tl3ClipSpyService;
end;//Tl3ClipSpyService.Instance

class function Tl3ClipSpyService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3ClipSpyService <> nil;
end;//Tl3ClipSpyService.Exists

procedure Tl3ClipSpyService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3ClipSpyService.ClearFields

end.
