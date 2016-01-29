unit K605362960;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K605362960.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::Unicode::K605362960
//
// {RequestLink:605362960}
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
 TK605362960 = class(TDeleteCharTest)
  {* [RequestLink:605362960] }
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
 end;//TK605362960
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evOp,
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

// start class TK605362960

procedure TK605362960.Navigate(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C4FE56300FB_55E43F0500A2_var*
//#UC END# *4C4FE56300FB_55E43F0500A2_var*
begin
//#UC START# *4C4FE56300FB_55E43F0500A2_impl*
 inherited;
 with aText do
 begin
  Check(MoveLeafCursor(ev_ocTopLeft, false));
 end;//with aText
//#UC END# *4C4FE56300FB_55E43F0500A2_impl*
end;//TK605362960.Navigate

function TK605362960.GetFolder: AnsiString;
 {-}
begin
 Result := 'Unicode';
end;//TK605362960.GetFolder

function TK605362960.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55E43F0500A2';
end;//TK605362960.GetModelElementGUID

function TK605362960.CharCount: Integer;
//#UC START# *4DF781CB0217_55E43F0500A2_var*
//#UC END# *4DF781CB0217_55E43F0500A2_var*
begin
//#UC START# *4DF781CB0217_55E43F0500A2_impl*
 Result := 81;
//#UC END# *4DF781CB0217_55E43F0500A2_impl*
end;//TK605362960.CharCount

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK605362960.Suite);

end.