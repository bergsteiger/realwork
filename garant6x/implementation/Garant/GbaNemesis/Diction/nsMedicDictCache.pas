unit nsMedicDictCache;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsMedicDictCache.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsMedicDictCache" MUID: (556B331F03BE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDictCachePrim
 , DynamicTreeUnit
;

type
 TnsMedicDictCache = {final} class(TnsDictCachePrim)
  private
   f_Root: INodeBase;
  protected
   function DoGetRoot: INodeBase; override;
  public
   class function Instance: TnsMedicDictCache;
    {* ����� ��������� ���������� ���������� TnsMedicDictCache }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsMedicDictCache
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , nsTypes
 , SysUtils
 , l3Base
 //#UC START# *556B331F03BEimpl_uses*
 //#UC END# *556B331F03BEimpl_uses*
;

var g_TnsMedicDictCache: TnsMedicDictCache = nil;
 {* ��������� ���������� TnsMedicDictCache }

procedure TnsMedicDictCacheFree;
 {* ����� ������������ ���������� ���������� TnsMedicDictCache }
begin
 l3Free(g_TnsMedicDictCache);
end;//TnsMedicDictCacheFree

function TnsMedicDictCache.DoGetRoot: INodeBase;
//#UC START# *5571C22C03A5_556B331F03BE_var*
//#UC END# *5571C22C03A5_556B331F03BE_var*
begin
//#UC START# *5571C22C03A5_556B331F03BE_impl*
 Result := DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(c_MedDiction_NodeClass));
//#UC END# *5571C22C03A5_556B331F03BE_impl*
end;//TnsMedicDictCache.DoGetRoot

class function TnsMedicDictCache.Instance: TnsMedicDictCache;
 {* ����� ��������� ���������� ���������� TnsMedicDictCache }
begin
 if (g_TnsMedicDictCache = nil) then
 begin
  l3System.AddExitProc(TnsMedicDictCacheFree);
  g_TnsMedicDictCache := Create;
 end;
 Result := g_TnsMedicDictCache;
end;//TnsMedicDictCache.Instance

class function TnsMedicDictCache.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsMedicDictCache <> nil;
end;//TnsMedicDictCache.Exists
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
