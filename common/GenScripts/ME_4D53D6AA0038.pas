unit ColumnResizeWithCtrl;
 {* Изменение размера колонки с зажатым Ctrl }

// Модуль: "w:\common\components\rtl\Garant\Daily\ColumnResizeWithCtrl.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ColumnResizeByMousePrimTest
 , Classes
;

type
 TColumnResizeWithCtrl = {abstract} class(TColumnResizeByMousePrimTest)
  {* Изменение размера колонки с зажатым Ctrl }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function GetKeys: TShiftState; override;
 end;//TColumnResizeWithCtrl
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

function TColumnResizeWithCtrl.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TColumnResizeWithCtrl.GetFolder

function TColumnResizeWithCtrl.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D53D6AA0038';
end;//TColumnResizeWithCtrl.GetModelElementGUID

function TColumnResizeWithCtrl.GetKeys: TShiftState;
//#UC START# *4E32CA120170_4D53D6AA0038_var*
//#UC END# *4E32CA120170_4D53D6AA0038_var*
begin
//#UC START# *4E32CA120170_4D53D6AA0038_impl*
 Result := [ssCtrl];
//#UC END# *4E32CA120170_4D53D6AA0038_impl*
end;//TColumnResizeWithCtrl.GetKeys
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
