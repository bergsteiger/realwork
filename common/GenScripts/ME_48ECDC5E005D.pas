unit evMultiSelectionDataFormatting;

// Модуль: "w:\common\components\gui\Garant\Everest\evMultiSelectionDataFormatting.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evMultiSelectionRange
 , nevTools
 , l3Variant
 , nevBase
 , l3Interfaces
;

type
 TevMultiSelectionDataFormatting = class(TevMultiSelectionRange, InevDataFormatting, InevDataFormattingModify)
  protected
   function GetFont(const aView: InevView;
    aMap: TnevFormatInfoPrim;
    Stop: PInteger = nil): InevFontPrim;
   function GetStyle(Stop: PInteger = nil): Tl3Variant;
   function Modify(const aView: InevView): InevDataFormattingModify;
   function SetAtom(const aView: InevView;
    anIndex: Cardinal;
    aValue: Tl3Variant;
    const anOp: InevOp): Boolean;
   function ChangeParam(const aView: InevView;
    const aMarker: IevMarker;
    aValue: Integer;
    const anOp: InevOp = nil): Boolean;
   function DeleteHyperlink(const anOp: InevOp = nil): Boolean;
   function DeleteSegments(const anOp: InevOp = nil): Boolean;
    {* удаляет сегменты. }
   function AddIndentMarker(const aView: InevView;
    aValue: Integer;
    const anOpPack: InevOp = nil): Boolean;
   function DeleteIndentMarker(const aView: InevView;
    const anOpPack: InevOp = nil): Boolean;
   function GetFormatting: InevDataFormatting; override;
 end;//TevMultiSelectionDataFormatting

implementation

uses
 l3ImplUses
 , k2Base
 , nevFacade
 , afwFacade
;

function TevMultiSelectionDataFormatting.GetFont(const aView: InevView;
 aMap: TnevFormatInfoPrim;
 Stop: PInteger = nil): InevFontPrim;
//#UC START# *47C68E0C02E2_48ECDC5E005D_var*
var
 NF1 : InevFontPrim;
 pNF : ^InevFontPrim;
 Ass : Boolean;
 NF  : InevFontPrim absolute Result;

 function AddChildFont(const aChild: InevRange; Index: Integer): Boolean;
 begin//AddChildFont
  Result := false;
  try
   if (Stop <> nil) AND (Stop^ > 1) then Exit;
   pNF^ := aChild.Formatting.GetFont(aView, aMap.InfoForChild(aChild.Obj^), Stop);
   if (Stop <> nil) AND (Stop^ > 1) then Exit;
   if (NF <> nil) then
   begin
    if not Ass then
     pNF := @NF1
    else
    if NF.SubFont(pNF^) then
     Exit;
   end;//(NF <> nil)
   if not afw.InOp then
    afw.ProcessMessages;
  finally
   if Ass then
    NF1 := nil
   else
   if (NF <> nil) then
    Ass := true;
  end;//try..finally
  Result := true;
 end;//AddChildFont

//#UC END# *47C68E0C02E2_48ECDC5E005D_var*
begin
//#UC START# *47C68E0C02E2_48ECDC5E005D_impl*
 Ass := false;
 pNF := @Result;
 IterateF(evL2TSA(@AddChildFont));
//#UC END# *47C68E0C02E2_48ECDC5E005D_impl*
end;//TevMultiSelectionDataFormatting.GetFont

function TevMultiSelectionDataFormatting.GetStyle(Stop: PInteger = nil): Tl3Variant;
//#UC START# *47C68E3402A5_48ECDC5E005D_var*
var
 ResultStyle : Tl3Variant absolute Result;
 Ass         : Boolean;

 function AddChildStyle(const aChild: InevRange; anIndex: Integer): Boolean;
 var
  St : Tl3Variant;
 begin//AddChildStyle
  Result := false;
  if (Stop <> nil) AND (Stop^ > 1) then Exit;
  St := aChild.Formatting.GetStyle(Stop);
  if (Stop <> nil) AND (Stop^ > 1) then Exit;
  if (St = nil) OR St.IsNull then
  begin
   ResultStyle := k2NullTag;
   Exit;
  end//St = nil
  else
  if Ass then
  begin
   if not St.IsSame(ResultStyle) then
   begin
    ResultStyle := k2NullTag;
    Exit;
   end;//not St.IsSame(ResultStyle)
  end//Ass
  else
  begin
   ResultStyle := St;
   Ass := true;
  end;//Ass
  if not afw.InOp then
   afw.ProcessMessages;
  Result := true;
 end;//AddChildStyle

//#UC END# *47C68E3402A5_48ECDC5E005D_var*
begin
//#UC START# *47C68E3402A5_48ECDC5E005D_impl*
 Result := k2NullTag;
 Ass := false;
 IterateF(evL2TSA(@AddChildStyle));
//#UC END# *47C68E3402A5_48ECDC5E005D_impl*
end;//TevMultiSelectionDataFormatting.GetStyle

function TevMultiSelectionDataFormatting.Modify(const aView: InevView): InevDataFormattingModify;
//#UC START# *47C68E3D0279_48ECDC5E005D_var*
//#UC END# *47C68E3D0279_48ECDC5E005D_var*
begin
//#UC START# *47C68E3D0279_48ECDC5E005D_impl*
 Result := Self;
//#UC END# *47C68E3D0279_48ECDC5E005D_impl*
end;//TevMultiSelectionDataFormatting.Modify

function TevMultiSelectionDataFormatting.SetAtom(const aView: InevView;
 anIndex: Cardinal;
 aValue: Tl3Variant;
 const anOp: InevOp): Boolean;
//#UC START# *47C690130239_48ECDC5E005D_var*

 function _DoChild(const aBlock: InevRange; aBlockIndex: Integer): Boolean;
 var
  l_F : InevDataFormattingModify;
 begin//_DoChild
  Result := true;
  l_F := aBlock.Formatting.Modify(aView);
  if (l_F <> nil) AND l_F.SetAtom(aView, anIndex, aValue, anOp) then
   SetAtom := true;
 end;//_DoChild

//#UC END# *47C690130239_48ECDC5E005D_var*
begin
//#UC START# *47C690130239_48ECDC5E005D_impl*
 Result := false;
 IterateF(evL2TSA(@_DoChild));
//#UC END# *47C690130239_48ECDC5E005D_impl*
end;//TevMultiSelectionDataFormatting.SetAtom

function TevMultiSelectionDataFormatting.ChangeParam(const aView: InevView;
 const aMarker: IevMarker;
 aValue: Integer;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C6902A0263_48ECDC5E005D_var*

 function _DoChild(const aBlock: InevRange; aBlockIndex: Integer): Boolean;
 var
  l_F : InevDataFormattingModify;
 begin//_DoChild
  Result := true;
  l_F := aBlock.Formatting.Modify(aView);
  if (l_F <> nil) AND l_F.ChangeParam(aView, aMarker, aValue, anOp) then
   ChangeParam := true;
 end;//_DoChild

//#UC END# *47C6902A0263_48ECDC5E005D_var*
begin
//#UC START# *47C6902A0263_48ECDC5E005D_impl*
 Result := false;
 IterateF(evL2TSA(@_DoChild));
//#UC END# *47C6902A0263_48ECDC5E005D_impl*
end;//TevMultiSelectionDataFormatting.ChangeParam

function TevMultiSelectionDataFormatting.DeleteHyperlink(const anOp: InevOp = nil): Boolean;
//#UC START# *47C690400067_48ECDC5E005D_var*

 function _DoChild(const aBlock: InevRange; aBlockIndex: Integer): Boolean;
 var
  l_F : InevDataFormattingModify;
 begin//_DoChild
  Result := true;
  l_F := aBlock.Formatting.Modify(nil);
  if (l_F <> nil) AND l_F.DeleteHyperlink(anOp) then
   DeleteHyperlink := true;
 end;//_DoChild

//#UC END# *47C690400067_48ECDC5E005D_var*
begin
//#UC START# *47C690400067_48ECDC5E005D_impl*
 Result := false;
 IterateF(evL2TSA(@_DoChild));
//#UC END# *47C690400067_48ECDC5E005D_impl*
end;//TevMultiSelectionDataFormatting.DeleteHyperlink

function TevMultiSelectionDataFormatting.DeleteSegments(const anOp: InevOp = nil): Boolean;
 {* удаляет сегменты. }
//#UC START# *47C6904C01B8_48ECDC5E005D_var*

 function _DoChild(const aBlock: InevRange; aBlockIndex: Integer): Boolean;
 var
  l_F : InevDataFormattingModify;
 begin//_DoChild
  Result := true;
  l_F := aBlock.Formatting.Modify(nil);
  if (l_F <> nil) AND l_F.DeleteSegments(anOp) then
   DeleteSegments := true;
 end;//_DoChild

//#UC END# *47C6904C01B8_48ECDC5E005D_var*
begin
//#UC START# *47C6904C01B8_48ECDC5E005D_impl*
 Result := false;
 IterateF(evL2TSA(@_DoChild));
//#UC END# *47C6904C01B8_48ECDC5E005D_impl*
end;//TevMultiSelectionDataFormatting.DeleteSegments

function TevMultiSelectionDataFormatting.AddIndentMarker(const aView: InevView;
 aValue: Integer;
 const anOpPack: InevOp = nil): Boolean;
//#UC START# *48DCAFCF0379_48ECDC5E005D_var*

 function _DoChild(const aBlock: InevRange; aBlockIndex: Integer): Boolean;
 var
  l_F : InevDataFormattingModify;
 begin//_DoChild
  Result := true;
  l_F := aBlock.Formatting.Modify(aView);
  if (l_F <> nil) AND l_F.AddIndentMarker(aView, aValue, anOpPack) then
   AddIndentMarker := true;
 end;//_DoChild

//#UC END# *48DCAFCF0379_48ECDC5E005D_var*
begin
//#UC START# *48DCAFCF0379_48ECDC5E005D_impl*
 Result := false;
 IterateF(evL2TSA(@_DoChild));
//#UC END# *48DCAFCF0379_48ECDC5E005D_impl*
end;//TevMultiSelectionDataFormatting.AddIndentMarker

function TevMultiSelectionDataFormatting.DeleteIndentMarker(const aView: InevView;
 const anOpPack: InevOp = nil): Boolean;
//#UC START# *48DCB01401C8_48ECDC5E005D_var*
  
 function _DoChild(const aBlock: InevRange; aBlockIndex: Integer): Boolean;
 var
  l_F : InevDataFormattingModify;
 begin//_DoChild
  Result := true;
  l_F := aBlock.Formatting.Modify(aView);
  if (l_F <> nil) AND l_F.DeleteIndentMarker(aView, anOpPack) then
   DeleteIndentMarker := true;
 end;//_DoChild

//#UC END# *48DCB01401C8_48ECDC5E005D_var*
begin
//#UC START# *48DCB01401C8_48ECDC5E005D_impl*
 Result := false;
 IterateF(evL2TSA(@_DoChild));
//#UC END# *48DCB01401C8_48ECDC5E005D_impl*
end;//TevMultiSelectionDataFormatting.DeleteIndentMarker

function TevMultiSelectionDataFormatting.GetFormatting: InevDataFormatting;
//#UC START# *48ECD26D01EC_48ECDC5E005D_var*
//#UC END# *48ECD26D01EC_48ECDC5E005D_var*
begin
//#UC START# *48ECD26D01EC_48ECDC5E005D_impl*
 Result := Self;
//#UC END# *48ECD26D01EC_48ECDC5E005D_impl*
end;//TevMultiSelectionDataFormatting.GetFormatting

end.
