unit nsWindowNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "UserInteraction"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/UserInteraction/nsWindowNode.pas"
// Начат: 20.10.2009 21:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Operations::OfficeLike::UserInteraction::WindowsListSupport::TnsWindowNode
//
// Нода используемая для построения дерева окон системы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  vcmInterfaces,
  l3Tree_TLB,
  OfficeLikeAppInterfaces,
  l3NodesModelPart
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TnsWindowNode = class(Tl3UsualNode, InsWindow)
  {* Нода используемая для построения дерева окон системы }
 private
 // private fields
   fForm : IvcmEntityForm;
 protected
 // realized methods
   function Get_Form: IvcmEntityForm;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aForm: IvcmEntityForm;
    const aText: Tl3WString); reintroduce;
   class function Make(const aForm: IvcmEntityForm;
    const aText: Tl3WString): Il3Node; reintroduce;
 end;//TnsWindowNode
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3String
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TnsWindowNode

constructor TnsWindowNode.Create(const aForm: IvcmEntityForm;
  const aText: Tl3WString);
//#UC START# *4ADDE38A00B3_4ADC5E7C0264_var*
//#UC END# *4ADDE38A00B3_4ADC5E7C0264_var*
begin
//#UC START# *4ADDE38A00B3_4ADC5E7C0264_impl*
 inherited Create{(nil, -1, -1)};
 fForm := aForm;
 if l3IsNil(aText) and Assigned(aForm) then
  Text := l3PCharLen(aForm.Caption)
 else
  Text := aText;
//#UC END# *4ADDE38A00B3_4ADC5E7C0264_impl*
end;//TnsWindowNode.Create

class function TnsWindowNode.Make(const aForm: IvcmEntityForm;
  const aText: Tl3WString): Il3Node;
var
 l_Inst : TnsWindowNode;
begin
 l_Inst := Create(aForm, aText);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsWindowNode.Get_Form: IvcmEntityForm;
//#UC START# *4991A633007F_4ADC5E7C0264get_var*
//#UC END# *4991A633007F_4ADC5E7C0264get_var*
begin
//#UC START# *4991A633007F_4ADC5E7C0264get_impl*
 Result := fForm;
//#UC END# *4991A633007F_4ADC5E7C0264get_impl*
end;//TnsWindowNode.Get_Form

procedure TnsWindowNode.Cleanup;
//#UC START# *479731C50290_4ADC5E7C0264_var*
//#UC END# *479731C50290_4ADC5E7C0264_var*
begin
//#UC START# *479731C50290_4ADC5E7C0264_impl*
 fForm := nil;
 inherited;
//#UC END# *479731C50290_4ADC5E7C0264_impl*
end;//TnsWindowNode.Cleanup

{$IfEnd} //not NoVCM

end.