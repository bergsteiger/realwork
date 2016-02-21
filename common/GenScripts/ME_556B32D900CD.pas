unit nsDictCache;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsDictCache.pas"
// ���������: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDictCachePrim
 , DynamicTreeUnit
;

type
 TnsDictCache = {final} class(TnsDictCachePrim)
  private
   f_Root: INodeBase;
  protected
   function DoGetRoot: INodeBase; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsDictCache;
    {* ����� ��������� ���������� ���������� TnsDictCache }
 end;//TnsDictCache
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

var g_TnsDictCache: TnsDictCache = nil;
 {* ��������� ���������� TnsDictCache }

procedure TnsDictCacheFree;
 {* ����� ������������ ���������� ���������� TnsDictCache }
begin
 l3Free(g_TnsDictCache);
end;//TnsDictCacheFree

class function TnsDictCache.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsDictCache <> nil;
end;//TnsDictCache.Exists

function TnsDictCache.DoGetRoot: INodeBase;
//#UC START# *5571C22C03A5_556B32D900CD_var*
//#UC END# *5571C22C03A5_556B32D900CD_var*
begin
//#UC START# *5571C22C03A5_556B32D900CD_impl*
 Result := DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(c_Diction_NodeClass));
//#UC END# *5571C22C03A5_556B32D900CD_impl*
end;//TnsDictCache.DoGetRoot

class function TnsDictCache.Instance: TnsDictCache;
 {* ����� ��������� ���������� ���������� TnsDictCache }
begin
 if (g_TnsDictCache = nil) then
 begin
  l3System.AddExitProc(TnsDictCacheFree);
  g_TnsDictCache := Create;
 end;
 Result := g_TnsDictCache;
end;//TnsDictCache.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
