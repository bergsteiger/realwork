unit evParaListHotSpotTesterPrim;

// Модуль: "w:\common\components\gui\Garant\Everest\evParaListHotSpotTesterPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevParaListHotSpotTesterPrim" MUID: (4E6E373A03A3)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evHotSpot
 , nevGUIInterfaces
 , nevTools
 , l3Variant
 , nevBase
;

type
 _nevParaListTool_Parent_ = TevHotSpot;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}
 _evDecorHotSpotTester_Parent_ = _nevParaListTool_;
 {$Include w:\common\components\gui\Garant\Everest\evDecorHotSpotTester.imp.pas}
 TevParaListHotSpotTesterPrim = class(_evDecorHotSpotTester_, InevHotSpotTester2)
  protected
   function GetChildHotSpot(const aView: InevControlView;
    const aState: TevCursorState;
    const aPt: InevBasePoint;
    const aMap: InevMap;
    const aChild: InevObject;
    out theSpot: IevHotSpot): Boolean; virtual;
   function DoGetAdvancedHotSpot(const aView: InevControlView;
    const aState: TevCursorState;
    const aPt: InevBasePoint;
    const aMap: InevMap;
    out theSpot: IevHotSpot): Boolean; virtual;
   function GetAdvancedHotSpot(const aView: InevControlView;
    const aState: TevCursorState;
    const aPt: InevBasePoint;
    const aMap: InevMap;
    out theSpot: IevHotSpot): Boolean;
    {* Возвращает "горячую точку" }
  public
   constructor Create(aTag: Tl3Variant;
    const aProcessor: InevProcessor); reintroduce;
   class function Make(aTag: Tl3Variant;
    const aProcessor: InevProcessor): InevHotSpotTester2; reintroduce;
 end;//TevParaListHotSpotTesterPrim
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , evDecorHotSpot
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , SysUtils
;

type _Instance_R_ = TevParaListHotSpotTesterPrim;

{$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\evDecorHotSpotTester.imp.pas}

function TevParaListHotSpotTesterPrim.GetChildHotSpot(const aView: InevControlView;
 const aState: TevCursorState;
 const aPt: InevBasePoint;
 const aMap: InevMap;
 const aChild: InevObject;
 out theSpot: IevHotSpot): Boolean;
//#UC START# *4D6406EE0228_4E6E373A03A3_var*
var
 l_HotSpotTester : InevHotSpotTester2;
//#UC END# *4D6406EE0228_4E6E373A03A3_var*
begin
//#UC START# *4D6406EE0228_4E6E373A03A3_impl*
 if aChild.AsObject.QT(InevHotSpotTester2, l_HotSpotTester, Processor) then
  try
   Result := l_HotSpotTester.GetAdvancedHotSpot(aView,
                                                aState,
                                                aPt,
                                                aMap,
                                                theSpot);
  finally
   l_HotSpotTester := nil;
  end//try..finally
 else
  Result := false;
//#UC END# *4D6406EE0228_4E6E373A03A3_impl*
end;//TevParaListHotSpotTesterPrim.GetChildHotSpot

constructor TevParaListHotSpotTesterPrim.Create(aTag: Tl3Variant;
 const aProcessor: InevProcessor);
//#UC START# *4E6E4DA50023_4E6E373A03A3_var*
//#UC END# *4E6E4DA50023_4E6E373A03A3_var*
begin
//#UC START# *4E6E4DA50023_4E6E373A03A3_impl*
 inherited Create(aTag, aProcessor);
//#UC END# *4E6E4DA50023_4E6E373A03A3_impl*
end;//TevParaListHotSpotTesterPrim.Create

class function TevParaListHotSpotTesterPrim.Make(aTag: Tl3Variant;
 const aProcessor: InevProcessor): InevHotSpotTester2;
var
 l_Inst : TevParaListHotSpotTesterPrim;
begin
 l_Inst := Create(aTag, aProcessor);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevParaListHotSpotTesterPrim.Make

function TevParaListHotSpotTesterPrim.DoGetAdvancedHotSpot(const aView: InevControlView;
 const aState: TevCursorState;
 const aPt: InevBasePoint;
 const aMap: InevMap;
 out theSpot: IevHotSpot): Boolean;
//#UC START# *4E6E4F91001A_4E6E373A03A3_var*
var
 //l_AcceptDrop : Bool;
 l_IPt        : InevBasePoint;
 //l_List       : InevParaList;
//#UC END# *4E6E4F91001A_4E6E373A03A3_var*
begin
//#UC START# *4E6E4F91001A_4E6E373A03A3_impl*
 Result := false;
 l_IPt := aPt.Inner;
 if (l_IPt <> nil) then
  Result := GetChildHotSpot(aView,
                            aState,
                            l_IPt,
                            aMap.ReserveMap(l_IPt.Obj^),
                            l_IPt.Obj^,
                            theSpot);
//#UC END# *4E6E4F91001A_4E6E373A03A3_impl*
end;//TevParaListHotSpotTesterPrim.DoGetAdvancedHotSpot

function TevParaListHotSpotTesterPrim.GetAdvancedHotSpot(const aView: InevControlView;
 const aState: TevCursorState;
 const aPt: InevBasePoint;
 const aMap: InevMap;
 out theSpot: IevHotSpot): Boolean;
 {* Возвращает "горячую точку" }
//#UC START# *4A250DD6037C_4E6E373A03A3_var*

var
 l_Child : InevObject;

 function IsAfterHiddenChild : Boolean;
 var
  l_P : InevPara;
  l_Cnt : Integer;
 begin//IsAfterHiddenChild
  Result := false;
  if (l_Child.PID = 1) then
   if l_Child.AsObject.QT(InevPara, l_P) then
   begin
    l_Cnt := 10;
    // http://mdp.garant.ru/pages/viewpage.action?pageId=288000491
    while not Result AND (l_Cnt > 0) do
    begin
     l_P := EvPrevOverallPara(l_P);
     if (l_P <> nil) AND l_P.AsObject.IsValid then
     begin
      if aView.FormatInfoByPara(l_P).IsHidden(true, true) then
       Result := true
      else
       //break
       // - почему не break - что-то не понимаю
       ;
     end//l_P <> nil
     else
      break;
     Dec(l_Cnt); 
    end;//while true
   end;//l_Child.QT(InevPara, l_P)
 end;//IsAfterHiddenChild

var
 l_IPt : InevBasePoint;
 l_M   : TnevRect;
 l_Y   : Integer;
//#UC END# *4A250DD6037C_4E6E373A03A3_var*
begin
//#UC START# *4A250DD6037C_4E6E373A03A3_impl*
 l_IPt := aPt.Inner;
 if (l_IPt <> nil) then
 begin
  l_Child := l_IPt.Obj^;
  if l_Child.AsObject.IsValid then
  begin
   if not EvExpandedText(ParaX.AsObject) and aMap.FI.DecorObj(nev_dtHeader).IsValid then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=288000491
   begin
    l_M := aMap.FI.Spacing;
    l_Y := aState.rPoint.Y - aMap.Bounds.Top;
    if (l_Child.PID = 0) OR
       IsAfterHiddenChild
       // - заточка для скрытых параграфов
       then
     if (l_M.Top > 0) AND
        (l_Y < l_M.Top) then
      if GetDecorHotSpot(nev_dtHeader, aView, aState, aMap, theSpot) then
      begin
       Result := true;
       theSpot := TevDecorHotSpot.Make(ParaX, theSpot);
       Exit;
      end;//GetDecorHotSpot
    end;//aMap.FI.DecorObj(nev_dtHeader).IsValid
  end;//l_Child.IsValid
 end;//l_IPt <> nil
 Result := DoGetAdvancedHotSpot(aView, aState, aPt, aMap, theSpot);
//#UC END# *4A250DD6037C_4E6E373A03A3_impl*
end;//TevParaListHotSpotTesterPrim.GetAdvancedHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

end.
