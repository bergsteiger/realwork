unit K283149108;
 {* [RequestLink:283149108] }

// ������: "w:\common\components\rtl\Garant\Daily\K283149108.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK283149108 = class(TPreviewTest)
  {* [RequestLink:283149108] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK283149108
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK283149108.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4E69FCE30379_var*
//#UC END# *4C07AC6F036D_4E69FCE30379_var*
begin
//#UC START# *4C07AC6F036D_4E69FCE30379_impl*
 Result := 30;
//#UC END# *4C07AC6F036D_4E69FCE30379_impl*
end;//TK283149108.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK283149108.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK283149108.GetFolder

function TK283149108.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E69FCE30379';
end;//TK283149108.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK283149108.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4E69FCE30379_var*
//#UC END# *51AF49E5001B_4E69FCE30379_var*
begin
//#UC START# *51AF49E5001B_4E69FCE30379_impl*
 Result := true;
//#UC END# *51AF49E5001B_4E69FCE30379_impl*
end;//TK283149108.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK283149108.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
