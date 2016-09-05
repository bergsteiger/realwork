unit NOT_FINISHED_vtOutlinerWithDragDrop;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtOutlinerWithDragDrop.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtOutlinerWithDragDrop" MUID: (4B97E8130272)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , vtOutlinerWithQuickSearch
 , ActiveX
 , l3TreeInterfaces
;

type
 Tl3CanBeginDrag = procedure(const aNode: Il3SimpleNode;
  var aOkEffect: LongInt) of object;

 Tl3CanAcceptData = function(const aData: IDataObject): Boolean of object;

 Tl3DoDrop = function(const aData: Il3SimpleNode;
  aWantMenu: Boolean;
  var dwEffect: LongInt): Boolean of object;

{$If NOT Defined(DesignTimeLibrary)}
 RvtNodeDataObject = ;
{$IfEnd} // NOT Defined(DesignTimeLibrary)

 TvtOutlinerWithDragDrop = class(TvtOutlinerWithQuickSearch)
  protected
   function CanAcceptData(const aData: IDataObject): Boolean; virtual;
   function DataObjectClass: RvtNodeDataObject; virtual;
 end;//TvtOutlinerWithDragDrop

implementation

uses
 l3ImplUses
 , vtOutlinerWithDragDropRes
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4B97E8130272impl_uses*
 //#UC END# *4B97E8130272impl_uses*
;

function TvtOutlinerWithDragDrop.CanAcceptData(const aData: IDataObject): Boolean;
//#UC START# *51EEB81F017C_4B97E8130272_var*
//#UC END# *51EEB81F017C_4B97E8130272_var*
begin
//#UC START# *51EEB81F017C_4B97E8130272_impl*
 !!! Needs to be implemented !!!
//#UC END# *51EEB81F017C_4B97E8130272_impl*
end;//TvtOutlinerWithDragDrop.CanAcceptData

function TvtOutlinerWithDragDrop.DataObjectClass: RvtNodeDataObject;
//#UC START# *52DD106403D3_4B97E8130272_var*
//#UC END# *52DD106403D3_4B97E8130272_var*
begin
//#UC START# *52DD106403D3_4B97E8130272_impl*
 !!! Needs to be implemented !!!
//#UC END# *52DD106403D3_4B97E8130272_impl*
end;//TvtOutlinerWithDragDrop.DataObjectClass

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtOutlinerWithDragDrop);
 {* Регистрация TvtOutlinerWithDragDrop }
{$IfEnd} // NOT Defined(NoScripts)

end.
