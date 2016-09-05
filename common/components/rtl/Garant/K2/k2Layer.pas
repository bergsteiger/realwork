unit k2Layer;
 {* Список тегов, с идентификатором. }

// Модуль: "w:\common\components\rtl\Garant\K2\k2Layer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2Layer" MUID: (47AC597C0320)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2List
 , l3Variant
 , Classes
 , k2Base
 , k2BaseStruct
;

type
 Tk2Layer = class(Tk2List)
  {* Список тегов, с идентификатором. }
  private
   f_Handle: Tl3Variant;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function ExpandSize(aTargetSize: Integer): Integer; override;
   {$If NOT Defined(k2TagIsAtomic)}
   function GetHasSubAtom(aProp: Tk2Prop): Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   function GetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; override;
   {$If NOT Defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); override;
  public
   procedure Assign(Source: TPersistent); override;
 end;//Tk2Layer

implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
 //#UC START# *47AC597C0320impl_uses*
 //#UC END# *47AC597C0320impl_uses*
;

procedure Tk2Layer.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_47AC597C0320_var*
//#UC END# *478CF34E02CE_47AC597C0320_var*
begin
//#UC START# *478CF34E02CE_47AC597C0320_impl*
 Assert(false, 'Кому понадобилось работать с тегом ' +
               ClassName + ' : ' +
               TagType.AsString +
               ' как с TPersistent?');
 if (Source Is Tk2Layer) then
  Tk2Layer(Source).f_Handle.SetRefTo(f_Handle);
 inherited Assign(Source);
//#UC END# *478CF34E02CE_47AC597C0320_impl*
end;//Tk2Layer.Assign

procedure Tk2Layer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47AC597C0320_var*
//#UC END# *479731C50290_47AC597C0320_var*
begin
//#UC START# *479731C50290_47AC597C0320_impl*
 FreeAndNil(f_Handle);
 inherited;
//#UC END# *479731C50290_47AC597C0320_impl*
end;//Tk2Layer.Cleanup

function Tk2Layer.ExpandSize(aTargetSize: Integer): Integer;
//#UC START# *47B975AF02ED_47AC597C0320_var*
//#UC END# *47B975AF02ED_47AC597C0320_var*
begin
//#UC START# *47B975AF02ED_47AC597C0320_impl*
 if aTargetSize = 0 then
  Result := Succ(Capacity)
 else
  Result := aTargetSize;
//#UC END# *47B975AF02ED_47AC597C0320_impl*
end;//Tk2Layer.ExpandSize

{$If NOT Defined(k2TagIsAtomic)}
function Tk2Layer.GetHasSubAtom(aProp: Tk2Prop): Boolean;
//#UC START# *49A544E802B2_47AC597C0320_var*
//#UC END# *49A544E802B2_47AC597C0320_var*
begin
//#UC START# *49A544E802B2_47AC597C0320_impl*
 Result := inherited GetHasSubAtom(aProp) OR (aProp.TagIndex = k2_tiHandle)
//#UC END# *49A544E802B2_47AC597C0320_impl*
end;//Tk2Layer.GetHasSubAtom
{$IfEnd} // NOT Defined(k2TagIsAtomic)

function Tk2Layer.GetSubAtom(aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
//#UC START# *49A54517029C_47AC597C0320_var*
//#UC END# *49A54517029C_47AC597C0320_var*
begin
//#UC START# *49A54517029C_47AC597C0320_impl*
 if (aProp.TagIndex = k2_tiHandle) then
 begin
  Data := f_Handle;
  Result := true;
 end//aProp.TagIndex = k2_tiHandle
 else
  Result := inherited GetSubAtom(aProp, Data);
//#UC END# *49A54517029C_47AC597C0320_impl*
end;//Tk2Layer.GetSubAtom

{$If NOT Defined(k2TagIsAtomic)}
function Tk2Layer.SetAtomPrim(const aProp: _PropIn_;
 var V: Tk2Values): Boolean;
//#UC START# *49A545580241_47AC597C0320_var*
var
 l_H : Tl3Variant;
//#UC END# *49A545580241_47AC597C0320_var*
begin
//#UC START# *49A545580241_47AC597C0320_impl*
 Assert(aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex = k2_tiHandle);
 l_H := nil;
 V.SetRef(l_H);
 if (l_H = f_Handle) then
 begin
  Result := false;
  FreeAndNil(l_H);
 end//l_H = f_Handle
 else 
 begin
  Result := true;
  f_Handle.SetRef(V.rOld);
  FreeAndNil(f_Handle);
  f_Handle := l_H;
 end;//l_H = f_Handle
//#UC END# *49A545580241_47AC597C0320_impl*
end;//Tk2Layer.SetAtomPrim
{$IfEnd} // NOT Defined(k2TagIsAtomic)

procedure Tk2Layer.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_47AC597C0320_var*
var
 l_Prop : Tk2Prop;
//#UC END# *49A545D501F6_47AC597C0320_var*
begin
//#UC START# *49A545D501F6_47AC597C0320_impl*
 l_Prop := Tk2Prop(Tk2Type(TagType).Prop[k2_tiHandle]);
 Action(Self.f_Handle, l_Prop);
 inherited;
//#UC END# *49A545D501F6_47AC597C0320_impl*
end;//Tk2Layer.DoIterateProperties

end.
