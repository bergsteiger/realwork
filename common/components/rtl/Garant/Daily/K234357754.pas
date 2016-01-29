unit K234357754;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K234357754.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K234357754
//
// [$234357754]
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
  MergeAndCheckSelectionTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK234357754 = class(TMergeAndCheckSelectionTest)
  {* [$234357754] }
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
 end;//TK234357754
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  l3Base,
  evOp,
  l3InternalInterfaces,
  evTypes,
  evMsgCode
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK234357754

function TK234357754.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK234357754.GetFolder

procedure TK234357754.GetSelectParam(out aStartRow: Integer;
  out aStartCell: Integer;
  out aFinishRow: Integer;
  out aFinishCell: Integer);
//#UC START# *4CC81D4101AC_4CE13064009E_var*
//#UC END# *4CC81D4101AC_4CE13064009E_var*
begin
//#UC START# *4CC81D4101AC_4CE13064009E_impl*
 aStartRow := 0;
 aStartCell := 1;
 aFinishRow := 1;
 aFinishCell := 2;
//#UC END# *4CC81D4101AC_4CE13064009E_impl*
end;//TK234357754.GetSelectParam

function TK234357754.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CE13064009E';
end;//TK234357754.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK234357754.Suite);

end.