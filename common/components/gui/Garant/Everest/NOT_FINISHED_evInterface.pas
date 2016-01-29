unit NOT_FINISHED_evInterface;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evInterface.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::StyleTable::TevInterface
//
// Базовый клас для инструментов работающих с тегами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3CacheableBase,
  nevBase,
  l3Variant
  ;

type
 TevInterface = class(Tl3CacheableBase)
  {* Базовый клас для инструментов работающих с тегами }
 private
 // private fields
   f_Context : InevOp;
    {* Поле для свойства Context}
 protected
 // property methods
   function pm_GetTag: Tl3Variant; virtual;
   procedure pm_SetTag(aValue: Tl3Variant); virtual;
   procedure pm_SetContext(const aValue: InevOp); virtual;
   function pm_GetIsOwn(anIndex: Integer): Boolean; virtual;
   procedure pm_SetIsOwn(anIndex: Integer; aValue: Boolean); virtual;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure Changing; virtual;
     {* Сигнатура метода Changing }
   procedure ChangedEx(aCancel: Boolean); virtual;
   function IsDefault: Boolean; virtual;
 public
 // public properties
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

// start class TevInterface

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

procedure TevInterface.pm_SetIsOwn(anIndex: Integer; aValue: Boolean);
//#UC START# *554CEA2D01A9_522ED98F0223set_var*
//#UC END# *554CEA2D01A9_522ED98F0223set_var*
begin
//#UC START# *554CEA2D01A9_522ED98F0223set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CEA2D01A9_522ED98F0223set_impl*
end;//TevInterface.pm_SetIsOwn

procedure TevInterface.ClearFields;
 {-}
begin
 Context := nil;
 inherited;
end;//TevInterface.ClearFields

end.