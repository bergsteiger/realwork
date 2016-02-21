unit kwEXCEPT;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwEXCEPT.pas"
// ���������: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMedianBacket
;

type
 TkwEXCEPT = {final} class(TkwMedianBacket)
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEXCEPT
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

class function TkwEXCEPT.GetWordNameForRegister: AnsiString;
begin
 Result := 'EXCEPT';
end;//TkwEXCEPT.GetWordNameForRegister

initialization
 TkwEXCEPT.RegisterInEngine;
 {* ����������� EXCEPT }
{$IfEnd} // NOT Defined(NoScripts)

end.
