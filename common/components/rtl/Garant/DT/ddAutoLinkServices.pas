unit ddAutoLinkServices;

// Модуль: "w:\common\components\rtl\Garant\DT\ddAutoLinkServices.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddAutoLinkServices" MUID: (552BF78902EE)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3AutolinkService
 , l3Variant
;

type
 TddAutolinkService = {final} class(Tl3ProtoObject, Il3AutolinkService)
  public
   function GetAutolinkFilter: Ik2TagGenerator;
   procedure CleanAutolinkFilter;
   class function Instance: TddAutolinkService;
    {* Метод получения экземпляра синглетона TddAutolinkService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TddAutolinkService
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ddAutoLinkFilter
 , SysUtils
 , l3Base
 //#UC START# *552BF78902EEimpl_uses*
 , ddGeneralLawsLinkFinder
 //#UC END# *552BF78902EEimpl_uses*
;

var g_TddAutolinkService: TddAutolinkService = nil;
 {* Экземпляр синглетона TddAutolinkService }

procedure TddAutolinkServiceFree;
 {* Метод освобождения экземпляра синглетона TddAutolinkService }
begin
 l3Free(g_TddAutolinkService);
end;//TddAutolinkServiceFree

function TddAutolinkService.GetAutolinkFilter: Ik2TagGenerator;
//#UC START# *552BF6BD0156_552BF7B201EE_var*
var
 l_Filter: TddAutoLinkFilter;
//#UC END# *552BF6BD0156_552BF7B201EE_var*
begin
//#UC START# *552BF6BD0156_552BF7B201EE_impl*
 l_Filter := TddAutoLinkFilter.Create(nil);
 try
  l_Filter.AddLinkFinder(ddGetGeneralLawsLinkFinderDef);
  Result := l_Filter;
 finally
  FreeAndNil(l_Filter);
 end;
//#UC END# *552BF6BD0156_552BF7B201EE_impl*
end;//TddAutolinkService.GetAutolinkFilter

procedure TddAutolinkService.CleanAutolinkFilter;
//#UC START# *552BF6FF02A9_552BF7B201EE_var*
//#UC END# *552BF6FF02A9_552BF7B201EE_var*
begin
//#UC START# *552BF6FF02A9_552BF7B201EE_impl*
 ddGeneralLawsLinkFinderCleanup;
//#UC END# *552BF6FF02A9_552BF7B201EE_impl*
end;//TddAutolinkService.CleanAutolinkFilter

class function TddAutolinkService.Instance: TddAutolinkService;
 {* Метод получения экземпляра синглетона TddAutolinkService }
begin
 if (g_TddAutolinkService = nil) then
 begin
  l3System.AddExitProc(TddAutolinkServiceFree);
  g_TddAutolinkService := Create;
 end;
 Result := g_TddAutolinkService;
end;//TddAutolinkService.Instance

class function TddAutolinkService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TddAutolinkService <> nil;
end;//TddAutolinkService.Exists

initialization
 Tl3AutolinkService.Instance.Alien := TddAutolinkService.Instance;
 {* Регистрация TddAutolinkService }
{$IfEnd} // NOT Defined(Nemesis)

end.
