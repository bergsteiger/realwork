unit K269066487;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K269066487.pas"
// Начат: 14.06.2011 19:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7 Lulin::K269066487
//
// {RequestLink:269066487}
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
  DeleteCharTest,
  evCustomEditorWindow,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK269066487 = class(TDeleteCharTest)
  {* [RequestLink:269066487] }
 protected
 // overridden protected methods
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
     {* Устанавливает курсор или выделение }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function CharCount: Integer; override;
 end;//TK269066487
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
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

// start class TK269066487

procedure TK269066487.Navigate(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C4FE56300FB_4DF781FF03B3_var*
//#UC END# *4C4FE56300FB_4DF781FF03B3_var*
begin
//#UC START# *4C4FE56300FB_4DF781FF03B3_impl*
 // - ничего не делаем 
//#UC END# *4C4FE56300FB_4DF781FF03B3_impl*
end;//TK269066487.Navigate

function TK269066487.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7 Lulin';
end;//TK269066487.GetFolder

function TK269066487.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DF781FF03B3';
end;//TK269066487.GetModelElementGUID

function TK269066487.CharCount: Integer;
//#UC START# *4DF781CB0217_4DF781FF03B3_var*
//#UC END# *4DF781CB0217_4DF781FF03B3_var*
begin
//#UC START# *4DF781CB0217_4DF781FF03B3_impl*
 Result := 17; 
//#UC END# *4DF781CB0217_4DF781FF03B3_impl*
end;//TK269066487.CharCount

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK269066487.Suite);

end.