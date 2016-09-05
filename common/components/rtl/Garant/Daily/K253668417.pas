unit K253668417;
 {* [RequestLink:253668417] }

// ������: "w:\common\components\rtl\Garant\Daily\K253668417.pas"
// ���������: "TestCase"
// ������� ������: "K253668417" MUID: (4D5BE28703A0)
// ��� ����: "TK253668417"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK253668417 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:253668417] }
  protected
   function GetEnablePictures: Boolean; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK253668417
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4D5BE28703A0impl_uses*
 //#UC END# *4D5BE28703A0impl_uses*
;

function TK253668417.GetEnablePictures: Boolean;
//#UC START# *4D5BE2F500AD_4D5BE28703A0_var*
//#UC END# *4D5BE2F500AD_4D5BE28703A0_var*
begin
//#UC START# *4D5BE2F500AD_4D5BE28703A0_impl*
 Result := true;
//#UC END# *4D5BE2F500AD_4D5BE28703A0_impl*
end;//TK253668417.GetEnablePictures

function TK253668417.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK253668417.GetFolder

function TK253668417.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D5BE28703A0';
end;//TK253668417.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK253668417.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
