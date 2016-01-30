unit K269062434;
 {* [$269062434] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K269062434.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PreviewWithRowCompare
;

type
 TK269062434 = class(TPreviewWithRowCompare)
  {* [$269062434] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK269062434
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK269062434.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4DF8BC1F007E_var*
//#UC END# *4C07AC6F036D_4DF8BC1F007E_var*
begin
//#UC START# *4C07AC6F036D_4DF8BC1F007E_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4DF8BC1F007E_impl*
end;//TK269062434.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK269062434.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK269062434.GetFolder

function TK269062434.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DF8BC1F007E';
end;//TK269062434.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK269062434.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4DF8BC1F007E_var*
//#UC END# *51AF49E5001B_4DF8BC1F007E_var*
begin
//#UC START# *51AF49E5001B_4DF8BC1F007E_impl*
 Result := True;
//#UC END# *51AF49E5001B_4DF8BC1F007E_impl*
end;//TK269062434.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK269062434.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
