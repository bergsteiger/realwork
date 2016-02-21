unit K585129079_NSRC_KeepExisting;
 {* [RequestLink:585129079] }

// ������: "w:\common\components\rtl\Garant\Daily\K585129079_NSRC_KeepExisting.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK585129079_NSRC_KeepExisting = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:585129079] }
  protected
   function NSRCCodePage: Integer; override;
    {* ��������� ��� ������� � NSRC }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   function PainterCodePage: Integer; override;
 end;//TK585129079_NSRC_KeepExisting
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Chars
 , TestFrameWork
;

function TK585129079_NSRC_KeepExisting.NSRCCodePage: Integer;
 {* ��������� ��� ������� � NSRC }
//#UC START# *4BEBCEA00177_5491B41C0353_var*
//#UC END# *4BEBCEA00177_5491B41C0353_var*
begin
//#UC START# *4BEBCEA00177_5491B41C0353_impl*
 Result := CP_KeepExisting;
//#UC END# *4BEBCEA00177_5491B41C0353_impl*
end;//TK585129079_NSRC_KeepExisting.NSRCCodePage

function TK585129079_NSRC_KeepExisting.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK585129079_NSRC_KeepExisting.GetFolder

function TK585129079_NSRC_KeepExisting.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5491B41C0353';
end;//TK585129079_NSRC_KeepExisting.GetModelElementGUID

function TK585129079_NSRC_KeepExisting.PainterCodePage: Integer;
//#UC START# *5491B011031B_5491B41C0353_var*
//#UC END# *5491B011031B_5491B41C0353_var*
begin
//#UC START# *5491B011031B_5491B41C0353_impl*
 Result := NSRCCodePage;
//#UC END# *5491B011031B_5491B41C0353_impl*
end;//TK585129079_NSRC_KeepExisting.PainterCodePage

initialization
 TestFramework.RegisterTest(TK585129079_NSRC_KeepExisting.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
