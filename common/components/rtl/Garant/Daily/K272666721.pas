unit K272666721;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K272666721.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K272666721
//
// [$272666721]
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
  InsertSectionBreak,
  evCustomEditorWindow
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK272666721 = class(TInsertSectionBreak)
  {* [$272666721] }
 protected
 // realized methods
   function MoveCursorCount: Integer; override;
   procedure CheckPara(const aText: TevCustomEditorWindow); override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK272666721
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevBase,
  TestFrameWork,
  evMsgCode,
  evOp
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

// start class TK272666721

function TK272666721.MoveCursorCount: Integer;
//#UC START# *4E158FBB0190_4E158C2C0116_var*
//#UC END# *4E158FBB0190_4E158C2C0116_var*
begin
//#UC START# *4E158FBB0190_4E158C2C0116_impl*
 Result := 3;
//#UC END# *4E158FBB0190_4E158C2C0116_impl*
end;//TK272666721.MoveCursorCount

procedure TK272666721.CheckPara(const aText: TevCustomEditorWindow);
//#UC START# *4E15941B03E7_4E158C2C0116_var*
var
 l_UpperFI: TnevFormatInfoPrim;
 l_LowerFI: TnevFormatInfoPrim;
//#UC END# *4E15941B03E7_4E158C2C0116_var*
begin
//#UC START# *4E15941B03E7_4E158C2C0116_impl*
 l_UpperFI := aText.View.FormatInfoByPoint(aText.Document.Para[1].MakePoint);
 l_LowerFI := aText.View.FormatInfoByPoint(aText.Document.Para[aText.Document.ChildrenCount - 1].MakePoint);
 Check(l_UpperFI.RLimitWidth <> l_LowerFI.RLimitWidth, 'Разделы разные, а ширина параграфов одинаковая!');
//#UC END# *4E15941B03E7_4E158C2C0116_impl*
end;//TK272666721.CheckPara

function TK272666721.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK272666721.GetFolder

function TK272666721.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E158C2C0116';
end;//TK272666721.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK272666721.Suite);

end.