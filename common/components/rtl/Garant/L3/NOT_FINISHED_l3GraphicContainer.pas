unit NOT_FINISHED_l3GraphicContainer;

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3GraphicContainer.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3GraphicContainer" MUID: (48DD20E400C2)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3_Base
 , l3InternalInterfaces
 , l3Units
 , l3Core
 , l3Interfaces
 , Classes
;

type
 Tl3PrimGraphicContainer = class(Tl3_Base, Il3Bitmap)
  protected
   procedure StretchDraw(const R: Tl3Rect;
    const aCanvas: Il3Canvas);
   procedure SaveToClipboardFormat(var AFormat: Word;
    var AData: THandle;
    var APalette: HPALETTE);
   procedure AssignTo(P: TObject);
   procedure Assign(P: TPersistent);
   function IsMF: Boolean;
   function pm_GetWidth: Integer;
   function pm_GetHeight: Integer;
   function pm_GetInchWidth: Integer;
   function pm_GetInchHeight: Integer;
 end;//Tl3PrimGraphicContainer

 Tl3SizeableGraphicContainerPrim = class(Tl3PrimGraphicContainer)
 end;//Tl3SizeableGraphicContainerPrim

 Tl3SizeableGraphicContainer = class(Tl3SizeableGraphicContainerPrim)
 end;//Tl3SizeableGraphicContainer

 Tl3GraphicContainer = class(Tl3SizeableGraphicContainerPrim)
 end;//Tl3GraphicContainer

implementation

uses
 l3ImplUses
 , l3GraphicContainerStack
 //#UC START# *48DD20E400C2impl_uses*
 //#UC END# *48DD20E400C2impl_uses*
;

procedure Tl3PrimGraphicContainer.StretchDraw(const R: Tl3Rect;
 const aCanvas: Il3Canvas);
//#UC START# *476F70A4036F_48DD2129027C_var*
//#UC END# *476F70A4036F_48DD2129027C_var*
begin
//#UC START# *476F70A4036F_48DD2129027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F70A4036F_48DD2129027C_impl*
end;//Tl3PrimGraphicContainer.StretchDraw

procedure Tl3PrimGraphicContainer.SaveToClipboardFormat(var AFormat: Word;
 var AData: THandle;
 var APalette: HPALETTE);
//#UC START# *476F70D70190_48DD2129027C_var*
//#UC END# *476F70D70190_48DD2129027C_var*
begin
//#UC START# *476F70D70190_48DD2129027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F70D70190_48DD2129027C_impl*
end;//Tl3PrimGraphicContainer.SaveToClipboardFormat

procedure Tl3PrimGraphicContainer.AssignTo(P: TObject);
//#UC START# *476F711D0027_48DD2129027C_var*
//#UC END# *476F711D0027_48DD2129027C_var*
begin
//#UC START# *476F711D0027_48DD2129027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F711D0027_48DD2129027C_impl*
end;//Tl3PrimGraphicContainer.AssignTo

procedure Tl3PrimGraphicContainer.Assign(P: TPersistent);
//#UC START# *476F71240272_48DD2129027C_var*
//#UC END# *476F71240272_48DD2129027C_var*
begin
//#UC START# *476F71240272_48DD2129027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F71240272_48DD2129027C_impl*
end;//Tl3PrimGraphicContainer.Assign

function Tl3PrimGraphicContainer.IsMF: Boolean;
//#UC START# *476F712D0181_48DD2129027C_var*
//#UC END# *476F712D0181_48DD2129027C_var*
begin
//#UC START# *476F712D0181_48DD2129027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F712D0181_48DD2129027C_impl*
end;//Tl3PrimGraphicContainer.IsMF

function Tl3PrimGraphicContainer.pm_GetWidth: Integer;
//#UC START# *476F713A0299_48DD2129027Cget_var*
//#UC END# *476F713A0299_48DD2129027Cget_var*
begin
//#UC START# *476F713A0299_48DD2129027Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F713A0299_48DD2129027Cget_impl*
end;//Tl3PrimGraphicContainer.pm_GetWidth

function Tl3PrimGraphicContainer.pm_GetHeight: Integer;
//#UC START# *476F7149024D_48DD2129027Cget_var*
//#UC END# *476F7149024D_48DD2129027Cget_var*
begin
//#UC START# *476F7149024D_48DD2129027Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F7149024D_48DD2129027Cget_impl*
end;//Tl3PrimGraphicContainer.pm_GetHeight

function Tl3PrimGraphicContainer.pm_GetInchWidth: Integer;
//#UC START# *476F71580018_48DD2129027Cget_var*
//#UC END# *476F71580018_48DD2129027Cget_var*
begin
//#UC START# *476F71580018_48DD2129027Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F71580018_48DD2129027Cget_impl*
end;//Tl3PrimGraphicContainer.pm_GetInchWidth

function Tl3PrimGraphicContainer.pm_GetInchHeight: Integer;
//#UC START# *476F71670396_48DD2129027Cget_var*
//#UC END# *476F71670396_48DD2129027Cget_var*
begin
//#UC START# *476F71670396_48DD2129027Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F71670396_48DD2129027Cget_impl*
end;//Tl3PrimGraphicContainer.pm_GetInchHeight

end.
