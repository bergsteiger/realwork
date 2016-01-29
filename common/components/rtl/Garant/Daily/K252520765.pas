unit K252520765;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K252520765.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K252520765
//
// [$252520765]
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
  ScrollByArrowAndCheckShapesTest,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK252520765 = class(TScrollByArrowAndCheckShapesTest)
  {* [$252520765] }
 protected
 // realized methods
   function GetScrollCount: Integer; override;
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK252520765
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp,
  l3InternalInterfaces
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  nevTools
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK252520765

function TK252520765.GetScrollCount: Integer;
//#UC START# *4D80BB670151_4D80BA2F01D0_var*
//#UC END# *4D80BB670151_4D80BA2F01D0_var*
begin
//#UC START# *4D80BB670151_4D80BA2F01D0_impl*
 Result := 44;
//#UC END# *4D80BB670151_4D80BA2F01D0_impl*
end;//TK252520765.GetScrollCount

{$If defined(nsTest) AND not defined(NoVCM)}
function TK252520765.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4D80BA2F01D0_var*
//#UC END# *4C07AC6F036D_4D80BA2F01D0_var*
begin
//#UC START# *4C07AC6F036D_4D80BA2F01D0_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D80BA2F01D0_impl*
end;//TK252520765.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK252520765.FormExtent: TPoint;
//#UC START# *4C08CF700318_4D80BA2F01D0_var*
//#UC END# *4C08CF700318_4D80BA2F01D0_var*
begin
//#UC START# *4C08CF700318_4D80BA2F01D0_impl*
 Result.X := 950;
 Result.Y := 670;
//#UC END# *4C08CF700318_4D80BA2F01D0_impl*
end;//TK252520765.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK252520765.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK252520765.GetFolder

function TK252520765.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D80BA2F01D0';
end;//TK252520765.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK252520765.Suite);

end.