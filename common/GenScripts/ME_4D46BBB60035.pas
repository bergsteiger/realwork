unit OutlinerWithEVDStyleNodes;

// ������: "w:\common\components\rtl\Garant\Daily\OutlinerWithEVDStyleNodes.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OutlinerTest
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
 {$If NOT Defined(NoVCM)}
 , Outliner_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TOutlinerWithEVDStyleNodes = {abstract} class(TOutlinerTest)
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormMade(const aForm: _FormClass_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If NOT Defined(NoVCM)}
   procedure Load(aForm: TOutlinerFormForm;
    const aFileName: AnsiString); override;
    {* ��������� ������ � ������. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TOutlinerWithEVDStyleNodes
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevInternalInterfaces
 , evTreeGenerator
 , evEvdRd
 , l3Base
 , l3String
 , l3ControlsTypes
 , k2Tags
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$If NOT Defined(NoVCM)}
function TOutlinerWithEVDStyleNodes.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4D46BBB60035_var*
//#UC END# *4C08CF700318_4D46BBB60035_var*
begin
//#UC START# *4C08CF700318_4D46BBB60035_impl*
 Result.X := 400;
 Result.Y := 600;
//#UC END# *4C08CF700318_4D46BBB60035_impl*
end;//TOutlinerWithEVDStyleNodes.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TOutlinerWithEVDStyleNodes.FormMade(const aForm: _FormClass_);
//#UC START# *4C08D61F0231_4D46BBB60035_var*
//#UC END# *4C08D61F0231_4D46BBB60035_var*
begin
//#UC START# *4C08D61F0231_4D46BBB60035_impl*
 inherited;
 aForm.TreeControl.SelfDrawNodes := True;
//#UC END# *4C08D61F0231_4D46BBB60035_impl*
end;//TOutlinerWithEVDStyleNodes.FormMade
{$IfEnd} // NOT Defined(NoVCM)

function TOutlinerWithEVDStyleNodes.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'OutlinerTests';
end;//TOutlinerWithEVDStyleNodes.GetFolder

{$If NOT Defined(NoVCM)}
procedure TOutlinerWithEVDStyleNodes.Load(aForm: TOutlinerFormForm;
 const aFileName: AnsiString);
 {* ��������� ������ � ������. }
//#UC START# *4D46E22801EB_4D46BBB60035_var*
var
 l_Gen : Tk2TagGenerator;
//#UC END# *4D46E22801EB_4D46BBB60035_var*
begin
//#UC START# *4D46E22801EB_4D46BBB60035_impl*
 aForm.TreeControl.CTree.CRootNode.Text := l3PCharLen('�����������');
 l_Gen := TevTreeGenerator.Create(aForm.TreeControl.CTree.CRootNode, k2_tiContentsLevel);
 try
  TevEvdReader.SetTo(l_Gen, FileFromCurrent(aFileName));
  (l_Gen as TevCustomEvdReader).Execute;
 finally
  l3Free(l_Gen);
 end; {try..finally}
//#UC END# *4D46E22801EB_4D46BBB60035_impl*
end;//TOutlinerWithEVDStyleNodes.Load
{$IfEnd} // NOT Defined(NoVCM)

function TOutlinerWithEVDStyleNodes.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D46BBB60035';
end;//TOutlinerWithEVDStyleNodes.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
