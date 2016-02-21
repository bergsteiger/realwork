unit NOT_FINISHED_k2TagPointer;

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_FINISHED_k2TagPointer.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2ToolPrim
 , k2Interfaces
 , l3Variant
 , k2Prim
 , l3Interfaces
 , k2BaseTypes
 , l3Types
;

type
 _k2TagHolder_Parent_ = Tk2ToolPrim;
 {$Include w:\common\components\rtl\Garant\K2\k2TagHolder.imp.pas}
 _k2TagBox_Parent_ = _k2TagHolder_;
 {$Include w:\common\components\rtl\Garant\K2\k2TagBox.imp.pas}
 Tk2TagPointer = {abstract} class(_k2TagBox_, Ik2TagListener, Ik2TagTool)
  protected
   procedure ClearTagCache; virtual;
   procedure DoFire(const anEvent: Tk2Event;
    const anOp: Ik2Op); virtual;
   procedure ClearParents; virtual;
   function GetParentTool: Ik2TagTool; virtual;
   function GetExcludeEvents: Tk2EventIDs; virtual;
   function NeedEvents: Boolean; virtual;
    {* Нужно ли подписываться на события тегов }
   procedure TagChanged(aNew: Tl3Variant); virtual;
   procedure Fire(const anEvent: Tk2Event;
    const anOp: Ik2Op);
    {* сообщение о том, что c тегом что-то произошло. }
   function ExcludeEvents: Tk2EventIDs;
    {* События, которые не надо слушать. }
   function pm_GetParentTool: Ik2TagTool;
   procedure pm_SetParentTool(const aValue: Ik2TagTool);
   function GetAsBox: Tl3Variant; override;
  public
   constructor Create(aTag: Tl3Variant); reintroduce; virtual;
   class function Make(aTag: Tl3Variant): Ik2TagTool; virtual;
   procedure SetTagQT(aTag: Tl3Variant); override;
 end;//Tk2TagPointer

implementation

uses
 l3ImplUses
 , SysUtils
 , k2NullTagImpl
 , k2Tags
 , k2Base
 , k2InterfaceFactory
;

{$Include w:\common\components\rtl\Garant\K2\k2TagHolder.imp.pas}

type _Instance_R_ = Tk2TagPointer;

{$Include w:\common\components\rtl\Garant\K2\k2TagBox.imp.pas}

procedure Tk2TagPointer.ClearTagCache;
//#UC START# *48CE74A10014_467C185C03E7_var*
//#UC END# *48CE74A10014_467C185C03E7_var*
begin
//#UC START# *48CE74A10014_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48CE74A10014_467C185C03E7_impl*
end;//Tk2TagPointer.ClearTagCache

procedure Tk2TagPointer.DoFire(const anEvent: Tk2Event;
 const anOp: Ik2Op);
//#UC START# *48CF73CE00B5_467C185C03E7_var*
//#UC END# *48CF73CE00B5_467C185C03E7_var*
begin
//#UC START# *48CF73CE00B5_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48CF73CE00B5_467C185C03E7_impl*
end;//Tk2TagPointer.DoFire

procedure Tk2TagPointer.ClearParents;
//#UC START# *48CFBCF803B3_467C185C03E7_var*
//#UC END# *48CFBCF803B3_467C185C03E7_var*
begin
//#UC START# *48CFBCF803B3_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48CFBCF803B3_467C185C03E7_impl*
end;//Tk2TagPointer.ClearParents

function Tk2TagPointer.GetParentTool: Ik2TagTool;
//#UC START# *48D0BC9401DB_467C185C03E7_var*
//#UC END# *48D0BC9401DB_467C185C03E7_var*
begin
//#UC START# *48D0BC9401DB_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48D0BC9401DB_467C185C03E7_impl*
end;//Tk2TagPointer.GetParentTool

function Tk2TagPointer.GetExcludeEvents: Tk2EventIDs;
//#UC START# *48D0F4810330_467C185C03E7_var*
//#UC END# *48D0F4810330_467C185C03E7_var*
begin
//#UC START# *48D0F4810330_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48D0F4810330_467C185C03E7_impl*
end;//Tk2TagPointer.GetExcludeEvents

constructor Tk2TagPointer.Create(aTag: Tl3Variant);
//#UC START# *4A3F4707018A_467C185C03E7_var*
//#UC END# *4A3F4707018A_467C185C03E7_var*
begin
//#UC START# *4A3F4707018A_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A3F4707018A_467C185C03E7_impl*
end;//Tk2TagPointer.Create

function Tk2TagPointer.NeedEvents: Boolean;
 {* Нужно ли подписываться на события тегов }
//#UC START# *4A48AFBD001D_467C185C03E7_var*
//#UC END# *4A48AFBD001D_467C185C03E7_var*
begin
//#UC START# *4A48AFBD001D_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A48AFBD001D_467C185C03E7_impl*
end;//Tk2TagPointer.NeedEvents

procedure Tk2TagPointer.TagChanged(aNew: Tl3Variant);
//#UC START# *4E3A40FC010F_467C185C03E7_var*
//#UC END# *4E3A40FC010F_467C185C03E7_var*
begin
//#UC START# *4E3A40FC010F_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E3A40FC010F_467C185C03E7_impl*
end;//Tk2TagPointer.TagChanged

class function Tk2TagPointer.Make(aTag: Tl3Variant): Ik2TagTool;
//#UC START# *52F20C1F00D4_467C185C03E7_var*
//#UC END# *52F20C1F00D4_467C185C03E7_var*
begin
//#UC START# *52F20C1F00D4_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52F20C1F00D4_467C185C03E7_impl*
end;//Tk2TagPointer.Make

procedure Tk2TagPointer.Fire(const anEvent: Tk2Event;
 const anOp: Ik2Op);
 {* сообщение о том, что c тегом что-то произошло. }
//#UC START# *4761446F0081_467C185C03E7_var*
//#UC END# *4761446F0081_467C185C03E7_var*
begin
//#UC START# *4761446F0081_467C185C03E7_impl*
 assert(false, 'Tk2TagPointer.Fire not implemented');
//#UC END# *4761446F0081_467C185C03E7_impl*
end;//Tk2TagPointer.Fire

function Tk2TagPointer.ExcludeEvents: Tk2EventIDs;
 {* События, которые не надо слушать. }
//#UC START# *476144C702AA_467C185C03E7_var*
//#UC END# *476144C702AA_467C185C03E7_var*
begin
//#UC START# *476144C702AA_467C185C03E7_impl*
 assert(false, 'Tk2TagPointer.ExcludeEvents not implemented');
//#UC END# *476144C702AA_467C185C03E7_impl*
end;//Tk2TagPointer.ExcludeEvents

function Tk2TagPointer.pm_GetParentTool: Ik2TagTool;
//#UC START# *476145AF00A8_467C185C03E7get_var*
//#UC END# *476145AF00A8_467C185C03E7get_var*
begin
//#UC START# *476145AF00A8_467C185C03E7get_impl*
 assert(false, 'Tk2TagPointer.pm_GetParentTool not implemented');
//#UC END# *476145AF00A8_467C185C03E7get_impl*
end;//Tk2TagPointer.pm_GetParentTool

procedure Tk2TagPointer.pm_SetParentTool(const aValue: Ik2TagTool);
//#UC START# *476145AF00A8_467C185C03E7set_var*
//#UC END# *476145AF00A8_467C185C03E7set_var*
begin
//#UC START# *476145AF00A8_467C185C03E7set_impl*
 assert(false, 'Tk2TagPointer.pm_SetParentTool not implemented');
//#UC END# *476145AF00A8_467C185C03E7set_impl*
end;//Tk2TagPointer.pm_SetParentTool

procedure Tk2TagPointer.SetTagQT(aTag: Tl3Variant);
//#UC START# *49E75FA4010C_467C185C03E7_var*
//#UC END# *49E75FA4010C_467C185C03E7_var*
begin
//#UC START# *49E75FA4010C_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E75FA4010C_467C185C03E7_impl*
end;//Tk2TagPointer.SetTagQT

function Tk2TagPointer.GetAsBox: Tl3Variant;
//#UC START# *532FFF230250_467C185C03E7_var*
//#UC END# *532FFF230250_467C185C03E7_var*
begin
//#UC START# *532FFF230250_467C185C03E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *532FFF230250_467C185C03E7_impl*
end;//Tk2TagPointer.GetAsBox

end.
