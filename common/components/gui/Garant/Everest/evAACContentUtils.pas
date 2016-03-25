unit evAACContentUtils;
 {* [$602009846] }

// Модуль: "w:\common\components\gui\Garant\Everest\evAACContentUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evAACContentUtils" MUID: (55CB06D00354)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevBase
 , nevTools
;

const
 cnAACLeftBackColor = $C48B5C;
 cnAACContentsLeftIndent = 750;
 cnTopAACItem = nevInch div 16;
 cnAACSeparatorSpace = 1050;
 cnAACContentsRigthIndent = 450;
 cnAACRightBottomSpace = 1350;

function evIsAACItem(aSegment: Tl3Variant;
 aTextLen: Integer;
 aCheckInternal: Boolean): Boolean;
 {* Проверяет покрывает ли гиперссылка весь параграф. }
procedure evSelectAACHyperlink(const aView: InevControlView;
 aHyperlink: Tl3Variant;
 const aOwnerPara: InevObject;
 aCheckInternal: Boolean);
function evIsAACHyperlink(aPara: Tl3Variant;
 aCheckInternal: Boolean): Boolean;
function evAACNeedSpaceBefore(aPara: Tl3Variant): Boolean;
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , HyperLink_Const
 , evdStyles
 , evdTypes
 , k2Tags
 , evSegLst
 , evParaTools
;

function evIsAACItem(aSegment: Tl3Variant;
 aTextLen: Integer;
 aCheckInternal: Boolean): Boolean;
 {* Проверяет покрывает ли гиперссылка весь параграф. }
//#UC START# *502205C20239_55CB06D00354_var*
var
 l_Type : Integer;
 l_DocID: Integer;
//#UC END# *502205C20239_55CB06D00354_var*
begin
//#UC START# *502205C20239_55CB06D00354_impl*
 Result := aSegment.IsValid and
           (aSegment.IsKindOf(k2_typHyperLink) or (aSegment.IntA[k2_tiStyle] = ev_saHyperlink));
 if Result then
 begin
  Result := (aSegment.IntA[k2_tiStart] <= 1) and (aSegment.IntA[k2_tiFinish] >= aTextLen);
  if Result and aCheckInternal then
  begin
   with aSegment.Child[0] do
   begin
    l_Type := IntA[k2_tiType];
    l_DocID :=IntA[k2_tiDocID];
   end; // with aSegment.Child[0] do
   Result := (l_Type = CI_TOPIC) and (l_DocID = 0);
  end; // if Result then
 end; // if Result then
//#UC END# *502205C20239_55CB06D00354_impl*
end;//evIsAACItem

procedure evSelectAACHyperlink(const aView: InevControlView;
 aHyperlink: Tl3Variant;
 const aOwnerPara: InevObject;
 aCheckInternal: Boolean);
//#UC START# *5063E9CC0008_55CB06D00354_var*
var
 l_Start          : InevBasePoint;
 l_Block          : InevRange;
 l_Finish         : InevBasePoint;
 l_IsHyperlinkOnly: Boolean;
//#UC END# *5063E9CC0008_55CB06D00354_var*
begin
//#UC START# *5063E9CC0008_55CB06D00354_impl*
 if aHyperlink <> nil then
 begin
  l_IsHyperlinkOnly := EvIsAACHyperlink(aOwnerPara.AsObject, aCheckInternal);
  l_Start := aOwnerPara.MakePoint;
  l_Start.SetEntryPoint(aHyperlink.IntA[k2_tiStart] - 1);
  if l_IsHyperlinkOnly then
   l_Start.SetAtStart(aView, True);
  l_Finish := aOwnerPara.MakePoint;
  l_Finish.SetEntryPoint(aHyperlink.IntA[k2_tiFinish]);
  if l_IsHyperlinkOnly then
   l_Finish.SetAtEnd(aView, True);
  l_Block := aOwnerPara.Range(l_Start, l_Finish);
  aView.Control.Selection.Select(l_Block, False);
 end; // if aHyperlink <> nil then
//#UC END# *5063E9CC0008_55CB06D00354_impl*
end;//evSelectAACHyperlink

function evIsAACHyperlink(aPara: Tl3Variant;
 aCheckInternal: Boolean): Boolean;
//#UC START# *50223AB403B3_55CB06D00354_var*
var
 l_Pos      : Integer;
 l_Len      : Integer;
 l_Seg      : Tl3Variant;
 l_Segments : Tl3Variant;
//#UC END# *50223AB403B3_55CB06D00354_var*
begin
//#UC START# *50223AB403B3_55CB06D00354_impl*
 Result := False;
 l_Segments := aPara.Attr[k2_tiSegments];
 if l_Segments.IsValid then
 begin
  l_Len := aPara.PCharLenA[k2_tiText].SLen;
  l_Seg := evSegments_GetSegmentOnPos(l_Segments, ev_slHyperlinks, 1, l_Pos);
  Result := EvIsAACItem(l_Seg.AsObject, l_Len, aCheckInternal);
  if not Result then
  begin
   l_Seg := evSegments_GetSegmentOnPos(l_Segments, ev_slView, 1, l_Pos);
   Result := EvIsAACItem(l_Seg, l_Len, aCheckInternal);
  end;{Seg = nil}
 end; // if l_Segments.IsValid then
//#UC END# *50223AB403B3_55CB06D00354_impl*
end;//evIsAACHyperlink

function evAACNeedSpaceBefore(aPara: Tl3Variant): Boolean;
//#UC START# *55CB274E02B4_55CB06D00354_var*
var
 l_Para: InevPara;
//#UC END# *55CB274E02B4_55CB06D00354_var*
begin
//#UC START# *55CB274E02B4_55CB06D00354_impl*
 Result := aPara.PCharLenA[k2_tiText].SLen > 0;
 if Result then
 begin
  if not aPara.AsObject.QT(InevPara, l_Para) then
   Assert(false);
  Result := False;
  while (l_Para <> nil) and l_Para.IsValid do
  begin
   l_Para := evPrevOverallPara(l_Para);
   if (l_Para <> nil) and l_Para.IsValid then
    if not l_Para.IsEmpty then
     if EvIsAACHyperlink(l_Para.AsObject, True) then
     begin
      Result := True;
      Break;
     end // if not l_Para.IsEmpty and EvIsAACHyperlink(l_Para.AsObject, True) then
     else
      Break;
  end; // while (l_Para <> nil) and l_Para.IsValid do
 end; // if Result then
//#UC END# *55CB274E02B4_55CB06D00354_impl*
end;//evAACNeedSpaceBefore
{$IfEnd} // Defined(k2ForEditor)

end.
