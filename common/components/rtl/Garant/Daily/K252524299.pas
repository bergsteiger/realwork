unit K252524299;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K252524299.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K252524299
//
// [$252524299]
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
  TabInTableTest,
  nevTools
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK252524299 = class(TTabInTableTest)
  {* [$252524299] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   procedure CheckPoint(const aCellPoint: InevBasePoint); override;
   function GetDownMoveCount: Integer; override;
     {* Количество смещений вниз }
   function GetTabMoveCount: Integer; override;
     {* Количество смещений по табуляциии }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK252524299
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
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

// start class TK252524299

function TK252524299.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK252524299.GetFolder

procedure TK252524299.CheckPoint(const aCellPoint: InevBasePoint);
//#UC START# *4D5A4CA602E5_4D5A463C02C1_var*
//#UC END# *4D5A4CA602E5_4D5A463C02C1_var*
begin
//#UC START# *4D5A4CA602E5_4D5A463C02C1_impl*
 Check((aCellPoint.Obj.PID = 0) and (aCellPoint.ParentPoint.Obj.PID = 4));
//#UC END# *4D5A4CA602E5_4D5A463C02C1_impl*
end;//TK252524299.CheckPoint

function TK252524299.GetDownMoveCount: Integer;
//#UC START# *4D5A4CD801F7_4D5A463C02C1_var*
//#UC END# *4D5A4CD801F7_4D5A463C02C1_var*
begin
//#UC START# *4D5A4CD801F7_4D5A463C02C1_impl*
 Result := 3;
//#UC END# *4D5A4CD801F7_4D5A463C02C1_impl*
end;//TK252524299.GetDownMoveCount

function TK252524299.GetTabMoveCount: Integer;
//#UC START# *4D5A4CFB029F_4D5A463C02C1_var*
//#UC END# *4D5A4CFB029F_4D5A463C02C1_var*
begin
//#UC START# *4D5A4CFB029F_4D5A463C02C1_impl*
 Result := 1;
//#UC END# *4D5A4CFB029F_4D5A463C02C1_impl*
end;//TK252524299.GetTabMoveCount

function TK252524299.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D5A463C02C1';
end;//TK252524299.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK252524299.Suite);

end.