unit nsDayTipsDictCache;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsDayTipsDictCache.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDictCachePrim
 , DynamicTreeUnit
;

type
 TnsDayTipsDictCache = class(TnsDictCachePrim)
  private
   f_Root: INodeBase;
  protected
   function DoGetRoot: INodeBase; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsDayTipsDictCache;
    {* Метод получения экземпляра синглетона TnsDayTipsDictCache }
 end;//TnsDayTipsDictCache
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , nsTypes
 , SysUtils
 , l3Base
;

var g_TnsDayTipsDictCache: TnsDayTipsDictCache = nil;
 {* Экземпляр синглетона TnsDayTipsDictCache }

procedure TnsDayTipsDictCacheFree;
 {* Метод освобождения экземпляра синглетона TnsDayTipsDictCache }
begin
 l3Free(g_TnsDayTipsDictCache);
end;//TnsDayTipsDictCacheFree

class function TnsDayTipsDictCache.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
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

class function TnsDayTipsDictCache.Instance: TnsDayTipsDictCache;
 {* Метод получения экземпляра синглетона TnsDayTipsDictCache }
begin
 if (g_TnsDayTipsDictCache = nil) then
 begin
  l3System.AddExitProc(TnsDayTipsDictCacheFree);
  g_TnsDayTipsDictCache := Create;
 end;
 Result := g_TnsDayTipsDictCache;
end;//TnsDayTipsDictCache.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
