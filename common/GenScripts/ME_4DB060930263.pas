unit tfwModuleOperationWord;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , vcmExternalInterfaces
 , tfwScriptingInterfaces
;

type
 TtfwModuleOperationWord = class(TtfwRegisterableWord)
  {* Слово для выполнения операции модуля }
  function GetModuleOperationCode: TvcmMOPID;
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwModuleOperationWord
 
implementation

uses
 l3ImplUses
 , vcmBase
 , kwString
 , vcmBaseOperationsCollectionItem
 , vcmModulesCollectionItem
 , l3Except
 , vcmBaseMenuManager
 , SysUtils
;

end.
