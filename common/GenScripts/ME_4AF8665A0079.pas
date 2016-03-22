unit PrimStyleEditorExample_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorExample_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimStyleEditorExample" MUID: (4AF8665A0079)
// Имя типа: "TPrimStyleEditorExampleForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Settings_Strange_Controls
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , eeEditorWithoutOperations
 , nevGUIInterfaces
 , afwInterfaces
;

type
 //#UC START# *4AF8665A0079ci*
 //#UC END# *4AF8665A0079ci*
 //#UC START# *4AF8665A0079cit*
 //#UC END# *4AF8665A0079cit*
 TPrimStyleEditorExampleForm = class(TvcmEntityForm)
  private
   f_TextSource: TnscTextSource;
    {* Поле для свойства TextSource }
   f_EditorPanel: TvtPanel;
    {* Поле для свойства EditorPanel }
   f_Editor: TeeEditorWithoutOperations;
    {* Поле для свойства Editor }
  private
   procedure EditorGetHotSpotInfo(Sender: TObject;
    const aHotSpot: IevHotSpot;
    const aKeys: TafwCursorState;
    var theInfo: TafwCursorInfo);
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure StyleEditor_ReloadStyleTable_Execute;
   procedure StyleEditor_ReloadStyleTable(const aParams: IvcmExecuteParamsPrim);
  public
   property TextSource: TnscTextSource
    read f_TextSource;
   property EditorPanel: TvtPanel
    read f_EditorPanel;
 //#UC START# *4AF8665A0079publ*
 //#UC END# *4AF8665A0079publ*
 end;//TPrimStyleEditorExampleForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Variant
 , nevTools
 , l3InterfacesMisc
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , TextSegment_Const
 , k2Tags
 , evdNativeReader
 , Classes
 , afwFacade
 , l3Memory
 , l3Filer
 , l3Stream
 , l3String
 , l3Base
 , StyledLeafPara_Const
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utStyleEditorExampleLocalConstants }
 str_utStyleEditorExampleCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorExampleCaption'; rValue : 'Текстовое окно редактора стилей');
  {* Заголовок пользовательского типа "Текстовое окно редактора стилей" }

procedure TPrimStyleEditorExampleForm.EditorGetHotSpotInfo(Sender: TObject;
 const aHotSpot: IevHotSpot;
 const aKeys: TafwCursorState;
 var theInfo: TafwCursorInfo);
//#UC START# *526A83CD00ED_4AF8665A0079_var*
var
 l_TagWrap: Il3TagRef;
 l_Point: InevBasePoint;
//#UC END# *526A83CD00ED_4AF8665A0079_var*
begin
//#UC START# *526A83CD00ED_4AF8665A0079_impl*
 if l3BQueryInterface(aHotSpot, Il3TagRef, l_TagWrap) then
  try
   with l_TagWrap.AsObject do
    if IsKindOf(k2_typTextSegment) then
     with theInfo do
     begin
      rCursor := ev_csHelp;
      rHint := vcmFmt(str_StyleEditorExampleHint, [Attr[k2_tiStyle].AsString]);
      Exit;
     end;//with theInfo
  finally
   l_TagWrap := nil;
  end;
 if (Sender As TevCustomEditorWindow).GetPtPoint(aKeys.rPoint, l_Point) then
  with l_Point.MostInner.Obj^ do
   if AsObject.IsKindOf(k2_typStyledLeafPara) then
    with theInfo do
    begin
     rCursor := ev_csHelp;
     rHint := vcmFmt(str_StyleEditorExampleHint, [AsObject.Attr[k2_tiStyle].AsString]);
     Exit;
    end;//with theInfo
//#UC END# *526A83CD00ED_4AF8665A0079_impl*
end;//TPrimStyleEditorExampleForm.EditorGetHotSpotInfo

procedure TPrimStyleEditorExampleForm.StyleEditor_ReloadStyleTable_Execute;
//#UC START# *4AF8660E0079_4AF8665A0079exec_var*
var
 l_StyleTableSpy: IafwStyleTableSpy;
//#UC END# *4AF8660E0079_4AF8665A0079exec_var*
begin
//#UC START# *4AF8660E0079_4AF8665A0079exec_impl*
 if Supports(f_TextSource, IafwStyleTableSpy, l_StyleTableSpy) then
  try
   l_StyleTableSpy.StyleTableChanged;
  finally
   l_StyleTableSpy := nil;
  end
 else
  Assert(False, 'Can''t query "IafwStyleTableSpy" interface');
//#UC END# *4AF8660E0079_4AF8665A0079exec_impl*
end;//TPrimStyleEditorExampleForm.StyleEditor_ReloadStyleTable_Execute

procedure TPrimStyleEditorExampleForm.StyleEditor_ReloadStyleTable(const aParams: IvcmExecuteParamsPrim);
begin
 Self.StyleEditor_ReloadStyleTable_Execute;
end;//TPrimStyleEditorExampleForm.StyleEditor_ReloadStyleTable

procedure TPrimStyleEditorExampleForm.InitFields;
//#UC START# *47A042E100E2_4AF8665A0079_var*
const
 CDefaultStyleTableExampleResourceName = 'nsDefaultStyleTableExample';
var
 l_Filer: Tl3CustomFiler;
 l_Reader: TevdNativeReader;
 l_Stream: TStream;
 l_String: String;
//#UC END# *47A042E100E2_4AF8665A0079_var*
begin
//#UC START# *47A042E100E2_4AF8665A0079_impl*
 inherited;
 ActiveControl := f_Editor;
 BorderIcons := [];
 Anchors := [];

 try
  if afw.Application.LocaleInfo.Language = afw_lngRussian then
   l_String := ''
  else
   l_String := vcmConstString(str_StyleTableExample);
  if (l_String <> '') then
   l_Stream := Tl3StringStream.Create(l3PCharLen(l_String))
  else
   l_Stream := Tl3ResourceStream.Create(HInstance, CDefaultStyleTableExampleResourceName);
  try
   l_Filer := Tl3CustomFiler.Create;
   try
    l_Filer.Stream := l_Stream;
    l_Reader := TevdNativeReader.Create;
    try
     l_Reader.Filer := l_Filer;
     f_Editor.TextSource.Load(l_Reader);
    finally
     l3Free(l_Reader);
    end;//try..finally
   finally
    l3Free(l_Filer);
   end;//try..finally
  finally
   l3Free(l_Stream);
  end;//try..finally
 except
  on EResNotFound do;
 end;//try..except
//#UC END# *47A042E100E2_4AF8665A0079_impl*
end;//TPrimStyleEditorExampleForm.InitFields

procedure TPrimStyleEditorExampleForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AF8665A0079_var*
//#UC END# *4A8E8F2E0195_4AF8665A0079_var*
begin
//#UC START# *4A8E8F2E0195_4AF8665A0079_impl*
 inherited;
 with f_EditorPanel do
 begin
  Align := alClient;
  BevelInner := bvRaised;
  BevelOuter := bvLowered;
 end;
 with f_Editor do
 begin
  Align := alClient;
  TextSource := f_TextSource;
  IsStaticText := True;
  OnGetHotSpotInfo := EditorGetHotSpotInfo;
 end;
//#UC END# *4A8E8F2E0195_4AF8665A0079_impl*
end;//TPrimStyleEditorExampleForm.InitControls

//#UC START# *4AF8665A0079impl*
{$R PrimStyleEditorExample_Form.res}
//#UC END# *4AF8665A0079impl*

initialization
 str_utStyleEditorExampleCaption.Init;
 {* Инициализация str_utStyleEditorExampleCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimStyleEditorExampleForm);
 {* Регистрация PrimStyleEditorExample }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
