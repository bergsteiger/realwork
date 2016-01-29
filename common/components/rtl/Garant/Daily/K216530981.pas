unit K216530981;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K216530981.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K216530981
//
// [$216530981]
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
  MergeCellsTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK216530981 = class(TMergeCellsTest)
  {* [$216530981] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
     {* Получить "координаты" точек выделения. }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK216530981
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
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

// start class TK216530981

function TK216530981.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK216530981.GetFolder

procedure TK216530981.GetSelectParam(out aStartRow: Integer;
  out aStartCell: Integer;
  out aFinishRow: Integer;
  out aFinishCell: Integer);
//#UC START# *4CC81D4101AC_4C123FA0030D_var*
//#UC END# *4CC81D4101AC_4C123FA0030D_var*
begin
//#UC START# *4CC81D4101AC_4C123FA0030D_impl*
 aStartRow := 0;
 aStartCell := 0;
 aFinishRow := 2;
 aFinishCell := 1;
//#UC END# *4CC81D4101AC_4C123FA0030D_impl*
end;//TK216530981.GetSelectParam

function TK216530981.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C123FA0030D';
end;//TK216530981.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK216530981.Suite);

end.