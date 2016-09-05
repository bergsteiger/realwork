unit nsTypesNew;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Model\nsTypesNew.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsTypesNew" MUID: (4D4161F5012E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , IOUnit
;

type
 TnsStringPair = record
  rIl3CString: Il3CString;
  rIString: IString;
 end;//TnsStringPair

 TListLogicOperation = (
  LLO_AND
  , LLO_OR
  , LLO_AND_NOT
  , LLO_NONE
 );//TListLogicOperation

 TnsFileFormat = (
  {* - форматы файла. }
  ns_ffRTF
  , ns_ffTxt
  , ns_ffHTML
  , ns_ffXML
  , ns_ffEvd
  , ns_ffNull
  , ns_ffPDF
 );//TnsFileFormat

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4D4161F5012Eimpl_uses*
 //#UC END# *4D4161F5012Eimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TListLogicOperation));
 {* Регистрация типа TListLogicOperation }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnsFileFormat));
 {* Регистрация типа TnsFileFormat }
{$IfEnd} // NOT Defined(NoScripts)

end.
