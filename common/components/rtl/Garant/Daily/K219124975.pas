unit K219124975;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K219124975.pas"
// Начат: 23.06.2010 16:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K219124975
//
// {RequestLink:219124975}
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
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PreviewTestBefore235875079
  {$IfEnd} //nsTest AND not NoVCM
  ,
  evHAFPainterEx
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK219124975 = class(TPreviewTestBefore235875079)
  {* [RequestLink:219124975] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function TreatExceptionAsSuccess: Boolean; override;
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure ReadColontituls(var theColontituls: TevColontituls); override;
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetHAFFontSize: Integer; override;
     {* Размер колонтитулов. 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK219124975
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evTypes,
  l3Base,
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK219124975

{$If defined(nsTest) AND not defined(NoVCM)}
function TK219124975.TreatExceptionAsSuccess: Boolean;
//#UC START# *4BFD1B5A0200_4C21F7540004_var*
//#UC END# *4BFD1B5A0200_4C21F7540004_var*
begin
//#UC START# *4BFD1B5A0200_4C21F7540004_impl*
 Result := true;
//#UC END# *4BFD1B5A0200_4C21F7540004_impl*
end;//TK219124975.TreatExceptionAsSuccess
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK219124975.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C21F7540004_var*
//#UC END# *4C07AC6F036D_4C21F7540004_var*
begin
//#UC START# *4C07AC6F036D_4C21F7540004_impl*
 Result := 39;
//#UC END# *4C07AC6F036D_4C21F7540004_impl*
end;//TK219124975.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TK219124975.ReadColontituls(var theColontituls: TevColontituls);
//#UC START# *4C221AE002A2_4C21F7540004_var*
//#UC END# *4C221AE002A2_4C21F7540004_var*
begin
//#UC START# *4C221AE002A2_4C21F7540004_impl*
 inherited;
 theColontituls[pcUpRightFirst] := l3CStr('%DocFullName%'#10'%DocRedactionDate%');
 theColontituls[pcUpRight] := theColontituls[pcUpRightFirst];
 theColontituls[pcDownRightFirst] := l3CStr(''{'%DocCurrentPage% / %DocPagesCount%'});
 theColontituls[pcDownRight] := theColontituls[pcDownRightFirst];
//#UC END# *4C221AE002A2_4C21F7540004_impl*
end;//TK219124975.ReadColontituls
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK219124975.GetHAFFontSize: Integer;
//#UC START# *4C2224D00159_4C21F7540004_var*
//#UC END# *4C2224D00159_4C21F7540004_var*
begin
//#UC START# *4C2224D00159_4C21F7540004_impl*
 Result := 28;
//#UC END# *4C2224D00159_4C21F7540004_impl*
end;//TK219124975.GetHAFFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK219124975.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK219124975.GetFolder

function TK219124975.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C21F7540004';
end;//TK219124975.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK219124975.Suite);

end.