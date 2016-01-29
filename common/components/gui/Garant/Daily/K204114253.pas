unit K204114253;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/K204114253.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::K204114253
//
// [$204114253]
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
  elCustomEdit
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM) AND not defined(NotTunedDUnit)}
  ,
  VCMBaseTest
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM AND not NotTunedDUnit
  ,
  elCustomEdit_Form,
  Types
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 _FormClass_ = TelCustomEditForm;
 _FormProducer_Parent_ = TVCMBaseTest;
 {$Include ..\Daily\FormProducer.imp.pas}
 TK204114253 = class(_FormProducer_)
  {* [$204114253] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure DoIt;
 end;//TK204114253
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  l3Base,
  evdSchema,
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

{$Include ..\Daily\FormProducer.imp.pas}

type
  TelCustomEditHack = class(TelCustomEdit)
  end;//TelCustomEditHack

// start class TK204114253

procedure TK204114253.DoIt;
//#UC START# *4BCE9E6D027F_4BCE9DB603BB_var*
const
 cText = '��� ���������';
var
 l_F : _FormClass_;
//#UC END# *4BCE9E6D027F_4BCE9DB603BB_var*
begin
//#UC START# *4BCE9E6D027F_4BCE9DB603BB_impl*
 l_F := MakeForm;
 try
  with l_F do
  begin
   TelCustomEditHack(Edit).Paras.ParagraphStrings[0] := l3CStr(cText);
   Show;
   Check(TelCustomEditHack(Edit).Text = cText);
  end;//with l_F
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *4BCE9E6D027F_4BCE9DB603BB_impl*
end;//TK204114253.DoIt

function TK204114253.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TK204114253.GetFolder

function TK204114253.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BCE9DB603BB';
end;//TK204114253.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

initialization
 TestFramework.RegisterTest(TK204114253.Suite);

end.