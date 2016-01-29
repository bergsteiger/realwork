unit ChromeLikeBaseVisualObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeBaseVisualObject.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeTabSet::TChromeLikeBaseVisualObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  ChromeLikeBaseVisualObjectPrim,
  ChromeLikeBaseVisualObjectList
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 TChromeLikeBaseVisualObject = class(TChromeLikeBaseVisualObjectPrim)
 private
 // private fields
   f_Children : TChromeLikeBaseVisualObjectList;
 protected
 // overridden property methods
   function pm_GetChildren(Index: Integer): TChromeLikeBaseVisualObjectPrim; override;
   function pm_GetChildrenCount: Integer; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InsertObject(aObject: TChromeLikeBaseVisualObjectPrim); override;
   procedure RemoveChild(aIndex: Integer); override;
 public
 // overridden public methods
   constructor Create(aParent: TChromeLikeBaseVisualObjectPrim); override;
 end;//TChromeLikeBaseVisualObject
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  SysUtils
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class TChromeLikeBaseVisualObject

procedure TChromeLikeBaseVisualObject.Cleanup;
//#UC START# *479731C50290_550C09E20148_var*
//#UC END# *479731C50290_550C09E20148_var*
begin
//#UC START# *479731C50290_550C09E20148_impl*
 DeleteChildren;
 FreeAndNil(f_Children);
 inherited;
//#UC END# *479731C50290_550C09E20148_impl*
end;//TChromeLikeBaseVisualObject.Cleanup

procedure TChromeLikeBaseVisualObject.InsertObject(aObject: TChromeLikeBaseVisualObjectPrim);
//#UC START# *5506A438011F_550C09E20148_var*
//#UC END# *5506A438011F_550C09E20148_var*
begin
//#UC START# *5506A438011F_550C09E20148_impl*
 f_Children.Add(aObject);
 inherited;
//#UC END# *5506A438011F_550C09E20148_impl*
end;//TChromeLikeBaseVisualObject.InsertObject

procedure TChromeLikeBaseVisualObject.RemoveChild(aIndex: Integer);
//#UC START# *5506A45102AC_550C09E20148_var*
//#UC END# *5506A45102AC_550C09E20148_var*
begin
//#UC START# *5506A45102AC_550C09E20148_impl*
 f_Children.Delete(aIndex);
 inherited;
//#UC END# *5506A45102AC_550C09E20148_impl*
end;//TChromeLikeBaseVisualObject.RemoveChild

function TChromeLikeBaseVisualObject.pm_GetChildren(Index: Integer): TChromeLikeBaseVisualObjectPrim;
//#UC START# *5506A4F20013_550C09E20148get_var*
//#UC END# *5506A4F20013_550C09E20148get_var*
begin
//#UC START# *5506A4F20013_550C09E20148get_impl*
 Result := f_Children[Index];
//#UC END# *5506A4F20013_550C09E20148get_impl*
end;//TChromeLikeBaseVisualObject.pm_GetChildren

function TChromeLikeBaseVisualObject.pm_GetChildrenCount: Integer;
//#UC START# *5506AF4E01FC_550C09E20148get_var*
//#UC END# *5506AF4E01FC_550C09E20148get_var*
begin
//#UC START# *5506AF4E01FC_550C09E20148get_impl*
 Result := f_Children.Count;
//#UC END# *5506AF4E01FC_550C09E20148get_impl*
end;//TChromeLikeBaseVisualObject.pm_GetChildrenCount

constructor TChromeLikeBaseVisualObject.Create(aParent: TChromeLikeBaseVisualObjectPrim);
//#UC START# *5506B7960083_550C09E20148_var*
//#UC END# *5506B7960083_550C09E20148_var*
begin
//#UC START# *5506B7960083_550C09E20148_impl*
 f_Children := TChromeLikeBaseVisualObjectList.Create;
 inherited;
//#UC END# *5506B7960083_550C09E20148_impl*
end;//TChromeLikeBaseVisualObject.Create

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.