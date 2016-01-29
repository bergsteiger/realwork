unit OutlinerWithEVDStyleNodes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/OutlinerWithEVDStyleNodes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::OutlinerTests::OutlinerWithEVDStyleNodes
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
  OutlinerTest
  {$IfEnd} //nsTest AND not NoVCM
  ,
  Types
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  Outliner_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TOutlinerWithEVDStyleNodes = {abstract} class(TOutlinerTest)
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure FormMade(const aForm: _FormClass_); override;
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Load(aForm: TOutlinerFormForm;
    const aFileName: AnsiString); override;
     {* Загрузить данные в дерево. }
   {$IfEnd} //nsTest AND not NoVCM
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TOutlinerWithEVDStyleNodes
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevInternalInterfaces,
  evTreeGenerator,
  evEvdRd,
  l3Base,
  l3String,
  l3ControlsTypes,
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TOutlinerWithEVDStyleNodes

{$If defined(nsTest) AND not defined(NoVCM)}
function TOutlinerWithEVDStyleNodes.FormExtent: TPoint;
//#UC START# *4C08CF700318_4D46BBB60035_var*
//#UC END# *4C08CF700318_4D46BBB60035_var*
begin
//#UC START# *4C08CF700318_4D46BBB60035_impl*
 Result.X := 400;
 Result.Y := 600;
//#UC END# *4C08CF700318_4D46BBB60035_impl*
end;//TOutlinerWithEVDStyleNodes.FormExtent
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TOutlinerWithEVDStyleNodes.FormMade(const aForm: _FormClass_);
//#UC START# *4C08D61F0231_4D46BBB60035_var*
//#UC END# *4C08D61F0231_4D46BBB60035_var*
begin
//#UC START# *4C08D61F0231_4D46BBB60035_impl*
 inherited;
 aForm.TreeControl.SelfDrawNodes := True;
//#UC END# *4C08D61F0231_4D46BBB60035_impl*
end;//TOutlinerWithEVDStyleNodes.FormMade
{$IfEnd} //nsTest AND not NoVCM

function TOutlinerWithEVDStyleNodes.GetFolder: AnsiString;
 {-}
begin
 Result := 'OutlinerTests';
end;//TOutlinerWithEVDStyleNodes.GetFolder

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TOutlinerWithEVDStyleNodes.Load(aForm: TOutlinerFormForm;
  const aFileName: AnsiString);
//#UC START# *4D46E22801EB_4D46BBB60035_var*
var
 l_Gen : Tk2TagGenerator;
//#UC END# *4D46E22801EB_4D46BBB60035_var*
begin
//#UC START# *4D46E22801EB_4D46BBB60035_impl*
 aForm.TreeControl.CTree.CRootNode.Text := l3PCharLen('КОММЕНТАРИИ');
 l_Gen := TevTreeGenerator.Create(aForm.TreeControl.CTree.CRootNode, k2_tiContentsLevel);
 try
  TevEvdReader.SetTo(l_Gen, FileFromCurrent(aFileName));
  (l_Gen as TevCustomEvdReader).Execute;
 finally
  l3Free(l_Gen);
 end; {try..finally}
//#UC END# *4D46E22801EB_4D46BBB60035_impl*
end;//TOutlinerWithEVDStyleNodes.Load
{$IfEnd} //nsTest AND not NoVCM

function TOutlinerWithEVDStyleNodes.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D46BBB60035';
end;//TOutlinerWithEVDStyleNodes.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.