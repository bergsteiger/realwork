unit K275780190;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Tests"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Archi_Tests/K275780190.pas"
// Начат: 26.07.2011 16:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Archi Tests::Tags::K275780190
//
// {RequestLink:275780190}.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Archi_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK275780190 = class(TTextViaEditorProcessor)
  {* [RequestLink:275780190]. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK275780190
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  k2Tags,
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK275780190

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TK275780190.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4E2EB2D50291_var*
//#UC END# *4BE13147032C_4E2EB2D50291_var*
begin
//#UC START# *4BE13147032C_4E2EB2D50291_impl*
 aForm.Text.Document.Int64A[k2_tiMDPPageID] := $FAFAFAFAFEFEFEFE;
//#UC END# *4BE13147032C_4E2EB2D50291_impl*
end;//TK275780190.Process
{$IfEnd} //nsTest AND not NoVCM

function TK275780190.GetFolder: AnsiString;
 {-}
begin
 Result := 'Tags';
end;//TK275780190.GetFolder

function TK275780190.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E2EB2D50291';
end;//TK275780190.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK275780190.Suite);

end.