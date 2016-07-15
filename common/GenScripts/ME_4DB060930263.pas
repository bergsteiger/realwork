unit tfwModuleOperationWord;
 {* Слово для выполнения операции модуля }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\tfwModuleOperationWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwModuleOperationWord" MUID: (4DB060930263)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , vcmExternalInterfaces
 , tfwScriptingInterfaces
;

type
 TtfwModuleOperationWord = {abstract} class(TtfwRegisterableWordPrim)
  {* Слово для выполнения операции модуля }
  protected
   function GetModuleOperationCode: TvcmMOPID; virtual;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TtfwModuleOperationWord
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
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

function TtfwModuleOperationWord.GetModuleOperationCode: TvcmMOPID;
//#UC START# *4DB079E00084_4DB060930263_var*
//#UC END# *4DB079E00084_4DB060930263_var*
begin
//#UC START# *4DB079E00084_4DB060930263_impl*
 FillChar(Result, SizeOf(Result), $FF);
 Assert(false);
//#UC END# *4DB079E00084_4DB060930263_impl*
end;//TtfwModuleOperationWord.GetModuleOperationCode

procedure TtfwModuleOperationWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB060930263_var*
//#UC END# *4DAEEDE10285_4DB060930263_var*
begin
//#UC START# *4DAEEDE10285_4DB060930263_impl*
 aCtx.rCaller.Check(vcmDispatcher.ModuleOperation(GetModuleOperationCode));
//#UC END# *4DAEEDE10285_4DB060930263_impl*
end;//TtfwModuleOperationWord.DoDoIt

initialization
 TtfwModuleOperationWord.RegisterClass;
 {* Регистрация TtfwModuleOperationWord }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
