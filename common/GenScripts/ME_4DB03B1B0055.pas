unit InsiderOwnScripter;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\InsiderOwnScripter.pas"
// Стереотип: "TestCase"
// Элемент модели: "InsiderOwnScripter" MUID: (4DB03B1B0055)
// Имя типа: "TInsiderOwnScripter"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CustomInsiderScripter
 //#UC START# *4DB03B1B0055intf_uses*
 //#UC END# *4DB03B1B0055intf_uses*
;

type
 //#UC START# *4DB03B1B0055ci*
 //#UC END# *4DB03B1B0055ci*
 //#UC START# *4DB03B1B0055cit*
 //#UC END# *4DB03B1B0055cit*
 TInsiderOwnScripter = {abstract} class(TCustomInsiderScripter)
  protected
   procedure Run; override;
   procedure Prepare; override;
    {* Вызывается в начале DoIt }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 //#UC START# *4DB03B1B0055publ*
 //#UC END# *4DB03B1B0055publ*
 end;//TInsiderOwnScripter
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , tfwScriptEngine
 //#UC START# *4DB03B1B0055impl_uses*
 , nsUtils
 //#UC END# *4DB03B1B0055impl_uses*
;

procedure TInsiderOwnScripter.Run;
//#UC START# *4DC3D2E00153_4DB03B1B0055_var*
//#UC END# *4DC3D2E00153_4DB03B1B0055_var*
begin
//#UC START# *4DC3D2E00153_4DB03B1B0055_impl*
 OwnScriptFromFile;
//#UC END# *4DC3D2E00153_4DB03B1B0055_impl*
end;//TInsiderOwnScripter.Run

procedure TInsiderOwnScripter.Prepare;
 {* Вызывается в начале DoIt }
//#UC START# *4DC3DE630030_4DB03B1B0055_var*
//#UC END# *4DC3DE630030_4DB03B1B0055_var*
begin
//#UC START# *4DC3DE630030_4DB03B1B0055_impl*
 g_WasBeep := false;
 //Script('"Закрыть все окна кроме текущего" StyleTable:Restore ОсновноеМеню "Сбрасываем вкладку БП в умолчательное состояние" "Выключаем машину времени" clipboard:clear');
 //ScriptFromFile('@\TestProlog.script');
//#UC END# *4DC3DE630030_4DB03B1B0055_impl*
end;//TInsiderOwnScripter.Prepare

function TInsiderOwnScripter.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Core';
end;//TInsiderOwnScripter.GetFolder

function TInsiderOwnScripter.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DB03B1B0055';
end;//TInsiderOwnScripter.GetModelElementGUID

//#UC START# *4DB03B1B0055impl*
//#UC END# *4DB03B1B0055impl*
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
