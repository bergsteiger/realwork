unit dsDrugListDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Drug"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Drug/dsDrugListDocument.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 ���������� ��������::Inpharm::Drug::sdsDrugList::TdsDrugListDocument
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
  l3Interfaces,
  l3Types,
  afwInterfaces,
  nevTools,
  DocumentInterfaces,
  WorkWithListInterfaces,
  nsDocumentLikeStateHolder
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
  l3NotifyPtrList,
  UnderControlUnit,
  UnderControlInterfaces,
  bsTypes,
  DocumentUnit,
  bsTypesNew,
  FoldersDomainInterfaces,
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}
 TdsDrugListDocument = {vac} class(_dsBaseDocument_)
 protected
 // overridden protected methods
   function MakeContainer: InevDocumentContainer; override;
     {* ������������ ��������� ��������� }
 end;//TdsDrugListDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsF1DocumentContainer,
  IOUnit,
  l3Base,
  bsUtils,
  BaseTypesUnit,
  bsConvert,
  l3Utils,
  deDocInfo,
  nsTypes,
  nsDocInfoHAFMacroReplacer
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsFolderFilterInfo,
  l3InterfacesMisc,
  SysUtils,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsDrugListDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}

// start class TdsDrugListDocument

function TdsDrugListDocument.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_4933E8FF02C7_var*
//#UC END# *4C6AB38800F3_4933E8FF02C7_var*
begin
//#UC START# *4C6AB38800F3_4933E8FF02C7_impl*
 Result := TnsF1DocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_4933E8FF02C7_impl*
end;//TdsDrugListDocument.MakeContainer

{$IfEnd} //not Admin AND not Monitorings

end.