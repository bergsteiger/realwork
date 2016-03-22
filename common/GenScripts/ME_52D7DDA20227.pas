unit kwFINALLY;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwFINALLY.pas"
// ���������: "ScriptKeyword"
// ������� ������: "FINALLY" MUID: (52D7DDA20227)
// ��� ����: "TkwFINALLY"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMedianBacket
;

type
 TkwFINALLY = {final} class(TkwMedianBacket)
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwFINALLY
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

class function TkwFINALLY.GetWordNameForRegister: AnsiString;
begin
 Result := 'FINALLY';
end;//TkwFINALLY.GetWordNameForRegister

initialization
 TkwFINALLY.RegisterInEngine;
 {* ����������� FINALLY }
{$IfEnd} // NOT Defined(NoScripts)

end.
