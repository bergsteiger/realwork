unit nsAttrBranchStruct;
 {* ������������ ��� ����������� ������� ������ ������ � ������������� ��� (������ 5.�) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsAttrBranchStruct.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsAttrBranchStruct" MUID: (4909E1DD038F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsAttributeOneLevelTreeStruct
 , bsInterfaces
 , DynamicTreeUnit
 , nsFilterableTreeStruct
 , l3TreeInterfaces
;

type
 TnsAttrBranchStruct = class(TnsAttributeOneLevelTreeStruct, InsRootInfo)
  {* ������������ ��� ����������� ������� ������ ������ � ������������� ��� (������ 5.�) }
  private
   f_RootInfoNode: INodeBase;
    {* �������, ��� ���? }
  protected
   function pm_GetRoot: INodeBase;
   procedure pm_SetRoot(const aValue: INodeBase);
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   constructor CreateFiltered(const aNewRoot: INodeBase;
    aSource: TnsFilterableTreeStruct;
    const aFilters: Il3TreeFilters); override;
   function CanFiltrate: Boolean; override;
 end;//TnsAttrBranchStruct

implementation

uses
 l3ImplUses
;

function TnsAttrBranchStruct.pm_GetRoot: INodeBase;
//#UC START# *4909E0C00304_4909E1DD038Fget_var*
//#UC END# *4909E0C00304_4909E1DD038Fget_var*
begin
//#UC START# *4909E0C00304_4909E1DD038Fget_impl*
 Result := f_RootInfoNode;
//#UC END# *4909E0C00304_4909E1DD038Fget_impl*
end;//TnsAttrBranchStruct.pm_GetRoot

procedure TnsAttrBranchStruct.pm_SetRoot(const aValue: INodeBase);
//#UC START# *4909E0C00304_4909E1DD038Fset_var*
//#UC END# *4909E0C00304_4909E1DD038Fset_var*
begin
//#UC START# *4909E0C00304_4909E1DD038Fset_impl*
 f_RootInfoNode := aValue;
//#UC END# *4909E0C00304_4909E1DD038Fset_impl*
end;//TnsAttrBranchStruct.pm_SetRoot

procedure TnsAttrBranchStruct.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4909E1DD038F_var*
//#UC END# *479731C50290_4909E1DD038F_var*
begin
//#UC START# *479731C50290_4909E1DD038F_impl*
 inherited;
 // �������� ��� �� ������ ���� ��������� _�����_ ���������� ������ ���� (��������
 // ������� ����� ��������� ����
 // ��25433
 f_RootInfoNode := nil;
//#UC END# *479731C50290_4909E1DD038F_impl*
end;//TnsAttrBranchStruct.Cleanup

constructor TnsAttrBranchStruct.CreateFiltered(const aNewRoot: INodeBase;
 aSource: TnsFilterableTreeStruct;
 const aFilters: Il3TreeFilters);
//#UC START# *48FF458602EC_4909E1DD038F_var*
//#UC END# *48FF458602EC_4909E1DD038F_var*
begin
//#UC START# *48FF458602EC_4909E1DD038F_impl*
 inherited CreateFiltered(aNewRoot, aSource, aFilters);
 if aSource is TnsAttrBranchStruct then
  f_RootInfoNode := TnsAttrBranchStruct(aSource).f_RootInfoNode;
//#UC END# *48FF458602EC_4909E1DD038F_impl*
end;//TnsAttrBranchStruct.CreateFiltered

function TnsAttrBranchStruct.CanFiltrate: Boolean;
//#UC START# *48FF4C3A00C4_4909E1DD038F_var*
//#UC END# *48FF4C3A00C4_4909E1DD038F_var*
begin
//#UC START# *48FF4C3A00C4_4909E1DD038F_impl*
 Result := False;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=122650660
//#UC END# *48FF4C3A00C4_4909E1DD038F_impl*
end;//TnsAttrBranchStruct.CanFiltrate

end.
