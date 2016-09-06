unit msmOpenService;

// Модуль: "w:\common\components\gui\Garant\msm\msmOpenService.pas"
// Стереотип: "Service"
// Элемент модели: "TmsmOpenService" MUID: (57CED46B03BD)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmModelElements
;

 (*
 MmsmOpenService = interface
  {* Контракт сервиса TmsmOpenService }
  procedure OpenListInNewWindow(const anElementForList: ImsmModelElement);
 end;//MmsmOpenService
 *)

type
 ImsmOpenService = interface
  {* Интерфейс сервиса TmsmOpenService }
  procedure OpenListInNewWindow(const anElementForList: ImsmModelElement);
 end;//ImsmOpenService

 TmsmOpenService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ImsmOpenService;
    {* Внешняя реализация сервиса ImsmOpenService }
  protected
   procedure pm_SetAlien(const aValue: ImsmOpenService);
   procedure ClearFields; override;
  public
   procedure OpenListInNewWindow(const anElementForList: ImsmModelElement);
   class function Instance: TmsmOpenService;
    {* Метод получения экземпляра синглетона TmsmOpenService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: ImsmOpenService
    write pm_SetAlien;
    {* Внешняя реализация сервиса ImsmOpenService }
 end;//TmsmOpenService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57CED46B03BDimpl_uses*
 //#UC END# *57CED46B03BDimpl_uses*
;

var g_TmsmOpenService: TmsmOpenService = nil;
 {* Экземпляр синглетона TmsmOpenService }

procedure TmsmOpenServiceFree;
 {* Метод освобождения экземпляра синглетона TmsmOpenService }
begin
 l3Free(g_TmsmOpenService);
end;//TmsmOpenServiceFree

procedure TmsmOpenService.pm_SetAlien(const aValue: ImsmOpenService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TmsmOpenService.pm_SetAlien

procedure TmsmOpenService.OpenListInNewWindow(const anElementForList: ImsmModelElement);
//#UC START# *5077A5E39FAB_57CED46B03BD_var*
//#UC END# *5077A5E39FAB_57CED46B03BD_var*
begin
//#UC START# *5077A5E39FAB_57CED46B03BD_impl*
 if (f_Alien <> nil) then
  f_Alien.OpenListInNewWindow(anElementForList);
//#UC END# *5077A5E39FAB_57CED46B03BD_impl*
end;//TmsmOpenService.OpenListInNewWindow

class function TmsmOpenService.Instance: TmsmOpenService;
 {* Метод получения экземпляра синглетона TmsmOpenService }
begin
 if (g_TmsmOpenService = nil) then
 begin
  l3System.AddExitProc(TmsmOpenServiceFree);
  g_TmsmOpenService := Create;
 end;
 Result := g_TmsmOpenService;
end;//TmsmOpenService.Instance

class function TmsmOpenService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmOpenService <> nil;
end;//TmsmOpenService.Exists

procedure TmsmOpenService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TmsmOpenService.ClearFields

end.
