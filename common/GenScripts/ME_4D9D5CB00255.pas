unit K259163553;
 {* [$259163553] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K259163553.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollUpAndDownAndCheckShapes
 , Types
;

type
 TK259163553 = class(TScrollUpAndDownAndCheckShapes)
  {* [$259163553] }
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
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK259163553
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK259163553.GetScrollCount(aUp: Boolean): Integer;
//#UC START# *4D9AE1F40181_4D9D5CB00255_var*
//#UC END# *4D9AE1F40181_4D9D5CB00255_var*
begin
//#UC START# *4D9AE1F40181_4D9D5CB00255_impl*
 if aUp then
  Result := 3
 else
  Result := 16;
//#UC END# *4D9AE1F40181_4D9D5CB00255_impl*
end;//TK259163553.GetScrollCount

{$If NOT Defined(NoVCM)}
function TK259163553.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4D9D5CB00255_var*
//#UC END# *4C07AC6F036D_4D9D5CB00255_var*
begin
//#UC START# *4C07AC6F036D_4D9D5CB00255_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D9D5CB00255_impl*
end;//TK259163553.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK259163553.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4D9D5CB00255_var*
//#UC END# *4C08CF4300BE_4D9D5CB00255_var*
begin
//#UC START# *4C08CF4300BE_4D9D5CB00255_impl*
 Result := True;
//#UC END# *4C08CF4300BE_4D9D5CB00255_impl*
end;//TK259163553.WebStyle
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK259163553.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4D9D5CB00255_var*
//#UC END# *4C08CF700318_4D9D5CB00255_var*
begin
//#UC START# *4C08CF700318_4D9D5CB00255_impl*
 Result.X := 970;
 Result.Y := 670; 
//#UC END# *4C08CF700318_4D9D5CB00255_impl*
end;//TK259163553.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK259163553.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK259163553.GetFolder

function TK259163553.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D9D5CB00255';
end;//TK259163553.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK259163553.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4D9D5CB00255_var*
//#UC END# *51AF49E5001B_4D9D5CB00255_var*
begin
//#UC START# *51AF49E5001B_4D9D5CB00255_impl*
 Result := True;
//#UC END# *51AF49E5001B_4D9D5CB00255_impl*
end;//TK259163553.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK259163553.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
