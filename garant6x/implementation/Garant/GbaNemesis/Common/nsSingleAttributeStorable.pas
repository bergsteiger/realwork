unit nsSingleAttributeStorable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsSingleAttributeStorable.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::DocumentDataObjects::TnsSingleAttributeStorable
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3_String,
  evNodeStorable,
  l3Interfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsSingleAttributeStorable = class(TevNodeStorable)
 private
 // private fields
   f_Text : Tl3_String;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function Text: Tl3WString; override;
 end;//TnsSingleAttributeStorable
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  l3TreeInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsSingleAttributeStorable

procedure TnsSingleAttributeStorable.Cleanup;
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

{$IfEnd} //not Admin AND not Monitorings

end.