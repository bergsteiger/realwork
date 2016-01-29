unit f1VersionInfoService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/f1VersionInfoService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ServiceImplementation::Class>> Shared Delphi Low Level::L3::VersionInfo::Tf1VersionInfoService
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

{$If defined(Nemesis)}
uses
  l3ProtoObject,
  l3VersionInfoService
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
//#UC START# *55DDD0110086ci*
//#UC END# *55DDD0110086ci*
//#UC START# *55DDD0110086cit*
//#UC END# *55DDD0110086cit*
 Tf1VersionInfoService = {final} class(Tl3ProtoObject, Il3VersionInfoService)
 public
 // realized methods
   function VersionInfo: AnsiString;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
//#UC START# *55DDD0110086publ*
//#UC END# *55DDD0110086publ*
 public
 // singleton factory method
   class function Instance: Tf1VersionInfoService;
    {- возвращает экземпляр синглетона. }
 end;//Tf1VersionInfoService
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3Base {a}
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}


// start class Tf1VersionInfoService

var g_Tf1VersionInfoService : Tf1VersionInfoService = nil;

procedure Tf1VersionInfoServiceFree;
begin
 l3Free(g_Tf1VersionInfoService);
end;

class function Tf1VersionInfoService.Instance: Tf1VersionInfoService;
begin
 if (g_Tf1VersionInfoService = nil) then
 begin
  l3System.AddExitProc(Tf1VersionInfoServiceFree);
  g_Tf1VersionInfoService := Create;
 end;
 Result := g_Tf1VersionInfoService;
end;


class function Tf1VersionInfoService.Exists: Boolean;
 {-}
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

//#UC START# *55DDD0110086impl*
//#UC END# *55DDD0110086impl*

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis)}
// Регистрация Tf1VersionInfoService
 Tl3VersionInfoService.Instance.Alien := Tf1VersionInfoService.Instance;
{$IfEnd} //Nemesis

end.