unit evHAFPainterEx;

// Модуль: "w:\common\components\gui\Garant\Everest\evHAFPainterEx.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evTypes
 , l3Interfaces
 , evHAFPainter
 , afwInterfaces
 , l3InternalInterfaces
 , l3Variant
;

type
 TevColontituls = array [TevPageColontituls] of Il3CString;

 TevReadColontitulsEvent = procedure(var theColontituls: TevColontituls) of object;

 _afwSettingChanged_Parent_ = TevHAFPainter;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas}
 _afwSettingsReplace_Parent_ = _afwSettingChanged_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}
 TevHAFPainterEx = class(_afwSettingsReplace_)
  protected
   f_Colontituls: TevColontituls;
  protected
   function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean; virtual;
   function GetAppTitle: AnsiString; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoSettingChanged(const aSettingId: TafwSettingId): Boolean; override;
    {* Обработчик изменения указанной настройки }
   procedure SettingsReplaceFinish; override;
   function DoNeedPagesCount: Boolean; override;
  public
   procedure ReadColontitulSettings; virtual;
   procedure TuneHeader(const aCanvas: Il3Canvas;
    aHeader: Tl3Variant;
    aTop: Boolean); override;
   constructor Create(const aMacroReplacer: Il3HAFMacroReplacer); override;
 end;//TevHAFPainterEx

var g_OnReadColontituls: TevReadColontitulsEvent;

implementation

uses
 l3ImplUses
 , l3String
 , evHAFPainterMacros
 , k2Tags
 {$If Defined(k2ForEditor)}
 , evSBSPar
 {$IfEnd} // Defined(k2ForEditor)
 , l3Const
 , evdStyles
 , nevInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3Base
 , afwFacade
 , afwSettingsChangePublisher
;

{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}

function TevHAFPainterEx.IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
//#UC START# *5243E95503E4_47F352A30004_var*
//#UC END# *5243E95503E4_47F352A30004_var*
begin
//#UC START# *5243E95503E4_47F352A30004_impl*
 Result := False;
//#UC END# *5243E95503E4_47F352A30004_impl*
end;//TevHAFPainterEx.IsSettingAffectsUs

procedure TevHAFPainterEx.ReadColontitulSettings;
//#UC START# *5243E9AE0230_47F352A30004_var*
//#UC END# *5243E9AE0230_47F352A30004_var*
begin
//#UC START# *5243E9AE0230_47F352A30004_impl*
 f_Colontituls[pcUpLeftFirst] := l3CStr(SAppTitle);
 f_Colontituls[pcUpLeft] := l3CStr(SAppTitle);
 f_Colontituls[pcUpRightFirst] := l3Fmt(str_nevpmDefaultColontitul.AsCStr, [SDocName, SDocPagesCount, SCurrentDate]);
 f_Colontituls[pcUpRight] := l3Fmt('%s/%s', [SDocCurrentPage, SDocPagesCount]);
 if Assigned(g_OnReadColontituls) then
  g_OnReadColontituls(f_Colontituls);
//#UC END# *5243E9AE0230_47F352A30004_impl*
end;//TevHAFPainterEx.ReadColontitulSettings

function TevHAFPainterEx.GetAppTitle: AnsiString;
//#UC START# *53EDC0B8024A_47F352A30004_var*
//#UC END# *53EDC0B8024A_47F352A30004_var*
begin
//#UC START# *53EDC0B8024A_47F352A30004_impl*
 Result := Application.Title;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=562594453
//#UC END# *53EDC0B8024A_47F352A30004_impl*
end;//TevHAFPainterEx.GetAppTitle

procedure TevHAFPainterEx.TuneHeader(const aCanvas: Il3Canvas;
 aHeader: Tl3Variant;
 aTop: Boolean);
//#UC START# *5243CD850286_47F352A30004_var*
 procedure TuneColontitul(const aCanvas: Il3Canvas; aPara: Tl3Variant; const aFormat: Il3CString; aLeft: Boolean);
 const
  RF = [rfReplaceAll];
 var
  l_String : Il3CString;
  l_Canvas : IafwPreviewCanvas;
 begin//TuneColontitul
  if l3IsNil(aFormat) then
   Exit;
//
  if (PagesCount = 0) AND Supports(aCanvas, IafwPreviewCanvas, l_Canvas) AND
     not l_Canvas.IsPagesCounter then
   try
    PagesCount := l_Canvas.PagesInfo.rPagesCount;
   finally
    l_Canvas := nil;
   end;//try..finally
  if MacroReplacer <> nil then
   l_String := MacroReplacer.Replace(aFormat)
  else
   l_String := aFormat;
  l_String := l3StringReplace(l_String, l3PCharLen(SAppTitle), l3PCharLen(GetAppTitle), RF);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=562594453
  l_String := l3StringReplace(l_String, l3PCharLen(SDocCurrentPage), MacroDocCurrentPage(aCanvas), RF);
  l_String := l3StringReplace(l_String, l3PCharLen(SDocPagesCount), MacroDocPagesCount, RF);
  l_String := l3StringReplace(l_String, l3PCharLen(SCurrentDate), l3PCharLen(DateToStr(Date)), RF);
  l_String := l3StringReplace(l_String, l3PCharLen(SCurrentTime), l3PCharLen(TimeToStr(Time)), RF);
//
  l3DeleteChars(l_String, [#$D]);
  if aLeft then
   aPara.IntA[k2_tiStyle] := ev_saHFLeft
  else
   aPara.IntA[k2_tiStyle] := ev_saHFRight;
  aPara.PCharLenA[k2_tiText] := l3PCharLen(l_String);
 end;//TuneColontitul

var
 l_UpLeft: Il3CString;
 l_UpRight: Il3CString;
 l_DownLeft: Il3CString;
 l_DownRight: Il3CString;
//#UC END# *5243CD850286_47F352A30004_var*
begin
//#UC START# *5243CD850286_47F352A30004_impl*
 if (aCanvas.PageNumber = 1) then
 begin
  l_UpLeft := f_Colontituls[pcUpLeftFirst];
  l_UpRight := f_Colontituls[pcUpRightFirst];
  l_DownLeft := f_Colontituls[pcDownLeftFirst];
  l_DownRight := f_Colontituls[pcDownRightFirst];
 end//aCanvas.PageNumber = 1
 else
 begin
  l_UpLeft := f_Colontituls[pcUpLeft];
  l_UpRight := f_Colontituls[pcUpRight];
  l_DownLeft := f_Colontituls[pcDownLeft];
  l_DownRight := f_Colontituls[pcDownRight];
 end;//aCanvas.PageNumber = 1
 if aTop then
 begin
  TuneColontitul(aCanvas, evSBS_LeftPara(aHeader), l_UpLeft, True);
  TuneColontitul(aCanvas, evSBS_RightPara(aHeader), l_UpRight, False);
 end//aTop
 else
 begin
  TuneColontitul(aCanvas, evSBS_LeftPara(aHeader), l_DownLeft, True);
  TuneColontitul(aCanvas, evSBS_RightPara(aHeader), l_DownRight, False);
 end;//aTop
// TuneColontitul(aCanvas, , l_DownLeft);
// TuneColontitul(aCanvas, , l_DownRight);
//#UC END# *5243CD850286_47F352A30004_impl*
end;//TevHAFPainterEx.TuneHeader

procedure TevHAFPainterEx.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47F352A30004_var*
var
 I: TevPageColontituls;
//#UC END# *479731C50290_47F352A30004_var*
begin
//#UC START# *479731C50290_47F352A30004_impl*
 for I := Low(f_Colontituls) to High(f_Colontituls) do
  f_Colontituls[I] := nil;
 inherited;
//#UC END# *479731C50290_47F352A30004_impl*
end;//TevHAFPainterEx.Cleanup

function TevHAFPainterEx.DoSettingChanged(const aSettingId: TafwSettingId): Boolean;
 {* Обработчик изменения указанной настройки }
//#UC START# *47EA863A035C_47F352A30004_var*
//#UC END# *47EA863A035C_47F352A30004_var*
begin
//#UC START# *47EA863A035C_47F352A30004_impl*
 Result := IsSettingAffectsUs(aSettingID);
 if Result then
  ReadColontitulSettings;
//#UC END# *47EA863A035C_47F352A30004_impl*
end;//TevHAFPainterEx.DoSettingChanged

procedure TevHAFPainterEx.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_47F352A30004_var*
//#UC END# *47EA8B9601FE_47F352A30004_var*
begin
//#UC START# *47EA8B9601FE_47F352A30004_impl*
 ReadColontitulSettings;
//#UC END# *47EA8B9601FE_47F352A30004_impl*
end;//TevHAFPainterEx.SettingsReplaceFinish

constructor TevHAFPainterEx.Create(const aMacroReplacer: Il3HAFMacroReplacer);
//#UC START# *5243CCEE0271_47F352A30004_var*
//#UC END# *5243CCEE0271_47F352A30004_var*
begin
//#UC START# *5243CCEE0271_47F352A30004_impl*
 inherited;
 ReadColontitulSettings;
//#UC END# *5243CCEE0271_47F352A30004_impl*
end;//TevHAFPainterEx.Create

function TevHAFPainterEx.DoNeedPagesCount: Boolean;
//#UC START# *5243DA2102ED_47F352A30004_var*
var
 l_Index: TevPageColontituls;
//#UC END# *5243DA2102ED_47F352A30004_var*
begin
//#UC START# *5243DA2102ED_47F352A30004_impl*
 Result := inherited DoNeedPagesCount;
 l_Index := Low(TevPageColontituls);
 if not Result then
  while True do
  begin
   if (l3Pos(f_Colontituls[l_Index], SDocPagesCount) <> l3NotFound) then
   begin
    Result := True;
    Break;
   end;//l3Pos(f_Colontituls[l_Index], SDocPagesCount) <> l3NotFound
   if (l_Index = High(TevPageColontituls)) then
    Break;
   Inc(l_Index);
  end;//while True
//#UC END# *5243DA2102ED_47F352A30004_impl*
end;//TevHAFPainterEx.DoNeedPagesCount

end.
