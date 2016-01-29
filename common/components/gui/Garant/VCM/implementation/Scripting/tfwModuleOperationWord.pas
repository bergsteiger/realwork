unit tfwModuleOperationWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Scripting"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/Scripting/tfwModuleOperationWord.pas"
// �����: 21.04.2011 20:52
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Scripting::Operations::TtfwModuleOperationWord
//
// ����� ��� ���������� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 TtfwModuleOperationWord = {abstract} class(TtfwRegisterableWord)
  {* ����� ��� ���������� �������� ������ }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class procedure RegisterInEngine; override;
 protected
 // protected methods
   class function GetModuleOperationCode: TvcmMOPID; virtual;
 end;//TtfwModuleOperationWord
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmBase,
  kwString,
  vcmBaseOperationsCollectionItem,
  vcmModulesCollectionItem,
  l3Except,
  vcmBaseMenuManager,
  SysUtils
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TtfwModuleOperationWord

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
   l_ToolbarControl.RegisterInstance('�������::' + l_ToolbarControlName);
  except
   on El3DuplicateItem do
    ;
  end;//try..except
 finally
  FreeAndNil(l_ToolbarControl);
 end;//try..finally
//#UC END# *52A086150180_4DB060930263_impl*
end;//TtfwModuleOperationWord.RegisterInEngine

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� TtfwModuleOperationWord
 TtfwModuleOperationWord.RegisterClass;
{$IfEnd} //not NoScripts AND not NoVCM

end.