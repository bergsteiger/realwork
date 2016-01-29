unit PreviewTestBefore235875079WithRowCmp;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/PreviewTestBefore235875079WithRowCmp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TPreviewTestBefore235875079WithRowCmp
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
  PreviewTestBefore235875079
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _PrintRowCompare_Parent_ = TPreviewTestBefore235875079;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\PrintRowCompare.imp.pas}
 TPreviewTestBefore235875079WithRowCmp = {abstract} class(_PrintRowCompare_)
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
 end;//TPreviewTestBefore235875079WithRowCmp
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

// start class TPreviewTestBefore235875079WithRowCmp

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TPreviewTestBefore235875079WithRowCmp.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4DF88322024C_var*
var
 l_OldName: string;
 l_LogName: string;
//#UC END# *4BE419AF0217_4DF88322024C_var*
begin
//#UC START# *4BE419AF0217_4DF88322024C_impl*
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
//#UC END# *4BE419AF0217_4DF88322024C_impl*
end;//TPreviewTestBefore235875079WithRowCmp.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TPreviewTestBefore235875079WithRowCmp.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TPreviewTestBefore235875079WithRowCmp.GetFolder

function TPreviewTestBefore235875079WithRowCmp.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DF88322024C';
end;//TPreviewTestBefore235875079WithRowCmp.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.