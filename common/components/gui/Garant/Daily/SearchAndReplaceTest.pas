unit SearchAndReplaceTest;
 {* ���� ������/������ }

// ������: "w:\common\components\gui\Garant\Daily\SearchAndReplaceTest.pas"
// ���������: "TestCase"
// ������� ������: "TSearchAndReplaceTest" MUID: (4BE04F030356)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , SearchAndReplacePrimTest
 , nevTools
 , evTypes
;

type
 TSearchAndReplaceTest = {abstract} class(TSearchAndReplacePrimTest)
  {* ���� ������/������ }
  protected
   function StringForSearch: AnsiString; virtual; abstract;
    {* ������ ��� ������ }
   function StringForReplace: AnsiString; virtual; abstract;
    {* ������ ��� ������ }
   function Searcher: IevSearcher; override;
   function Replacer: IevReplacer; override;
   function Options: TevSearchOptionSet; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TSearchAndReplaceTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evSearch
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4BE04F030356impl_uses*
 //#UC END# *4BE04F030356impl_uses*
;

function TSearchAndReplaceTest.Searcher: IevSearcher;
//#UC START# *4C288BAA0058_4BE04F030356_var*
//#UC END# *4C288BAA0058_4BE04F030356_var*
begin
//#UC START# *4C288BAA0058_4BE04F030356_impl*
 Result := TevBMTextSearcher.Make(StringForSearch, Options);
//#UC END# *4C288BAA0058_4BE04F030356_impl*
end;//TSearchAndReplaceTest.Searcher

function TSearchAndReplaceTest.Replacer: IevReplacer;
//#UC START# *4C288BFC002C_4BE04F030356_var*
//#UC END# *4C288BFC002C_4BE04F030356_var*
begin
//#UC START# *4C288BFC002C_4BE04F030356_impl*
 Result := TevTextReplacer.Make(StringForReplace, Options);
//#UC END# *4C288BFC002C_4BE04F030356_impl*
end;//TSearchAndReplaceTest.Replacer

function TSearchAndReplaceTest.Options: TevSearchOptionSet;
//#UC START# *4C288CC60231_4BE04F030356_var*
//#UC END# *4C288CC60231_4BE04F030356_var*
begin
//#UC START# *4C288CC60231_4BE04F030356_impl*
 Result := [ev_soGlobal, ev_soReplace, ev_soReplaceAll];
//#UC END# *4C288CC60231_4BE04F030356_impl*
end;//TSearchAndReplaceTest.Options

function TSearchAndReplaceTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TSearchAndReplaceTest.GetFolder

function TSearchAndReplaceTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BE04F030356';
end;//TSearchAndReplaceTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
