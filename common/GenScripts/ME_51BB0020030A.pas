unit K460275638Suite;

// Модуль: "w:\common\components\rtl\Garant\Daily\K460275638Suite.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TK460275638Suite" MUID: (51BB0020030A)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CustomFolderTestSuite
;

type
 TK460275638Suite = class(TCustomFolderTestSuite)
  protected
   function GetExt: AnsiString; override;
 end;//TK460275638Suite
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TK460275638Suite.GetExt: AnsiString;
//#UC START# *4EA50C04021B_51BB0020030A_var*
//#UC END# *4EA50C04021B_51BB0020030A_var*
begin
//#UC START# *4EA50C04021B_51BB0020030A_impl*
 Result := '.regexp';
//#UC END# *4EA50C04021B_51BB0020030A_impl*
end;//TK460275638Suite.GetExt
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
