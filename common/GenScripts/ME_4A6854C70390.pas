unit NOT_FINISHED_nsTypes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Model\NOT_FINISHED_nsTypes.pas"
// ���������: "UtilityPack"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
;

const
 {* ��������� ��� ������ � ������� }
 nne_ResetChildrenCount = 1000;
  {* - ������� ������ �����. }

type
 TnsFileFormat = (
  {* - ������� �����. }
  ns_ffRTF
  , ns_ffTxt
  , ns_ffHTML
  , ns_ffXML
  , ns_ffEvd
  , ns_ffNull
 );//TnsFileFormat

 TListLogicOperation = (
  {* ���������� �������� �� �������. }
 );//TListLogicOperation

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

procedure nsAStr;
procedure nsCStr;
procedure nsWStr;
procedure nsEStr;

implementation

uses
 l3ImplUses
 , nsTypesNew
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

end.
