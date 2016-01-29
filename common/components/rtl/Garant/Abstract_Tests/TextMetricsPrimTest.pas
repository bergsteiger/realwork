unit TextMetricsPrimTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Abstract Tests"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Abstract_Tests/TextMetricsPrimTest.pas"
// �����: 14.12.2010 15:52
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TTextMetricsPrimTest
//
// ���� ����������� ������� ������. ����� ��� AllChildrenCount, NettoCharCount, BruttoCharCount,
// TextParaCount, BitmapParaCount
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TextViaEditorProcessorWithExternalSave,
  l3Filer
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TTextMetricsPrimTest = {abstract} class(TTextViaEditorProcessorWithExternalSave)
  {* ���� ����������� ������� ������. ����� ��� AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }
 protected
 // realized methods
   procedure DoSave(aForm: TPrimTextLoadForm;
     aFiler: Tl3CustomFiler); override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
    {$If defined(nsTest) AND not defined(NoVCM)}
   function EtalonFileExtension: AnsiString; override;
     {* ���������� ���������� ����� }
    {$IfEnd} //nsTest AND not NoVCM
    {$If defined(nsTest) AND not defined(NoVCM)}
   function HeaderBegin: AnsiChar; override;
    {$IfEnd} //nsTest AND not NoVCM
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TTextMetricsPrimTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  k2Tags,
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TTextMetricsPrimTest

procedure TTextMetricsPrimTest.DoSave(aForm: TPrimTextLoadForm;
  aFiler: Tl3CustomFiler);
//#UC START# *4D0771F102B6_4D07699A02E4_var*
//#UC END# *4D0771F102B6_4D07699A02E4_var*
begin
//#UC START# *4D0771F102B6_4D07699A02E4_impl*
 with aForm.Text do
 begin
  with TextSource.DocumentContainer do
  begin
   aFiler.WriteLn('AllChildrenCount = ' + IntToStr(Obj.IntA[k2_tiAllChildrenCount]));
   with DocumentInfo do
   begin
    aFiler.WriteLn('NettoCharCount = ' + IntToStr(NettoCharCount));
    aFiler.WriteLn('BruttoCharCount = ' + IntToStr(BruttoCharCount));
    aFiler.WriteLn('TextParaCount = ' + IntToStr(TextParaCount));
    aFiler.WriteLn('BitmapParaCount = ' + IntToStr(BitmapParaCount));
   end;//with DocumentInfo
  end;//with TextSource.DocumentContainer
 end;//with aForm.Text
//#UC END# *4D0771F102B6_4D07699A02E4_impl*
end;//TTextMetricsPrimTest.DoSave

function TTextMetricsPrimTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TTextMetricsPrimTest.GetFolder

{$If defined(nsTest) AND not defined(NoVCM)}
function TTextMetricsPrimTest.EtalonFileExtension: AnsiString;
//#UC START# *4D0769150130_4D07699A02E4_var*
//#UC END# *4D0769150130_4D07699A02E4_var*
begin
//#UC START# *4D0769150130_4D07699A02E4_impl*
 Result := 'metrics';
//#UC END# *4D0769150130_4D07699A02E4_impl*
end;//TTextMetricsPrimTest.EtalonFileExtension
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TTextMetricsPrimTest.HeaderBegin: AnsiChar;
//#UC START# *4D07693F0262_4D07699A02E4_var*
//#UC END# *4D07693F0262_4D07699A02E4_var*
begin
//#UC START# *4D07693F0262_4D07699A02E4_impl*
 Result := #0;
//#UC END# *4D07693F0262_4D07699A02E4_impl*
end;//TTextMetricsPrimTest.HeaderBegin
{$IfEnd} //nsTest AND not NoVCM

function TTextMetricsPrimTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D07699A02E4';
end;//TTextMetricsPrimTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.