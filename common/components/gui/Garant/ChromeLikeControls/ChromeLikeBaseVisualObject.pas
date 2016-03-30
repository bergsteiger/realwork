unit ChromeLikeBaseVisualObject;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseVisualObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TChromeLikeBaseVisualObject" MUID: (550C09E20148)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , ChromeLikeBaseVisualObjectPrim
 , ChromeLikeBaseVisualObjectList
;

type
 TChromeLikeBaseVisualObject = class(TChromeLikeBaseVisualObjectPrim)
  private
   f_Children: TChromeLikeBaseVisualObjectList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InsertObject(aObject: TChromeLikeBaseVisualObjectPrim); override;
   procedure RemoveChild(aIndex: Integer); override;
   function pm_GetChildren(Index: Integer): TChromeLikeBaseVisualObjectPrim; override;
   function pm_GetChildrenCount: Integer; override;
  public
   constructor Create(aParent: TChromeLikeBaseVisualObjectPrim); override;
 end;//TChromeLikeBaseVisualObject
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , SysUtils
;

procedure TChromeLikeBaseVisualObject.Cleanup;
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
