unit K204114253;
 {* [$204114253] }

// Модуль: "w:\common\components\gui\Garant\Daily\K204114253.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , VCMBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 , elCustomEdit_Form
 , Types
;

type
 _FormClass_ = TelCustomEditForm;
 _FormProducer_Parent_ = TVCMBaseTest;
 {$Include w:\common\components\gui\Garant\Daily\FormProducer.imp.pas}
 TK204114253 = class(_FormProducer_)
  {* [$204114253] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TK204114253
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , elCustomEdit
 , evdSchema
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

type
 TelCustomEditHack = class(TelCustomEdit)
 end;//TelCustomEditHack

{$Include w:\common\components\gui\Garant\Daily\FormProducer.imp.pas}

procedure TK204114253.DoIt;
//#UC START# *4BCE9E6D027F_4BCE9DB603BB_var*
const
 cText = 'Все документы';
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
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TK204114253.GetFolder

function TK204114253.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BCE9DB603BB';
end;//TK204114253.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK204114253.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
