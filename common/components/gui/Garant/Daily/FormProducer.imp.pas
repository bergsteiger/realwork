{$IfNDef FormProducer_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/FormProducer.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Operations For Tests::TestFormsTest::MixIns::FormProducer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define FormProducer_imp}
{$If defined(nsTest) AND not defined(NoVCM)}
 FormClassRef = class of _FormClass_;

 _FormProducer_ = {mixin} class(_FormProducer_Parent_)
 protected
 // protected fields
   f_FixedHeight : Integer;
 protected
 // protected methods
   function MakeForm: _FormClass_;
   function MakeFormClass: FormClassRef; virtual;
   function FormExtent: TPoint; virtual;
     {* Размеры формы }
   procedure FormMade(const aForm: _FormClass_); virtual;
   function UseFormExtentAsClientSize: Boolean; virtual;
     {* Использовать заданные размеры формы как размеры клиентской области - размеры формы пересчитываются относительно этих ограничений. }
 end;//_FormProducer_
{$Else}

 _FormProducer_ = _FormProducer_Parent_;

{$IfEnd} //nsTest AND not NoVCM

{$Else FormProducer_imp}

{$If defined(nsTest) AND not defined(NoVCM)}

// start class _FormProducer_

function _FormProducer_.MakeForm: _FormClass_;
//#UC START# *4BCE9FC203E4_4BCE9EF8033F_var*
var
 l_E : TPoint;
//#UC END# *4BCE9FC203E4_4BCE9EF8033F_var*
begin
//#UC START# *4BCE9FC203E4_4BCE9EF8033F_impl*
 Result := _FormClass_(MakeFormClass.Make(vcmMakeParams).VCLWinControl);
 l_E := FormExtent;
 if (f_FixedHeight > 0) then
  l_E.Y := f_FixedHeight;
 if (l_E.X > 0) OR (l_E.Y > 0) then
 begin
  if (l_E.X <= 0) then
   l_E.X := Result.Width;
  if (l_E.Y <= 0) then
   l_E.Y := Result.Height;
  if UseFormExtentAsClientSize then
  begin
   Result.Width := l_E.X + Result.Width - Result.ClientWidth;
   Result.Height := l_E.Y + Result.Height - Result.ClientHeight;
  end // if UseFormExtentAsClientSize then
  else
  begin
   Result.Width := l_E.X;
   Result.Height := l_E.Y;
  end;
  Result.Top := 0;
  Result.Left := 0;
 end;//l_E.X > 0
 FormMade(Result);
 Result.Caption := ClassName + '.' + FTestName;
//#UC END# *4BCE9FC203E4_4BCE9EF8033F_impl*
end;//_FormProducer_.MakeForm

function _FormProducer_.MakeFormClass: FormClassRef;
//#UC START# *4C9B2B7F0266_4BCE9EF8033F_var*
//#UC END# *4C9B2B7F0266_4BCE9EF8033F_var*
begin
//#UC START# *4C9B2B7F0266_4BCE9EF8033F_impl*
 Result := _FormClass_;
//#UC END# *4C9B2B7F0266_4BCE9EF8033F_impl*
end;//_FormProducer_.MakeFormClass

function _FormProducer_.FormExtent: TPoint;
//#UC START# *4C08CF700318_4BCE9EF8033F_var*
//#UC END# *4C08CF700318_4BCE9EF8033F_var*
begin
//#UC START# *4C08CF700318_4BCE9EF8033F_impl*
 l3FillChar(Result, SizeOf(Result));
//#UC END# *4C08CF700318_4BCE9EF8033F_impl*
end;//_FormProducer_.FormExtent

procedure _FormProducer_.FormMade(const aForm: _FormClass_);
//#UC START# *4C08D61F0231_4BCE9EF8033F_var*
//#UC END# *4C08D61F0231_4BCE9EF8033F_var*
begin
//#UC START# *4C08D61F0231_4BCE9EF8033F_impl*
 // - ничего не делаем
//#UC END# *4C08D61F0231_4BCE9EF8033F_impl*
end;//_FormProducer_.FormMade

function _FormProducer_.UseFormExtentAsClientSize: Boolean;
//#UC START# *4DA2F7900393_4BCE9EF8033F_var*
//#UC END# *4DA2F7900393_4BCE9EF8033F_var*
begin
//#UC START# *4DA2F7900393_4BCE9EF8033F_impl*
 Result := False;
//#UC END# *4DA2F7900393_4BCE9EF8033F_impl*
end;//_FormProducer_.UseFormExtentAsClientSize

{$IfEnd} //nsTest AND not NoVCM

{$EndIf FormProducer_imp}
