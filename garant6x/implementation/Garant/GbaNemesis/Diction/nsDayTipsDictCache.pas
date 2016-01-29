unit nsDayTipsDictCache;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Diction"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/nsDayTipsDictCache.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Diction::Diction::Diction$Unit::TnsDayTipsDictCache
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
 TnsDayTipsDictCache = class(TnsDictCachePrim)
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
   class function Instance: TnsDayTipsDictCache;
    {- возвращает экземпляр синглетона. }
 end;//TnsDayTipsDictCache
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


// start class TnsDayTipsDictCache

var g_TnsDayTipsDictCache : TnsDayTipsDictCache = nil;

procedure TnsDayTipsDictCacheFree;
begin
 l3Free(g_TnsDayTipsDictCache);
end;

class function TnsDayTipsDictCache.Instance: TnsDayTipsDictCache;
begin
 if (g_TnsDayTipsDictCache = nil) then
 begin
  l3System.AddExitProc(TnsDayTipsDictCacheFree);
  g_TnsDayTipsDictCache := Create;
 end;
 Result := g_TnsDayTipsDictCache;
end;


class function TnsDayTipsDictCache.Exists: Boolean;
 {-}
begin
 Result := g_TnsDayTipsDictCache <> nil;
end;//TnsDayTipsDictCache.Exists

function TnsDayTipsDictCache.DoGetRoot: INodeBase;
//#UC START# *5571C22C03A5_5571B3100338_var*
//#UC END# *5571C22C03A5_5571B3100338_var*
begin
//#UC START# *5571C22C03A5_5571B3100338_impl*
 defDataAdapter.NativeAdapter.MakeTipsManager.GetTipsTreeRoot(Result);
//#UC END# *5571C22C03A5_5571B3100338_impl*
end;//TnsDayTipsDictCache.DoGetRoot

{$IfEnd} //not Admin AND not Monitorings

end.