unit DrawTest;
 {* Тест вида: нарисовали и сравнили с эталоном. }

// Модуль: "w:\common\components\rtl\Garant\Daily\DrawTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , DrawTestPrim
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDrawTest = {abstract} class(TDrawTestPrim)
  {* Тест вида: нарисовали и сравнили с эталоном. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
    {* Произвести какие-нибудь операции перед отрисовкой. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NoVCM)}
   function UseFormExtentAsClientSize: Boolean; override;
    {* Использовать заданные размеры формы как размеры клиентской области - размеры формы пересчитываются относительно этих ограничений. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TDrawTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
procedure TDrawTest.DoBeforeDrawing(aForm: TPrimTextLoadForm);
 {* Произвести какие-нибудь операции перед отрисовкой. }
//#UC START# *4CAC45AE011E_4CC7F3170362_var*
//#UC END# *4CAC45AE011E_4CC7F3170362_var*
begin
//#UC START# *4CAC45AE011E_4CC7F3170362_impl*
 // Это тест просто для проверки отрисовки, поэтому ничего не делаем. 
//#UC END# *4CAC45AE011E_4CC7F3170362_impl*
end;//TDrawTest.DoBeforeDrawing
{$IfEnd} // NOT Defined(NoVCM)

function TDrawTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TDrawTest.GetFolder

{$If NOT Defined(NoVCM)}
function TDrawTest.UseFormExtentAsClientSize: Boolean;
 {* Использовать заданные размеры формы как размеры клиентской области - размеры формы пересчитываются относительно этих ограничений. }
//#UC START# *4DA2F7900393_4CC7F3170362_var*
//#UC END# *4DA2F7900393_4CC7F3170362_var*
begin
//#UC START# *4DA2F7900393_4CC7F3170362_impl*
 Result := True;
//#UC END# *4DA2F7900393_4CC7F3170362_impl*
end;//TDrawTest.UseFormExtentAsClientSize
{$IfEnd} // NOT Defined(NoVCM)

function TDrawTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CC7F3170362';
end;//TDrawTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
