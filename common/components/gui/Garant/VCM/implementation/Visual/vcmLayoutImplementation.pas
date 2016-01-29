unit vcmLayoutImplementation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmLayoutImplementation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmLayoutImplementation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3ProtoObjectWithCOMQI
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 IvcmLayoutInternal = interface(IUnknown)
   ['{3C78DB5C-C875-4768-AC34-75F697D2514D}']
   procedure ClearLinkToControl;
 end;//IvcmLayoutInternal

 TvcmLayoutImplementation = class(Tl3ProtoObjectWithCOMQI, IvcmLayout, IvcmLayoutInternal)
 private
 // private fields
   f_Control : TWinControl;
    {* Поле для свойства Control}
 protected
 // realized methods
   procedure ClearLinkToControl;
   function Get_VCLWinControl: TWinControl;
 public
 // realized methods
   function IsAcceptable(aDataUpdate: Boolean): Boolean;
     {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 protected
 // protected methods
   function GetIsAcceptable(aDataUpdate: Boolean): Boolean; virtual;
     {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
 public
 // public methods
   constructor Create(aControl: TWinControl); reintroduce;
   class function Make(aControl: TWinControl): IvcmLayout; reintroduce;
     {* Сигнатура фабрики TvcmLayoutImplementation.Make }
 protected
 // protected properties
   property Control: TWinControl
     read f_Control;
 end;//TvcmLayoutImplementation
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}

// start class TvcmLayoutImplementation

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
end;

function TvcmLayoutImplementation.GetIsAcceptable(aDataUpdate: Boolean): Boolean;
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
//#UC START# *5511680A003B_4F82714B0271_var*
//#UC END# *5511680A003B_4F82714B0271_var*
begin
//#UC START# *5511680A003B_4F82714B0271_impl*
 Result := GetIsAcceptable(aDataUpdate);
//#UC END# *5511680A003B_4F82714B0271_impl*
end;//TvcmLayoutImplementation.IsAcceptable

procedure TvcmLayoutImplementation.Cleanup;
//#UC START# *479731C50290_4F82714B0271_var*
//#UC END# *479731C50290_4F82714B0271_var*
begin
//#UC START# *479731C50290_4F82714B0271_impl*
 f_Control := nil;
 inherited;
//#UC END# *479731C50290_4F82714B0271_impl*
end;//TvcmLayoutImplementation.Cleanup

{$If not defined(DesignTimeLibrary)}
class function TvcmLayoutImplementation.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4F82714B0271_var*
//#UC END# *47A6FEE600FC_4F82714B0271_var*
begin
//#UC START# *47A6FEE600FC_4F82714B0271_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4F82714B0271_impl*
end;//TvcmLayoutImplementation.IsCacheable
{$IfEnd} //not DesignTimeLibrary

{$IfEnd} //not NoVCM

end.