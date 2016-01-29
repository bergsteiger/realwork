unit dsSelectedAttributes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Search"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Search/dsSelectedAttributes.pas"
// �����: 29.07.2005 17.07 
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Common For Shell And Monitoring::Search::Search::Search::TdsSelectedAttributes
//
// ������ ������ ����� "��������� �������� ������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  SearchInterfaces,
  SearchDomainInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  bsInterfaces
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 _FormDataSourceType_ = IdsSelectedAttributes;
 _InitDataType_ = IdeSelectedAttributes;
 {$Include ..\Search\dsTagSimpleTree.imp.pas}
 TdsSelectedAttributes = {final vac} class(_dsTagSimpleTree_, IdsSelectedAttributes)
  {* ������ ������ ����� "��������� �������� ������" }
 private
 // private fields
   f_RefreshValues : InsSelectedAttributesIterators;
 protected
 // realized methods
   function MakeSimpleTree: Il3SimpleTree; override;
     {* ������� ������ ������ }
   function pm_GetRefreshValues: InsSelectedAttributesIterators;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   {$If not defined(NoVCM)}
   procedure GotData; override;
     {* - ������ ����������. }
   {$IfEnd} //not NoVCM
 end;//TdsSelectedAttributes
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  SysUtils,
  bsUtils,
  l3Base,
  vtUtils,
  vtStdRes,
  DynamicTreeUnit,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

type _Instance_R_ = TdsSelectedAttributes;

{$Include ..\Search\dsTagSimpleTree.imp.pas}

// start class TdsSelectedAttributes

function TdsSelectedAttributes.MakeSimpleTree: Il3SimpleTree;
//#UC START# *47F4C2B9014A_49241B9903B7_var*
//#UC END# *47F4C2B9014A_49241B9903B7_var*
begin
//#UC START# *47F4C2B9014A_49241B9903B7_impl*
 Result := nil;
 Assert(false);
 // ���� ������ ����, �� ������ http://mdp.garant.ru/pages/viewpage.action?pageId=135605187
//#UC END# *47F4C2B9014A_49241B9903B7_impl*
end;//TdsSelectedAttributes.MakeSimpleTree

function TdsSelectedAttributes.pm_GetRefreshValues: InsSelectedAttributesIterators;
//#UC START# *49241D5D01C0_49241B9903B7get_var*
//#UC END# *49241D5D01C0_49241B9903B7get_var*
begin
//#UC START# *49241D5D01C0_49241B9903B7get_impl*
 Result := f_RefreshValues;
//#UC END# *49241D5D01C0_49241B9903B7get_impl*
end;//TdsSelectedAttributes.pm_GetRefreshValues

procedure TdsSelectedAttributes.Cleanup;
//#UC START# *479731C50290_49241B9903B7_var*
//#UC END# *479731C50290_49241B9903B7_var*
begin
//#UC START# *479731C50290_49241B9903B7_impl*
 f_RefreshValues := nil;
 inherited;
//#UC END# *479731C50290_49241B9903B7_impl*
end;//TdsSelectedAttributes.Cleanup

{$If not defined(NoVCM)}
procedure TdsSelectedAttributes.GotData;
//#UC START# *492ACF630072_49241B9903B7_var*
//#UC END# *492ACF630072_49241B9903B7_var*
begin
//#UC START# *492ACF630072_49241B9903B7_impl*
 inherited;
 f_RefreshValues := PartData.RefreshValues;
//#UC END# *492ACF630072_49241B9903B7_impl*
end;//TdsSelectedAttributes.GotData
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin

end.