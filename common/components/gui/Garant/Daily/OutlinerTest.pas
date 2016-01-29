unit OutlinerTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/OutlinerTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::OutlinerTests::OutlinerTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  Outliner_Form,
  Types
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 _FormClass_ = TOutlinerFormForm;
 _FormProducer_Parent_ = TBaseTest;
 {$Include ..\Daily\FormProducer.imp.pas}
 TOutlinerTest = {abstract} class(_FormProducer_)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure Load(aForm: TOutlinerFormForm;
    const aFileName: AnsiString); virtual;
     {* Загрузить данные в дерево. }
 published
 // published methods
   procedure DoIt();
 end;//TOutlinerTest
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

{$Include ..\Daily\FormProducer.imp.pas}

// start class TOutlinerTest

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
//#UC START# *4D46E22801EB_4D46B552013B_var*
//#UC END# *4D46E22801EB_4D46B552013B_var*
begin
//#UC START# *4D46E22801EB_4D46B552013B_impl*
//#UC END# *4D46E22801EB_4D46B552013B_impl*
end;//TOutlinerTest.Load

function TOutlinerTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'OutlinerTests';
end;//TOutlinerTest.GetFolder

function TOutlinerTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D46B552013B';
end;//TOutlinerTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.