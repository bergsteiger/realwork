unit evDocument_Wrap;

// Модуль: "w:\common\components\gui\Garant\Everest\evDocument_Wrap.pas"
// Стереотип: "Wrapper"
// Элемент модели: "WevDocument" MUID: (4857B5D901D7)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evPara_Wrap
 , l3Variant
 , k2Base
;

type
 WevDocument = class(WevPara)
  protected
   function GetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; override;
 end;//WevDocument

implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , Para_Const
 , Document_Const
 //#UC START# *4857B5D901D7impl_uses*
 //#UC END# *4857B5D901D7impl_uses*
;

function WevDocument.GetAtomData(AE: Tl3Variant;
 aProp: Tk2CustomProperty;
 out Data: Tl3Variant): Boolean;
//#UC START# *4857A995029E_4857B5D901D7_var*
//#UC END# *4857A995029E_4857B5D901D7_var*
begin
//#UC START# *4857A995029E_4857B5D901D7_impl*
 if (aProp.TagIndex = k2_tiFixedWidth) then
 begin
  if AE.Owner.IsKindOf(k2_typPara) then
  // - вложенные документы не должны задавать свою ширину при форматировании
  begin
   Result := true;
   Data := aProp.MakeTag(Ord(false)).AsObject;
   Exit;
  end;//IsKindOf(k2_typPara)
 end;//aProp.TagIndex = k2_tiFixedWidth
 Result := inherited GetAtomData(AE, aProp, Data);
//#UC END# *4857A995029E_4857B5D901D7_impl*
end;//WevDocument.GetAtomData

end.
