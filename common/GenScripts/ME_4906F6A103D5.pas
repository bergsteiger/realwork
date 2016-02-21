unit nsTipsTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\DayTips\nsTipsTree.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTreeStruct
 , l3TreeInterfaces
 , DynamicTreeUnit
 , afwInterfaces
;

type
 TnsTipsTree = class(TnsDataResetTreeStruct)
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function SettingsID: TafwSettingId; override;
  public
   class function Make: Il3SimpleTree;
 end;//TnsTipsTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , nsConst
 , SysUtils
;

class function TnsTipsTree.Make: Il3SimpleTree;
//#UC START# *4906F6FD017E_4906F6A103D5_var*
var
 l_Tree : TnsTipsTree;
 l_Root : INodeBase;
//#UC END# *4906F6FD017E_4906F6A103D5_var*
begin
//#UC START# *4906F6FD017E_4906F6A103D5_impl*
 with defDataAdapter.NativeAdapter.MakeTipsManager do
 begin
  if not IsExist then
  begin
   Result := nil;
   Exit;
  end;
  GetTipsTreeRoot(l_Root);
 end;
 l_Tree := Create(l_Root, False);
 try
  Result := l_Tree;
 finally;
  FreeAndNil(l_Tree);
 end;//try..finally
//#UC END# *4906F6FD017E_4906F6A103D5_impl*
end;//TnsTipsTree.Make

function TnsTipsTree.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_4906F6A103D5_var*
//#UC END# *48FF64F60078_4906F6A103D5_var*
begin
//#UC START# *48FF64F60078_4906F6A103D5_impl*
 defDataAdapter.NativeAdapter.MakeTipsManager.GetTipsTreeRoot(Result);
//#UC END# *48FF64F60078_4906F6A103D5_impl*
end;//TnsTipsTree.ReAqurieUnfilteredRoot

function TnsTipsTree.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_4906F6A103D5_var*
//#UC END# *48FF56D003E6_4906F6A103D5_var*
begin
//#UC START# *48FF56D003E6_4906F6A103D5_impl*
 Result := gi_cpDayTips;
//#UC END# *48FF56D003E6_4906F6A103D5_impl*
end;//TnsTipsTree.SettingsID
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
