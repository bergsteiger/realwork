unit vcmNodes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmNodes.pas"
// Начат: 15.01.2007 21:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::vcmCore::TvcmNodes
//
// Список нод.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _ItemType_ = IvcmNode;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TvcmNodes = class(_l3InterfaceRefList_, IvcmNodes)
  {* Список нод. }
 private
 // private fields
   f_PlainLevel : Integer;
   f_ShowRoot : Boolean;
   f_Tree : IvcmTree;
   f_Current : IvcmNode;
 protected
 // realized methods
   function Get_Current: IvcmNode;
   procedure Set_Current(const aValue: IvcmNode);
   function Get_PlainLevel: Integer;
   procedure Set_PlainLevel(aValue: Integer);
   function Get_ShowRoot: Boolean;
   procedure Set_ShowRoot(aValue: Boolean);
   function Get_Tree: IvcmTree;
   procedure Set_Tree(const aValue: IvcmTree);
   function pm_GetCount: Integer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   class function MakeI: IvcmNodes; reintroduce;
 end;//TvcmNodes
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

type _Instance_R_ = TvcmNodes;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

// start class TvcmNodes

class function TvcmNodes.MakeI: IvcmNodes;
var
 l_Inst : TvcmNodes;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmNodes.Get_Current: IvcmNode;
//#UC START# *4683D67D025B_47DF707B01E2get_var*
//#UC END# *4683D67D025B_47DF707B01E2get_var*
begin
//#UC START# *4683D67D025B_47DF707B01E2get_impl*
 Result := f_Current;
//#UC END# *4683D67D025B_47DF707B01E2get_impl*
end;//TvcmNodes.Get_Current

procedure TvcmNodes.Set_Current(const aValue: IvcmNode);
//#UC START# *4683D67D025B_47DF707B01E2set_var*
//#UC END# *4683D67D025B_47DF707B01E2set_var*
begin
//#UC START# *4683D67D025B_47DF707B01E2set_impl*
 f_Current := aValue;
//#UC END# *4683D67D025B_47DF707B01E2set_impl*
end;//TvcmNodes.Set_Current

function TvcmNodes.Get_PlainLevel: Integer;
//#UC START# *476948E60097_47DF707B01E2get_var*
//#UC END# *476948E60097_47DF707B01E2get_var*
begin
//#UC START# *476948E60097_47DF707B01E2get_impl*
 Result := f_PlainLevel;
//#UC END# *476948E60097_47DF707B01E2get_impl*
end;//TvcmNodes.Get_PlainLevel

procedure TvcmNodes.Set_PlainLevel(aValue: Integer);
//#UC START# *476948E60097_47DF707B01E2set_var*
//#UC END# *476948E60097_47DF707B01E2set_var*
begin
//#UC START# *476948E60097_47DF707B01E2set_impl*
 f_PlainLevel := aValue;
//#UC END# *476948E60097_47DF707B01E2set_impl*
end;//TvcmNodes.Set_PlainLevel

function TvcmNodes.Get_ShowRoot: Boolean;
//#UC START# *47694900005D_47DF707B01E2get_var*
//#UC END# *47694900005D_47DF707B01E2get_var*
begin
//#UC START# *47694900005D_47DF707B01E2get_impl*
 Result := f_ShowRoot;
//#UC END# *47694900005D_47DF707B01E2get_impl*
end;//TvcmNodes.Get_ShowRoot

procedure TvcmNodes.Set_ShowRoot(aValue: Boolean);
//#UC START# *47694900005D_47DF707B01E2set_var*
//#UC END# *47694900005D_47DF707B01E2set_var*
begin
//#UC START# *47694900005D_47DF707B01E2set_impl*
 f_ShowRoot := aValue;
//#UC END# *47694900005D_47DF707B01E2set_impl*
end;//TvcmNodes.Set_ShowRoot

function TvcmNodes.Get_Tree: IvcmTree;
//#UC START# *47F9C46D00CA_47DF707B01E2get_var*
//#UC END# *47F9C46D00CA_47DF707B01E2get_var*
begin
//#UC START# *47F9C46D00CA_47DF707B01E2get_impl*
 Result := f_Tree;
//#UC END# *47F9C46D00CA_47DF707B01E2get_impl*
end;//TvcmNodes.Get_Tree

procedure TvcmNodes.Set_Tree(const aValue: IvcmTree);
//#UC START# *47F9C46D00CA_47DF707B01E2set_var*
//#UC END# *47F9C46D00CA_47DF707B01E2set_var*
begin
//#UC START# *47F9C46D00CA_47DF707B01E2set_impl*
 f_Tree := aValue;
//#UC END# *47F9C46D00CA_47DF707B01E2set_impl*
end;//TvcmNodes.Set_Tree

function TvcmNodes.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_47DF707B01E2get_var*
//#UC END# *4BB08B8902F2_47DF707B01E2get_var*
begin
//#UC START# *4BB08B8902F2_47DF707B01E2get_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_47DF707B01E2get_impl*
end;//TvcmNodes.pm_GetCount

procedure TvcmNodes.Cleanup;
//#UC START# *479731C50290_47DF707B01E2_var*
//#UC END# *479731C50290_47DF707B01E2_var*
begin
//#UC START# *479731C50290_47DF707B01E2_impl*
 f_Tree := nil;
 f_Current := nil;
 inherited;
//#UC END# *479731C50290_47DF707B01E2_impl*
end;//TvcmNodes.Cleanup

procedure TvcmNodes.InitFields;
//#UC START# *47A042E100E2_47DF707B01E2_var*
//#UC END# *47A042E100E2_47DF707B01E2_var*
begin
//#UC START# *47A042E100E2_47DF707B01E2_impl*
 inherited;
 f_PlainLevel := High(f_PlainLevel);
 f_ShowRoot := false;
//#UC END# *47A042E100E2_47DF707B01E2_impl*
end;//TvcmNodes.InitFields

{$IfEnd} //not NoVCM

end.