unit TextEditorVisitor;
 {* ����, ���������� � ������� ��������� ����� ��������, �� �� ���������� ��� }

// ������: "w:\common\components\gui\Garant\Daily\TextEditorVisitor.pas"
// ���������: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextEditorVisitorPrim
;

type
 TTextEditorVisitor = {abstract} class(TTextEditorVisitorPrim)
  {* ����, ���������� � ������� ��������� ����� ��������, �� �� ���������� ��� }
  protected
   function GetNormalFontSize: Integer; virtual;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   function MaxHeight: Integer; virtual;
    {* ���� ������������ �� 0, �� ����� ����������� ���� ������� ������ �� FormExtent.Y �� MaxHeight }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   procedure DoIt;
    {* ���������� ���� ����� }
 end;//TTextEditorVisitor
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , evStyleInterface
 , TestFrameWork
 , vcmBase
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TTextEditorVisitor.DoIt;
 {* ���������� ���� ����� }
//#UC START# *4BE131BC038E_4BE425C70228_var*
var
 l_SI : TevStyleInterface;
 l_Size : Integer;
 l_NewSize : Integer;
 l_MaxHeight : Integer;
//#UC END# *4BE131BC038E_4BE425C70228_var*
begin
//#UC START# *4BE131BC038E_4BE425C70228_impl*
 l_SI := TevStyleInterface.Make;
 try
  l_NewSize := GetNormalFontSize;
  l_Size := l_SI.Font.Size;
  try
   if (l_NewSize > 0) then
    l_SI.Font.Size := l_NewSize;
   l_MaxHeight := MaxHeight;
   if (l_MaxHeight > 0) then
   begin
    f_FixedHeight := 0;
    f_FixedHeight := FormExtent.Y;
    if (f_FixedHeight < 0) then
     f_FixedHeight := 300;
    while (f_FixedHeight < l_MaxHeight) do
    begin
     try
      VisitText;
     except
      ToLog('Form height = ' + IntToStr(f_FixedHeight));
      raise;
     end;//try..except
     Inc(f_FixedHeight);
    end;//f_FixedHeight < l_MaxHeight
   end//l_MaxHeight > 0
   else
    VisitText;
  finally
   l_SI.Font.Size := l_Size;
  end;//try..finally
 finally
  FreeAndNil(l_SI);
 end;//try..finally
//#UC END# *4BE131BC038E_4BE425C70228_impl*
end;//TTextEditorVisitor.DoIt

function TTextEditorVisitor.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4BE425C70228_var*
//#UC END# *4C07AC6F036D_4BE425C70228_var*
begin
//#UC START# *4C07AC6F036D_4BE425C70228_impl*
 Result := 0;
//#UC END# *4C07AC6F036D_4BE425C70228_impl*
end;//TTextEditorVisitor.GetNormalFontSize

function TTextEditorVisitor.MaxHeight: Integer;
 {* ���� ������������ �� 0, �� ����� ����������� ���� ������� ������ �� FormExtent.Y �� MaxHeight }
//#UC START# *4C0E56F000A4_4BE425C70228_var*
//#UC END# *4C0E56F000A4_4BE425C70228_var*
begin
//#UC START# *4C0E56F000A4_4BE425C70228_impl*
 Result := 0;
//#UC END# *4C0E56F000A4_4BE425C70228_impl*
end;//TTextEditorVisitor.MaxHeight

function TTextEditorVisitor.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TTextEditorVisitor.GetFolder

function TTextEditorVisitor.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BE425C70228';
end;//TTextEditorVisitor.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
