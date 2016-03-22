unit kwUses;
 {* ���������� ������� ������� � ������:
������:
[code]
USES
 DocumentNumbers.script
;
[code] }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwUses.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Uses" MUID: (4DC3A27D0253)
// ��� ����: "TkwUses"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwUsesLike
;

type
 TkwUses = class(TkwUsesLike)
  {* ���������� ������� ������� � ������:
������:
[code]
USES
 DocumentNumbers.script
;
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwUses
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

class function TkwUses.GetWordNameForRegister: AnsiString;
begin
 Result := 'USES';
end;//TkwUses.GetWordNameForRegister

initialization
 TkwUses.RegisterInEngine;
 {* ����������� Uses }
{$IfEnd} // NOT Defined(NoScripts)

end.
