unit evHiddenFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evHiddenFilter.pas"
// Начат: 10.12.2004 17:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevHiddenFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdStyles,
  k2TagGen,
  evdLeafParaFilter,
  l3Variant,
  l3Interfaces,
  Classes,
  k2Base
  ;

type
 TevHiddenFilter = class(TevdLeafParaFilter)
 private
 // private fields
   f_TreatCollapsedAsHidden : Boolean;
   f_HiddenStyles : TevStandardStyles;
    {* Поле для свойства HiddenStyles}
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
     {* Определяет нужно ли фильтровать переданный абзац }
 public
 // public methods
   class function SetTo(aHiddenStyles: TevStandardStyles;
     aTreatCollapsedAsHidden: Boolean;
     var theGenerator: Tk2TagGenerator): Tk2TagGenerator;
   constructor Create(aHiddenStyles: TevStandardStyles;
     aTreatCollapsedAsHidden: Boolean); reintroduce;
   class function MakePrim(aHiddenStyles: TevStandardStyles;
     aTreatCollapsedAsHidden: Boolean): Ik2TagGenerator; reintroduce;
     {* Сигнатура фабрики TevHiddenFilter.MakePrim }
   class function Make(aHiddenStyles: TevStandardStyles;
     aTreatCollapsedAsHidden: Boolean): Ik2TagGenerator;
 public
 // public properties
   property HiddenStyles: TevStandardStyles
     read f_HiddenStyles
     write f_HiddenStyles;
 end;//TevHiddenFilter

implementation

uses
  StyledLeafPara_Const,
  TextPara_Const,
  nevTextParaRenderInfo,
  nevLeafRenderInfo,
  nevTools,
  SysUtils,
  evCommentsEliminator,
  nevFormatInfo,
  nevFormatInfoFactory,
  k2Tags
  ;

// start class TevHiddenFilter

class function TevHiddenFilter.SetTo(aHiddenStyles: TevStandardStyles;
  aTreatCollapsedAsHidden: Boolean;
  var theGenerator: Tk2TagGenerator): Tk2TagGenerator;
//#UC START# *4D6CD4C70259_47ECBAA30322_var*
//#UC END# *4D6CD4C70259_47ECBAA30322_var*
begin
//#UC START# *4D6CD4C70259_47ECBAA30322_impl*
 if (aHiddenStyles = []) then
  // - не надо ничего фильтровать
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
end;

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
//#UC START# *49E488070386_47ECBAA30322_var*
//#UC END# *49E488070386_47ECBAA30322_var*
begin
//#UC START# *49E488070386_47ECBAA30322_impl*
 Result := k2_typStyledLeafPara; 
//#UC END# *49E488070386_47ECBAA30322_impl*
end;//TevHiddenFilter.ParaTypeForFiltering

function TevHiddenFilter.NeedWritePara(aLeaf: Tl3Variant): Boolean;
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
   // - ЭТО ОГРОМНЫЙ НАПИЛЬНИК. НАДО КОНЕЧНО ВЫДЕЛЯТЬ СОБСТВЕННУЮ РЕАЛИЗАЦИЮ TnevFormatInfoPrim,
   //   без знания про View и форматирование, а только умеющую строить _ViewSegments
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