unit K259163541;
 {* [$259163541] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K259163541.pas"
// Стереотип: "TestCase"
// Элемент модели: "K259163541" MUID: (4D9AD88E026D)
// Имя типа: "TK259163541"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollUpAndDownAndCheckShapes
 , Types
;

type
 TK259163541 = class(TScrollUpAndDownAndCheckShapes)
  {* [$259163541] }
  protected
   function GetScrollCount(aUp: Boolean): Integer; override;
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK259163541
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3InternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
;

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

{$If NOT Defined(NoVCM)}
function TK259163541.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4D9AD88E026D_var*
//#UC END# *4C07AC6F036D_4D9AD88E026D_var*
begin
//#UC START# *4C07AC6F036D_4D9AD88E026D_impl*
 Result := 12;        
//#UC END# *4C07AC6F036D_4D9AD88E026D_impl*
end;//TK259163541.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK259163541.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4D9AD88E026D_var*
//#UC END# *4C08CF4300BE_4D9AD88E026D_var*
begin
//#UC START# *4C08CF4300BE_4D9AD88E026D_impl*
 Result := True;
//#UC END# *4C08CF4300BE_4D9AD88E026D_impl*
end;//TK259163541.WebStyle
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK259163541.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4D9AD88E026D_var*
//#UC END# *4C08CF700318_4D9AD88E026D_var*
begin
//#UC START# *4C08CF700318_4D9AD88E026D_impl*
 Result.X := 970;
 Result.Y := 670;     
//#UC END# *4C08CF700318_4D9AD88E026D_impl*
end;//TK259163541.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK259163541.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK259163541.GetFolder

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK259163541.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4D9AD88E026D_var*
//#UC END# *51AF49E5001B_4D9AD88E026D_var*
begin
//#UC START# *51AF49E5001B_4D9AD88E026D_impl*
 Result := True;
//#UC END# *51AF49E5001B_4D9AD88E026D_impl*
end;//TK259163541.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK259163541.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D9AD88E026D';
end;//TK259163541.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK259163541.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
