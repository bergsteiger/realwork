unit tfwModuleOperationWord;
 {* Слово для выполнения операции модуля }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\tfwModuleOperationWord.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , vcmExternalInterfaces
 , tfwScriptingInterfaces
;

type
 TtfwModuleOperationWord = {abstract} class(TtfwRegisterableWord)
  {* Слово для выполнения операции модуля }
  protected
   class function GetModuleOperationCode: TvcmMOPID; virtual;
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class procedure RegisterInEngine; override;
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

class function TtfwModuleOperationWord.GetModuleOperationCode: TvcmMOPID;
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

class procedure TtfwModuleOperationWord.RegisterInEngine;
//#UC START# *52A086150180_4DB060930263_var*
var
 l_ToolbarControl : TkwString;
 l_ToolbarControlName : String;
 //l_Mod : TvcmModulesCollectionItem;
 //l_Op : TvcmBaseOperationsCollectionItem;
 //l_ID : TvcmMOPID;
//#UC END# *52A086150180_4DB060930263_var*
begin
//#UC START# *52A086150180_4DB060930263_impl*
 inherited;
 l_ToolbarControlName := Copy(ClassName, 4, Length(ClassName) - 3);
 if (l_ToolbarControlName[1] = '_') then
  l_ToolbarControlName := Copy(l_ToolbarControlName, 2, Length(ClassName) - 1);
 l_ToolbarControlName := 'bt_' + 'mo_' + l_ToolbarControlName;
 //l_ID := GetModuleOperationCode;
 //l_Mod := g_MenuManager.Modules.FindItemByID(l_ID.rMoID) As TvcmModulesCollectionItem;
 //l_Op := l_Mod.Operations.FindItemByID(l_ID.rOpID) As TvcmBaseOperationsCollectionItem;
 //l_ToolbarControlName := 'bt_' + l_Mod.Name + '_' + l_Op.Name;
 l_ToolbarControl := TkwString.Create(TtfwCStringFactory.C(l_ToolbarControlName));
 try
  try
   l_ToolbarControl.RegisterInstance('контрол::' + l_ToolbarControlName);
  except
   on El3DuplicateItem do
    ;
  end;//try..except
 finally
  FreeAndNil(l_ToolbarControl);
 end;//try..finally
//#UC END# *52A086150180_4DB060930263_impl*
end;//TtfwModuleOperationWord.RegisterInEngine

initialization
 TtfwModuleOperationWord.RegisterClass;
 {* Регистрация TtfwModuleOperationWord }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
