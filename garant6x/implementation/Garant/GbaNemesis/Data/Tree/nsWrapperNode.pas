unit nsWrapperNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsWrapperNode.pas"
// Начат: 21.10.2009 18:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::OldTree::TnsWrapperNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3_String,
  OldTreeInterfaces,
  l3NodesModelPart,
  l3Interfaces,
  l3Types
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsWrapperNode = class(Tl3PlaceNode, InsWrapperNode)
 private
 // private fields
   f_Name : Tl3_String;
   f_Comment : Tl3_String;
 protected
 // realized methods
   function pm_GetName: Tl3WString;
   procedure pm_SetName(const aValue: Tl3WString);
   function pm_GetComment: Tl3WString;
   procedure pm_SetComment(const aValue: Tl3WString);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
 end;//TnsWrapperNode
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base,
  SysUtils
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TnsWrapperNode

function TnsWrapperNode.pm_GetName: Tl3WString;
//#UC START# *49904DAD00EB_4AC230590004get_var*
//#UC END# *49904DAD00EB_4AC230590004get_var*
begin
//#UC START# *49904DAD00EB_4AC230590004get_impl*
 Result := f_Name.AsPCharLen;
//#UC END# *49904DAD00EB_4AC230590004get_impl*
end;//TnsWrapperNode.pm_GetName

procedure TnsWrapperNode.pm_SetName(const aValue: Tl3WString);
//#UC START# *49904DAD00EB_4AC230590004set_var*
//#UC END# *49904DAD00EB_4AC230590004set_var*
begin
//#UC START# *49904DAD00EB_4AC230590004set_impl*
 l3Set(f_Name, aValue);
//#UC END# *49904DAD00EB_4AC230590004set_impl*
end;//TnsWrapperNode.pm_SetName

function TnsWrapperNode.pm_GetComment: Tl3WString;
//#UC START# *49904DBF02F0_4AC230590004get_var*
//#UC END# *49904DBF02F0_4AC230590004get_var*
begin
//#UC START# *49904DBF02F0_4AC230590004get_impl*
 Result := f_Comment.AsPCharLen;
//#UC END# *49904DBF02F0_4AC230590004get_impl*
end;//TnsWrapperNode.pm_GetComment

procedure TnsWrapperNode.pm_SetComment(const aValue: Tl3WString);
//#UC START# *49904DBF02F0_4AC230590004set_var*
//#UC END# *49904DBF02F0_4AC230590004set_var*
begin
//#UC START# *49904DBF02F0_4AC230590004set_impl*
 l3Set(f_Comment, aValue);
//#UC END# *49904DBF02F0_4AC230590004set_impl*
end;//TnsWrapperNode.pm_SetComment

procedure TnsWrapperNode.Cleanup;
//#UC START# *479731C50290_4AC230590004_var*
//#UC END# *479731C50290_4AC230590004_var*
begin
//#UC START# *479731C50290_4AC230590004_impl*
 FreeAndNil(f_Name);
 FreeAndNil(f_Comment);
 inherited;
//#UC END# *479731C50290_4AC230590004_impl*
end;//TnsWrapperNode.Cleanup

function TnsWrapperNode.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4AC230590004_var*
//#UC END# *47A869BB02DE_4AC230590004_var*
begin
//#UC START# *47A869BB02DE_4AC230590004_impl*
 Result := f_Name.AsPCharLen;
//#UC END# *47A869BB02DE_4AC230590004_impl*
end;//TnsWrapperNode.GetAsPCharLen

procedure TnsWrapperNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_4AC230590004_var*
//#UC END# *47A869D10074_4AC230590004_var*
begin
//#UC START# *47A869D10074_4AC230590004_impl*
 pm_SetName(Value);
//#UC END# *47A869D10074_4AC230590004_impl*
end;//TnsWrapperNode.DoSetAsPCharLen

{$IfEnd} //not Admin

end.