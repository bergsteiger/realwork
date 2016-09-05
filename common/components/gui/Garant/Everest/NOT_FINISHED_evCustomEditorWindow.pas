unit NOT_FINISHED_evCustomEditorWindow;
 {* Реализация базового оконного элемента для отображения содержимого документа }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evCustomEditorWindow.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TevCustomEditorWindow" MUID: (4829D92A037B)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomEditorWindowPrim
 , evCustomTextSource
 , nevTools
 , nevBase
 , l3Interfaces
 , Messages
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nevGUIInterfaces
 , afwInterfaces
 , Windows
 , evExcept
 , evEditorWindowHotSpot
 , nevSelection
 , afwNavigation
 , evEditorInterfaces
 , evCustomFont
;

type
 RevEditorWindowHotSpot = class of TevEditorWindowHotSpot;

 RevSelection = class of TnevSelection;

 TevJumpToEvent = function(Sender: TObject;
  anEffects: TafwJumpToEffects;
  const aMoniker: IevMoniker): Boolean;

 TevParaChangeEvent = procedure(Sender: TObject;
  const aTextPara: IedTextParagraph) of object;
  {* нотификация об изменении текущего параграфа }

 TevGetHotspotInfo = procedure(Sender: TObject;
  const aHotSpot: IevHotSpot;
  const aKeys: TafwCursorState;
  var theInfo: TafwCursorInfo) of object;

 IevEditorWindowFont = class(TevCustomFont)
 end;//IevEditorWindowFont

 TevCustomEditorWindow = class(TevCustomEditorWindowPrim)
  {* Реализация базового оконного элемента для отображения содержимого документа }
  private
   procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
   procedure WMPaint(var Msg: TWMPaint); message WM_Paint;
   procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
   procedure WMChar(var Msg: TWMChar); message WM_CHAR;
   procedure WMKeyDown(var Msg: TWMKeyDown); message CN_KEYDOWN;
  protected
   function pm_GetPlainText: Boolean; virtual;
   procedure pm_SetPlainText(aValue: Boolean); virtual;
   function pm_GetTextSource: TevCustomTextSource; virtual;
   procedure pm_SetTextSource(aValue: TevCustomTextSource); virtual;
   function IsReadOnly: Boolean; virtual;
   {$If NOT Defined(NoVCM)}
   function IvcmState_LoadState(const aState: IUnknown;
    aStateType: TvcmStateType;
    aClone: Boolean): Boolean; virtual;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function IvcmState_SaveState(out aState: IUnknown;
    aStateType: TvcmStateType): Boolean; virtual;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoHitTest(const aHotSpot: IevHotSpot;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo); virtual;
   function CheckMouseUp(const aHotSpot: IevHotSpot;
    const aState: TevMouseState): Boolean; virtual;
   procedure ScrollInfoChange(aVert: Boolean;
    const aScrollInfo: TScrollInfo;
    aPosChanged: Boolean); virtual;
   function DoBreakPara(aDrawLines: Boolean;
    const anOp: InevOp): Boolean; overload; virtual;
   function HandledReadOnly(E: EevReadOnly): Boolean; virtual;
   function VScrollWidth(const anIC: Il3InfoCanvas): Integer; virtual;
   function DoDrawDocument(const aCanvas: Il3Canvas;
    out aMap: InevMap): Boolean; virtual;
   procedure ParaChange; virtual;
    {* текущий параграф изменился. }
   procedure BlockChange; virtual;
    {* изменилось выделение. }
   procedure SetEditRect; virtual;
   procedure DoScrollEvent; overload; virtual;
   procedure MakeCursor; virtual;
   function ReplaceConfirm(const aBlock: InevRange;
    AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt; virtual;
   procedure MakeTextSource(out theTextSource: TevCustomTextSource); virtual;
   function AllowDrawDocumentEdge: Boolean; virtual;
   procedure AfterOperation; virtual;
   function IsVScrollBarVisible: Boolean; virtual;
    {* проверяет видимость вертикального скроллбара. }
   function GetPaintSelection: InevRange; virtual;
   procedure DoCursorInSelectionChange; virtual;
    {* изменилось свойство CursorInSelection. }
   procedure DoFontChange(const Font: Il3Font); virtual;
   procedure DoBeforeRMouseClick; virtual;
   function RightIndentMul: Integer; virtual;
   function WantEnter: Boolean; virtual;
   function WantTab(aKeyPressed: Boolean = False): Boolean; virtual;
   function DoBreakPara(aDrawLines: Boolean;
    const anOp: InevOp): Boolean; overload; virtual;
   procedure TextChange; virtual;
    {* вызывается при смене текста. }
   function GetHorzDelta: Integer; virtual;
    {* зазор, после которого начинается скроллирование вправо. }
   procedure SetTextColor(const aCanvas: Il3Canvas); virtual;
   function GetTopMargin: Integer; virtual;
    {* Возвращает отступ до текста сверху. }
   function ProcessHotSpots: Boolean; virtual;
    {* Обрабатывать ли "горячие точки" на предмет показа Hint'а и мышиного курсора или вызывать поведение по-умолчанию. [$100958718] }
   function GetInfoCanvas: InevInfoCanvas; virtual;
   function ProcessCommandEx(Cmd: Integer;
    aForce: Boolean;
    aSubCmd: Cardinal;
    aCount: Integer): Boolean; virtual;
    {* process the specified command, return true if processed }
   function SelectionClass: RevSelection; virtual;
   function HotSpotClass: RevEditorWindowHotSpot; virtual;
   procedure DoScrollEvent; overload; virtual;
   function SelectWhenUnfocused: Boolean; virtual;
   procedure DoUnselectAfterInsertData; virtual;
   function GetLimitWidth: Integer; override;
   procedure DoCursorChanged; override;
   procedure WebStyleChanged; override;
   procedure DoAfterSetZoom; override;
  public
   function Tabulate: Boolean; virtual;
    {* эквивалетно нажатию Tab. }
   function Untabulate: Boolean; virtual;
    {* эквивалетно нажатию Shift-Tab. }
   function CloseQuery: Boolean; virtual;
   function MakeExportFilters(aSelection: Boolean;
    aForExport: Boolean): InevTagGenerator; virtual;
  public
   property PlainText: Boolean
    read pm_GetPlainText
    write pm_SetPlainText;
   property TextSource: TevCustomTextSource
    read pm_GetTextSource
    write pm_SetTextSource;
 end;//TevCustomEditorWindow

implementation

uses
 l3ImplUses
 , nevView
 , l3ProcessMessagesManager
 {$If NOT Defined(NoScripts)}
 , EditorFromStackKeyWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4829D92A037Bimpl_uses*
 //#UC END# *4829D92A037Bimpl_uses*
;

function TevCustomEditorWindow.pm_GetPlainText: Boolean;
//#UC START# *484515B3012E_4829D92A037Bget_var*
//#UC END# *484515B3012E_4829D92A037Bget_var*
begin
//#UC START# *484515B3012E_4829D92A037Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *484515B3012E_4829D92A037Bget_impl*
end;//TevCustomEditorWindow.pm_GetPlainText

procedure TevCustomEditorWindow.pm_SetPlainText(aValue: Boolean);
//#UC START# *484515B3012E_4829D92A037Bset_var*
//#UC END# *484515B3012E_4829D92A037Bset_var*
begin
//#UC START# *484515B3012E_4829D92A037Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *484515B3012E_4829D92A037Bset_impl*
end;//TevCustomEditorWindow.pm_SetPlainText

function TevCustomEditorWindow.pm_GetTextSource: TevCustomTextSource;
//#UC START# *54C0FC1000D3_4829D92A037Bget_var*
//#UC END# *54C0FC1000D3_4829D92A037Bget_var*
begin
//#UC START# *54C0FC1000D3_4829D92A037Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C0FC1000D3_4829D92A037Bget_impl*
end;//TevCustomEditorWindow.pm_GetTextSource

procedure TevCustomEditorWindow.pm_SetTextSource(aValue: TevCustomTextSource);
//#UC START# *54C0FC1000D3_4829D92A037Bset_var*
//#UC END# *54C0FC1000D3_4829D92A037Bset_var*
begin
//#UC START# *54C0FC1000D3_4829D92A037Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C0FC1000D3_4829D92A037Bset_impl*
end;//TevCustomEditorWindow.pm_SetTextSource

function TevCustomEditorWindow.IsReadOnly: Boolean;
//#UC START# *53F34C2A025E_4829D92A037B_var*
//#UC END# *53F34C2A025E_4829D92A037B_var*
begin
//#UC START# *53F34C2A025E_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *53F34C2A025E_4829D92A037B_impl*
end;//TevCustomEditorWindow.IsReadOnly

{$If NOT Defined(NoVCM)}
function TevCustomEditorWindow.IvcmState_LoadState(const aState: IUnknown;
 aStateType: TvcmStateType;
 aClone: Boolean): Boolean;
//#UC START# *54084F6B01FD_4829D92A037B_var*
//#UC END# *54084F6B01FD_4829D92A037B_var*
begin
//#UC START# *54084F6B01FD_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *54084F6B01FD_4829D92A037B_impl*
end;//TevCustomEditorWindow.IvcmState_LoadState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TevCustomEditorWindow.IvcmState_SaveState(out aState: IUnknown;
 aStateType: TvcmStateType): Boolean;
//#UC START# *54084FBC0018_4829D92A037B_var*
//#UC END# *54084FBC0018_4829D92A037B_var*
begin
//#UC START# *54084FBC0018_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *54084FBC0018_4829D92A037B_impl*
end;//TevCustomEditorWindow.IvcmState_SaveState
{$IfEnd} // NOT Defined(NoVCM)

procedure TevCustomEditorWindow.DoHitTest(const aHotSpot: IevHotSpot;
 const aState: TafwCursorState;
 var theInfo: TafwCursorInfo);
//#UC START# *54C0FCF701F6_4829D92A037B_var*
//#UC END# *54C0FCF701F6_4829D92A037B_var*
begin
//#UC START# *54C0FCF701F6_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C0FCF701F6_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoHitTest

function TevCustomEditorWindow.CheckMouseUp(const aHotSpot: IevHotSpot;
 const aState: TevMouseState): Boolean;
//#UC START# *54C1012501EA_4829D92A037B_var*
//#UC END# *54C1012501EA_4829D92A037B_var*
begin
//#UC START# *54C1012501EA_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C1012501EA_4829D92A037B_impl*
end;//TevCustomEditorWindow.CheckMouseUp

procedure TevCustomEditorWindow.ScrollInfoChange(aVert: Boolean;
 const aScrollInfo: TScrollInfo;
 aPosChanged: Boolean);
//#UC START# *54C101DD01C5_4829D92A037B_var*
//#UC END# *54C101DD01C5_4829D92A037B_var*
begin
//#UC START# *54C101DD01C5_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C101DD01C5_4829D92A037B_impl*
end;//TevCustomEditorWindow.ScrollInfoChange

function TevCustomEditorWindow.DoBreakPara(aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *54C1028A038A_4829D92A037B_var*
//#UC END# *54C1028A038A_4829D92A037B_var*
begin
//#UC START# *54C1028A038A_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C1028A038A_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoBreakPara

function TevCustomEditorWindow.HandledReadOnly(E: EevReadOnly): Boolean;
//#UC START# *54C1033D03DF_4829D92A037B_var*
//#UC END# *54C1033D03DF_4829D92A037B_var*
begin
//#UC START# *54C1033D03DF_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C1033D03DF_4829D92A037B_impl*
end;//TevCustomEditorWindow.HandledReadOnly

function TevCustomEditorWindow.VScrollWidth(const anIC: Il3InfoCanvas): Integer;
//#UC START# *54C108A40224_4829D92A037B_var*
//#UC END# *54C108A40224_4829D92A037B_var*
begin
//#UC START# *54C108A40224_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C108A40224_4829D92A037B_impl*
end;//TevCustomEditorWindow.VScrollWidth

function TevCustomEditorWindow.DoDrawDocument(const aCanvas: Il3Canvas;
 out aMap: InevMap): Boolean;
//#UC START# *5538F4D60240_4829D92A037B_var*
//#UC END# *5538F4D60240_4829D92A037B_var*
begin
//#UC START# *5538F4D60240_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5538F4D60240_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoDrawDocument

procedure TevCustomEditorWindow.ParaChange;
 {* текущий параграф изменился. }
//#UC START# *482BFA340236_4829D92A037B_var*
//#UC END# *482BFA340236_4829D92A037B_var*
begin
//#UC START# *482BFA340236_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFA340236_4829D92A037B_impl*
end;//TevCustomEditorWindow.ParaChange

procedure TevCustomEditorWindow.BlockChange;
 {* изменилось выделение. }
//#UC START# *482BFA5C0286_4829D92A037B_var*
//#UC END# *482BFA5C0286_4829D92A037B_var*
begin
//#UC START# *482BFA5C0286_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFA5C0286_4829D92A037B_impl*
end;//TevCustomEditorWindow.BlockChange

procedure TevCustomEditorWindow.SetEditRect;
//#UC START# *482BFA6D022D_4829D92A037B_var*
//#UC END# *482BFA6D022D_4829D92A037B_var*
begin
//#UC START# *482BFA6D022D_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFA6D022D_4829D92A037B_impl*
end;//TevCustomEditorWindow.SetEditRect

procedure TevCustomEditorWindow.DoScrollEvent;
//#UC START# *482BFA79031D_4829D92A037B_var*
//#UC END# *482BFA79031D_4829D92A037B_var*
begin
//#UC START# *482BFA79031D_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFA79031D_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoScrollEvent

procedure TevCustomEditorWindow.MakeCursor;
//#UC START# *482BFA9401ED_4829D92A037B_var*
//#UC END# *482BFA9401ED_4829D92A037B_var*
begin
//#UC START# *482BFA9401ED_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFA9401ED_4829D92A037B_impl*
end;//TevCustomEditorWindow.MakeCursor

function TevCustomEditorWindow.ReplaceConfirm(const aBlock: InevRange;
 AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
//#UC START# *482BFAD20173_4829D92A037B_var*
//#UC END# *482BFAD20173_4829D92A037B_var*
begin
//#UC START# *482BFAD20173_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFAD20173_4829D92A037B_impl*
end;//TevCustomEditorWindow.ReplaceConfirm

procedure TevCustomEditorWindow.MakeTextSource(out theTextSource: TevCustomTextSource);
//#UC START# *482BFB0A00E0_4829D92A037B_var*
//#UC END# *482BFB0A00E0_4829D92A037B_var*
begin
//#UC START# *482BFB0A00E0_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFB0A00E0_4829D92A037B_impl*
end;//TevCustomEditorWindow.MakeTextSource

function TevCustomEditorWindow.AllowDrawDocumentEdge: Boolean;
//#UC START# *482BFBEE00D5_4829D92A037B_var*
//#UC END# *482BFBEE00D5_4829D92A037B_var*
begin
//#UC START# *482BFBEE00D5_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFBEE00D5_4829D92A037B_impl*
end;//TevCustomEditorWindow.AllowDrawDocumentEdge

procedure TevCustomEditorWindow.AfterOperation;
//#UC START# *482BFC030100_4829D92A037B_var*
//#UC END# *482BFC030100_4829D92A037B_var*
begin
//#UC START# *482BFC030100_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFC030100_4829D92A037B_impl*
end;//TevCustomEditorWindow.AfterOperation

function TevCustomEditorWindow.IsVScrollBarVisible: Boolean;
 {* проверяет видимость вертикального скроллбара. }
//#UC START# *482BFC0E0175_4829D92A037B_var*
//#UC END# *482BFC0E0175_4829D92A037B_var*
begin
//#UC START# *482BFC0E0175_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFC0E0175_4829D92A037B_impl*
end;//TevCustomEditorWindow.IsVScrollBarVisible

function TevCustomEditorWindow.GetPaintSelection: InevRange;
//#UC START# *482BFC2E0363_4829D92A037B_var*
//#UC END# *482BFC2E0363_4829D92A037B_var*
begin
//#UC START# *482BFC2E0363_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFC2E0363_4829D92A037B_impl*
end;//TevCustomEditorWindow.GetPaintSelection

procedure TevCustomEditorWindow.DoCursorInSelectionChange;
 {* изменилось свойство CursorInSelection. }
//#UC START# *482BFC4200D0_4829D92A037B_var*
//#UC END# *482BFC4200D0_4829D92A037B_var*
begin
//#UC START# *482BFC4200D0_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFC4200D0_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoCursorInSelectionChange

procedure TevCustomEditorWindow.DoFontChange(const Font: Il3Font);
//#UC START# *482BFC540231_4829D92A037B_var*
//#UC END# *482BFC540231_4829D92A037B_var*
begin
//#UC START# *482BFC540231_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFC540231_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoFontChange

procedure TevCustomEditorWindow.DoBeforeRMouseClick;
//#UC START# *482BFC8100F4_4829D92A037B_var*
//#UC END# *482BFC8100F4_4829D92A037B_var*
begin
//#UC START# *482BFC8100F4_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFC8100F4_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoBeforeRMouseClick

function TevCustomEditorWindow.RightIndentMul: Integer;
//#UC START# *482BFC8E036F_4829D92A037B_var*
//#UC END# *482BFC8E036F_4829D92A037B_var*
begin
//#UC START# *482BFC8E036F_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFC8E036F_4829D92A037B_impl*
end;//TevCustomEditorWindow.RightIndentMul

function TevCustomEditorWindow.WantEnter: Boolean;
//#UC START# *482BFCA000E4_4829D92A037B_var*
//#UC END# *482BFCA000E4_4829D92A037B_var*
begin
//#UC START# *482BFCA000E4_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFCA000E4_4829D92A037B_impl*
end;//TevCustomEditorWindow.WantEnter

function TevCustomEditorWindow.WantTab(aKeyPressed: Boolean = False): Boolean;
//#UC START# *482BFCAE0072_4829D92A037B_var*
//#UC END# *482BFCAE0072_4829D92A037B_var*
begin
//#UC START# *482BFCAE0072_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFCAE0072_4829D92A037B_impl*
end;//TevCustomEditorWindow.WantTab

function TevCustomEditorWindow.DoBreakPara(aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *482BFCBF01F0_4829D92A037B_var*
//#UC END# *482BFCBF01F0_4829D92A037B_var*
begin
//#UC START# *482BFCBF01F0_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFCBF01F0_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoBreakPara

function TevCustomEditorWindow.Tabulate: Boolean;
 {* эквивалетно нажатию Tab. }
//#UC START# *482BFD1802D3_4829D92A037B_var*
//#UC END# *482BFD1802D3_4829D92A037B_var*
begin
//#UC START# *482BFD1802D3_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFD1802D3_4829D92A037B_impl*
end;//TevCustomEditorWindow.Tabulate

function TevCustomEditorWindow.Untabulate: Boolean;
 {* эквивалетно нажатию Shift-Tab. }
//#UC START# *482BFD2C0107_4829D92A037B_var*
//#UC END# *482BFD2C0107_4829D92A037B_var*
begin
//#UC START# *482BFD2C0107_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFD2C0107_4829D92A037B_impl*
end;//TevCustomEditorWindow.Untabulate

function TevCustomEditorWindow.CloseQuery: Boolean;
//#UC START# *482BFD410052_4829D92A037B_var*
//#UC END# *482BFD410052_4829D92A037B_var*
begin
//#UC START# *482BFD410052_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFD410052_4829D92A037B_impl*
end;//TevCustomEditorWindow.CloseQuery

function TevCustomEditorWindow.MakeExportFilters(aSelection: Boolean;
 aForExport: Boolean): InevTagGenerator;
//#UC START# *482BFD8601F3_4829D92A037B_var*
//#UC END# *482BFD8601F3_4829D92A037B_var*
begin
//#UC START# *482BFD8601F3_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482BFD8601F3_4829D92A037B_impl*
end;//TevCustomEditorWindow.MakeExportFilters

procedure TevCustomEditorWindow.TextChange;
 {* вызывается при смене текста. }
//#UC START# *482C26D6006A_4829D92A037B_var*
//#UC END# *482C26D6006A_4829D92A037B_var*
begin
//#UC START# *482C26D6006A_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482C26D6006A_4829D92A037B_impl*
end;//TevCustomEditorWindow.TextChange

procedure TevCustomEditorWindow.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
//#UC START# *482C434700DD_4829D92A037B_var*
//#UC END# *482C434700DD_4829D92A037B_var*
begin
//#UC START# *482C434700DD_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482C434700DD_4829D92A037B_impl*
end;//TevCustomEditorWindow.WMEraseBkGnd

procedure TevCustomEditorWindow.WMPaint(var Msg: TWMPaint);
//#UC START# *482C4396007C_4829D92A037B_var*
//#UC END# *482C4396007C_4829D92A037B_var*
begin
//#UC START# *482C4396007C_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482C4396007C_4829D92A037B_impl*
end;//TevCustomEditorWindow.WMPaint

procedure TevCustomEditorWindow.WMGetDlgCode(var Msg: TWMGetDlgCode);
//#UC START# *482C43B5039C_4829D92A037B_var*
//#UC END# *482C43B5039C_4829D92A037B_var*
begin
//#UC START# *482C43B5039C_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482C43B5039C_4829D92A037B_impl*
end;//TevCustomEditorWindow.WMGetDlgCode

procedure TevCustomEditorWindow.WMChar(var Msg: TWMChar);
//#UC START# *482C43E5012C_4829D92A037B_var*
//#UC END# *482C43E5012C_4829D92A037B_var*
begin
//#UC START# *482C43E5012C_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482C43E5012C_4829D92A037B_impl*
end;//TevCustomEditorWindow.WMChar

procedure TevCustomEditorWindow.WMKeyDown(var Msg: TWMKeyDown);
//#UC START# *482C440A0182_4829D92A037B_var*
//#UC END# *482C440A0182_4829D92A037B_var*
begin
//#UC START# *482C440A0182_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482C440A0182_4829D92A037B_impl*
end;//TevCustomEditorWindow.WMKeyDown

function TevCustomEditorWindow.GetHorzDelta: Integer;
 {* зазор, после которого начинается скроллирование вправо. }
//#UC START# *482C706503AF_4829D92A037B_var*
//#UC END# *482C706503AF_4829D92A037B_var*
begin
//#UC START# *482C706503AF_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *482C706503AF_4829D92A037B_impl*
end;//TevCustomEditorWindow.GetHorzDelta

procedure TevCustomEditorWindow.SetTextColor(const aCanvas: Il3Canvas);
//#UC START# *4831634B00FF_4829D92A037B_var*
//#UC END# *4831634B00FF_4829D92A037B_var*
begin
//#UC START# *4831634B00FF_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4831634B00FF_4829D92A037B_impl*
end;//TevCustomEditorWindow.SetTextColor

function TevCustomEditorWindow.GetTopMargin: Integer;
 {* Возвращает отступ до текста сверху. }
//#UC START# *483D718E0143_4829D92A037B_var*
//#UC END# *483D718E0143_4829D92A037B_var*
begin
//#UC START# *483D718E0143_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *483D718E0143_4829D92A037B_impl*
end;//TevCustomEditorWindow.GetTopMargin

function TevCustomEditorWindow.ProcessHotSpots: Boolean;
 {* Обрабатывать ли "горячие точки" на предмет показа Hint'а и мышиного курсора или вызывать поведение по-умолчанию. [$100958718] }
//#UC START# *4875FDAD037A_4829D92A037B_var*
//#UC END# *4875FDAD037A_4829D92A037B_var*
begin
//#UC START# *4875FDAD037A_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4875FDAD037A_4829D92A037B_impl*
end;//TevCustomEditorWindow.ProcessHotSpots

function TevCustomEditorWindow.GetInfoCanvas: InevInfoCanvas;
//#UC START# *489845790346_4829D92A037B_var*
//#UC END# *489845790346_4829D92A037B_var*
begin
//#UC START# *489845790346_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *489845790346_4829D92A037B_impl*
end;//TevCustomEditorWindow.GetInfoCanvas

function TevCustomEditorWindow.ProcessCommandEx(Cmd: Integer;
 aForce: Boolean;
 aSubCmd: Cardinal;
 aCount: Integer): Boolean;
 {* process the specified command, return true if processed }
//#UC START# *48E227FA00E0_4829D92A037B_var*
//#UC END# *48E227FA00E0_4829D92A037B_var*
begin
//#UC START# *48E227FA00E0_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E227FA00E0_4829D92A037B_impl*
end;//TevCustomEditorWindow.ProcessCommandEx

function TevCustomEditorWindow.SelectionClass: RevSelection;
//#UC START# *48E22866033A_4829D92A037B_var*
//#UC END# *48E22866033A_4829D92A037B_var*
begin
//#UC START# *48E22866033A_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E22866033A_4829D92A037B_impl*
end;//TevCustomEditorWindow.SelectionClass

function TevCustomEditorWindow.HotSpotClass: RevEditorWindowHotSpot;
//#UC START# *48E2297000D3_4829D92A037B_var*
//#UC END# *48E2297000D3_4829D92A037B_var*
begin
//#UC START# *48E2297000D3_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E2297000D3_4829D92A037B_impl*
end;//TevCustomEditorWindow.HotSpotClass

procedure TevCustomEditorWindow.DoScrollEvent;
//#UC START# *48E22AAF019D_4829D92A037B_var*
//#UC END# *48E22AAF019D_4829D92A037B_var*
begin
//#UC START# *48E22AAF019D_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E22AAF019D_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoScrollEvent

function TevCustomEditorWindow.SelectWhenUnfocused: Boolean;
//#UC START# *48E22AD302CE_4829D92A037B_var*
//#UC END# *48E22AD302CE_4829D92A037B_var*
begin
//#UC START# *48E22AD302CE_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E22AD302CE_4829D92A037B_impl*
end;//TevCustomEditorWindow.SelectWhenUnfocused

procedure TevCustomEditorWindow.DoUnselectAfterInsertData;
//#UC START# *48E22B8B00CE_4829D92A037B_var*
//#UC END# *48E22B8B00CE_4829D92A037B_var*
begin
//#UC START# *48E22B8B00CE_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E22B8B00CE_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoUnselectAfterInsertData

function TevCustomEditorWindow.GetLimitWidth: Integer;
//#UC START# *48E0EEAC0254_4829D92A037B_var*
//#UC END# *48E0EEAC0254_4829D92A037B_var*
begin
//#UC START# *48E0EEAC0254_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E0EEAC0254_4829D92A037B_impl*
end;//TevCustomEditorWindow.GetLimitWidth

procedure TevCustomEditorWindow.DoCursorChanged;
//#UC START# *48E1F1B1033C_4829D92A037B_var*
//#UC END# *48E1F1B1033C_4829D92A037B_var*
begin
//#UC START# *48E1F1B1033C_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E1F1B1033C_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoCursorChanged

procedure TevCustomEditorWindow.WebStyleChanged;
//#UC START# *48E238D80225_4829D92A037B_var*
//#UC END# *48E238D80225_4829D92A037B_var*
begin
//#UC START# *48E238D80225_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E238D80225_4829D92A037B_impl*
end;//TevCustomEditorWindow.WebStyleChanged

procedure TevCustomEditorWindow.DoAfterSetZoom;
//#UC START# *4D3998FE03C1_4829D92A037B_var*
//#UC END# *4D3998FE03C1_4829D92A037B_var*
begin
//#UC START# *4D3998FE03C1_4829D92A037B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D3998FE03C1_4829D92A037B_impl*
end;//TevCustomEditorWindow.DoAfterSetZoom

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomEditorWindow);
 {* Регистрация TevCustomEditorWindow }
{$IfEnd} // NOT Defined(NoScripts)

end.
