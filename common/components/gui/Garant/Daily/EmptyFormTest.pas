unit EmptyFormTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/EmptyFormTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::EmptyFormTests::TEmptyFormTest
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
  FromWithPanel_Form,
  Types
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 _FormClass_ = TFromWithPanelForm;
 _FormProducer_Parent_ = TBaseTest;
 {$Include ..\Daily\FormProducer.imp.pas}
 TEmptyFormTest = {abstract} class(_FormProducer_)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure CheckControl; virtual;
 published
 // published methods
   procedure DoIt;
 end;//TEmptyFormTest
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

// start class TEmptyFormTest

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
 {-}
begin
 Result := 'EmptyFormTests';
end;//TEmptyFormTest.GetFolder

function TEmptyFormTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '51D5285300B7';
end;//TEmptyFormTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.