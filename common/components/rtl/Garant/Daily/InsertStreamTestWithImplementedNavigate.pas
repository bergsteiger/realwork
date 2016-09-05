unit InsertStreamTestWithImplementedNavigate;
 {* То же что и TInsertStreamTest, но с пустым Navigate }

// Модуль: "w:\common\components\rtl\Garant\Daily\InsertStreamTestWithImplementedNavigate.pas"
// Стереотип: "TestCase"
// Элемент модели: "TInsertStreamTestWithImplementedNavigate" MUID: (4C501582010E)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , InsertStreamTest
 , evCustomEditorWindow
 , l3Variant
;

type
 TInsertStreamTestWithImplementedNavigate = {abstract} class(TInsertStreamTest)
  {* То же что и TInsertStreamTest, но с пустым Navigate }
  protected
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
    {* Устанавливает курсор или выделение }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TInsertStreamTestWithImplementedNavigate
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
 //#UC START# *4C501582010Eimpl_uses*
 //#UC END# *4C501582010Eimpl_uses*
;

procedure TInsertStreamTestWithImplementedNavigate.Navigate(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
 {* Устанавливает курсор или выделение }
//#UC START# *4C4FE56300FB_4C501582010E_var*
//#UC END# *4C4FE56300FB_4C501582010E_var*
begin
//#UC START# *4C4FE56300FB_4C501582010E_impl*
 // - ничего не делаем
//#UC END# *4C4FE56300FB_4C501582010E_impl*
end;//TInsertStreamTestWithImplementedNavigate.Navigate

function TInsertStreamTestWithImplementedNavigate.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TInsertStreamTestWithImplementedNavigate.GetFolder

function TInsertStreamTestWithImplementedNavigate.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C501582010E';
end;//TInsertStreamTestWithImplementedNavigate.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
