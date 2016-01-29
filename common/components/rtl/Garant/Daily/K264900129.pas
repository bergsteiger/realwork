unit K264900129;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K264900129.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K264900129
//
// [$264900129]
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
 TK264900129 = class(TScrollByArrowAndCheckShapesTest)
  {* [$264900129] }
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
 end;//TK264900129
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

// start class TK264900129

function TK264900129.GetScrollCount: Integer;
//#UC START# *4D80BB670151_4DB658500049_var*
//#UC END# *4D80BB670151_4DB658500049_var*
begin
//#UC START# *4D80BB670151_4DB658500049_impl*
 Result := 50;
//#UC END# *4D80BB670151_4DB658500049_impl*
end;//TK264900129.GetScrollCount

{$If defined(nsTest) AND not defined(NoVCM)}
function TK264900129.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4DB658500049_var*
//#UC END# *4C07AC6F036D_4DB658500049_var*
begin
//#UC START# *4C07AC6F036D_4DB658500049_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4DB658500049_impl*
end;//TK264900129.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK264900129.FormExtent: TPoint;
//#UC START# *4C08CF700318_4DB658500049_var*
//#UC END# *4C08CF700318_4DB658500049_var*
begin
//#UC START# *4C08CF700318_4DB658500049_impl*
 Result.X := 1000;
 Result.Y := 710;
//#UC END# *4C08CF700318_4DB658500049_impl*
end;//TK264900129.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK264900129.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK264900129.GetFolder

function TK264900129.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DB658500049';
end;//TK264900129.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK264900129.Suite);

end.