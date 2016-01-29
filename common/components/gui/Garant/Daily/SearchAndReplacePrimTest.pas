unit SearchAndReplacePrimTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Daily/SearchAndReplacePrimTest.pas"
// �����: 28.06.2010 15:45
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TSearchAndReplacePrimTest
//
// ���� ������/������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  nevTools,
  evTypes,
  TextViaEditorProcessor,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TSearchAndReplacePrimTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ������/������ }
 protected
 // realized methods
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* ���������� ������� ��������� ������ }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 protected
 // protected methods
   function Searcher: IevSearcher; virtual; abstract;
   function Replacer: IevReplacer; virtual; abstract;
   function Options: TevSearchOptionSet; virtual; abstract;
 end;//TSearchAndReplacePrimTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TSearchAndReplacePrimTest

procedure TSearchAndReplacePrimTest.Process(aForm: TPrimTextLoadForm);
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
 {-}
begin
 Result := 'Everest';
end;//TSearchAndReplacePrimTest.GetFolder

function TSearchAndReplacePrimTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C288B4D012F';
end;//TSearchAndReplacePrimTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.