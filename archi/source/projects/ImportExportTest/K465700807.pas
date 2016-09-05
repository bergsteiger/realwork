unit K465700807;

// Модуль: "w:\archi\source\projects\ImportExportTest\K465700807.pas"
// Стереотип: "TestCase"
// Элемент модели: "TK465700807" MUID: (51CC0A110114)

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ietBaseTest
 , evdDTTypes
;

type
 TK465700807 = class(TietBaseTest)
  protected
   function GetOutputFormat: TepSupportFileType; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK465700807
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *51CC0A110114impl_uses*
 //#UC END# *51CC0A110114impl_uses*
;

function TK465700807.GetOutputFormat: TepSupportFileType;
//#UC START# *51CBE62E006B_51CC0A110114_var*
//#UC END# *51CBE62E006B_51CC0A110114_var*
begin
//#UC START# *51CBE62E006B_51CC0A110114_impl*
 Result := outNSRC;
//#UC END# *51CBE62E006B_51CC0A110114_impl*
end;//TK465700807.GetOutputFormat

function TK465700807.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ImportExport';
end;//TK465700807.GetFolder

function TK465700807.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51CC0A110114';
end;//TK465700807.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK465700807.Suite);
{$IfEnd} // Defined(nsTest)

end.
