unit NOT_FINISHED_nsTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Model"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Model/NOT_FINISHED_nsTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Базовые определения предметной области::LegalDomain::Model::nsTypes::nsTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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

const
  { Константы для работы с деревом }
 nne_ResetChildrenCount = 1000;
  { - событие сброса детей. }

type
 TListLogicOperation = (
  {* Логические операции со списком. }
   
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
  {* дополнительный тип фильтрации для деревьев атрибутов }
   ns_ftNone // никаких дополнительных фильтров
 , ns_ftTrim // При создании дерева атрибутов нужно накладывать дополнительный фильтр ITrimFilter
 , ns_ftTrimLeaf // При создании дерева атрибутов нужно накладывать дополнительный фильтр ITrimLeafFilter
 , ns_ftBlocks // При создании дерева атрибутов нужно накладывать дополнительный фильтр IBlocksFilter
 , ns_ftInpharm // Для фильтрации узла инфарама
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
   {* Сигнатура метода nsAStr }
procedure NsCStr;
   {* Сигнатура метода nsCStr }
procedure NsWStr;
   {* Сигнатура метода nsWStr }
procedure NsEStr;
   {* Сигнатура метода nsEStr }

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