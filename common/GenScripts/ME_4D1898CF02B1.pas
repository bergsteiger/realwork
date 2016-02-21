unit PreviewWithLinesTest;

// ������: "w:\common\components\gui\Garant\Daily\PreviewWithLinesTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PreviewWithLinesTestBefore235875079
;

type
 TPreviewWithLinesTest = {abstract} class(TPreviewWithLinesTestBefore235875079)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function IsBefore235875079: Boolean; override;
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TPreviewWithLinesTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TPreviewWithLinesTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TPreviewWithLinesTest.GetFolder

function TPreviewWithLinesTest.IsBefore235875079: Boolean;
//#UC START# *4D18990C0329_4D1898CF02B1_var*
//#UC END# *4D18990C0329_4D1898CF02B1_var*
begin
//#UC START# *4D18990C0329_4D1898CF02B1_impl*
 Result := false;
//#UC END# *4D18990C0329_4D1898CF02B1_impl*
end;//TPreviewWithLinesTest.IsBefore235875079

function TPreviewWithLinesTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D1898CF02B1';
end;//TPreviewWithLinesTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
