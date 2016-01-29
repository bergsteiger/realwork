unit NOT_FINISHED_vgObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VGScene"
// ������: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgObject.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  vgAnyObjectList,
  vgCustomObject,
  vgSortableObjectList,
  vgCustomObjectList
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgObject = class(TvgCustomObject)
 private
 // private fields
   FNotifyList : TvgAnyObjectList;
 protected
 // realized methods
   function pm_GetIsVisual: Boolean; override;
 protected
 // protected fields
   FChildren : TvgSortableObjectList;
 public
 // public methods
   procedure AddObjectsToList(aList: TvgCustomObjectList);
   procedure AddControlsToList(aList: TvgCustomObjectList);
 end;//TvgObject
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

// start class TvgObject

procedure TvgObject.AddObjectsToList(aList: TvgCustomObjectList);
//#UC START# *4D5EA9B9016E_4D4956480326_var*
//#UC END# *4D5EA9B9016E_4D4956480326_var*
begin
//#UC START# *4D5EA9B9016E_4D4956480326_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EA9B9016E_4D4956480326_impl*
end;//TvgObject.AddObjectsToList

procedure TvgObject.AddControlsToList(aList: TvgCustomObjectList);
//#UC START# *4D5EA9E700D0_4D4956480326_var*
//#UC END# *4D5EA9E700D0_4D4956480326_var*
begin
//#UC START# *4D5EA9E700D0_4D4956480326_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EA9E700D0_4D4956480326_impl*
end;//TvgObject.AddControlsToList

function TvgObject.pm_GetIsVisual: Boolean;
//#UC START# *4D5EAD10009D_4D4956480326get_var*
//#UC END# *4D5EAD10009D_4D4956480326get_var*
begin
//#UC START# *4D5EAD10009D_4D4956480326get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EAD10009D_4D4956480326get_impl*
end;//TvgObject.pm_GetIsVisual

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� TvgObject
 TtfwClassRef.Register(TvgObject);
{$IfEnd} //not NoScripts AND not NoVGScene

end.