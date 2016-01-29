unit nsTipsTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DayTips"
// Автор: Лукьянец Р.В,
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/DayTips/nsTipsTree.pas"
// Начат: 2008/02/21 06:56:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Интерфейсные элементы::DayTips::DayTips::DayTipsData::TnsTipsTree
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
  l3TreeInterfaces,
  nsDataResetTreeStruct,
  afwInterfaces,
  DynamicTreeUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsTipsTree = class(TnsDataResetTreeStruct)
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 protected
 // overridden protected methods
   function SettingsID: TafwSettingId; override;
 public
 // public methods
   class function Make: Il3SimpleTree;
 end;//TnsTipsTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  nsConst,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsTipsTree

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

{$IfEnd} //not Admin AND not Monitorings

end.