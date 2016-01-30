unit nsRubricatorCache;
 {* �����-�� ���, ������� �� ����� ���� ������ �� ��������, � �������� ����� � �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsRubricatorCache.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3CacheableBase
 , DynamicTreeUnit
;

type
 TnsRubricatorCache = class(Tl3CacheableBase)
  {* �����-�� ���, ������� �� ����� ���� ������ �� ��������, � �������� ����� � �������� }
  protected
   function pm_GetRubricatorRoot: INodeBase;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsRubricatorCache;
    {* ����� ��������� ���������� ���������� TnsRubricatorCache }
  public
   property RubricatorRoot: INodeBase
    read pm_GetRubricatorRoot;
 end;//TnsRubricatorCache
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , BaseTypesUnit
 , nsTypes
 , SysUtils
 , l3Base
;

var g_TnsRubricatorCache: TnsRubricatorCache = nil;
 {* ��������� ���������� TnsRubricatorCache }

procedure TnsRubricatorCacheFree;
 {* ����� ������������ ���������� ���������� TnsRubricatorCache }
begin
 l3Free(g_TnsRubricatorCache);
end;//TnsRubricatorCacheFree

function TnsRubricatorCache.pm_GetRubricatorRoot: INodeBase;
//#UC START# *4908807B02FD_490724F202F5get_var*
//#UC END# *4908807B02FD_490724F202F5get_var*
begin
//#UC START# *4908807B02FD_490724F202F5get_impl*
 try
  Result := DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(c_MainMenu_NodeClass));
 except
  on ECanNotFindData do
  begin
   Result := nil;
   Assert(False);
  end; 
 end
//#UC END# *4908807B02FD_490724F202F5get_impl*
end;//TnsRubricatorCache.pm_GetRubricatorRoot

class function TnsRubricatorCache.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsRubricatorCache <> nil;
end;//TnsRubricatorCache.Exists

class function TnsRubricatorCache.Instance: TnsRubricatorCache;
 {* ����� ��������� ���������� ���������� TnsRubricatorCache }
begin
 if (g_TnsRubricatorCache = nil) then
 begin
  l3System.AddExitProc(TnsRubricatorCacheFree);
  g_TnsRubricatorCache := Create;
 end;
 Result := g_TnsRubricatorCache;
end;//TnsRubricatorCache.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
