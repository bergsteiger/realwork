unit K234363615;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K234363615.pas"
// Начат: 17.09.2010 15:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K234363615
//
// {RequestLink:234363615}.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  CopyPasteTest,
  nevTools,
  evCustomEditorWindow,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK234363615 = class(TCopyPasteTest)
  {* [RequestLink:234363615]. }
 protected
 // realized methods
   function DoSelect(aText: TevCustomEditorWindow;
     const anOp: Il3OpPack): InevRange; override;
     {* Выделяет текст в редакторе }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK234363615
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp,
  l3Base,
  l3InternalInterfaces
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK234363615

function TK234363615.DoSelect(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack): InevRange;
//#UC START# *4C93538E0218_4C9352DE031D_var*
//#UC END# *4C93538E0218_4C9352DE031D_var*
begin
//#UC START# *4C93538E0218_4C9352DE031D_impl*
 Result := aText.Document.Para[4].Range;
//#UC END# *4C93538E0218_4C9352DE031D_impl*
end;//TK234363615.DoSelect

function TK234363615.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK234363615.GetFolder

function TK234363615.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C9352DE031D';
end;//TK234363615.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK234363615.Suite);

end.