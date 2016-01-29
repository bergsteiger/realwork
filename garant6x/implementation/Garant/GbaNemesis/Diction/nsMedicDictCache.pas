unit nsMedicDictCache;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Diction"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/nsMedicDictCache.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Diction::Diction::Diction$Unit::TnsMedicDictCache
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicTreeUnit,
  nsDictCachePrim
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsMedicDictCache = {final} class(TnsDictCachePrim)
 private
 // private fields
   f_Root : INodeBase;
 protected
 // realized methods
   function DoGetRoot: INodeBase; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsMedicDictCache;
    {- возвращает экземпляр синглетона. }
 end;//TnsMedicDictCache
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  DataAdapter,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnsMedicDictCache

var g_TnsMedicDictCache : TnsMedicDictCache = nil;

procedure TnsMedicDictCacheFree;
begin
 l3Free(g_TnsMedicDictCache);
end;

class function TnsMedicDictCache.Instance: TnsMedicDictCache;
begin
 if (g_TnsMedicDictCache = nil) then
 begin
  l3System.AddExitProc(TnsMedicDictCacheFree);
  g_TnsMedicDictCache := Create;
 end;
 Result := g_TnsMedicDictCache;
end;


class function TnsMedicDictCache.Exists: Boolean;
 {-}
begin
 Result := g_TnsMedicDictCache <> nil;
end;//TnsMedicDictCache.Exists

function TnsMedicDictCache.DoGetRoot: INodeBase;
//#UC START# *5571C22C03A5_556B331F03BE_var*
//#UC END# *5571C22C03A5_556B331F03BE_var*
begin
//#UC START# *5571C22C03A5_556B331F03BE_impl*
 Result := DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(c_MedDiction_NodeClass));
//#UC END# *5571C22C03A5_556B331F03BE_impl*
end;//TnsMedicDictCache.DoGetRoot

{$IfEnd} //not Admin AND not Monitorings

end.