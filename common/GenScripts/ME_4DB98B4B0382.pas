unit kwControlWord;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwControlWord.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , Controls
 , tfwScriptingInterfaces
 , Classes
;

type
 _SystemWord_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SystemWord.imp.pas}
 TkwControlWord = {abstract} class(_SystemWord_)
  protected
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoComponent(aControl: TComponent;
    const aCtx: TtfwContext); virtual;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwControlWord
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , SysUtils
 , l3CloseFormHelper
 , l3MessagesService
 , l3FormsService
 , Windows
 , Forms
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\SystemWord.imp.pas}

procedure TkwControlWord.DoComponent(aControl: TComponent;
 const aCtx: TtfwContext);
//#UC START# *5357B6FB0024_4DB98B4B0382_var*
//#UC END# *5357B6FB0024_4DB98B4B0382_var*
begin
//#UC START# *5357B6FB0024_4DB98B4B0382_impl*
 RunnerError(aControl.Name + ' �� �������� ���������, � �������� ����������� ������ ' + aControl.ClassName, aCtx);
//#UC END# *5357B6FB0024_4DB98B4B0382_impl*
end;//TkwControlWord.DoComponent

procedure TkwControlWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB98B4B0382_var*

var
 l_C : TControl;
 
 procedure GetControl;
 begin//GetControl
  l_C := FindControl(GetFocus);
  if (l_C = nil) then
  // - �������� �� ��� ���������� ��� �� ��� ��� ��������� �����
  begin
   if (Screen.ActiveForm <> nil) then
    l_C := Screen.ActiveForm.ActiveControl
   else 
   if (Screen.ActiveCustomForm <> nil) then
    l_C := TForm(Screen.ActiveCustomForm).ActiveControl;
  end;//l_C = nil
  RunnerAssert(l_C <> nil, '�� ������ �������� �������� �������', aCtx);
 end;//GetControl

var
{.$IFDEF Archi}
 i      : Integer;
 l_Comp : TComponent;
{.$ENDIF Archi}
 l_F    : TCustomForm;
 l_CP   : TComponent;
 l_N    : AnsiString;
 l_PrevClosedForm : TCustomForm;
 l_OriginalFormName : AnsiString;
//#UC END# *4DAEEDE10285_4DB98B4B0382_var*
begin
//#UC START# *4DAEEDE10285_4DB98B4B0382_impl*
 l_N := aCtx.rEngine.PopDelphiString;
 l_PrevClosedForm := nil;
 l_CP := nil;
 GetControl;
 if (l_C.Name <> l_N) then
 begin
  l_F := Tl3FormsService.Instance.GetParentForm(l_C);
  RunnerAssert(l_F <> nil, '�� ����� ������������ ����� ��� ' + l_C.Name, aCtx);
  l_OriginalFormName := l_F.Name;
  while (l_F <> nil) do
  begin
   if l_F.Name = l_N then
   begin
    l_CP := l_F;
    Break;
   end; // if l_F.Name = l_N then
   l_CP := l_F.FindComponent(l_N);
   {.$IFDEF Archi}
   for i := 0 to l_F.ComponentCount - 1 do
   begin
    l_Comp := l_F.Components[i];
    if (l_Comp.Name = l_N) then
    begin
     l_CP := l_Comp;
     break;
    end;//l_Comp.Name = l_N
    if l_Comp.ComponentCount > 0 then
     l_CP := l_Comp.FindComponent(l_N);
    if (l_CP <> nil) then
     Break;
   end;//for i
   {.$ENDIF Archi}
   if (l_CP <> nil) then
    Break;
   if (TForm(l_F).FormStyle = fsStayOnTop) then
   begin
    RunnerAssert(l_F <> l_PrevClosedForm, '�����: ' + l_F.Name + ' ��� �������� ���������', aCtx);
    l_PrevClosedForm := l_F;
    if Tl3CloseFormHelper.Instance.Close(l_F) then
     Tl3MessagesService.Instance.ProcessMessages
     // - ����� ����� "������" ���������
    else
     RunnerError('�� ������� ������� �����: ' + l_F.Name, aCtx);
    GetControl;
    if (l_C.Name = l_N) then
    begin
     l_CP := l_C;
     break;
    end;//l_C.Name = l_N
    l_F := Tl3FormsService.Instance.GetParentForm(l_C);
    RunnerAssert(l_F <> nil, '', aCtx);
    continue;
   end;//TForm(l_F).FormStyle = fsStayOnTop
   RunnerAssert(TForm(l_F).FormStyle <> fsStayOnTop, '', aCtx);
   l_F := Tl3FormsService.Instance.GetAnotherParentForm(l_F);
  end;//while (l_F <> nil)
  RunnerAssert(l_CP <> nil, Format('�� ������ ������� %s �� ����� %s', [l_N, l_OriginalFormName]), aCtx);
  if (l_CP Is TControl) then
  begin
   l_C := l_CP As TControl;
   RunnerAssert(l_C.Name = l_N, '��� ��������: ' + l_C.Name + ', � ������: ' + l_N, aCtx);
  end//l_CP Is TControl
  else
  begin
   RunnerAssert(l_CP.Name = l_N, '��� ��������: ' + l_CP.Name + ', � ������: ' + l_N, aCtx);
   DoComponent(l_CP, aCtx);
   Exit;
  end;//l_CP Is TControl
 end;//l_C.Name <> l_N
 DoControl(l_C, aCtx);
//#UC END# *4DAEEDE10285_4DB98B4B0382_impl*
end;//TkwControlWord.DoDoIt

initialization
 TkwControlWord.RegisterClass;
 {* ����������� TkwControlWord }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
