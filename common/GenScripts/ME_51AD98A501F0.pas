unit PageCountTest;

// ������: "w:\common\components\gui\Garant\Daily\PageCountTest.pas"
// ���������: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PreviewTest
;

type
 TPageCountTest = {abstract} class(TPreviewTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   function OnlyCheckPageCount: Boolean; override;
 end;//TPageCountTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
;

function TPageCountTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TPageCountTest.GetFolder

function TPageCountTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51AD98A501F0';
end;//TPageCountTest.GetModelElementGUID

function TPageCountTest.OnlyCheckPageCount: Boolean;
//#UC START# *51AD98E70324_51AD98A501F0_var*
//#UC END# *51AD98E70324_51AD98A501F0_var*
begin
//#UC START# *51AD98E70324_51AD98A501F0_impl*
 Result := True;
//#UC END# *51AD98E70324_51AD98A501F0_impl*
end;//TPageCountTest.OnlyCheckPageCount
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
