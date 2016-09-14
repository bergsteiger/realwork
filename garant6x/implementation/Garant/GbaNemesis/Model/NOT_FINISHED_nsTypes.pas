unit NOT_FINISHED_nsTypes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Model\NOT_FINISHED_nsTypes.pas"
// ���������: "UtilityPack"
// ������� ������: "nsTypes" MUID: (4A6854C70390)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsTypesNew
;

const
 {* ������ ��� �������� nsTypesNew.TListLogicOperation }
 LLO_AND = nsTypesNew.LLO_AND;
 LLO_OR = nsTypesNew.LLO_OR;
 LLO_AND_NOT = nsTypesNew.LLO_AND_NOT;
 LLO_NONE = nsTypesNew.LLO_NONE;
 {* ������ ��� �������� nsTypesNew.TnsFileFormat }
 ns_ffRTF = nsTypesNew.ns_ffRTF;
 ns_ffTxt = nsTypesNew.ns_ffTxt;
 ns_ffHTML = nsTypesNew.ns_ffHTML;
 ns_ffXML = nsTypesNew.ns_ffXML;
 ns_ffEvd = nsTypesNew.ns_ffEvd;
 ns_ffNull = nsTypesNew.ns_ffNull;
 ns_ffPDF = nsTypesNew.ns_ffPDF;
 {* ��������� ��� ������ � ������� }
 nne_ResetChildrenCount = 1000;
  {* - ������� ������ �����. }

type
 TListLogicOperation = nsTypesNew.TListLogicOperation;
  {* ���������� �������� �� �������. }

 TnsResetTreeStatus = (
  rtsNone
  , rtsRoot
  , rtsFullRoot
  , rtsOneLevel
 );//TnsResetTreeStatus

 TnsFilterType = (
  {* �������������� ��� ���������� ��� �������� ��������� }
  ns_ftNone
   {* ������� �������������� �������� }
  , ns_ftTrim
   {* ��� �������� ������ ��������� ����� ����������� �������������� ������ ITrimFilter }
  , ns_ftTrimLeaf
   {* ��� �������� ������ ��������� ����� ����������� �������������� ������ ITrimLeafFilter }
  , ns_ftBlocks
   {* ��� �������� ������ ��������� ����� ����������� �������������� ������ IBlocksFilter }
  , ns_ftInpharm
   {* ��� ���������� ���� �������� }
 );//TnsFilterType

 TnsNavigatorItemParams = record
 end;//TnsNavigatorItemParams

 TnsMedicMainMenuNodeType = (
 );//TnsMedicMainMenuNodeType

 TWarningType = (
 );//TWarningType

 TWarningTypeSet = set of TWarningType;

 TnsExportKind = (
  ekDisk
  , ekShell
  , ekEMail
 );//TnsExportKind

 TnsLongProcessType = (
 );//TnsLongProcessType

 ETryOpenMissingDocument = class
 end;//ETryOpenMissingDocument

 TnsDeleteResult = (
 );//TnsDeleteResult

 TnsChangeRedactionType = (
 );//TnsChangeRedactionType

 TnsShowSynchroForm = (
 );//TnsShowSynchroForm

 TnsDocumentAndLinkOpenKind = (
  okInCurrentTab
  , okInNewTab
  , okInNewWindow
 );//TnsDocumentAndLinkOpenKind

 TnsFileFormat = nsTypesNew.TnsFileFormat;

procedure nsAStr;
procedure nsCStr;
procedure nsWStr;
procedure nsEStr;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4A6854C70390impl_uses*
 //#UC END# *4A6854C70390impl_uses*
;

procedure nsAStr;
//#UC START# *4AAF9718001D_4A6854C70390_var*
//#UC END# *4AAF9718001D_4A6854C70390_var*
begin
//#UC START# *4AAF9718001D_4A6854C70390_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AAF9718001D_4A6854C70390_impl*
end;//nsAStr

procedure nsCStr;
//#UC START# *4AB882990057_4A6854C70390_var*
//#UC END# *4AB882990057_4A6854C70390_var*
begin
//#UC START# *4AB882990057_4A6854C70390_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB882990057_4A6854C70390_impl*
end;//nsCStr

procedure nsWStr;
//#UC START# *4ADEE542029C_4A6854C70390_var*
//#UC END# *4ADEE542029C_4A6854C70390_var*
begin
//#UC START# *4ADEE542029C_4A6854C70390_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADEE542029C_4A6854C70390_impl*
end;//nsWStr

procedure nsEStr;
//#UC START# *4CF4DE5F0071_4A6854C70390_var*
//#UC END# *4CF4DE5F0071_4A6854C70390_var*
begin
//#UC START# *4CF4DE5F0071_4A6854C70390_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CF4DE5F0071_4A6854C70390_impl*
end;//nsEStr

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TListLogicOperation));
 {* ����������� ���� TListLogicOperation }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnsFileFormat));
 {* ����������� ���� TnsFileFormat }
{$IfEnd} // NOT Defined(NoScripts)

end.
