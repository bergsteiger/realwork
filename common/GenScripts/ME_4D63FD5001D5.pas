unit evReqGroup_Wrap;

// Модуль: "w:\common\components\gui\Garant\Everest\evReqGroup_Wrap.pas"
// Стереотип: "Wrapper"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evPara_Wrap
 , ReqGroup_Const
 , l3Variant
 , k2Base
;

type
 WevReqGroup = class(WevPara)
  protected
   function PreGetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; override;
 end;//WevReqGroup

implementation

uses
 l3ImplUses
 , Graphics
 , k2Tags
;

function WevReqGroup.PreGetAtomData(AE: Tl3Variant;
 aProp: Tk2CustomProperty;
 out Data: Tl3Variant): Boolean;
//#UC START# *48DD0CE60313_4D63FD5001D5_var*
//#UC END# *48DD0CE60313_4D63FD5001D5_var*
begin
//#UC START# *48DD0CE60313_4D63FD5001D5_impl*
 {$IfDef evReqGroupNeedsRadio}
 if (aProp.TagIndex = k2_tiBackColor) AND not AE.BoolA[k2_tiChecked] then
 begin
  Data := $F7F6F5{clSilver};
  Result := true;
  Exit;
 end;//aProp.TagIndex = k2_tiBackColor
 {$EndIf evReqGroupNeedsRadio}
 Result := inherited PreGetAtomData(AE, aProp, Data);
//#UC END# *48DD0CE60313_4D63FD5001D5_impl*
end;//WevReqGroup.PreGetAtomData

end.
