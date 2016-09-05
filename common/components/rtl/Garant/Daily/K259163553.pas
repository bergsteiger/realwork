unit K259163553;
 {* [$259163553] }

// ������: "w:\common\components\rtl\Garant\Daily\K259163553.pas"
// ���������: "TestCase"
// ������� ������: "K259163553" MUID: (4D9D5CB00255)
// ��� ����: "TK259163553"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollUpAndDownAndCheckShapes
 , Types
;

type
 TK259163553 = class(TScrollUpAndDownAndCheckShapes)
  {* [$259163553] }
  protected
   function GetScrollCount(aUp: Boolean): Integer; override;
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK259163553
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3InternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
 //#UC START# *4D9D5CB00255impl_uses*
 //#UC END# *4D9D5CB00255impl_uses*
;

function TK259163553.GetScrollCount(aUp: Boolean): Integer;
//#UC START# *4D9AE1F40181_4D9D5CB00255_var*
//#UC END# *4D9AE1F40181_4D9D5CB00255_var*
begin
//#UC START# *4D9AE1F40181_4D9D5CB00255_impl*
 if aUp then
  Result := 3
 else
  Result := 16;
//#UC END# *4D9AE1F40181_4D9D5CB00255_impl*
end;//TK259163553.GetScrollCount

{$If NOT Defined(NoVCM)}
function TK259163553.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4D9D5CB00255_var*
//#UC END# *4C07AC6F036D_4D9D5CB00255_var*
begin
//#UC START# *4C07AC6F036D_4D9D5CB00255_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D9D5CB00255_impl*
end;//TK259163553.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK259163553.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4D9D5CB00255_var*
//#UC END# *4C08CF4300BE_4D9D5CB00255_var*
begin
//#UC START# *4C08CF4300BE_4D9D5CB00255_impl*
 Result := True;
//#UC END# *4C08CF4300BE_4D9D5CB00255_impl*
end;//TK259163553.WebStyle
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK259163553.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4D9D5CB00255_var*
//#UC END# *4C08CF700318_4D9D5CB00255_var*
begin
//#UC START# *4C08CF700318_4D9D5CB00255_impl*
 Result.X := 970;
 Result.Y := 670; 
//#UC END# *4C08CF700318_4D9D5CB00255_impl*
end;//TK259163553.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK259163553.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4D9D5CB00255_var*
//#UC END# *51AF49E5001B_4D9D5CB00255_var*
begin
//#UC START# *51AF49E5001B_4D9D5CB00255_impl*
 Result := True;
//#UC END# *51AF49E5001B_4D9D5CB00255_impl*
end;//TK259163553.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK259163553.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK259163553.GetFolder

function TK259163553.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D9D5CB00255';
end;//TK259163553.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK259163553.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
