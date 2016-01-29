unit K252524333;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K252524333.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K252524333
//
// [$252524333]
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
  ColumnResizeWithCtrl
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK252524333 = class(TColumnResizeWithCtrl)
  {* [$252524333] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   procedure GetColumnAndRow(var aCol: Integer;
     var aRow: Integer); override;
   function GetDelta: Integer; override;
 end;//TK252524333
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

// start class TK252524333

function TK252524333.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK252524333.GetFolder

function TK252524333.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D53D7020116';
end;//TK252524333.GetModelElementGUID

procedure TK252524333.GetColumnAndRow(var aCol: Integer;
  var aRow: Integer);
//#UC START# *4E32CA35008A_4D53D7020116_var*
//#UC END# *4E32CA35008A_4D53D7020116_var*
begin
//#UC START# *4E32CA35008A_4D53D7020116_impl*
 aCol := 2;
 aRow := 4;
//#UC END# *4E32CA35008A_4D53D7020116_impl*
end;//TK252524333.GetColumnAndRow

function TK252524333.GetDelta: Integer;
//#UC START# *4E32CA5E0115_4D53D7020116_var*
//#UC END# *4E32CA5E0115_4D53D7020116_var*
begin
//#UC START# *4E32CA5E0115_4D53D7020116_impl*
 Result := 250;
//#UC END# *4E32CA5E0115_4D53D7020116_impl*
end;//TK252524333.GetDelta

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK252524333.Suite);

end.