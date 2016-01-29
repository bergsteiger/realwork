unit nsDictCache;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Diction"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/nsDictCache.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������� ��������::Diction::Diction::Diction$Unit::TnsDictCache
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
  nsDictCachePrim
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDictCache = {final} class(TnsDictCachePrim)
 private
 // private fields
   f_Root : INodeBase;
 protected
 // realized methods
   function DoGetRoot: INodeBase; override;
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TnsDictCache;
    {- ���������� ��������� ����������. }
 end;//TnsDictCache
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


// start class TnsDictCache

var g_TnsDictCache : TnsDictCache = nil;

procedure TnsDictCacheFree;
begin
 l3Free(g_TnsDictCache);
end;

class function TnsDictCache.Instance: TnsDictCache;
begin
 if (g_TnsDictCache = nil) then
 begin
  l3System.AddExitProc(TnsDictCacheFree);
  g_TnsDictCache := Create;
 end;
 Result := g_TnsDictCache;
end;


class function TnsDictCache.Exists: Boolean;
 {-}
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

{$IfEnd} //not Admin AND not Monitorings

end.