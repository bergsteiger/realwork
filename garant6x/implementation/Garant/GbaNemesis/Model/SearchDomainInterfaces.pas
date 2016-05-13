unit SearchDomainInterfaces;
 {* Поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Model\SearchDomainInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "SearchDomainInterfaces" MUID: (4990510C0026)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 TLogicOperation = (
  loNone
  , loOr
  , loAnd
  , loNot
 );//TLogicOperation

 InsLogicOperation = interface
  ['{6FF60911-661A-4835-9C7D-D3A8553EDE96}']
  function pm_GetOperation: TLogicOperation;
  procedure pm_SetOperation(aValue: TLogicOperation);
  property Operation: TLogicOperation
   read pm_GetOperation
   write pm_SetOperation;
 end;//InsLogicOperation

 TLogicOperationSet = set of TLogicOperation;

 InsTaggedTreeInfo = interface
  ['{255BD920-7322-4C04-A208-161C9656148B}']
  function pm_GetTag: Il3CString;
  procedure pm_SetTag(const aValue: Il3CString);
  function pm_GetLogicOperations: TLogicOperationSet;
  procedure pm_SetLogicOperations(aValue: TLogicOperationSet);
  function pm_GetServerOneLevel: Boolean;
  procedure pm_SetServerOneLevel(aValue: Boolean);
  function pm_GetIsOneLogicOperation: Boolean;
  procedure AssignInfo(const aInfo: InsTaggedTreeInfo);
  function IsDataOneLevel: Boolean;
  property Tag: Il3CString
   read pm_GetTag
   write pm_SetTag;
  property LogicOperations: TLogicOperationSet
   read pm_GetLogicOperations
   write pm_SetLogicOperations;
   {* допустимые для дерева логические операции }
  property ServerOneLevel: Boolean
   read pm_GetServerOneLevel
   write pm_SetServerOneLevel;
  property IsOneLogicOperation: Boolean
   read pm_GetIsOneLogicOperation;
   {* количество логический операций - одна }
 end;//InsTaggedTreeInfo

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TLogicOperation));
 {* Регистрация типа TLogicOperation }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(InsLogicOperation));
 {* Регистрация типа InsLogicOperation }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(InsTaggedTreeInfo));
 {* Регистрация типа InsTaggedTreeInfo }
{$IfEnd} // NOT Defined(NoScripts)

end.
