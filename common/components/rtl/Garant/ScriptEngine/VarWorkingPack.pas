unit VarWorkingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\VarWorkingPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "VarWorkingPack" MUID: (5512AB3401E0)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwTypeInfo
 , tfwConst
 , tfwScriptingTypes
;

type
 TkwCONST = {final} class(TtfwConst)
  {* ���������� ���������.
������:
[code]
 CONST cFake1 5
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCONST

class function TkwCONST.GetWordNameForRegister: AnsiString;
begin
 Result := 'CONST';
end;//TkwCONST.GetWordNameForRegister

initialization
 TkwCONST.RegisterInEngine;
 {* ����������� CONST }
{$IfEnd} // NOT Defined(NoScripts)

end.
