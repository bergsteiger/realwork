unit f1VersionInfoService;

// Модуль: "w:\common\components\rtl\Garant\L3\f1VersionInfoService.pas"
// Стереотип: "ServiceImplementation"

{$Include l3Define.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3VersionInfoService
;

type
 //#UC START# *55DDD0110086ci*
 //#UC END# *55DDD0110086ci*
 //#UC START# *55DDD0110086cit*
 //#UC END# *55DDD0110086cit*
 Tf1VersionInfoService = {final} class(Tl3ProtoObject, Il3VersionInfoService)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function VersionInfo: AnsiString;
   class function Instance: Tf1VersionInfoService;
    {* Метод получения экземпляра синглетона Tf1VersionInfoService }
 //#UC START# *55DDD0110086publ*
 //#UC END# *55DDD0110086publ*
 end;//Tf1VersionInfoService
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tf1VersionInfoService: Tf1VersionInfoService = nil;
 {* Экземпляр синглетона Tf1VersionInfoService }

procedure Tf1VersionInfoServiceFree;
 {* Метод освобождения экземпляра синглетона Tf1VersionInfoService }
begin
 l3Free(g_Tf1VersionInfoService);
end;//Tf1VersionInfoServiceFree

class function Tf1VersionInfoService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tf1VersionInfoService <> nil;
end;//Tf1VersionInfoService.Exists

function Tf1VersionInfoService.VersionInfo: AnsiString;
//#UC START# *30F5EA5AF6DF_55DDD0110086_var*
{$Include nsBuildVersion.inc}
//#UC END# *30F5EA5AF6DF_55DDD0110086_var*
begin
//#UC START# *30F5EA5AF6DF_55DDD0110086_impl*
 Result := c_BuildVersion;
 if (Result = 'X.XX.X.XXX') then
  Result := '';
//#UC END# *30F5EA5AF6DF_55DDD0110086_impl*
end;//Tf1VersionInfoService.VersionInfo

class function Tf1VersionInfoService.Instance: Tf1VersionInfoService;
 {* Метод получения экземпляра синглетона Tf1VersionInfoService }
begin
 if (g_Tf1VersionInfoService = nil) then
 begin
  l3System.AddExitProc(Tf1VersionInfoServiceFree);
  g_Tf1VersionInfoService := Create;
 end;
 Result := g_Tf1VersionInfoService;
end;//Tf1VersionInfoService.Instance

//#UC START# *55DDD0110086impl*
//#UC END# *55DDD0110086impl*

initialization
 Tl3VersionInfoService.Instance.Alien := Tf1VersionInfoService.Instance;
 {* Регистрация Tf1VersionInfoService }
{$IfEnd} // Defined(Nemesis)

end.
