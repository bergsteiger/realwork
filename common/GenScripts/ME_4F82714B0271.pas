unit vcmLayoutImplementation;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmLayoutImplementation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmLayoutImplementation" MUID: (4F82714B0271)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObjectWithCOMQI
 , vcmInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvcmLayoutImplementation = class;

 IvcmLayoutInternal = interface
  ['{3C78DB5C-C875-4768-AC34-75F697D2514D}']
  procedure ClearLinkToControl;
 end;//IvcmLayoutInternal

 TvcmLayoutImplementation = class(Tl3ProtoObjectWithCOMQI, IvcmLayout, IvcmLayoutInternal)
  private
   f_Control: TWinControl;
  protected
   function GetIsAcceptable(aDataUpdate: Boolean): Boolean; virtual;
    {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
   procedure ClearLinkToControl;
   function Get_VCLWinControl: TWinControl;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(aControl: TWinControl); reintroduce;
   class function Make(aControl: TWinControl): IvcmLayout; reintroduce;
   function IsAcceptable(aDataUpdate: Boolean): Boolean;
    {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
  protected
   property Control: TWinControl
    read f_Control;
 end;//TvcmLayoutImplementation
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

constructor TvcmLayoutImplementation.Create(aControl: TWinControl);
//#UC START# *4F827263026A_4F82714B0271_var*
//#UC END# *4F827263026A_4F82714B0271_var*
begin
//#UC START# *4F827263026A_4F82714B0271_impl*
 inherited Create;
 f_Control := aControl; 
//#UC END# *4F827263026A_4F82714B0271_impl*
end;//TvcmLayoutImplementation.Create

class function TvcmLayoutImplementation.Make(aControl: TWinControl): IvcmLayout;
var
 l_Inst : TvcmLayoutImplementation;
begin
 l_Inst := Create(aControl);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmLayoutImplementation.Make

function TvcmLayoutImplementation.GetIsAcceptable(aDataUpdate: Boolean): Boolean;
 {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
//#UC START# *55127C030325_4F82714B0271_var*
//#UC END# *55127C030325_4F82714B0271_var*
begin
//#UC START# *55127C030325_4F82714B0271_impl*
 Result := True;
//#UC END# *55127C030325_4F82714B0271_impl*
end;//TvcmLayoutImplementation.GetIsAcceptable

procedure TvcmLayoutImplementation.ClearLinkToControl;
//#UC START# *4F82737803BE_4F82714B0271_var*
//#UC END# *4F82737803BE_4F82714B0271_var*
begin
//#UC START# *4F82737803BE_4F82714B0271_impl*
 f_Control := nil;
//#UC END# *4F82737803BE_4F82714B0271_impl*
end;//TvcmLayoutImplementation.ClearLinkToControl

function TvcmLayoutImplementation.Get_VCLWinControl: TWinControl;
//#UC START# *5511678C0335_4F82714B0271get_var*
//#UC END# *5511678C0335_4F82714B0271get_var*
begin
//#UC START# *5511678C0335_4F82714B0271get_impl*
 Result := f_Control;
//#UC END# *5511678C0335_4F82714B0271get_impl*
end;//TvcmLayoutImplementation.Get_VCLWinControl

function TvcmLayoutImplementation.IsAcceptable(aDataUpdate: Boolean): Boolean;
 {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
//#UC START# *5511680A003B_4F82714B0271_var*
//#UC END# *5511680A003B_4F82714B0271_var*
begin
//#UC START# *5511680A003B_4F82714B0271_impl*
 Result := GetIsAcceptable(aDataUpdate);
//#UC END# *5511680A003B_4F82714B0271_impl*
end;//TvcmLayoutImplementation.IsAcceptable

procedure TvcmLayoutImplementation.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F82714B0271_var*
//#UC END# *479731C50290_4F82714B0271_var*
begin
//#UC START# *479731C50290_4F82714B0271_impl*
 f_Control := nil;
 inherited;
//#UC END# *479731C50290_4F82714B0271_impl*
end;//TvcmLayoutImplementation.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TvcmLayoutImplementation.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4F82714B0271_var*
//#UC END# *47A6FEE600FC_4F82714B0271_var*
begin
//#UC START# *47A6FEE600FC_4F82714B0271_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4F82714B0271_impl*
end;//TvcmLayoutImplementation.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$IfEnd} // NOT Defined(NoVCM)
end.
