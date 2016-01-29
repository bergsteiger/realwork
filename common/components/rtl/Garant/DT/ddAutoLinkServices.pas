unit ddAutoLinkServices;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DT"
// Модуль: "w:/common/components/rtl/Garant/DT/ddAutoLinkServices.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::DT::Autolink::ddAutoLinkServices
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  l3AutolinkService,
  l3Variant
  ;

type
 TddAutolinkService = {final} class(Tl3ProtoObject, Il3AutolinkService)
 public
 // realized methods
   function GetAutolinkFilter: Ik2TagGenerator;
   procedure CleanAutolinkFilter;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TddAutolinkService;
    {- возвращает экземпляр синглетона. }
 end;//TddAutolinkService
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base {a},
  ddAutoLinkFilter
  ;


// start class TddAutolinkService

var g_TddAutolinkService : TddAutolinkService = nil;

procedure TddAutolinkServiceFree;
begin
 l3Free(g_TddAutolinkService);
end;

class function TddAutolinkService.Instance: TddAutolinkService;
begin
 if (g_TddAutolinkService = nil) then
 begin
  l3System.AddExitProc(TddAutolinkServiceFree);
  g_TddAutolinkService := Create;
 end;
 Result := g_TddAutolinkService;
end;


class function TddAutolinkService.Exists: Boolean;
 {-}
begin
 Result := g_TddAutolinkService <> nil;
end;//TddAutolinkService.Exists

function TddAutolinkService.GetAutolinkFilter: Ik2TagGenerator;
//#UC START# *27BE83734EFD_552BF7B201EE_var*
//#UC END# *27BE83734EFD_552BF7B201EE_var*
begin
//#UC START# *27BE83734EFD_552BF7B201EE_impl*
 Result := ddAutoLinkFilter.GetAutolinkFilter;
//#UC END# *27BE83734EFD_552BF7B201EE_impl*
end;//TddAutolinkService.GetAutolinkFilter

procedure TddAutolinkService.CleanAutolinkFilter;
//#UC START# *A18BB0B1A222_552BF7B201EE_var*
//#UC END# *A18BB0B1A222_552BF7B201EE_var*
begin
//#UC START# *A18BB0B1A222_552BF7B201EE_impl*
 ddAutoLinkFilter.CleanAutolinkFilter;
//#UC END# *A18BB0B1A222_552BF7B201EE_impl*
end;//TddAutolinkService.CleanAutolinkFilter
{$IfEnd} //not Nemesis

initialization
{$If not defined(Nemesis)}
// Регистрация TddAutolinkService
 Tl3AutolinkService.Instance.Alien := TddAutolinkService.Instance;
{$IfEnd} //not Nemesis

end.