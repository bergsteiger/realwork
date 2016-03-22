unit K269064546;
 {* [$269064546] }

// ������: "w:\common\components\rtl\Garant\Daily\K269064546.pas"
// ���������: "TestCase"
// ������� ������: "K269064546" MUID: (4E44C6EA03B0)
// ��� ����: "TK269064546"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollByLineBackAndSelectPt
 , nevTools
 , Types
 , l3Units
;

type
 TK269064546 = class(TScrollByLineBackAndSelectPt)
  {* [$269064546] }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
   function GetScrollCount: Integer; override;
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* ���������� �����, �� ������� ����� ������������������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK269064546
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK269064546.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
//#UC START# *4BF4E6A00093_4E44C6EA03B0_var*
//#UC END# *4BF4E6A00093_4E44C6EA03B0_var*
begin
//#UC START# *4BF4E6A00093_4E44C6EA03B0_impl*
 Result := aDocument.AsList.Para[1].AsList.Para[1].AsList.Para[2];
//#UC END# *4BF4E6A00093_4E44C6EA03B0_impl*
end;//TK269064546.GetInnerPara

function TK269064546.GetScrollCount: Integer;
//#UC START# *4BFE40CD0337_4E44C6EA03B0_var*
//#UC END# *4BFE40CD0337_4E44C6EA03B0_var*
begin
//#UC START# *4BFE40CD0337_4E44C6EA03B0_impl*
 Result := 22;
//#UC END# *4BFE40CD0337_4E44C6EA03B0_impl*
end;//TK269064546.GetScrollCount

{$If NOT Defined(NoVCM)}
function TK269064546.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4E44C6EA03B0_var*
//#UC END# *4C07AC6F036D_4E44C6EA03B0_var*
begin
//#UC START# *4C07AC6F036D_4E44C6EA03B0_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4E44C6EA03B0_impl*
end;//TK269064546.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK269064546.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4E44C6EA03B0_var*
//#UC END# *4C08CF700318_4E44C6EA03B0_var*
begin
//#UC START# *4C08CF700318_4E44C6EA03B0_impl*
 Result.X := 950;
 Result.Y := 650;
//#UC END# *4C08CF700318_4E44C6EA03B0_impl*
end;//TK269064546.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK269064546.GetPoint(const aMap: InevMap): Tl3Point;
 {* ���������� �����, �� ������� ����� ������������������. }
//#UC START# *4C3C927B027E_4E44C6EA03B0_var*
//#UC END# *4C3C927B027E_4E44C6EA03B0_var*
begin
//#UC START# *4C3C927B027E_4E44C6EA03B0_impl*
 Result.X := 4600;
 Result.Y := 10;
//#UC END# *4C3C927B027E_4E44C6EA03B0_impl*
end;//TK269064546.GetPoint

function TK269064546.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK269064546.GetFolder

function TK269064546.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E44C6EA03B0';
end;//TK269064546.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK269064546.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
