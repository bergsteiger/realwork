unit OutlinerTest;

// Модуль: "w:\common\components\gui\Garant\Daily\OutlinerTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "OutlinerTest" MUID: (4D46B552013B)
// Имя типа: "TOutlinerTest"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , Outliner_Form
 , Types
;

type
 _FormClass_ = TOutlinerFormForm;
 _FormProducer_Parent_ = TBaseTest;
 {$Include w:\common\components\gui\Garant\Daily\FormProducer.imp.pas}
 TOutlinerTest = {abstract} class(_FormProducer_)
  protected
   procedure Load(aForm: TOutlinerFormForm;
    const aFileName: AnsiString); virtual;
    {* Загрузить данные в дерево. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt();
 end;//TOutlinerTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 , TestFrameWork
 //#UC START# *4D46B552013Bimpl_uses*
 //#UC END# *4D46B552013Bimpl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
{$Include w:\common\components\gui\Garant\Daily\FormProducer.imp.pas}

procedure TOutlinerTest.DoIt();
//#UC START# *4D46C7AE01E3_4D46B552013B_var*
var
 l_F : _FormClass_;
//#UC END# *4D46C7AE01E3_4D46B552013B_var*
begin
//#UC START# *4D46C7AE01E3_4D46B552013B_impl*
 l_F := MakeForm;
 try
  Load(l_F, KPage + '.evd');
  l_F.Show;
  l_F.TreeControl.Repaint;
 finally
  FreeAndNil(l_F);
 end;//try..finally
 Check(True);
//#UC END# *4D46C7AE01E3_4D46B552013B_impl*
end;//TOutlinerTest.DoIt()

procedure TOutlinerTest.Load(aForm: TOutlinerFormForm;
 const aFileName: AnsiString);
 {* Загрузить данные в дерево. }
//#UC START# *4D46E22801EB_4D46B552013B_var*
//#UC END# *4D46E22801EB_4D46B552013B_var*
begin
//#UC START# *4D46E22801EB_4D46B552013B_impl*
//#UC END# *4D46E22801EB_4D46B552013B_impl*
end;//TOutlinerTest.Load

function TOutlinerTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'OutlinerTests';
end;//TOutlinerTest.GetFolder

function TOutlinerTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D46B552013B';
end;//TOutlinerTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)
end.
