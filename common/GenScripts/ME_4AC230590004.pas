unit nsWrapperNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsWrapperNode.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3NodesModelPart
 , OldTreeInterfaces
 , l3_String
 , l3Interfaces
 , l3Types
;

type
 TnsWrapperNode = class(Tl3PlaceNode, InsWrapperNode)
  private
   f_Name: Tl3_String;
   f_Comment: Tl3_String;
  protected
   function pm_GetName: Tl3WString;
   procedure pm_SetName(const aValue: Tl3WString);
   function pm_GetComment: Tl3WString;
   procedure pm_SetComment(const aValue: Tl3WString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
 end;//TnsWrapperNode
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
;

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
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(Admin)

end.
