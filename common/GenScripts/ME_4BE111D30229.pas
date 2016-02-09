unit TextViaEditorProcessor;
 {* Обработчик текста через редактор }

// Модуль: "w:\common\components\gui\Garant\Daily\TextViaEditorProcessor.pas"
// Стереотип: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TTextViaEditorProcessor = {abstract} class(TTextEditorVisitor)
  {* Обработчик текста через редактор }
  protected
   function EtalonFileExtension: AnsiString; virtual;
    {* Расширение эталонного файла }
   function HeaderBegin: AnsiChar; virtual;
   procedure Process(aForm: TPrimTextLoadForm); virtual; abstract;
    {* Собственно процесс обработки текста }
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTextViaEditorProcessor
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

function TTextViaEditorProcessor.EtalonFileExtension: AnsiString;
 {* Расширение эталонного файла }
//#UC START# *4D0769150130_4BE111D30229_var*
//#UC END# *4D0769150130_4BE111D30229_var*
begin
//#UC START# *4D0769150130_4BE111D30229_impl*
 Result := 'evd';
//#UC END# *4D0769150130_4BE111D30229_impl*
end;//TTextViaEditorProcessor.EtalonFileExtension

function TTextViaEditorProcessor.HeaderBegin: AnsiChar;
//#UC START# *4D07693F0262_4BE111D30229_var*
//#UC END# *4D07693F0262_4BE111D30229_var*
begin
//#UC START# *4D07693F0262_4BE111D30229_impl*
 Result := '%';
//#UC END# *4D07693F0262_4BE111D30229_impl*
end;//TTextViaEditorProcessor.HeaderBegin

procedure TTextViaEditorProcessor.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4BE111D30229_var*
//#UC END# *4BE419AF0217_4BE111D30229_var*
begin
//#UC START# *4BE419AF0217_4BE111D30229_impl*
 Process(aForm);
 Save(aForm);
 CheckOutputWithInput(KPage + EtalonSuffix + '.' + EtalonFileExtension, HeaderBegin);
//#UC END# *4BE419AF0217_4BE111D30229_impl*
end;//TTextViaEditorProcessor.DoVisit

function TTextViaEditorProcessor.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TTextViaEditorProcessor.GetFolder

function TTextViaEditorProcessor.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE111D30229';
end;//TTextViaEditorProcessor.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
