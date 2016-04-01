unit NOT_COMPLETED_nsWindowNode;
 {* Нода используемая для построения дерева окон системы }

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\NOT_COMPLETED_nsWindowNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsWindowNode" MUID: (4ADC5E7C0264)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3NodesModelPart
 , OfficeLikeAppInterfaces
 , vcmInterfaces
 , l3Tree_TLB
 , l3Interfaces
;

type
 TnsWindowNode = class(Tl3UsualNode, InsWindow)
  {* Нода используемая для построения дерева окон системы }
  private
   fForm: IvcmEntityForm;
  protected
   function Get_Form: IvcmEntityForm;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aForm: IvcmEntityForm;
    const aText: Tl3WString); reintroduce;
   class function Make(const aForm: IvcmEntityForm;
    const aText: Tl3WString): Il3Node; reintroduce;
 end;//TnsWindowNode
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3String
;

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
end;//TnsWindowNode.Make

function TnsWindowNode.Get_Form: IvcmEntityForm;
//#UC START# *4991A633007F_4ADC5E7C0264get_var*
//#UC END# *4991A633007F_4ADC5E7C0264get_var*
begin
//#UC START# *4991A633007F_4ADC5E7C0264get_impl*
 Result := fForm;
//#UC END# *4991A633007F_4ADC5E7C0264get_impl*
end;//TnsWindowNode.Get_Form

procedure TnsWindowNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4ADC5E7C0264_var*
//#UC END# *479731C50290_4ADC5E7C0264_var*
begin
//#UC START# *479731C50290_4ADC5E7C0264_impl*
 fForm := nil;
 inherited;
//#UC END# *479731C50290_4ADC5E7C0264_impl*
end;//TnsWindowNode.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

end.
