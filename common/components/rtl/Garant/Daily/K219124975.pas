unit K219124975;
 {* [RequestLink:219124975] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K219124975.pas"
// Стереотип: "TestCase"
// Элемент модели: "K219124975" MUID: (4C21F7540004)
// Имя типа: "TK219124975"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore235875079
 {$IfEnd} // NOT Defined(NoVCM)
 , evHAFPainterEx
;

type
 TK219124975 = class({$If NOT Defined(NoVCM)}
 TPreviewTestBefore235875079
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:219124975] }
  protected
   {$If NOT Defined(NoVCM)}
   function TreatExceptionAsSuccess: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ReadColontituls(var theColontituls: TevColontituls); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetHAFFontSize: Integer; override;
    {* Размер колонтитулов. 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK219124975
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evTypes
 , l3Base
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4C21F7540004impl_uses*
 //#UC END# *4C21F7540004impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK219124975.TreatExceptionAsSuccess: Boolean;
//#UC START# *4BFD1B5A0200_4C21F7540004_var*
//#UC END# *4BFD1B5A0200_4C21F7540004_var*
begin
//#UC START# *4BFD1B5A0200_4C21F7540004_impl*
 Result := true;
//#UC END# *4BFD1B5A0200_4C21F7540004_impl*
end;//TK219124975.TreatExceptionAsSuccess

function TK219124975.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C21F7540004_var*
//#UC END# *4C07AC6F036D_4C21F7540004_var*
begin
//#UC START# *4C07AC6F036D_4C21F7540004_impl*
 Result := 39;
//#UC END# *4C07AC6F036D_4C21F7540004_impl*
end;//TK219124975.GetNormalFontSize

procedure TK219124975.ReadColontituls(var theColontituls: TevColontituls);
//#UC START# *4C221AE002A2_4C21F7540004_var*
//#UC END# *4C221AE002A2_4C21F7540004_var*
begin
//#UC START# *4C221AE002A2_4C21F7540004_impl*
 inherited;
 theColontituls[pcUpRightFirst] := l3CStr('%DocFullName%'#10'%DocRedactionDate%');
 theColontituls[pcUpRight] := theColontituls[pcUpRightFirst];
 theColontituls[pcDownRightFirst] := l3CStr(''{'%DocCurrentPage% / %DocPagesCount%'});
 theColontituls[pcDownRight] := theColontituls[pcDownRightFirst];
//#UC END# *4C221AE002A2_4C21F7540004_impl*
end;//TK219124975.ReadColontituls

function TK219124975.GetHAFFontSize: Integer;
 {* Размер колонтитулов. 0 - по-умолчанию }
//#UC START# *4C2224D00159_4C21F7540004_var*
//#UC END# *4C2224D00159_4C21F7540004_var*
begin
//#UC START# *4C2224D00159_4C21F7540004_impl*
 Result := 28;
//#UC END# *4C2224D00159_4C21F7540004_impl*
end;//TK219124975.GetHAFFontSize

function TK219124975.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK219124975.GetFolder

function TK219124975.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C21F7540004';
end;//TK219124975.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK219124975.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
