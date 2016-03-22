unit seWordsInfo;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\seWordsInfo.pas"
// ���������: "UtilityPack"
// ������� ������: "seWordsInfo" MUID: (53E107920007)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
 , tfwScriptingInterfaces
;

function GetWordDirectives(const aCtx: TtfwContext;
 aWord: TtfwWord): Il3CString;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
;

function GetWordDirectives(const aCtx: TtfwContext;
 aWord: TtfwWord): Il3CString;
//#UC START# *53E10704024E_53E107920007_var*
//#UC END# *53E10704024E_53E107920007_var*
begin
//#UC START# *53E10704024E_53E107920007_impl*
 Result := aWord.ResultTypeInfo[aCtx].ToString;
//#UC END# *53E10704024E_53E107920007_impl*
end;//GetWordDirectives
{$IfEnd} // NOT Defined(NoScripts)

end.
