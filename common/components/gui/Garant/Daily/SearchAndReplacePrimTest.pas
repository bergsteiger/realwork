unit SearchAndReplacePrimTest;
 {* Тест поиска/замены }

// Модуль: "w:\common\components\gui\Garant\Daily\SearchAndReplacePrimTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TSearchAndReplacePrimTest" MUID: (4C288B4D012F)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessor
 , nevTools
 , evTypes
 , PrimTextLoad_Form
;

type
 TSearchAndReplacePrimTest = {abstract} class(TTextViaEditorProcessor)
  {* Тест поиска/замены }
  protected
   function Searcher: IevSearcher; virtual; abstract;
   function Replacer: IevReplacer; virtual; abstract;
   function Options: TevSearchOptionSet; virtual; abstract;
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TSearchAndReplacePrimTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TSearchAndReplacePrimTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4C288B4D012F_var*
//#UC END# *4BE13147032C_4C288B4D012F_var*
begin
//#UC START# *4BE13147032C_4C288B4D012F_impl*
 aForm.Text.Find(Searcher,
                 Replacer,
                 Options);
//#UC END# *4BE13147032C_4C288B4D012F_impl*
end;//TSearchAndReplacePrimTest.Process

function TSearchAndReplacePrimTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TSearchAndReplacePrimTest.GetFolder

function TSearchAndReplacePrimTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C288B4D012F';
end;//TSearchAndReplacePrimTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
