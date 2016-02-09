unit TextEditorVisitorPrim;
 {* ����, ���������� � ������� ��������� ����� ��������, �� �� ���������� ��� }

// ������: "w:\common\components\gui\Garant\Daily\TextEditorVisitorPrim.pas"
// ���������: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessorPrim
 , PrimTextLoad_Form
;

type
 TTextEditorVisitorPrim = {abstract} class(TTextViaEditorProcessorPrim)
  {* ����, ���������� � ������� ��������� ����� ��������, �� �� ���������� ��� }
  protected
   procedure VisitText(const aStr: AnsiString = 'Load');
    {* ���������� ��������� ��������� ������ }
   procedure DoVisit(aForm: TPrimTextLoadForm); virtual; abstract;
    {* ���������� ����� }
   function TreatExceptionAsSuccess: Boolean; virtual;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TTextEditorVisitorPrim
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , k2OperationContainer
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TTextEditorVisitorPrim.VisitText(const aStr: AnsiString = 'Load');
 {* ���������� ��������� ��������� ������ }
//#UC START# *4BE4196E0367_4BE418BB001F_var*
var
 l_F : _FormClass_;
 l_Raise : Boolean;
 l_DisableLog : Boolean; 
//#UC END# *4BE4196E0367_4BE418BB001F_var*
begin
//#UC START# *4BE4196E0367_4BE418BB001F_impl*
 l_F := MakeForm;
 try
  l_F.Show;
  l_Raise := TreatExceptionAsSuccess;
  l_DisableLog := l_Raise;
  if l_DisableLog then
   l3System.DisableExceptionToLog;
  try
   Load(l_F, KPage + '.evd', aStr);
   try
    try
     DoVisit(l_F);
    finally
     Check(not Tk2OperationContainer.CheckWasExceptionInFreeInOwner);
    end;//try..finally
   except
    if l_Raise then
     {l_Raise := false}
     Exit
     // - ����� �� ���������� ��������, ����� ���� ����� ���� ���������
    else
     raise;
   end;//try..except
  finally
   if l_DisableLog then
    l3System.EnableExceptionToLog;
  end;//try..finally
  Check(not l_Raise, '���� ��������� �� ������, �.�. ����� �� ������� � ������');
 finally
  l_F.Free;
 end;//try..finally
//#UC END# *4BE4196E0367_4BE418BB001F_impl*
end;//TTextEditorVisitorPrim.VisitText

function TTextEditorVisitorPrim.TreatExceptionAsSuccess: Boolean;
//#UC START# *4BFD1B5A0200_4BE418BB001F_var*
//#UC END# *4BFD1B5A0200_4BE418BB001F_var*
begin
//#UC START# *4BFD1B5A0200_4BE418BB001F_impl*
 Result := false;
//#UC END# *4BFD1B5A0200_4BE418BB001F_impl*
end;//TTextEditorVisitorPrim.TreatExceptionAsSuccess

function TTextEditorVisitorPrim.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TTextEditorVisitorPrim.GetFolder

function TTextEditorVisitorPrim.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BE418BB001F';
end;//TTextEditorVisitorPrim.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
