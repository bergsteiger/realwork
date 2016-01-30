{$IfNDef FormProducer_imp}

// Модуль: "w:\common\components\gui\Garant\Daily\FormProducer.imp.pas"
// Стереотип: "Impurity"

{$Define FormProducer_imp}

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
type
 // _FormClass_

 FormClassRef = class of _FormClass_;

 _FormProducer_ = class(_FormProducer_Parent_)
  protected
   f_FixedHeight: Integer;
  protected
   function MakeForm: _FormClass_;
   function MakeFormClass: FormClassRef; virtual;
   function FormExtent: TPoint; virtual;
    {* Размеры формы }
   procedure FormMade(const aForm: _FormClass_); virtual;
   function UseFormExtentAsClientSize: Boolean; virtual;
    {* Использовать заданные размеры формы как размеры клиентской области - размеры формы пересчитываются относительно этих ограничений. }
 end;//_FormProducer_

{$Else Defined(nsTest) AND NOT Defined(NoVCM)}

_FormProducer_ = _FormProducer_Parent_;

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)
{$Else FormProducer_imp}

{$IfNDef FormProducer_imp_impl}

{$Define FormProducer_imp_impl}

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
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
 {* Размеры формы }
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
 {* Использовать заданные размеры формы как размеры клиентской области - размеры формы пересчитываются относительно этих ограничений. }
//#UC START# *4DA2F7900393_4BCE9EF8033F_var*
//#UC END# *4DA2F7900393_4BCE9EF8033F_var*
begin
//#UC START# *4DA2F7900393_4BCE9EF8033F_impl*
 Result := False;
//#UC END# *4DA2F7900393_4BCE9EF8033F_impl*
end;//_FormProducer_.UseFormExtentAsClientSize
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

{$EndIf FormProducer_imp_impl}

{$EndIf FormProducer_imp}

