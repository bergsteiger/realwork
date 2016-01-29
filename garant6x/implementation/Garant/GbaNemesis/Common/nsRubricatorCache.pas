unit nsRubricatorCache;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Common$Lib"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsRubricatorCache.pas"
// �����: 2003/06/10 12:57:53
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::Rubricator::TnsRubricatorCache
//
// �����-�� ���, ������� �� ����� ���� ������ �� ��������, � �������� ����� � ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicTreeUnit,
  l3CacheableBase
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsRubricatorCache = class(Tl3CacheableBase)
  {* �����-�� ���, ������� �� ����� ���� ������ �� ��������, � �������� ����� � �������� }
 protected
 // property methods
   function pm_GetRubricatorRoot: INodeBase;
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // public properties
   property RubricatorRoot: INodeBase
     read pm_GetRubricatorRoot;
 public
 // singleton factory method
   class function Instance: TnsRubricatorCache;
    {- ���������� ��������� ����������. }
 end;//TnsRubricatorCache
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  DataAdapter,
  BaseTypesUnit,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnsRubricatorCache

var g_TnsRubricatorCache : TnsRubricatorCache = nil;

procedure TnsRubricatorCacheFree;
begin
 l3Free(g_TnsRubricatorCache);
end;

class function TnsRubricatorCache.Instance: TnsRubricatorCache;
begin
 if (g_TnsRubricatorCache = nil) then
 begin
  l3System.AddExitProc(TnsRubricatorCacheFree);
  g_TnsRubricatorCache := Create;
 end;
 Result := g_TnsRubricatorCache;
end;


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
 {-}
begin
 Result := g_TnsRubricatorCache <> nil;
end;//TnsRubricatorCache.Exists

{$IfEnd} //not Admin AND not Monitorings

end.