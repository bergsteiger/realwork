unit PreviewWithRowCompare;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/PreviewWithRowCompare.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TPreviewWithRowCompare
//
// Тест печати со сравнением строк.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PreviewTestBefore278833302
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _PrintRowCompare_Parent_ = TPreviewTestBefore278833302;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\PrintRowCompare.imp.pas}
 TPreviewWithRowCompare = {abstract} class(_PrintRowCompare_)
  {* Тест печати со сравнением строк. }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TPreviewWithRowCompare
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  TestFrameWork,
  PrintRowHeightsSpy
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\PrintRowCompare.imp.pas}

// start class TPreviewWithRowCompare

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TPreviewWithRowCompare.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4DF1E915017B_var*
var
 l_OldName: string;
 l_LogName: string;
//#UC END# *4BE419AF0217_4DF1E915017B_var*
begin
//#UC START# *4BE419AF0217_4DF1E915017B_impl*
 l_LogName := OutputPath + KPage + '.rowh';
 TPrintRowHeightsSpy.Instance.StartLogging(l_LogName);
 try
  inherited DoVisit(aForm);
 finally
  TPrintRowHeightsSpy.Instance.StopLogging;
 end;
 l_OldName := f_CurrentOutput;
 try
  f_CurrentOutput := l_LogName;
  CheckOutputWithInput(ChangeFileExt(ExtractFileName(l_LogName), EtalonSuffix + '.rowh'));
 finally
  f_CurrentOutput := l_OldName;
 end;
//#UC END# *4BE419AF0217_4DF1E915017B_impl*
end;//TPreviewWithRowCompare.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TPreviewWithRowCompare.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TPreviewWithRowCompare.GetFolder

function TPreviewWithRowCompare.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DF1E915017B';
end;//TPreviewWithRowCompare.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.