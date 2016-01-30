unit K182157315;
 {* [RequestLink:182157315] }

// ������: "w:\common\components\rtl\Garant\Daily\K182157315.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore278833302
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK182157315 = class(TPreviewTestBefore278833302)
  {* [RequestLink:182157315] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK182157315
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK182157315.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK182157315.GetFolder

function TK182157315.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D63DDD901EC';
end;//TK182157315.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK182157315.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4D63DDD901EC_var*
//#UC END# *51AF49E5001B_4D63DDD901EC_var*
begin
//#UC START# *51AF49E5001B_4D63DDD901EC_impl*
 Result := true;
//#UC END# *51AF49E5001B_4D63DDD901EC_impl*
end;//TK182157315.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK182157315.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
