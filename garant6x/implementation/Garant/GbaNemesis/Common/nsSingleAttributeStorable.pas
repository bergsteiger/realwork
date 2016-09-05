unit nsSingleAttributeStorable;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSingleAttributeStorable.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsSingleAttributeStorable" MUID: (4682704E0347)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , evNodeStorable
 , l3_String
 , l3Interfaces
;

type
 TnsSingleAttributeStorable = class(TevNodeStorable)
  private
   f_Text: Tl3_String;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function Text: Tl3WString; override;
 end;//TnsSingleAttributeStorable
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , l3TreeInterfaces
 //#UC START# *4682704E0347impl_uses*
 //#UC END# *4682704E0347impl_uses*
;

procedure TnsSingleAttributeStorable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4682704E0347_var*
//#UC END# *479731C50290_4682704E0347_var*
begin
//#UC START# *479731C50290_4682704E0347_impl*
 l3Free(f_Text);
 inherited;
//#UC END# *479731C50290_4682704E0347_impl*
end;//TnsSingleAttributeStorable.Cleanup

function TnsSingleAttributeStorable.Text: Tl3WString;
//#UC START# *48F494FD001D_4682704E0347_var*
var
 l_Node : Il3SimpleNode;
//#UC END# *48F494FD001D_4682704E0347_var*
begin
//#UC START# *48F494FD001D_4682704E0347_impl*
 if (f_Text = nil) then
 begin
  l_Node := Node;
  l3Set(f_Text, l_Node.Text);
  if (l_Node.GetLevel > 1) then
   repeat
    l_Node := l_Node.Parent;
    if (l_Node.GetLevel > 1) then
    begin
     f_Text.Insert('\', 0);
     f_Text.Insert(l_Node.Text, 0);
    end//l_Node.GetLevel > 1
    else
     l_Node := nil;
   until (l_Node = nil)
  else
  if l_Node.HasChild then
  begin
   f_Text.Append('\');
   f_Text.Append(l_Node.Child.Text);
  end;//l_Node.GetLevel > 1
 end;//f_Text = nil
 Result := f_Text.AsPCharLen;
//#UC END# *48F494FD001D_4682704E0347_impl*
end;//TnsSingleAttributeStorable.Text
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
