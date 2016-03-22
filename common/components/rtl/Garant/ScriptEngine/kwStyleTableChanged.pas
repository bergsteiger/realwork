unit kwStyleTableChanged;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableChanged.pas"
// ���������: "ScriptKeyword"
// ������� ������: "StyleTable_Changed" MUID: (4E68CC460163)
// ��� ����: "TkwStyleTableChanged"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwStyleTableChanged = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwStyleTableChanged
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
;

procedure TkwStyleTableChanged.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E68CC460163_var*
//#UC END# *4DAEEDE10285_4E68CC460163_var*
begin
//#UC START# *4DAEEDE10285_4E68CC460163_impl*
 EvNotifyStyleTableChanged;
//#UC END# *4DAEEDE10285_4E68CC460163_impl*
end;//TkwStyleTableChanged.DoDoIt

class function TkwStyleTableChanged.GetWordNameForRegister: AnsiString;
begin
 Result := 'StyleTable:Changed';
end;//TkwStyleTableChanged.GetWordNameForRegister

initialization
 TkwStyleTableChanged.RegisterInEngine;
 {* ����������� StyleTable_Changed }
{$IfEnd} // NOT Defined(NoScripts)

end.
