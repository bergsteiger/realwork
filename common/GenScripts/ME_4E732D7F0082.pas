unit vtHideField;

// Модуль: "w:\common\components\gui\Garant\VT\vtHideField.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , afwTextControl
 , afwInterfaces
 , evTypes
 , Classes
 , Graphics
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Types
 , Messages
 , afwTypes
 , l3InternalInterfaces
;

const
 c_hfTopImageIndent = 5;
  {* отступ иконки сверху по умолчанию }
 c_hfWidth = 150;
  {* ширина по умолчанию }
 c_hfHeight = 100;
  {* высота по умолчанию }
 c_hfHeaderColor = clNavy;
  {* цвет по умолчанию для заголовка }
 cDefaultHeight = 20;
 cDefaultOptions = [hfoCanHide, hfoHyperlink];

type
 ThfOption = (
  hfoCanHide
  , hfoHyperlink
 );//ThfOption

 ThfState = (
  hfsHide
  , hfsShow
 );//ThfState

 ThfOptions = set of ThfOption;

 ThfValidateStateEvent = procedure(aSender: TObject;
  var theState: ThfState) of object;

 ThfCommandEvent = function(aSender: TObject;
  aOperation: Tl3OperationCode): Boolean of object;

 TvtCustomHideField = class(TafwTextControl{$If NOT Defined(DesignTimeLibrary)}
 , IafwStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 )
  private
   f_HeaderChangeLink: TChangeLink;
   f_ButtonChangeLink: TChangeLink;
   f_DownPoint: TPoint;
   f_OnNeedProcessCommand: ThfCommandEvent;
    {* Поле для свойства OnNeedProcessCommand }
   f_StyleId: TevStyleId;
    {* Поле для свойства StyleId }
   f_OnValidateStateChanged: ThfValidateStateEvent;
    {* Поле для свойства OnValidateStateChanged }
   f_OnStateChanged: TNotifyEvent;
    {* Поле для свойства OnStateChanged }
   f_ShowHeight: Integer;
    {* Поле для свойства ShowHeight }
   f_TopHeaderIndent: Integer;
    {* Поле для свойства TopHeaderIndent }
   f_AfterClientSpace: Integer;
    {* Поле для свойства AfterClientSpace }
   f_BeforeClientSpace: Integer;
    {* Поле для свойства BeforeClientSpace }
   f_OnHyperlinkClick: TNotifyEvent;
    {* Поле для свойства OnHyperlinkClick }
   f_Options: ThfOptions;
    {* Поле для свойства Options }
   f_ClientIndent: Integer;
    {* Поле для свойства ClientIndent }
   f_HeaderColor: TColor;
    {* Поле для свойства HeaderColor }
   f_ButtonImageList: TCustomImageList;
    {* Поле для свойства ButtonImageList }
   f_ButtonOpenImage: TImageIndex;
    {* Поле для свойства ButtonOpenImage }
   f_ButtonCloseImage: TImageIndex;
    {* Поле для свойства ButtonCloseImage }
   f_HeaderImage: TImageIndex;
    {* Поле для свойства HeaderImage }
   f_CaptionIndent: Integer;
    {* Поле для свойства CaptionIndent }
   f_LeftImageIndent: Integer;
    {* Поле для свойства LeftImageIndent }
   f_TopImageIndent: Integer;
    {* Поле для свойства TopImageIndent }
   f_LeftHeaderIndent: Integer;
    {* Поле для свойства LeftHeaderIndent }
   f_Images: TCustomImageList;
    {* Поле для свойства Images }
   f_ClientControl: TWinControl;
    {* Поле для свойства ClientControl }
   f_State: ThfState;
    {* Поле для свойства State }
  private
   procedure DoHyperlink;
   procedure OnImageListChange(Sender: TObject);
   procedure ExchangeState;
    {* поменять состояние }
   function GetHeaderLineRect: TRect;
    {* высота заголовка, содержащего гипперссылку и кнопку }
   function GetHeaderLineHeight: Integer;
    {* высота линии содержащей гиперссылку и кнопку }
   function GetImageRect: TRect;
    {* возвращает положение иконки }
   function GetImageTop: Integer;
    {* верхняя точка иконки }
   procedure Rebuild;
    {* изменился один из параметров, нужно изменеить высоту и перерисовать }
   procedure MakeHideHeight;
    {* установить размер для свернутого состояния }
   {$If NOT Defined(DesignTimeLibrary)}
   function IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure CMControlChange(var Message: TMessage);
   procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
   procedure CMTextChanged(var Message: TMessage);
   procedure CMFontChanged(var Message: TMessage);
   procedure WMKillFocus(var Message: TMessage);
   procedure WMSetFocus(var Message: TMessage);
   {$If NOT Defined(DesignTimeLibrary)}
   procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   procedure CNKeyDown(var Msg: TWMKeyDown);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  protected
   procedure pm_SetStyleId(const aValue: TevStyleId);
   procedure pm_SetShowHeight(aValue: Integer);
   function pm_GetHeaderHeight: Integer;
   procedure pm_SetTopHeaderIndent(aValue: Integer);
   procedure pm_SetAfterClientSpace(aValue: Integer);
   procedure pm_SetBeforeClientSpace(aValue: Integer);
   procedure pm_SetOptions(aValue: ThfOptions);
   procedure pm_SetClientIndent(aValue: Integer);
   procedure pm_SetHeaderColor(aValue: TColor);
   procedure pm_SetButtonImageList(aValue: TCustomImageList);
   procedure pm_SetButtonOpenImage(aValue: TImageIndex);
   procedure pm_SetButtonCloseImage(aValue: TImageIndex);
   procedure pm_SetHeaderImage(aValue: TImageIndex);
   procedure pm_SetCaptionIndent(aValue: Integer);
   procedure pm_SetLeftImageIndent(aValue: Integer);
   procedure pm_SetTopImageIndent(aValue: Integer);
   procedure pm_SetLeftHeaderIndent(aValue: Integer);
   procedure pm_SetImages(aValue: TCustomImageList);
   procedure pm_SetClientControl(aValue: TWinControl);
   procedure pm_SetState(aValue: ThfState);
   function pm_GetCaptionRect: TRect;
   function pm_GetHeaderRect: TRect;
   procedure DoStateChanged; virtual;
   function CheckImage(aImages: TCustomImageList;
    aImageIndex: Integer): Boolean;
    {* проверяет установлен ли imagelist и не выходит ли за пределы диапазона индекс. }
   procedure DoStyleTableChanged; virtual;
   procedure HideControl; virtual;
   function OptionsStored: Boolean;
    {* "Функция определяющая, что свойство Options сохраняется" }
   {$If NOT Defined(DesignTimeLibrary)}
   procedure StyleTableChanged;
    {* таблица стилей изменилась. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetCommands: TafwCommands; override;
   function DoProcessCommand(Cmd: Tl3OperationCode;
    aForce: Boolean;
    aCount: Integer): Boolean; override;
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
   {$If NOT Defined(NoVCL)}
   procedure MouseMove(Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseUp(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseDown(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure AdjustClientRect(var Rect: TRect); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
  protected
   property CaptionRect: TRect
    read pm_GetCaptionRect;
   property HeaderRect: TRect
    read pm_GetHeaderRect;
  public
   property OnNeedProcessCommand: ThfCommandEvent
    read f_OnNeedProcessCommand
    write f_OnNeedProcessCommand;
   property StyleId: TevStyleId
    read f_StyleId
    write pm_SetStyleId;
    {* default evd_saGUI }
   property OnValidateStateChanged: ThfValidateStateEvent
    read f_OnValidateStateChanged
    write f_OnValidateStateChanged;
   property OnStateChanged: TNotifyEvent
    read f_OnStateChanged
    write f_OnStateChanged;
   property ShowHeight: Integer
    read f_ShowHeight
    write pm_SetShowHeight;
   property HeaderHeight: Integer
    read pm_GetHeaderHeight;
   property TopHeaderIndent: Integer
    read f_TopHeaderIndent
    write pm_SetTopHeaderIndent;
    {* default 0 }
   property AfterClientSpace: Integer
    read f_AfterClientSpace
    write pm_SetAfterClientSpace;
    {* default 0 }
   property BeforeClientSpace: Integer
    read f_BeforeClientSpace
    write pm_SetBeforeClientSpace;
   property OnHyperlinkClick: TNotifyEvent
    read f_OnHyperlinkClick
    write f_OnHyperlinkClick;
   property Options: ThfOptions
    read f_Options
    write pm_SetOptions
    stored OptionsStored;
    {* stored IsOptionsStored }
   property ClientIndent: Integer
    read f_ClientIndent
    write pm_SetClientIndent;
   property HeaderColor: TColor
    read f_HeaderColor
    write pm_SetHeaderColor;
   property ButtonImageList: TCustomImageList
    read f_ButtonImageList
    write pm_SetButtonImageList;
    {* imagelist с иконками для кнопки }
   property ButtonOpenImage: TImageIndex
    read f_ButtonOpenImage
    write pm_SetButtonOpenImage;
    {* default -1
кнопка для разворачивания заголовка }
   property ButtonCloseImage: TImageIndex
    read f_ButtonCloseImage
    write pm_SetButtonCloseImage;
    {* default -1
кнопка для сворачивания заголовка }
   property HeaderImage: TImageIndex
    read f_HeaderImage
    write pm_SetHeaderImage;
    {* default -1
иконка заголовка }
   property CaptionIndent: Integer
    read f_CaptionIndent
    write pm_SetCaptionIndent;
    {* default 0
отступ названия заголовка }
   property LeftImageIndent: Integer
    read f_LeftImageIndent
    write pm_SetLeftImageIndent;
    {* default 0
отступ слева иконки }
   property TopImageIndent: Integer
    read f_TopImageIndent
    write pm_SetTopImageIndent;
    {* default c_hfTopImageIndent
отступ иконки сверху }
   property LeftHeaderIndent: Integer
    read f_LeftHeaderIndent
    write pm_SetLeftHeaderIndent;
    {* default 0
отступ слева заголовка, на котором находится гипперссылка и кнопка }
   property Images: TCustomImageList
    read f_Images
    write pm_SetImages;
   property ClientControl: TWinControl
    read f_ClientControl
    write pm_SetClientControl;
   property State: ThfState
    read f_State
    write pm_SetState;
    {* состояние списка (скрыт/раскрыт) }
 end;//TvtCustomHideField

 //#UC START# *4E732D7F0082ci*
 //#UC END# *4E732D7F0082ci*
 //#UC START# *4E732D7F0082cit*
 //#UC END# *4E732D7F0082cit*
 TvtHideField = class(TvtCustomHideField)
 //#UC START# *4E732D7F0082publ*
  published
    property Align;
    property Caption;
    property ButtonCloseImage default -1;
    property ButtonImageList;
    property ButtonOpenImage default -1;
    property CaptionIndent default 0;
    property ClientControl;
    property Color;
    property ClientIndent;
    property HeaderImage default -1;
    property Images;
    property LeftHeaderIndent default 0;
    property LeftImageIndent default 0;
    property Options;
    property AfterClientSpace default 0;
    property BeforeClientSpace default 0;
    property TopHeaderIndent default 0;
    property TabOrder;
    property TopImageIndent default c_hfTopImageIndent;
    property Width default c_hfWidth;
    property Height default c_hfHeight;
    property StyleId {default evd_saGUI};
    property TabStop;
  published
    property OnHyperlinkClick;
    property OnStateChanged;
 //#UC END# *4E732D7F0082publ*
 end;//TvtHideField

implementation

uses
 l3ImplUses
 , vtHideFieldUtils
 , Windows
 , l3ScreenIC
 , l3String
 , l3Base
 , l3MinMax
 , afwFacade
 , evStyleInterface
 , TextPara_Const
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , evdTextStyle_Const
 , OvcCmd
 , OvcConst
 , l3Units
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , vtHideFieldWords
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 cstidState = 'State';
  {* идентификатор настройки для состояния }

procedure TvtCustomHideField.pm_SetStyleId(const aValue: TevStyleId);
//#UC START# *5110DC1F02C4_4E732D8B0291set_var*
//#UC END# *5110DC1F02C4_4E732D8B0291set_var*
begin
//#UC START# *5110DC1F02C4_4E732D8B0291set_impl*
 if aValue <> f_StyleId then
 begin
  f_StyleId := aValue;
  {$IfNDef DesignTimeLibrary}
  StyleTableChanged;
  {$EndIf DesignTimeLibrary}
 end;//if aValue <> f_StyleId then
//#UC END# *5110DC1F02C4_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetStyleId

procedure TvtCustomHideField.pm_SetShowHeight(aValue: Integer);
//#UC START# *5110DD530218_4E732D8B0291set_var*
//#UC END# *5110DD530218_4E732D8B0291set_var*
begin
//#UC START# *5110DD530218_4E732D8B0291set_impl*
 if f_ShowHeight <> aValue then
 begin
  f_ShowHeight := aValue;
  if (f_State = hfsShow) and not (Align in [alClient, alLeft, alRight]) then
   Height := f_ShowHeight;
 end;
//#UC END# *5110DD530218_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetShowHeight

function TvtCustomHideField.pm_GetHeaderHeight: Integer;
//#UC START# *5110DD72026C_4E732D8B0291get_var*
//#UC END# *5110DD72026C_4E732D8B0291get_var*
begin
//#UC START# *5110DD72026C_4E732D8B0291get_impl*
 with HeaderRect do
  Result := Bottom - Top;
//#UC END# *5110DD72026C_4E732D8B0291get_impl*
end;//TvtCustomHideField.pm_GetHeaderHeight

procedure TvtCustomHideField.pm_SetTopHeaderIndent(aValue: Integer);
//#UC START# *5110DD8902D1_4E732D8B0291set_var*
//#UC END# *5110DD8902D1_4E732D8B0291set_var*
begin
//#UC START# *5110DD8902D1_4E732D8B0291set_impl*
 if f_TopHeaderIndent <> aValue then
 begin
  f_TopHeaderIndent := aValue;
  Rebuild;
 end;
//#UC END# *5110DD8902D1_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetTopHeaderIndent

procedure TvtCustomHideField.pm_SetAfterClientSpace(aValue: Integer);
//#UC START# *5110DDB602F6_4E732D8B0291set_var*
//#UC END# *5110DDB602F6_4E732D8B0291set_var*
begin
//#UC START# *5110DDB602F6_4E732D8B0291set_impl*
 if f_AfterClientSpace <> aValue then
 begin
  f_AfterClientSpace := aValue;
  Rebuild;
 end;
//#UC END# *5110DDB602F6_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetAfterClientSpace

procedure TvtCustomHideField.pm_SetBeforeClientSpace(aValue: Integer);
//#UC START# *5110DDE30377_4E732D8B0291set_var*
//#UC END# *5110DDE30377_4E732D8B0291set_var*
begin
//#UC START# *5110DDE30377_4E732D8B0291set_impl*
 if f_BeforeClientSpace <> aValue then
 begin
  f_BeforeClientSpace := aValue;
  Rebuild;
 end;
//#UC END# *5110DDE30377_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetBeforeClientSpace

procedure TvtCustomHideField.pm_SetOptions(aValue: ThfOptions);
//#UC START# *5110DE5C018F_4E732D8B0291set_var*
//#UC END# *5110DE5C018F_4E732D8B0291set_var*
begin
//#UC START# *5110DE5C018F_4E732D8B0291set_impl*
 f_Options := aValue;
 Invalidate;
//#UC END# *5110DE5C018F_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetOptions

procedure TvtCustomHideField.pm_SetClientIndent(aValue: Integer);
//#UC START# *5110DE7900DD_4E732D8B0291set_var*
//#UC END# *5110DE7900DD_4E732D8B0291set_var*
begin
//#UC START# *5110DE7900DD_4E732D8B0291set_impl*
 if f_ClientIndent <> aValue then
 begin
  f_ClientIndent := aValue;
  Rebuild;
 end;
//#UC END# *5110DE7900DD_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetClientIndent

procedure TvtCustomHideField.pm_SetHeaderColor(aValue: TColor);
//#UC START# *5110E07D03D6_4E732D8B0291set_var*
//#UC END# *5110E07D03D6_4E732D8B0291set_var*
begin
//#UC START# *5110E07D03D6_4E732D8B0291set_impl*
 if f_HeaderColor <> aValue then
 begin
  f_HeaderColor := aValue;
  Rebuild;
 end;
//#UC END# *5110E07D03D6_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetHeaderColor

procedure TvtCustomHideField.pm_SetButtonImageList(aValue: TCustomImageList);
//#UC START# *5110E16E0250_4E732D8B0291set_var*
//#UC END# *5110E16E0250_4E732D8B0291set_var*
begin
//#UC START# *5110E16E0250_4E732D8B0291set_impl*
 if (f_ButtonImageList <> aValue) then
 begin
  if (f_ButtonChangeLink <> nil) AND (f_ButtonChangeLink.Sender = nil) then
   // - список картинок уже убит - надо его зачистить
   f_ButtonImageList := nil;
  // отрегистрируем
  if Assigned(f_ButtonImageList) then
   f_ButtonImageList.UnRegisterChanges(f_ButtonChangeLink);
  // зарегистрируем
  f_ButtonImageList := aValue;
  if Assigned(f_ButtonImageList) then
   f_ButtonImageList.RegisterChanges(f_ButtonChangeLink);
  Rebuild;
 end;
//#UC END# *5110E16E0250_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetButtonImageList

procedure TvtCustomHideField.pm_SetButtonOpenImage(aValue: TImageIndex);
//#UC START# *5110E2580305_4E732D8B0291set_var*
//#UC END# *5110E2580305_4E732D8B0291set_var*
begin
//#UC START# *5110E2580305_4E732D8B0291set_impl*
 if f_ButtonOpenImage <> aValue then
 begin
  f_ButtonOpenImage := aValue;
  Rebuild;
 end;
//#UC END# *5110E2580305_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetButtonOpenImage

procedure TvtCustomHideField.pm_SetButtonCloseImage(aValue: TImageIndex);
//#UC START# *5110E2E302A3_4E732D8B0291set_var*
//#UC END# *5110E2E302A3_4E732D8B0291set_var*
begin
//#UC START# *5110E2E302A3_4E732D8B0291set_impl*
 if f_ButtonCloseImage <> aValue then
 begin
  f_ButtonCloseImage := aValue;
  Rebuild;
 end;
//#UC END# *5110E2E302A3_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetButtonCloseImage

procedure TvtCustomHideField.pm_SetHeaderImage(aValue: TImageIndex);
//#UC START# *5110E32A0238_4E732D8B0291set_var*
//#UC END# *5110E32A0238_4E732D8B0291set_var*
begin
//#UC START# *5110E32A0238_4E732D8B0291set_impl*
 if f_HeaderImage <> aValue then
 begin
  f_HeaderImage := aValue;
  Rebuild;
 end;
//#UC END# *5110E32A0238_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetHeaderImage

procedure TvtCustomHideField.pm_SetCaptionIndent(aValue: Integer);
//#UC START# *5110E37A0105_4E732D8B0291set_var*
//#UC END# *5110E37A0105_4E732D8B0291set_var*
begin
//#UC START# *5110E37A0105_4E732D8B0291set_impl*
 if f_CaptionIndent <> aValue then
 begin
  f_CaptionIndent := aValue;
  Rebuild;
 end;//if f_CaptionIndent <> aValue then
//#UC END# *5110E37A0105_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetCaptionIndent

procedure TvtCustomHideField.pm_SetLeftImageIndent(aValue: Integer);
//#UC START# *5110E4050114_4E732D8B0291set_var*
//#UC END# *5110E4050114_4E732D8B0291set_var*
begin
//#UC START# *5110E4050114_4E732D8B0291set_impl*
 if f_LeftImageIndent <> aValue then
 begin
  f_LeftImageIndent := aValue;
  Rebuild;
 end;
//#UC END# *5110E4050114_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetLeftImageIndent

procedure TvtCustomHideField.pm_SetTopImageIndent(aValue: Integer);
//#UC START# *5110E46E02FC_4E732D8B0291set_var*
//#UC END# *5110E46E02FC_4E732D8B0291set_var*
begin
//#UC START# *5110E46E02FC_4E732D8B0291set_impl*
 if f_TopImageIndent <> aValue then
 begin
  f_TopImageIndent := aValue;
  Rebuild;
 end;
//#UC END# *5110E46E02FC_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetTopImageIndent

procedure TvtCustomHideField.pm_SetLeftHeaderIndent(aValue: Integer);
//#UC START# *5110E4CD02AE_4E732D8B0291set_var*
//#UC END# *5110E4CD02AE_4E732D8B0291set_var*
begin
//#UC START# *5110E4CD02AE_4E732D8B0291set_impl*
 if f_LeftHeaderIndent <> aValue then
 begin
  f_LeftHeaderIndent := aValue;
  Rebuild;
 end;
//#UC END# *5110E4CD02AE_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetLeftHeaderIndent

procedure TvtCustomHideField.pm_SetImages(aValue: TCustomImageList);
//#UC START# *5110E5130372_4E732D8B0291set_var*
//#UC END# *5110E5130372_4E732D8B0291set_var*
begin
//#UC START# *5110E5130372_4E732D8B0291set_impl*
 if (aValue <> f_Images) then
 begin
  if (f_HeaderChangeLink <> nil) AND (f_HeaderChangeLink.Sender = nil) then
   // - список картинок уже убит - надо его зачистить
   f_Images := nil;
  // отрегистрируем
  if Assigned(f_Images) then
   f_Images.UnRegisterChanges(f_HeaderChangeLink);
  // зарегистрируем
  f_Images := aValue;
  if Assigned(f_Images) then
   f_Images.RegisterChanges(f_HeaderChangeLink);
  Rebuild;
 end;
//#UC END# *5110E5130372_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetImages

procedure TvtCustomHideField.pm_SetClientControl(aValue: TWinControl);
//#UC START# *5110E5650373_4E732D8B0291set_var*
//#UC END# *5110E5650373_4E732D8B0291set_var*
begin
//#UC START# *5110E5650373_4E732D8B0291set_impl*
 f_ClientControl := aValue;
 if Assigned(f_ClientControl) then
  with f_ClientControl do
  begin
   Align := alClient;
   Parent := Self;
   if State = hfsHide then
    HideControl;
  end;//with f_ClientControl do
//#UC END# *5110E5650373_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetClientControl

procedure TvtCustomHideField.pm_SetState(aValue: ThfState);
//#UC START# *5110E5A70033_4E732D8B0291set_var*
var
 l_Rect: TRect;
//#UC END# *5110E5A70033_4E732D8B0291set_var*
begin
//#UC START# *5110E5A70033_4E732D8B0291set_impl*
 if aValue <> f_State then
 begin
  f_State := aValue;
  if Assigned(f_OnValidateStateChanged) then
   f_OnValidateStateChanged(Self, f_State);
  if (f_State <> aValue) then
   Exit;
  case f_State of
   // показать
   hfsShow:
   begin
    if ClientControl <> nil then
     ClientControl.Show;
    Height := f_ShowHeight;
   end;//hfsShow
   // скрыть
   hfsHide:
   begin
    f_ShowHeight := Height;
    MakeHideHeight;
    if ClientControl <> nil then
     ClientControl.Hide;
   end;//hfsHide
  end;//case f_State of
  l_Rect := ClientRect;
  AlignControls(nil, l_Rect); // http://mdp.garant.ru/pages/viewpage.action?pageId=336665276&focusedCommentId=337514167#comment-337514167
  DoStateChanged;
 end;//if aValue <> f_State then
//#UC END# *5110E5A70033_4E732D8B0291set_impl*
end;//TvtCustomHideField.pm_SetState

function TvtCustomHideField.pm_GetCaptionRect: TRect;
//#UC START# *5110E710033A_4E732D8B0291get_var*
var
 l_I  : Integer;
 l_R  : TRect;
 l_IC : Il3InfoCanvas;
//#UC END# *5110E710033A_4E732D8B0291get_var*
begin
//#UC START# *5110E710033A_4E732D8B0291get_impl*
 Result := GetHeaderLineRect;
 l_I := Result.Left;
 // Выводим после иконки:
 if CheckImage(f_Images, f_HeaderImage) then
  l_I := Max(l_I, f_LeftImageIndent + f_Images.Width);
 // Отсуп названия:
 Inc(l_I, f_CaptionIndent);
 Result.Left := Max(Result.Left, l_I);
 // Учтем иконку свернуть/развернуть справа от заголовка:
 if CheckImage(f_ButtonImageList, f_ButtonCloseImage) then
  Result.Right := Result.Right - f_ButtonImageList.Width;
 // Реальная длина
 SetRectEmpty(l_R);
 if not l3IsNil(CCaption) then
 begin
  l_IC := l3CrtIC;
  l_IC.Font.AssignFont(Font);
  l_IC.PasswordChar := #0; // http://mdp.garant.ru/pages/viewpage.action?pageId=294589287
  l_IC.DrawText(CCaption.AsWStr, l_R, DT_SINGLELINE or DT_CALCRECT);
  l_I := Min(Result.Right - Result.Left, l_R.Right);
  Result.Right := Result.Left + l_I;
 end;//not l3IsNil(CCaption)
//#UC END# *5110E710033A_4E732D8B0291get_impl*
end;//TvtCustomHideField.pm_GetCaptionRect

function TvtCustomHideField.pm_GetHeaderRect: TRect;
//#UC START# *5110E73702B2_4E732D8B0291get_var*
var
 l_I                 : Integer;
 l_BeforeClientSpace : Integer;
//#UC END# *5110E73702B2_4E732D8B0291get_var*
begin
//#UC START# *5110E73702B2_4E732D8B0291get_impl*
 SetRectEmpty(Result);
 Result := ClientRect;
 l_I := 0;
 // Высота иконки заголовка
 if CheckImage(f_Images, f_HeaderImage) then
  l_I := f_Images.Height + f_TopImageIndent;
 // Высота заголовка
 l_BeforeClientSpace := 0;
 if Assigned(f_ClientControl) then
  l_BeforeClientSpace := f_BeforeClientSpace;
 Result.Bottom := Max(Result.Top + l_I, GetHeaderLineRect.Bottom) +
  l_BeforeClientSpace;
//#UC END# *5110E73702B2_4E732D8B0291get_impl*
end;//TvtCustomHideField.pm_GetHeaderRect

procedure TvtCustomHideField.DoStateChanged;
//#UC START# *508F96700139_4E732D8B0291_var*
//#UC END# *508F96700139_4E732D8B0291_var*
begin
//#UC START# *508F96700139_4E732D8B0291_impl*
 if Assigned(f_OnStateChanged) then
  f_OnStateChanged(Self);
//#UC END# *508F96700139_4E732D8B0291_impl*
end;//TvtCustomHideField.DoStateChanged

function TvtCustomHideField.CheckImage(aImages: TCustomImageList;
 aImageIndex: Integer): Boolean;
 {* проверяет установлен ли imagelist и не выходит ли за пределы диапазона индекс. }
//#UC START# *5110E8730017_4E732D8B0291_var*
//#UC END# *5110E8730017_4E732D8B0291_var*
begin
//#UC START# *5110E8730017_4E732D8B0291_impl*
 Result := Assigned(aImages) and (aImageIndex <> -1) and (aImageIndex < aImages.Count);
//#UC END# *5110E8730017_4E732D8B0291_impl*
end;//TvtCustomHideField.CheckImage

procedure TvtCustomHideField.DoHyperlink;
//#UC START# *5110E8D4004F_4E732D8B0291_var*
//#UC END# *5110E8D4004F_4E732D8B0291_var*
begin
//#UC START# *5110E8D4004F_4E732D8B0291_impl*
 if Assigned(f_OnHyperlinkClick) then
  f_OnHyperlinkClick(Self);
//#UC END# *5110E8D4004F_4E732D8B0291_impl*
end;//TvtCustomHideField.DoHyperlink

procedure TvtCustomHideField.OnImageListChange(Sender: TObject);
//#UC START# *5110E94B0295_4E732D8B0291_var*
//#UC END# *5110E94B0295_4E732D8B0291_var*
begin
//#UC START# *5110E94B0295_4E732D8B0291_impl*
 Rebuild;
//#UC END# *5110E94B0295_4E732D8B0291_impl*
end;//TvtCustomHideField.OnImageListChange

procedure TvtCustomHideField.ExchangeState;
 {* поменять состояние }
//#UC START# *5110E98600A4_4E732D8B0291_var*
//#UC END# *5110E98600A4_4E732D8B0291_var*
begin
//#UC START# *5110E98600A4_4E732D8B0291_impl*
 case f_State of
  hfsHide: State := hfsShow;
 else
  State := hfsHide;
 end;
//#UC END# *5110E98600A4_4E732D8B0291_impl*
end;//TvtCustomHideField.ExchangeState

function TvtCustomHideField.GetHeaderLineRect: TRect;
 {* высота заголовка, содержащего гипперссылку и кнопку }
//#UC START# *5110E9B3001D_4E732D8B0291_var*
//#UC END# *5110E9B3001D_4E732D8B0291_var*
begin
//#UC START# *5110E9B3001D_4E732D8B0291_impl*
 Result := ClientRect;
 // Верхняя точка
 Result.Top := f_TopHeaderIndent;
 // Высота заголовка
 Result.Bottom := Result.Top + GetHeaderLineHeight;
 // Отступ слева
 Result.Left := f_LeftHeaderIndent;
//#UC END# *5110E9B3001D_4E732D8B0291_impl*
end;//TvtCustomHideField.GetHeaderLineRect

function TvtCustomHideField.GetHeaderLineHeight: Integer;
 {* высота линии содержащей гиперссылку и кнопку }
//#UC START# *5110E9DF0198_4E732D8B0291_var*
var
 lRect : TRect;
 lI    : Integer;
 lStr  : Il3CString;
 l_IC  : Il3InfoCanvas;
//#UC END# *5110E9DF0198_4E732D8B0291_var*
begin
//#UC START# *5110E9DF0198_4E732D8B0291_impl*
 // Высота текста
 SetRectEmpty(lRect);
 l_IC := l3CrtIC;
 l_IC.Font.AssignFont(Font);
 if l3IsNil(CCaption) then
  lStr := l3CStr('W')
 else
  lStr := CCaption;
 l_IC.DrawText(lStr.AsWStr, lRect, DT_CALCRECT);
 // Высота кнопки заголовка
 lI := 0;
 if CheckImage(f_ButtonImageList, f_ButtonOpenImage) then
  lI := f_ButtonImageList.Height;
 // Наибольшая высота
 Result := Max(lRect.Bottom, lI);
 // Добавим снизу и сверху по 2 дополнительных пикселя
 Inc(Result, 4);
//#UC END# *5110E9DF0198_4E732D8B0291_impl*
end;//TvtCustomHideField.GetHeaderLineHeight

function TvtCustomHideField.GetImageRect: TRect;
 {* возвращает положение иконки }
//#UC START# *5110EA09030A_4E732D8B0291_var*
//#UC END# *5110EA09030A_4E732D8B0291_var*
begin
//#UC START# *5110EA09030A_4E732D8B0291_impl*
 with Result do
 begin
  Left := f_LeftImageIndent;
  Top := GetImageTop;
  if f_Images <> nil then
  begin
   Right := Left + f_Images.Width;
   Bottom := Top + f_Images.Height;
  end
  else
  begin
   Right := Left;
   Bottom := Top;
  end;
 end;
//#UC END# *5110EA09030A_4E732D8B0291_impl*
end;//TvtCustomHideField.GetImageRect

function TvtCustomHideField.GetImageTop: Integer;
 {* верхняя точка иконки }
//#UC START# *5110EAD80111_4E732D8B0291_var*
//#UC END# *5110EAD80111_4E732D8B0291_var*
begin
//#UC START# *5110EAD80111_4E732D8B0291_impl*
 Result := ClientRect.Top + f_TopImageIndent;
//#UC END# *5110EAD80111_4E732D8B0291_impl*
end;//TvtCustomHideField.GetImageTop

procedure TvtCustomHideField.Rebuild;
 {* изменился один из параметров, нужно изменеить высоту и перерисовать }
//#UC START# *5110EB070102_4E732D8B0291_var*
//#UC END# *5110EB070102_4E732D8B0291_var*
begin
//#UC START# *5110EB070102_4E732D8B0291_impl*
 if not (csLoading in ComponentState) then
 begin
  case f_State of
   hfsShow: Realign;
   hfsHide: MakeHideHeight;
  end;//case f_State
  Invalidate;
 end;//not (csLoading in ComponentState)
//#UC END# *5110EB070102_4E732D8B0291_impl*
end;//TvtCustomHideField.Rebuild

procedure TvtCustomHideField.MakeHideHeight;
 {* установить размер для свернутого состояния }
//#UC START# *5110EB2F030B_4E732D8B0291_var*
//#UC END# *5110EB2F030B_4E732D8B0291_var*
begin
//#UC START# *5110EB2F030B_4E732D8B0291_impl*
 with HeaderRect do
  Self.Height := Bottom - Top;
//#UC END# *5110EB2F030B_4E732D8B0291_impl*
end;//TvtCustomHideField.MakeHideHeight

{$If NOT Defined(DesignTimeLibrary)}
function TvtCustomHideField.IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
//#UC START# *5110EB5702F3_4E732D8B0291_var*
var
 l_Time: Cardinal;
//#UC END# *5110EB5702F3_4E732D8B0291_var*
begin
//#UC START# *5110EB5702F3_4E732D8B0291_impl*
 Use;
 try
  afw.BeginOp;
  try
   l_Time := GetTickCount;
   Result := ProcessMessage(TMessage(Msg), l_Time);
   if Result then
    Msg.Result := -1;
  finally
   afw.EndOp;
  end;//try..finally
 finally
  Free;
 end;//try..finally
//#UC END# *5110EB5702F3_4E732D8B0291_impl*
end;//TvtCustomHideField.IsHandledShortcut
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvtCustomHideField.DoStyleTableChanged;
//#UC START# *51124356016F_4E732D8B0291_var*
//#UC END# *51124356016F_4E732D8B0291_var*
begin
//#UC START# *51124356016F_4E732D8B0291_impl*
 with TevStyleInterface.Make(k2_typTextPara, f_StyleId) do
 try
  Font.Assign2Font(Self.Font);
  HeaderColor := Font.BackColor;
 finally
  Free;
 end;//try..finally
//#UC END# *51124356016F_4E732D8B0291_impl*
end;//TvtCustomHideField.DoStyleTableChanged

procedure TvtCustomHideField.HideControl;
//#UC START# *5295F76F02C5_4E732D8B0291_var*
//#UC END# *5295F76F02C5_4E732D8B0291_var*
begin
//#UC START# *5295F76F02C5_4E732D8B0291_impl*
 if (f_ClientControl <> nil) then
  f_ClientControl.Hide;
//#UC END# *5295F76F02C5_4E732D8B0291_impl*
end;//TvtCustomHideField.HideControl

procedure TvtCustomHideField.CMControlChange(var Message: TMessage);
//#UC START# *5110EBF201E1_4E732D8B0291_var*
var
 lControl : TControl;
//#UC END# *5110EBF201E1_4E732D8B0291_var*
begin
//#UC START# *5110EBF201E1_4E732D8B0291_impl*
 inherited;
 lControl := TControl(Message.WParam);
 // компонент добавили
 if Boolean(Message.LParam) then
 begin
  if (lControl <> f_ClientControl) then
   ClientControl := TWinControl(lControl);
 end
 // компонент удалили
 else
  if f_ClientControl = lControl then
   ClientControl := nil;
//#UC END# *5110EBF201E1_4E732D8B0291_impl*
end;//TvtCustomHideField.CMControlChange

procedure TvtCustomHideField.WMEraseBkgnd(var Message: TWMEraseBkgnd);
//#UC START# *5110EC050384_4E732D8B0291_var*
//#UC END# *5110EC050384_4E732D8B0291_var*
begin
//#UC START# *5110EC050384_4E732D8B0291_impl*
 Message.Result := 1;
//#UC END# *5110EC050384_4E732D8B0291_impl*
end;//TvtCustomHideField.WMEraseBkgnd

procedure TvtCustomHideField.CMTextChanged(var Message: TMessage);
//#UC START# *5110EC1D028D_4E732D8B0291_var*
//#UC END# *5110EC1D028D_4E732D8B0291_var*
begin
//#UC START# *5110EC1D028D_4E732D8B0291_impl*
 inherited;
 if not (csLoading in ComponentState) then
  Invalidate;
//#UC END# *5110EC1D028D_4E732D8B0291_impl*
end;//TvtCustomHideField.CMTextChanged

procedure TvtCustomHideField.CMFontChanged(var Message: TMessage);
//#UC START# *5110EC4100FE_4E732D8B0291_var*
//#UC END# *5110EC4100FE_4E732D8B0291_var*
begin
//#UC START# *5110EC4100FE_4E732D8B0291_impl*
 inherited;
 if not (csLoading in ComponentState) then
  Invalidate;
//#UC END# *5110EC4100FE_4E732D8B0291_impl*
end;//TvtCustomHideField.CMFontChanged

procedure TvtCustomHideField.WMKillFocus(var Message: TMessage);
//#UC START# *5110EC5900F2_4E732D8B0291_var*
//#UC END# *5110EC5900F2_4E732D8B0291_var*
begin
//#UC START# *5110EC5900F2_4E732D8B0291_impl*
 inherited;
 Invalidate;
//#UC END# *5110EC5900F2_4E732D8B0291_impl*
end;//TvtCustomHideField.WMKillFocus

procedure TvtCustomHideField.WMSetFocus(var Message: TMessage);
//#UC START# *5110EC6D0373_4E732D8B0291_var*
//#UC END# *5110EC6D0373_4E732D8B0291_var*
begin
//#UC START# *5110EC6D0373_4E732D8B0291_impl*
 inherited;
 Invalidate;
//#UC END# *5110EC6D0373_4E732D8B0291_impl*
end;//TvtCustomHideField.WMSetFocus

{$If NOT Defined(DesignTimeLibrary)}
procedure TvtCustomHideField.WMSysKeyDown(var Msg: TWMSysKeyDown);
//#UC START# *5110EC890276_4E732D8B0291_var*
//#UC END# *5110EC890276_4E732D8B0291_var*
begin
//#UC START# *5110EC890276_4E732D8B0291_impl*
 if not IsHandledShortcut(Msg) then
  inherited;
//#UC END# *5110EC890276_4E732D8B0291_impl*
end;//TvtCustomHideField.WMSysKeyDown
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
procedure TvtCustomHideField.CNKeyDown(var Msg: TWMKeyDown);
//#UC START# *5110ECA600E4_4E732D8B0291_var*
//#UC END# *5110ECA600E4_4E732D8B0291_var*
begin
//#UC START# *5110ECA600E4_4E732D8B0291_impl*
 if not IsHandledShortcut(Msg) then
  inherited;
//#UC END# *5110ECA600E4_4E732D8B0291_impl*
end;//TvtCustomHideField.CNKeyDown
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function TvtCustomHideField.OptionsStored: Boolean;
 {* "Функция определяющая, что свойство Options сохраняется" }
//#UC START# *B7BEA46A4838_4E732D8B0291_var*
//#UC END# *B7BEA46A4838_4E732D8B0291_var*
begin
//#UC START# *B7BEA46A4838_4E732D8B0291_impl*
 Result := f_Options <> cDefaultOptions;;
//#UC END# *B7BEA46A4838_4E732D8B0291_impl*
end;//TvtCustomHideField.OptionsStored

{$If NOT Defined(DesignTimeLibrary)}
procedure TvtCustomHideField.StyleTableChanged;
 {* таблица стилей изменилась. }
//#UC START# *467D2CB10135_4E732D8B0291_var*
//#UC END# *467D2CB10135_4E732D8B0291_var*
begin
//#UC START# *467D2CB10135_4E732D8B0291_impl*
 DoStyleTableChanged;
//#UC END# *467D2CB10135_4E732D8B0291_impl*
end;//TvtCustomHideField.StyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvtCustomHideField.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E732D8B0291_var*
//#UC END# *479731C50290_4E732D8B0291_var*
begin
//#UC START# *479731C50290_4E732D8B0291_impl*
 {$IfNDef DesignTimeLibrary}
 evDelStyleTableSpy(Self);
 {$EndIf DesignTimeLibrary}
 l3Free(f_ButtonChangeLink);
 l3Free(f_HeaderChangeLink);
 inherited;
//#UC END# *479731C50290_4E732D8B0291_impl*
end;//TvtCustomHideField.Cleanup

constructor TvtCustomHideField.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4E732D8B0291_var*
//#UC END# *47D1602000C6_4E732D8B0291_var*
begin
//#UC START# *47D1602000C6_4E732D8B0291_impl*
 inherited;
 ControlStyle := ControlStyle + [csAcceptsControls];
 Height := c_hfHeight;
 Width := c_hfWidth;
 // Увеличим счетчик компонентов
 Inc(g_HideFieldCount);
 // Self
 f_TopImageIndent := c_hfTopImageIndent;
 with Font do
 begin
  Name := 'Arial';
  Color := clWhite;
  Style := [fsUnderline, fsBold];
 end;//with Font
 f_HeaderChangeLink := TChangeLink.Create;
 f_HeaderChangeLink.OnChange := OnImageListChange;
 f_ButtonChangeLink := TChangeLink.Create;
 f_ButtonChangeLink.OnChange := OnImageListChange;
 f_Options           := cDefaultOptions;
 f_TopHeaderIndent   := 0;
 f_ClientIndent      := 0;
 f_LeftHeaderIndent  := 0;
 f_LeftImageIndent   := 0;
 f_ButtonCloseImage  := -1;
 f_ButtonOpenImage   := -1;
 f_HeaderImage       := -1;
 f_HeaderColor       := c_hfHeaderColor;
 f_ShowHeight        := 0;
 f_State             := hfsShow;
 f_DownPoint         := Point(-1, -1);
 f_BeforeClientSpace := 0;
 f_AfterClientSpace  := 0;
 f_StyleId := evd_saGUI;
 {$IfNDef DesignTimeLibrary}
 evAddStyleTableSpy(Self, True);
 {$EndIf DesignTimeLibrary}
 DoubleBuffered := True;
//#UC END# *47D1602000C6_4E732D8B0291_impl*
end;//TvtCustomHideField.Create

function TvtCustomHideField.GetCommands: TafwCommands;
//#UC START# *48BD1E3C03B5_4E732D8B0291_var*
//#UC END# *48BD1E3C03B5_4E732D8B0291_var*
begin
//#UC START# *48BD1E3C03B5_4E732D8B0291_impl*
 SetCommands(ovcListCommands, Result);
//#UC END# *48BD1E3C03B5_4E732D8B0291_impl*
end;//TvtCustomHideField.GetCommands

function TvtCustomHideField.DoProcessCommand(Cmd: Tl3OperationCode;
 aForce: Boolean;
 aCount: Integer): Boolean;
//#UC START# *48BD22E601F2_4E732D8B0291_var*
  function lp_CanMoveFocus: Boolean;
  begin
   Result := (ClientControl <> nil) and (ClientControl.CanFocus) and
    (State = hfsShow);
  end;//lp_CanMoveFocus
//#UC END# *48BD22E601F2_4E732D8B0291_var*
begin
//#UC START# *48BD22E601F2_4E732D8B0291_impl*
 Result := inherited DoProcessCommand(Cmd, aForce, aCount);
 if not Result then
 begin
  if Assigned(f_OnNeedProcessCommand) then
   Result := not f_OnNeedProcessCommand(Self, Cmd);
  if not Result then
   case Cmd of
    // Стрелка вниз:
    ccDown: if lp_CanMoveFocus then
            begin
             ClientControl.SetFocus;
             Result := True;
            end;//if (ClientControl <> nil) and (ClientControl.CanFocus) then
    // -:
    ccTreeCollapse: if hfoCanHide in Options then
                    begin
                     State := hfsHide;
                     Result := True;
                    end;//if hfoCanHide in Options then
    // +:
    ccTreeExpand: if hfoCanHide in Options then
                  begin
                   ExchangeState;
                   Result := True;
                  end;//if hfoCanHide in Options then
    // Enter:
    ccActionItem: if hfoHyperlink in Options then
                  begin
                   DoHyperlink;
                   Result := True;
                  end else
                  if hfoCanHide in Options then
                  begin
                   ExchangeState;
                   Result := True;
                  end//if hfoCanHide in Options then
   end;//case Cmd of
 end;//
//#UC END# *48BD22E601F2_4E732D8B0291_impl*
end;//TvtCustomHideField.DoProcessCommand

procedure TvtCustomHideField.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_4E732D8B0291_var*
var
 l_ClientRect: Tl3SRect;

 procedure lp_DrawFocus;
 var
  l_FocusRect: Tl3SRect;
 begin
  l_FocusRect := l_ClientRect;
  l_FocusRect.Inflate(-1, -1);
   // - цвет шрифта может совпадать с цветом фона, поэтому рамку нужно рисовать
   //   внутри рамки заголовка;
  if Focused then
   //DrawFocusRect(l_R);
   with CN.Canvas do
   begin
    Pen.Color := Self.Font.Color;
    Rectangle(TRect(l_FocusRect));
   end;//if Focused then
 end;//lp_DrawFocus

 procedure lp_FillHideField;
 begin
  with CN do
  begin
   BackColor := Self.Color;
   FillRect(l_ClientRect);
  end;//with CN do
 end;//lp_FillHideField

 procedure lp_FillHeader;
 begin
  with CN do
  begin
   TRect(l_ClientRect) := GetHeaderLineRect;
   BackColor := f_HeaderColor;
   FillRect(l_ClientRect);
  end;//with CN do
 end;//lp_FillHeader

 procedure lp_DrawCaption;
 var
  l_R1: TRect;
 begin
  with CN do
  begin
   if not l3IsNil(CCaption) then
   begin
    l_R1 := CaptionRect;
    // Выводим
    Font.AssignFont(Self.Font);
    DrawText(CCaption.AsWStr, l_R1, DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS);
   end;//not l3IsNil(CCaption)
  end;//with CN do
 end;//lp_DrawCaptions

 procedure lp_DrawHideButton;
 var
  l_Image: TImageIndex;
  l_R1 : TRect;
  l_X : Integer;
  l_Y : Integer;
 begin
  if (hfoCanHide in f_Options) then
  begin
   case f_State of
    hfsHide:
     l_Image := f_ButtonOpenImage;
    hfsShow:
     l_Image := f_ButtonCloseImage;
    else
     l_Image := -1;
   end;
   l_Y := 0;
   if Assigned(f_OnValidateStateChanged) AND not l3IsNil(CCaption) then
   begin
    l_R1 := CaptionRect;
    l_X := l_ClientRect.Left + (l_R1.Right - l_R1.Left) + 4;
    l_Y := 2;
   end//if not l3IsNil(CCaption) then
   else
    l_X := l_ClientRect.Right - f_ButtonImageList.Width;
   if CheckImage(f_ButtonImageList, l_Image) then
    f_ButtonImageList.Draw(CN.Canvas, l_X,
     l_ClientRect.Top + l_Y + (((l_ClientRect.Bottom - l_ClientRect.Top) - f_ButtonImageList.Height) div 2), l_Image);
  end;//hfoCanHide in f_Options
 end;//lp_DrawHideButton

 procedure lp_DrawIcon;
 begin
  if CheckImage(f_Images, f_HeaderImage) then
  begin
   TRect(l_ClientRect) := GetImageRect;
   f_Images.Draw(CN.Canvas, l_ClientRect.Left, l_ClientRect.Top, f_HeaderImage);
  end;//CheckImage
 end;//lp_DrawIcon
//#UC END# *48C6C044025E_4E732D8B0291_var*
begin
//#UC START# *48C6C044025E_4E732D8B0291_impl*
 TRect(l_ClientRect) := ClientRect;
 // зальём фон белым:
 lp_FillHideField;
 // зальём заголовок:
 lp_FillHeader;
 // покажем рамку фокуса:
 lp_DrawFocus;
 // покажем название:
 lp_DrawCaption;
 // нарисуем кнопку
 lp_DrawHideButton;
 // иконка заголовка
 lp_DrawIcon;
//#UC END# *48C6C044025E_4E732D8B0291_impl*
end;//TvtCustomHideField.Paint

{$If NOT Defined(NoVCL)}
procedure TvtCustomHideField.MouseMove(Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *48E22B250241_4E732D8B0291_var*
//#UC END# *48E22B250241_4E732D8B0291_var*
begin
//#UC START# *48E22B250241_4E732D8B0291_impl*
 inherited;
 if (hfoHyperlink in f_Options) and (not l3IsNil(CCaption)) and
   (PtInRect(CaptionRect, Point(X, Y)) or
    PtInRect(GetImageRect, Point(X, Y))) then
  Windows.SetCursor(Screen.Cursors[crHandPoint])
 else
  Windows.SetCursor(Screen.Cursors[crDefault]);
//#UC END# *48E22B250241_4E732D8B0291_impl*
end;//TvtCustomHideField.MouseMove
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomHideField.MouseUp(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4E7896270076_4E732D8B0291_var*
var
 l_Point : TPoint;

 function lp_OpenHyperlink: Boolean;
 begin
  Result := (hfoHyperlink in f_Options) and
            (PtInRect(CaptionRect, l_Point) or
            (PtInRect(GetImageRect, l_Point))) and
            (not l3IsNil(CCaption));
 end;//lp_OpenHyperlink

 function lp_CanHide: Boolean;
 begin
  Result := // включено скрытие
            (hfoCanHide in f_Options) and
            // мышь между нажитием и отпусканием не двигали
            PointsEqual(f_DownPoint, l_Point) and
            // в пределах линии заголовка
            PtInRect(GetHeaderLineRect, l_Point);
 end;//lp_CanHide
//#UC END# *4E7896270076_4E732D8B0291_var*
begin
//#UC START# *4E7896270076_4E732D8B0291_impl*
 inherited;
 if Button = mbLeft then
 begin
  l_Point := Point(X, Y);
  if lp_OpenHyperlink then
   DoHyperlink
  else
   if lp_CanHide then
    ExchangeState;
 end;//if Button = mbLeft then
//#UC END# *4E7896270076_4E732D8B0291_impl*
end;//TvtCustomHideField.MouseUp
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomHideField.MouseDown(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4F88473B03CD_4E732D8B0291_var*
//#UC END# *4F88473B03CD_4E732D8B0291_var*
begin
//#UC START# *4F88473B03CD_4E732D8B0291_impl*
 inherited;
 if Button = mbLeft then
 begin
  f_DownPoint := Point(X, Y);
  if TabStop AND not Focused then
  begin
   SetFocus;
   Invalidate;
  end;//TabStop AND not Focused
 end else
  f_DownPoint := Point(-1, -1);
//#UC END# *4F88473B03CD_4E732D8B0291_impl*
end;//TvtCustomHideField.MouseDown
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomHideField.AdjustClientRect(var Rect: TRect);
//#UC START# *508F957E0283_4E732D8B0291_var*
//#UC END# *508F957E0283_4E732D8B0291_var*
begin
//#UC START# *508F957E0283_4E732D8B0291_impl*
 inherited;
 with HeaderRect do
  Inc(Rect.Top, Bottom - Top);
 // Отступ слева
 Inc(Rect.Left, f_ClientIndent);
 // Отступ снизу
 Dec(Rect.Bottom, f_AfterClientSpace); 
//#UC END# *508F957E0283_4E732D8B0291_impl*
end;//TvtCustomHideField.AdjustClientRect
{$IfEnd} // NOT Defined(NoVCL)

//#UC START# *4E732D7F0082impl*
//#UC END# *4E732D7F0082impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomHideField);
 {* Регистрация TvtCustomHideField }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtHideField);
 {* Регистрация TvtHideField }
{$IfEnd} // NOT Defined(NoScripts)

end.
