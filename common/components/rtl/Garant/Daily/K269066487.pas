unit K269066487;
 {* [RequestLink:269066487] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K269066487.pas"
// Стереотип: "TestCase"
// Элемент модели: "K269066487" MUID: (4DF781FF03B3)
// Имя типа: "TK269066487"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DeleteCharTest
 , evCustomEditorWindow
 , l3Variant
;

type
 TK269066487 = class(TDeleteCharTest)
  {* [RequestLink:269066487] }
  protected
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
    {* Устанавливает курсор или выделение }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function CharCount: Integer; override;
 end;//TK269066487
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
;

procedure TK269066487.Navigate(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
 {* Устанавливает курсор или выделение }
//#UC START# *4C4FE56300FB_4DF781FF03B3_var*
//#UC END# *4C4FE56300FB_4DF781FF03B3_var*
begin
//#UC START# *4C4FE56300FB_4DF781FF03B3_impl*
 // - ничего не делаем 
//#UC END# *4C4FE56300FB_4DF781FF03B3_impl*
end;//TK269066487.Navigate

function TK269066487.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK269066487.GetFolder

function TK269066487.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DF781FF03B3';
end;//TK269066487.GetModelElementGUID

function TK269066487.CharCount: Integer;
//#UC START# *4DF781CB0217_4DF781FF03B3_var*
//#UC END# *4DF781CB0217_4DF781FF03B3_var*
begin
//#UC START# *4DF781CB0217_4DF781FF03B3_impl*
 Result := 17; 
//#UC END# *4DF781CB0217_4DF781FF03B3_impl*
end;//TK269066487.CharCount

initialization
 TestFramework.RegisterTest(TK269066487.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
