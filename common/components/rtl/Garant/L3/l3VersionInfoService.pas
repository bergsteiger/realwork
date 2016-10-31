unit l3VersionInfoService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3VersionInfoService.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3VersionInfoService" MUID: (55DDCF7C004A)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3VersionInfoService = interface
  {* Контракт сервиса Tl3VersionInfoService }
  function VersionInfo: AnsiString;
 end;//Ml3VersionInfoService
 *)

type
 Il3VersionInfoService = interface
  {* Интерфейс сервиса Tl3VersionInfoService }
  function VersionInfo: AnsiString;
 end;//Il3VersionInfoService

 Tl3VersionInfoService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3VersionInfoService;
    {* Внешняя реализация сервиса Il3VersionInfoService }
  protected
   procedure pm_SetAlien(const aValue: Il3VersionInfoService);
   procedure ClearFields; override;
  public
   function VersionInfo: AnsiString;
   class function Instance: Tl3VersionInfoService;
    {* Метод получения экземпляра синглетона Tl3VersionInfoService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3VersionInfoService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3VersionInfoService }
 end;//Tl3VersionInfoService

implementation

uses
 l3ImplUses
 , vtVerInf
 , SysUtils
 , l3Base
 //#UC START# *55DDCF7C004Aimpl_uses*
 //#UC END# *55DDCF7C004Aimpl_uses*
;

var g_Tl3VersionInfoService: Tl3VersionInfoService = nil;
 {* Экземпляр синглетона Tl3VersionInfoService }

procedure Tl3VersionInfoServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3VersionInfoService }
begin
 l3Free(g_Tl3VersionInfoService);
end;//Tl3VersionInfoServiceFree

procedure Tl3VersionInfoService.pm_SetAlien(const aValue: Il3VersionInfoService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3VersionInfoService.pm_SetAlien

function Tl3VersionInfoService.VersionInfo: AnsiString;
//#UC START# *55DDCFBE0096_55DDCF7C004A_var*
//#UC END# *55DDCFBE0096_55DDCF7C004A_var*
begin
//#UC START# *55DDCFBE0096_55DDCF7C004A_impl*
 Result := '';
 if (f_Alien <> nil) then
  Result := f_Alien.VersionInfo;
 if (Result = '') then
 begin
  with TVersionInfo.Create do
  try
   if (FixedFileInfo <> nil) then
    with FileLongVersion do
    begin
     Result := (Format('%d.%d.%d.%d', [All[2], All[1], All[4], All[3]]));
    end;//with FileLongVersion
  finally
   Free;
  end;//try..finally
 end;//Result = ''
//#UC END# *55DDCFBE0096_55DDCF7C004A_impl*
end;//Tl3VersionInfoService.VersionInfo

class function Tl3VersionInfoService.Instance: Tl3VersionInfoService;
 {* Метод получения экземпляра синглетона Tl3VersionInfoService }
begin
 if (g_Tl3VersionInfoService = nil) then
 begin
  l3System.AddExitProc(Tl3VersionInfoServiceFree);
  g_Tl3VersionInfoService := Create;
 end;
 Result := g_Tl3VersionInfoService;
end;//Tl3VersionInfoService.Instance

class function Tl3VersionInfoService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3VersionInfoService <> nil;
end;//Tl3VersionInfoService.Exists

procedure Tl3VersionInfoService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3VersionInfoService.ClearFields

end.
