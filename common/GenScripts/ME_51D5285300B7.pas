unit EmptyFormTest;

// Модуль: "w:\common\components\gui\Garant\Daily\EmptyFormTest.pas"
// Стереотип: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , FromWithPanel_Form
 , Types
;

type
 _FormClass_ = TFromWithPanelForm;
 _FormProducer_Parent_ = TBaseTest;
 {$Include FormProducer.imp.pas}
 TEmptyFormTest = {abstract} class(_FormProducer_)
  protected
   procedure CheckControl; virtual;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TEmptyFormTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$Include FormProducer.imp.pas}

procedure TEmptyFormTest.DoIt;
//#UC START# *51D5290701CC_51D5285300B7_var*
var
 l_F : _FormClass_;
//#UC END# *51D5290701CC_51D5285300B7_var*
begin
//#UC START# *51D5290701CC_51D5285300B7_impl*
 l_F := MakeForm;
 try   
  l_F.Show;
  Application.ProcessMessages;
  CheckControl;
  Sleep(2000);
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *51D5290701CC_51D5285300B7_impl*
end;//TEmptyFormTest.DoIt

procedure TEmptyFormTest.CheckControl;
//#UC START# *51D5464D033C_51D5285300B7_var*
//#UC END# *51D5464D033C_51D5285300B7_var*
begin
//#UC START# *51D5464D033C_51D5285300B7_impl*
 
//#UC END# *51D5464D033C_51D5285300B7_impl*
end;//TEmptyFormTest.CheckControl

function TEmptyFormTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EmptyFormTests';
end;//TEmptyFormTest.GetFolder

function TEmptyFormTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51D5285300B7';
end;//TEmptyFormTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
