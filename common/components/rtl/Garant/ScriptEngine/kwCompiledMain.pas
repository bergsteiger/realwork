unit kwCompiledMain;
 {* ���������������� �������� ��� ������� }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledMain.pas"
// ���������: "SimpleClass"
// ������� ������: "TkwCompiledMain" MUID: (4F37CBBE015A)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWord
 , tfwScriptingInterfaces
;

type
 TkwCompiledMain = class(TkwCompiledWord)
  {* ���������������� �������� ��� ������� }
  protected
   function pm_GetParentWord: TtfwWord; override;
 end;//TkwCompiledMain
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassRef
;

function TkwCompiledMain.pm_GetParentWord: TtfwWord;
//#UC START# *52CFCF4B02C6_4F37CBBE015Aget_var*
//#UC END# *52CFCF4B02C6_4F37CBBE015Aget_var*
begin
//#UC START# *52CFCF4B02C6_4F37CBBE015Aget_impl*
 Result := nil;
//#UC END# *52CFCF4B02C6_4F37CBBE015Aget_impl*
end;//TkwCompiledMain.pm_GetParentWord

initialization
 TkwCompiledMain.RegisterClass;
 {* ����������� TkwCompiledMain }
{$IfEnd} // NOT Defined(NoScripts)

end.
