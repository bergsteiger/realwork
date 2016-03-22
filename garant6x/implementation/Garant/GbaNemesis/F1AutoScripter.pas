unit F1AutoScripter;
 {* Скрипт с поддержкой авторегистрации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1AutoScripter.pas"
// Стереотип: "TestCase"
// Элемент модели: "TF1AutoScripter" MUID: (4DC3F6DD00F1)

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , InsiderOwnScripter
;

type
 TF1AutoScripter = {abstract} class(TInsiderOwnScripter)
  {* Скрипт с поддержкой авторегистрации }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function ResolveScriptFilePath(const aFileName: AnsiString): AnsiString; override;
   class function IsScript: Boolean; override;
    {* Хак для конструктора - из-за хитрой иерархии и кучи конструкторов в TTestSuite. }
 end;//TF1AutoScripter
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , StrUtils
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(Admin)}
 , nsQueryInterfaces
 {$IfEnd} // NOT Defined(Admin)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUtils
 , nsConst
 , bsTypesNew
 , tfwScriptEngine
;

function TF1AutoScripter.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Core';
end;//TF1AutoScripter.GetFolder

function TF1AutoScripter.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DC3F6DD00F1';
end;//TF1AutoScripter.GetModelElementGUID

function TF1AutoScripter.ResolveScriptFilePath(const aFileName: AnsiString): AnsiString;
//#UC START# *4DB03121022B_4DC3F6DD00F1_var*
//#UC END# *4DB03121022B_4DC3F6DD00F1_var*
begin
//#UC START# *4DB03121022B_4DC3F6DD00F1_impl*
 if ANSIStartsText('@\', aFileName) then
  Result := FileFromCurrent('Common\' + Copy(aFileName, 3, Length(aFileName)-2))
 else 
 if (ExtractFilePath(aFileName) <> '') then
  Result := aFileName
 else
  Result := FileFromCurrent('Auto') + '\'+ aFileName;
//#UC END# *4DB03121022B_4DC3F6DD00F1_impl*
end;//TF1AutoScripter.ResolveScriptFilePath

class function TF1AutoScripter.IsScript: Boolean;
 {* Хак для конструктора - из-за хитрой иерархии и кучи конструкторов в TTestSuite. }
//#UC START# *4DC395670274_4DC3F6DD00F1_var*
//#UC END# *4DC395670274_4DC3F6DD00F1_var*
begin
//#UC START# *4DC395670274_4DC3F6DD00F1_impl*
 Result := True;
//#UC END# *4DC395670274_4DC3F6DD00F1_impl*
end;//TF1AutoScripter.IsScript
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
