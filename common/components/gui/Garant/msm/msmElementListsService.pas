unit msmElementListsService;

// Модуль: "w:\common\components\gui\Garant\msm\msmElementListsService.pas"
// Стереотип: "Service"
// Элемент модели: "TmsmElementListsService" MUID: (57FE4DA6014A)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

 (*
 MmsmElementListsService = interface
  {* Контракт сервиса TmsmElementListsService }
  procedure RegetLists;
  procedure RegetViewedListsFor(aWord: TtfwWord;
   const aListName: AnsiString);
 end;//MmsmElementListsService
 *)

type
 ImsmElementListsService = interface
  {* Интерфейс сервиса TmsmElementListsService }
  procedure RegetLists;
  procedure RegetViewedListsFor(aWord: TtfwWord;
   const aListName: AnsiString);
 end;//ImsmElementListsService

 TmsmElementListsService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ImsmElementListsService;
    {* Внешняя реализация сервиса ImsmElementListsService }
  protected
   procedure pm_SetAlien(const aValue: ImsmElementListsService);
   procedure ClearFields; override;
  public
   procedure RegetLists;
   procedure RegetViewedListsFor(aWord: TtfwWord;
    const aListName: AnsiString);
   class function Instance: TmsmElementListsService;
    {* Метод получения экземпляра синглетона TmsmElementListsService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: ImsmElementListsService
    write pm_SetAlien;
    {* Внешняя реализация сервиса ImsmElementListsService }
 end;//TmsmElementListsService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57FE4DA6014Aimpl_uses*
 //#UC END# *57FE4DA6014Aimpl_uses*
;

var g_TmsmElementListsService: TmsmElementListsService = nil;
 {* Экземпляр синглетона TmsmElementListsService }

procedure TmsmElementListsServiceFree;
 {* Метод освобождения экземпляра синглетона TmsmElementListsService }
begin
 l3Free(g_TmsmElementListsService);
end;//TmsmElementListsServiceFree

procedure TmsmElementListsService.pm_SetAlien(const aValue: ImsmElementListsService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TmsmElementListsService.pm_SetAlien

procedure TmsmElementListsService.RegetLists;
//#UC START# *57FE4DCD02F8_57FE4DA6014A_var*
//#UC END# *57FE4DCD02F8_57FE4DA6014A_var*
begin
//#UC START# *57FE4DCD02F8_57FE4DA6014A_impl*
 if (f_Alien <> nil) then
  f_Alien.RegetLists;
//#UC END# *57FE4DCD02F8_57FE4DA6014A_impl*
end;//TmsmElementListsService.RegetLists

procedure TmsmElementListsService.RegetViewedListsFor(aWord: TtfwWord;
 const aListName: AnsiString);
//#UC START# *57FF6A5703D7_57FE4DA6014A_var*
//#UC END# *57FF6A5703D7_57FE4DA6014A_var*
begin
//#UC START# *57FF6A5703D7_57FE4DA6014A_impl*
 if (f_Alien <> nil) then
  f_Alien.RegetViewedListsFor(aWord, aListName);
//#UC END# *57FF6A5703D7_57FE4DA6014A_impl*
end;//TmsmElementListsService.RegetViewedListsFor

class function TmsmElementListsService.Instance: TmsmElementListsService;
 {* Метод получения экземпляра синглетона TmsmElementListsService }
begin
 if (g_TmsmElementListsService = nil) then
 begin
  l3System.AddExitProc(TmsmElementListsServiceFree);
  g_TmsmElementListsService := Create;
 end;
 Result := g_TmsmElementListsService;
end;//TmsmElementListsService.Instance

class function TmsmElementListsService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmElementListsService <> nil;
end;//TmsmElementListsService.Exists

procedure TmsmElementListsService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TmsmElementListsService.ClearFields

end.
