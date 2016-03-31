unit NOT_FINISHED_evInterface;
 {* Базовый клас для инструментов работающих с тегами }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evInterface.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevInterface" MUID: (522ED98F0223)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3Variant
 , nevBase
;

type
 TevInterface = class(Tl3CacheableBase)
  {* Базовый клас для инструментов работающих с тегами }
  private
   f_Context: InevOp;
  protected
   function pm_GetTag: Tl3Variant; virtual;
   procedure pm_SetTag(aValue: Tl3Variant); virtual;
   procedure pm_SetContext(const aValue: InevOp); virtual;
   function pm_GetIsOwn(anIndex: Integer): Boolean; virtual;
   procedure pm_SetIsOwn(anIndex: Integer;
    aValue: Boolean); virtual;
   procedure Changing; virtual;
   procedure ChangedEx(aCancel: Boolean); virtual;
   function IsDefault: Boolean; virtual;
   procedure ClearFields; override;
  public
   property Tag: Tl3Variant
    read pm_GetTag
    write pm_SetTag;
   property Context: InevOp
    read f_Context
    write pm_SetContext;
   property IsOwn[anIndex: Integer]: Boolean
    read pm_GetIsOwn
    write pm_SetIsOwn;
 end;//TevInterface

implementation

uses
 l3ImplUses
;

function TevInterface.pm_GetTag: Tl3Variant;
//#UC START# *554CE8390106_522ED98F0223get_var*
//#UC END# *554CE8390106_522ED98F0223get_var*
begin
//#UC START# *554CE8390106_522ED98F0223get_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CE8390106_522ED98F0223get_impl*
end;//TevInterface.pm_GetTag

procedure TevInterface.pm_SetTag(aValue: Tl3Variant);
//#UC START# *554CE8390106_522ED98F0223set_var*
//#UC END# *554CE8390106_522ED98F0223set_var*
begin
//#UC START# *554CE8390106_522ED98F0223set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CE8390106_522ED98F0223set_impl*
end;//TevInterface.pm_SetTag

procedure TevInterface.pm_SetContext(const aValue: InevOp);
//#UC START# *554CE92F02D5_522ED98F0223set_var*
//#UC END# *554CE92F02D5_522ED98F0223set_var*
begin
//#UC START# *554CE92F02D5_522ED98F0223set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CE92F02D5_522ED98F0223set_impl*
end;//TevInterface.pm_SetContext

function TevInterface.pm_GetIsOwn(anIndex: Integer): Boolean;
//#UC START# *554CEA2D01A9_522ED98F0223get_var*
//#UC END# *554CEA2D01A9_522ED98F0223get_var*
begin
//#UC START# *554CEA2D01A9_522ED98F0223get_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CEA2D01A9_522ED98F0223get_impl*
end;//TevInterface.pm_GetIsOwn

procedure TevInterface.pm_SetIsOwn(anIndex: Integer;
 aValue: Boolean);
//#UC START# *554CEA2D01A9_522ED98F0223set_var*
//#UC END# *554CEA2D01A9_522ED98F0223set_var*
begin
//#UC START# *554CEA2D01A9_522ED98F0223set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CEA2D01A9_522ED98F0223set_impl*
end;//TevInterface.pm_SetIsOwn

procedure TevInterface.Changing;
//#UC START# *554CE773030B_522ED98F0223_var*
//#UC END# *554CE773030B_522ED98F0223_var*
begin
//#UC START# *554CE773030B_522ED98F0223_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CE773030B_522ED98F0223_impl*
end;//TevInterface.Changing

procedure TevInterface.ChangedEx(aCancel: Boolean);
//#UC START# *554CE783008B_522ED98F0223_var*
//#UC END# *554CE783008B_522ED98F0223_var*
begin
//#UC START# *554CE783008B_522ED98F0223_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CE783008B_522ED98F0223_impl*
end;//TevInterface.ChangedEx

function TevInterface.IsDefault: Boolean;
//#UC START# *554CE7CC01DE_522ED98F0223_var*
//#UC END# *554CE7CC01DE_522ED98F0223_var*
begin
//#UC START# *554CE7CC01DE_522ED98F0223_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CE7CC01DE_522ED98F0223_impl*
end;//TevInterface.IsDefault

procedure TevInterface.ClearFields;
begin
 Context := nil;
 inherited;
end;//TevInterface.ClearFields

end.
