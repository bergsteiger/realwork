unit K259163541;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K259163541.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K259163541
//
// [$259163541]
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
  ScrollUpAndDownAndCheckShapes,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK259163541 = class(TScrollUpAndDownAndCheckShapes)
  {* [$259163541] }
 protected
 // realized methods
   function GetScrollCount(aUp: Boolean): Integer; override;
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
    {$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
    {$IfEnd} //XE AND nsTest AND not NotTunedDUnit
 end;//TK259163541
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

// start class TK259163541

function TK259163541.GetScrollCount(aUp: Boolean): Integer;
//#UC START# *4D9AE1F40181_4D9AD88E026D_var*
//#UC END# *4D9AE1F40181_4D9AD88E026D_var*
begin
//#UC START# *4D9AE1F40181_4D9AD88E026D_impl*
 if aUp then
  Result := 2
 else
  Result := 16;
//#UC END# *4D9AE1F40181_4D9AD88E026D_impl*
end;//TK259163541.GetScrollCount

{$If defined(nsTest) AND not defined(NoVCM)}
function TK259163541.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4D9AD88E026D_var*
//#UC END# *4C07AC6F036D_4D9AD88E026D_var*
begin
//#UC START# *4C07AC6F036D_4D9AD88E026D_impl*
 Result := 12;        
//#UC END# *4C07AC6F036D_4D9AD88E026D_impl*
end;//TK259163541.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK259163541.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4D9AD88E026D_var*
//#UC END# *4C08CF4300BE_4D9AD88E026D_var*
begin
//#UC START# *4C08CF4300BE_4D9AD88E026D_impl*
 Result := True;
//#UC END# *4C08CF4300BE_4D9AD88E026D_impl*
end;//TK259163541.WebStyle
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK259163541.FormExtent: TPoint;
//#UC START# *4C08CF700318_4D9AD88E026D_var*
//#UC END# *4C08CF700318_4D9AD88E026D_var*
begin
//#UC START# *4C08CF700318_4D9AD88E026D_impl*
 Result.X := 970;
 Result.Y := 670;     
//#UC END# *4C08CF700318_4D9AD88E026D_impl*
end;//TK259163541.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK259163541.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK259163541.GetFolder

function TK259163541.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D9AD88E026D';
end;//TK259163541.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK259163541.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4D9AD88E026D_var*
//#UC END# *51AF49E5001B_4D9AD88E026D_var*
begin
//#UC START# *51AF49E5001B_4D9AD88E026D_impl*
 Result := True;
//#UC END# *51AF49E5001B_4D9AD88E026D_impl*
end;//TK259163541.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK259163541.Suite);

end.