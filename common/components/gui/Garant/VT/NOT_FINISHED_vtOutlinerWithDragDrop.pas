unit NOT_FINISHED_vtOutlinerWithDragDrop;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtOutlinerWithDragDrop.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::Outliner::TvtOutlinerWithDragDrop
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3TreeInterfaces,
  ActiveX,
  vtOutlinerWithQuickSearch
  ;

type
 Tl3CanBeginDrag = procedure (const aNode: Il3SimpleNode;
  var aOkEffect: LongInt) of object;

 Tl3CanAcceptData = function (const aData: IDataObject): Boolean of object;

 Tl3DoDrop = function (const aData: Il3SimpleNode;
  aWantMenu: Boolean;
  var dwEffect: LongInt): Boolean of object;


 {$If not defined(DesignTimeLibrary)}
 RvtNodeDataObject = ;
 {$IfEnd} //not DesignTimeLibrary

 TvtOutlinerWithDragDrop = class(TvtOutlinerWithQuickSearch)
 protected
 // protected methods
   function CanAcceptData(const aData: IDataObject): Boolean; virtual;
   function DataObjectClass: RvtNodeDataObject; virtual;
 end;//TvtOutlinerWithDragDrop

implementation

uses
  vtOutlinerWithDragDropRes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TvtOutlinerWithDragDrop

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
{$If not defined(NoScripts)}
// Регистрация TvtOutlinerWithDragDrop
 TtfwClassRef.Register(TvtOutlinerWithDragDrop);
{$IfEnd} //not NoScripts

end.