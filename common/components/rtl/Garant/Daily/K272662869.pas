unit K272662869;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K272662869.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K272662869
//
// [$272662869]
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
  HorzMergeCells
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK272662869 = class(THorzMergeCells)
  {* [$272662869] }
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
 end;//TK272662869
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

// start class TK272662869

function TK272662869.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK272662869.GetFolder

procedure TK272662869.GetSelectParam(out aStartRow: Integer;
  out aStartCell: Integer;
  out aFinishRow: Integer;
  out aFinishCell: Integer);
//#UC START# *4CC81D4101AC_4E11B5E4026F_var*
//#UC END# *4CC81D4101AC_4E11B5E4026F_var*
begin
//#UC START# *4CC81D4101AC_4E11B5E4026F_impl*
 aStartRow := 0;
 aStartCell := 0;
 aFinishRow := 2;
 aFinishCell := 2;
//#UC END# *4CC81D4101AC_4E11B5E4026F_impl*
end;//TK272662869.GetSelectParam

function TK272662869.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E11B5E4026F';
end;//TK272662869.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK272662869.Suite);

end.