unit NOT_FINISHED_nsTypes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Model\NOT_FINISHED_nsTypes.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
;

const
 {* Константы для работы с деревом }
 nne_ResetChildrenCount = 1000;
  {* - событие сброса детей. }

type
 TnsFileFormat = (
  {* - форматы файла. }
  ns_ffRTF
  , ns_ffTxt
  , ns_ffHTML
  , ns_ffXML
  , ns_ffEvd
  , ns_ffNull
 );//TnsFileFormat

 TListLogicOperation = (
  {* Логические операции со списком. }
 );//TListLogicOperation

 TnsResetTreeStatus = (
  rtsNone
  , rtsRoot
  , rtsFullRoot
  , rtsOneLevel
 );//TnsResetTreeStatus

 TnsFilterType = (
  {* дополнительный тип фильтрации для деревьев атрибутов }
  ns_ftNone
   {* никаких дополнительных фильтров }
  , ns_ftTrim
   {* При создании дерева атрибутов нужно накладывать дополнительный фильтр ITrimFilter }
  , ns_ftTrimLeaf
   {* При создании дерева атрибутов нужно накладывать дополнительный фильтр ITrimLeafFilter }
  , ns_ftBlocks
   {* При создании дерева атрибутов нужно накладывать дополнительный фильтр IBlocksFilter }
  , ns_ftInpharm
   {* Для фильтрации узла инфарама }
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
