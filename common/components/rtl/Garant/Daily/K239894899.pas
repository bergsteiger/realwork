unit K239894899;
 {* [$239894899] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K239894899.pas"
// Стереотип: "TestCase"
// Элемент модели: "K239894899" MUID: (4CDBC300002E)
// Имя типа: "TK239894899"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PreviewTestBefore235875079WithRowCmp
;

type
 TK239894899 = class(TPreviewTestBefore235875079WithRowCmp)
  {* [$239894899] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetHAFFontSize: Integer; override;
    {* Размер колонтитулов. 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TK239894899
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , PrintRowHeightsSpy
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
function TK239894899.GetHAFFontSize: Integer;
 {* Размер колонтитулов. 0 - по-умолчанию }
//#UC START# *4C2224D00159_4CDBC300002E_var*
//#UC END# *4C2224D00159_4CDBC300002E_var*
begin
//#UC START# *4C2224D00159_4CDBC300002E_impl*
 Result := 12;
//#UC END# *4C2224D00159_4CDBC300002E_impl*
end;//TK239894899.GetHAFFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK239894899.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK239894899.GetFolder

function TK239894899.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CDBC300002E';
end;//TK239894899.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK239894899.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4CDBC300002E_var*
//#UC END# *51AF49E5001B_4CDBC300002E_var*
begin
//#UC START# *51AF49E5001B_4CDBC300002E_impl*
 Result := true;
//#UC END# *51AF49E5001B_4CDBC300002E_impl*
end;//TK239894899.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

initialization
 TestFramework.RegisterTest(TK239894899.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
