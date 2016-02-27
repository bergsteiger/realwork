unit evHiddenFilter;

// ������: "w:\common\components\gui\Garant\Everest\evHiddenFilter.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , evdStyles
 , k2TagGen
 , l3Variant
 , k2Base
;

type
 TevHiddenFilter = class(TevdLeafParaFilter)
  private
   f_TreatCollapsedAsHidden: Boolean;
   f_HiddenStyles: TevStandardStyles;
    {* ���� ��� �������� HiddenStyles }
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* ���������� ����� �� ����������� ���������� ����� }
  public
   class function SetTo(aHiddenStyles: TevStandardStyles;
    aTreatCollapsedAsHidden: Boolean;
    var theGenerator: Tk2TagGenerator): Tk2TagGenerator;
   constructor Create(aHiddenStyles: TevStandardStyles;
    aTreatCollapsedAsHidden: Boolean); reintroduce;
   class function MakePrim(aHiddenStyles: TevStandardStyles;
    aTreatCollapsedAsHidden: Boolean): Ik2TagGenerator; reintroduce;
   class function Make(aHiddenStyles: TevStandardStyles;
    aTreatCollapsedAsHidden: Boolean): Ik2TagGenerator;
  public
   property HiddenStyles: TevStandardStyles
    read f_HiddenStyles
    write f_HiddenStyles;
 end;//TevHiddenFilter

implementation

uses
 l3ImplUses
 , StyledLeafPara_Const
 , TextPara_Const
 , nevTextParaRenderInfo
 , nevLeafRenderInfo
 , nevTools
 , SysUtils
 , evCommentsEliminator
 , nevFormatInfo
 , nevFormatInfoFactory
 , k2Tags
;

class function TevHiddenFilter.SetTo(aHiddenStyles: TevStandardStyles;
 aTreatCollapsedAsHidden: Boolean;
 var theGenerator: Tk2TagGenerator): Tk2TagGenerator;
//#UC START# *4D6CD4C70259_47ECBAA30322_var*
//#UC END# *4D6CD4C70259_47ECBAA30322_var*
begin
//#UC START# *4D6CD4C70259_47ECBAA30322_impl*
 if (aHiddenStyles = []) then
  // - �� ���� ������ �����������
 begin
  Result := theGenerator;
 end//aHiddenStyles = []
 else
 begin
  Result := inherited SetTo(theGenerator);
  (Result As TevHiddenFilter).HiddenStyles := aHiddenStyles;
  (Result As TevHiddenFilter).f_TreatCollapsedAsHidden := aTreatCollapsedAsHidden;
  if (-ev_saUserComment in aHiddenStyles) then
   Result := TevFullCommentsEliminator.SetTo(theGenerator);
 end;//aHiddenStyles = []
//#UC END# *4D6CD4C70259_47ECBAA30322_impl*
end;//TevHiddenFilter.SetTo

constructor TevHiddenFilter.Create(aHiddenStyles: TevStandardStyles;
 aTreatCollapsedAsHidden: Boolean);
//#UC START# *4D6CD5270101_47ECBAA30322_var*
//#UC END# *4D6CD5270101_47ECBAA30322_var*
begin
//#UC START# *4D6CD5270101_47ECBAA30322_impl*
 inherited Create;
 HiddenStyles := aHiddenStyles;
 f_TreatCollapsedAsHidden := aTreatCollapsedAsHidden;
//#UC END# *4D6CD5270101_47ECBAA30322_impl*
end;//TevHiddenFilter.Create

class function TevHiddenFilter.MakePrim(aHiddenStyles: TevStandardStyles;
 aTreatCollapsedAsHidden: Boolean): Ik2TagGenerator;
var
 l_Inst : TevHiddenFilter;
begin
 l_Inst := Create(aHiddenStyles, aTreatCollapsedAsHidden);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevHiddenFilter.MakePrim

class function TevHiddenFilter.Make(aHiddenStyles: TevStandardStyles;
 aTreatCollapsedAsHidden: Boolean): Ik2TagGenerator;
//#UC START# *4D6CDD9601FB_47ECBAA30322_var*
//#UC END# *4D6CDD9601FB_47ECBAA30322_var*
begin
//#UC START# *4D6CDD9601FB_47ECBAA30322_impl*
 Result := MakePrim(aHiddenStyles, aTreatCollapsedAsHidden);
 if (-ev_saUserComment in aHiddenStyles) then
  Result := TevFullCommentsEliminator.SetTo(Result);
//#UC END# *4D6CDD9601FB_47ECBAA30322_impl*
end;//TevHiddenFilter.Make

function TevHiddenFilter.ParaTypeForFiltering: Tk2Type;
 {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
//#UC START# *49E488070386_47ECBAA30322_var*
//#UC END# *49E488070386_47ECBAA30322_var*
begin
//#UC START# *49E488070386_47ECBAA30322_impl*
 Result := k2_typStyledLeafPara; 
//#UC END# *49E488070386_47ECBAA30322_impl*
end;//TevHiddenFilter.ParaTypeForFiltering

function TevHiddenFilter.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* ���������� ����� �� ����������� ���������� ����� }
//#UC START# *49E48829016F_47ECBAA30322_var*
var
 l_Para : InevPara;
 l_Map  : TnevFormatInfo;
//#UC END# *49E48829016F_47ECBAA30322_var*
begin
//#UC START# *49E48829016F_47ECBAA30322_impl*
 if aLeaf.QT(InevPara, l_Para) then
  try
   l_Map := TnevFormatInfoFactory.CreateFormatInfo(l_Para, nil, nil);
   // - ��� �������� ���������. ���� ������� �������� ����������� ���������� TnevFormatInfoPrim,
   //   ��� ������ ��� View � ��������������, � ������ ������� ������� _ViewSegments
   try
    l_Map.LimitWidth := High(Integer);
    Result := not l_Para.IsHiddenPrim(l_Map, HiddenStyles);
    if Result then
     if f_TreatCollapsedAsHidden then
      if l_Para.TreatCollapsedAsHidden then
       Result := not l_Para.AsObject.BoolA[k2_tiCollapsed];
   finally
    FreeAndNil(l_Map);
   end;//try..finally
  finally
   l_Para := nil;
  end//try..finally
 else
  Result := false; 
//#UC END# *49E48829016F_47ECBAA30322_impl*
end;//TevHiddenFilter.NeedWritePara

end.
