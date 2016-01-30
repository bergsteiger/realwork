unit SearchAndReplacePrimTest;
 {* ���� ������/������ }

// ������: "w:\common\components\gui\Garant\Daily\SearchAndReplacePrimTest.pas"
// ���������: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessor
 , nevTools
 , evTypes
 , PrimTextLoad_Form
;

type
 TSearchAndReplacePrimTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ������/������ }
  protected
   function Searcher: IevSearcher; virtual; abstract;
   function Replacer: IevReplacer; virtual; abstract;
   function Options: TevSearchOptionSet; virtual; abstract;
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TSearchAndReplacePrimTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TSearchAndReplacePrimTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4C288B4D012F_var*
//#UC END# *4BE13147032C_4C288B4D012F_var*
begin
//#UC START# *4BE13147032C_4C288B4D012F_impl*
 aForm.Text.Find(Searcher,
                 Replacer,
                 Options);
//#UC END# *4BE13147032C_4C288B4D012F_impl*
end;//TSearchAndReplacePrimTest.Process

function TSearchAndReplacePrimTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TSearchAndReplacePrimTest.GetFolder

function TSearchAndReplacePrimTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C288B4D012F';
end;//TSearchAndReplacePrimTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
