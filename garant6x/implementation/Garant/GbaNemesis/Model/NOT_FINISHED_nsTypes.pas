unit NOT_FINISHED_nsTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Model"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Model/NOT_FINISHED_nsTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Model::nsTypes::nsTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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

const
  { ��������� ��� ������ � ������� }
 nne_ResetChildrenCount = 1000;
  { - ������� ������ �����. }

type
 TListLogicOperation = (
  {* ���������� �������� �� �������. }
   
 );//TListLogicOperation

const
  { StringRoutines }
 

type
 TnsResetTreeStatus = (
   rtsNone
 , rtsRoot
 , rtsFullRoot
 , rtsOneLevel
 );//TnsResetTreeStatus

 TnsFilterType = (
  {* �������������� ��� ���������� ��� �������� ��������� }
   ns_ftNone // ������� �������������� ��������
 , ns_ftTrim // ��� �������� ������ ��������� ����� ����������� �������������� ������ ITrimFilter
 , ns_ftTrimLeaf // ��� �������� ������ ��������� ����� ����������� �������������� ������ ITrimLeafFilter
 , ns_ftBlocks // ��� �������� ������ ��������� ����� ����������� �������������� ������ IBlocksFilter
 , ns_ftInpharm // ��� ���������� ���� ��������
 );//TnsFilterType

 TnsNavigatorItemParams = record
 end;//TnsNavigatorItemParams

 TnsMedicMainMenuNodeType = (
   
 );//TnsMedicMainMenuNodeType

const
  { DateTimeRoutines }
 

type
 TWarningType = (
   
 );//TWarningType

 TWarningTypeSet = set of TWarningType;

 TnsExportKind = (
   ekDisk
 , ekShell
 , ekEMail
 );//TnsExportKind

const
  { DocPosTypeToEdtSubType Etc }
 

type
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
procedure NsAStr;
   {* ��������� ������ nsAStr }
procedure NsCStr;
   {* ��������� ������ nsCStr }
procedure NsWStr;
   {* ��������� ������ nsWStr }
procedure NsEStr;
   {* ��������� ������ nsEStr }

implementation

uses
  nsTypesNew
  ;

// unit methods

procedure NsAStr;
//#UC START# *4AAF9718001D_4A6854C70390_var*
//#UC END# *4AAF9718001D_4A6854C70390_var*
begin
//#UC START# *4AAF9718001D_4A6854C70390_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AAF9718001D_4A6854C70390_impl*
end;//NsAStr

procedure NsCStr;
//#UC START# *4AB882990057_4A6854C70390_var*
//#UC END# *4AB882990057_4A6854C70390_var*
begin
//#UC START# *4AB882990057_4A6854C70390_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB882990057_4A6854C70390_impl*
end;//NsCStr

procedure NsWStr;
//#UC START# *4ADEE542029C_4A6854C70390_var*
//#UC END# *4ADEE542029C_4A6854C70390_var*
begin
//#UC START# *4ADEE542029C_4A6854C70390_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADEE542029C_4A6854C70390_impl*
end;//NsWStr

procedure NsEStr;
//#UC START# *4CF4DE5F0071_4A6854C70390_var*
//#UC END# *4CF4DE5F0071_4A6854C70390_var*
begin
//#UC START# *4CF4DE5F0071_4A6854C70390_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CF4DE5F0071_4A6854C70390_impl*
end;//NsEStr

end.