unit dsAttributes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Business"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsAttributes.pas"
// �����: 2005/08/15 14:06:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::BaseDocument::TdsAttributes
//
// ������ ������ ����� "���������� � ���������"
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
  DocumentAndListInterfaces,
  DocumentInterfaces,
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
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _InitDataType_ = IdeDocInfo;
 _FormDataSourceType_ = IdsAttributes;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
 TdsAttributes = {vac} class(_dsSimpleTree_, IdsAttributes)
  {* ������ ������ ����� "���������� � ���������" }
 protected
 // realized methods
   function MakeSimpleTree: Il3SimpleTree; override;
     {* ������� ������ ������ }
   function pm_GetDocInfo: IdeDocInfo;
 end;//TdsAttributes
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDocAttributeTreeStruct,
  SysUtils,
  l3Base,
  vtUtils,
  vtStdRes,
  DynamicTreeUnit,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsAttributes;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}

// start class TdsAttributes

function TdsAttributes.MakeSimpleTree: Il3SimpleTree;
//#UC START# *47F4C2B9014A_49255F4302EE_var*
//#UC END# *47F4C2B9014A_49255F4302EE_var*
begin
//#UC START# *47F4C2B9014A_49255F4302EE_impl*
 if Assigned(PartData) and Assigned(PartData.Doc) then
  Result := TnsDocAttributeTreeStruct.Make(PartData.Doc)
 else
  Result := nil; 
//#UC END# *47F4C2B9014A_49255F4302EE_impl*
end;//TdsAttributes.MakeSimpleTree

function TdsAttributes.pm_GetDocInfo: IdeDocInfo;
//#UC START# *49255D4A0215_49255F4302EEget_var*
//#UC END# *49255D4A0215_49255F4302EEget_var*
begin
//#UC START# *49255D4A0215_49255F4302EEget_impl*
 Result := PartData;
//#UC END# *49255D4A0215_49255F4302EEget_impl*
end;//TdsAttributes.pm_GetDocInfo

{$IfEnd} //not Admin AND not Monitorings

end.