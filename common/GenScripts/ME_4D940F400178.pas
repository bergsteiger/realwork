unit K259175668;
 {* [$259175668] }

// ������: "w:\common\components\rtl\Garant\Daily\K259175668.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WrongSearchTest
;

type
 TK259175668 = class(TWrongSearchTest)
  {* [$259175668] }
  protected
   {$If NOT Defined(NoVCM)}
   function StringForSearch: AnsiString; override;
    {* ������ ��� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function StringForReplace: AnsiString; override;
    {* ������ ��� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK259175668
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK259175668.StringForSearch: AnsiString;
 {* ������ ��� ������ }
//#UC START# *4BE051200169_4D940F400178_var*
//#UC END# *4BE051200169_4D940F400178_var*
begin
//#UC START# *4BE051200169_4D940F400178_impl*
 Result := '*';
//#UC END# *4BE051200169_4D940F400178_impl*
end;//TK259175668.StringForSearch
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK259175668.StringForReplace: AnsiString;
 {* ������ ��� ������ }
//#UC START# *4BE0513800C9_4D940F400178_var*
//#UC END# *4BE0513800C9_4D940F400178_var*
begin
//#UC START# *4BE0513800C9_4D940F400178_impl*
 Result := ' ';
//#UC END# *4BE0513800C9_4D940F400178_impl*
end;//TK259175668.StringForReplace
{$IfEnd} // NOT Defined(NoVCM)

function TK259175668.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK259175668.GetFolder

function TK259175668.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D940F400178';
end;//TK259175668.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK259175668.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
