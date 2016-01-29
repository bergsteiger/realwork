unit ColumnResizeWithCtrl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ColumnResizeWithCtrl.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TColumnResizeWithCtrl
//
// Изменение размера колонки с зажатым Ctrl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  ColumnResizeByMousePrimTest,
  Classes
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TColumnResizeWithCtrl = {abstract} class(TColumnResizeByMousePrimTest)
  {* Изменение размера колонки с зажатым Ctrl }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function GetKeys: TShiftState; override;
 end;//TColumnResizeWithCtrl
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TColumnResizeWithCtrl

function TColumnResizeWithCtrl.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TColumnResizeWithCtrl.GetFolder

function TColumnResizeWithCtrl.GetModelElementGUID: AnsiString;
 {-}
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

{$IfEnd} //nsTest AND not NoScripts

end.