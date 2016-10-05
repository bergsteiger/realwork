unit tfwParserProgressService;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwParserProgressService.pas"
// Стереотип: "Service"
// Элемент модели: "TtfwParserProgressService" MUID: (57EE71E103BF)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Filer
;

 (*
 MtfwParserProgressService = interface
  {* Контракт сервиса TtfwParserProgressService }
  procedure TuneFiler(aFiler: Tl3CustomFiler);
 end;//MtfwParserProgressService
 *)

type
 ItfwParserProgressService = interface
  {* Интерфейс сервиса TtfwParserProgressService }
  procedure TuneFiler(aFiler: Tl3CustomFiler);
 end;//ItfwParserProgressService

 TtfwParserProgressService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ItfwParserProgressService;
    {* Внешняя реализация сервиса ItfwParserProgressService }
  protected
   procedure pm_SetAlien(const aValue: ItfwParserProgressService);
   procedure ClearFields; override;
  public
   procedure TuneFiler(aFiler: Tl3CustomFiler);
   class function Instance: TtfwParserProgressService;
    {* Метод получения экземпляра синглетона TtfwParserProgressService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: ItfwParserProgressService
    write pm_SetAlien;
    {* Внешняя реализация сервиса ItfwParserProgressService }
 end;//TtfwParserProgressService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57EE71E103BFimpl_uses*
 //#UC END# *57EE71E103BFimpl_uses*
;

var g_TtfwParserProgressService: TtfwParserProgressService = nil;
 {* Экземпляр синглетона TtfwParserProgressService }

procedure TtfwParserProgressServiceFree;
 {* Метод освобождения экземпляра синглетона TtfwParserProgressService }
begin
 l3Free(g_TtfwParserProgressService);
end;//TtfwParserProgressServiceFree

procedure TtfwParserProgressService.pm_SetAlien(const aValue: ItfwParserProgressService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TtfwParserProgressService.pm_SetAlien

procedure TtfwParserProgressService.TuneFiler(aFiler: Tl3CustomFiler);
//#UC START# *D5EA2D973852_57EE71E103BF_var*
//#UC END# *D5EA2D973852_57EE71E103BF_var*
begin
//#UC START# *D5EA2D973852_57EE71E103BF_impl*
 if (f_Alien <> nil) then
  f_Alien.TuneFiler(aFiler);
//#UC END# *D5EA2D973852_57EE71E103BF_impl*
end;//TtfwParserProgressService.TuneFiler

class function TtfwParserProgressService.Instance: TtfwParserProgressService;
 {* Метод получения экземпляра синглетона TtfwParserProgressService }
begin
 if (g_TtfwParserProgressService = nil) then
 begin
  l3System.AddExitProc(TtfwParserProgressServiceFree);
  g_TtfwParserProgressService := Create;
 end;
 Result := g_TtfwParserProgressService;
end;//TtfwParserProgressService.Instance

class function TtfwParserProgressService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwParserProgressService <> nil;
end;//TtfwParserProgressService.Exists

procedure TtfwParserProgressService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TtfwParserProgressService.ClearFields

end.
