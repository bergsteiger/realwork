unit K218824755;
 {* [RequestLink:218824755] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K218824755.pas"
// Стереотип: "TestCase"
// Элемент модели: "K218824755" MUID: (4C1B56120220)
// Имя типа: "TK218824755"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ComplexScrollByLines
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
;

type
 TK218824755 = class({$If NOT Defined(NoVCM)}
 TComplexScrollByLines
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:218824755] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetScrollLineCount2Down: Integer; override;
    {* количество строк для прокрутки вниз }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetScrollLineCount2Up: Integer; override;
    {* количество строк для прокрутки вверх }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CheckTopAnchor(const aView: InevInputView); override;
    {* проверить якорь начала отрисовки после окончания прокрутки }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK218824755
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4C1B56120220impl_uses*
 //#UC END# *4C1B56120220impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK218824755.GetScrollLineCount2Down: Integer;
 {* количество строк для прокрутки вниз }
//#UC START# *4C1B13B6016B_4C1B56120220_var*
//#UC END# *4C1B13B6016B_4C1B56120220_var*
begin
//#UC START# *4C1B13B6016B_4C1B56120220_impl*
 Result := 8;
//#UC END# *4C1B13B6016B_4C1B56120220_impl*
end;//TK218824755.GetScrollLineCount2Down

function TK218824755.GetScrollLineCount2Up: Integer;
 {* количество строк для прокрутки вверх }
//#UC START# *4C1B140B002A_4C1B56120220_var*
//#UC END# *4C1B140B002A_4C1B56120220_var*
begin
//#UC START# *4C1B140B002A_4C1B56120220_impl*
 Result := 2;
//#UC END# *4C1B140B002A_4C1B56120220_impl*
end;//TK218824755.GetScrollLineCount2Up

procedure TK218824755.CheckTopAnchor(const aView: InevInputView);
 {* проверить якорь начала отрисовки после окончания прокрутки }
//#UC START# *4C1F0A260192_4C1B56120220_var*
//#UC END# *4C1F0A260192_4C1B56120220_var*
begin
//#UC START# *4C1F0A260192_4C1B56120220_impl*
 
//#UC END# *4C1F0A260192_4C1B56120220_impl*
end;//TK218824755.CheckTopAnchor

function TK218824755.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK218824755.GetFolder

function TK218824755.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C1B56120220';
end;//TK218824755.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK218824755.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
