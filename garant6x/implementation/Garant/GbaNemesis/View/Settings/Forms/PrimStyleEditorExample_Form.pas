unit PrimStyleEditorExample_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimStyleEditorExample_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Основные прецеденты::Settings::View::Settings::PrimStyleEditorExample
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwInterfaces,
  evCustomEditorWindow
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  nevGUIInterfaces,
  vtPanel,
  Settings_Strange_Controls,
  l3StringIDEx,
  eeEditorWithoutOperations
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimStyleEditorExample_utStyleEditorExample_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
//#UC START# *4AF8665A0079ci*
//#UC END# *4AF8665A0079ci*
//#UC START# *4AF8665A0079cit*
//#UC END# *4AF8665A0079cit*
 TPrimStyleEditorExampleForm = {form} class(TvcmEntityForm)
 private
 // private fields
   f_TextSource : TnscTextSource;
    {* Поле для свойства TextSource}
   f_EditorPanel : TvtPanel;
    {* Поле для свойства EditorPanel}
   f_Editor : TeeEditorWithoutOperations;
    {* Поле для свойства Editor}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure EditorGetHotSpotInfo(Sender: TObject;
     const aHotSpot: IevHotSpot;
     const aKeys: TafwCursorState;
     var theInfo: TafwCursorInfo);
 protected
 // realized methods
   procedure StyleEditor_ReloadStyleTable_Execute;
   procedure StyleEditor_ReloadStyleTable(const aParams: IvcmExecuteParams);
 protected
 // overridden protected methods
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 public
 // public properties
   property TextSource: TnscTextSource
     read f_TextSource;
   property EditorPanel: TvtPanel
     read f_EditorPanel;
   property Editor: TeeEditorWithoutOperations
     read f_Editor;
//#UC START# *4AF8665A0079publ*
//#UC END# *4AF8665A0079publ*
 end;//TPrimStyleEditorExampleForm

 TvcmEntityFormRef = TPrimStyleEditorExampleForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Variant,
  nevTools,
  l3InterfacesMisc
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  TextSegment_Const,
  k2Tags,
  evdNativeReader,
  Classes,
  afwFacade,
  l3Memory,
  l3Filer,
  l3Stream,
  l3String,
  l3Base,
  StyledLeafPara_Const,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utStyleEditorExampleLocalConstants }
  str_utStyleEditorExampleCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorExampleCaption'; rValue : 'Текстовое окно редактора стилей');
   { Заголовок пользовательского типа "Текстовое окно редактора стилей" }

// start class TPrimStyleEditorExampleForm

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

procedure TPrimStyleEditorExampleForm.StyleEditor_ReloadStyleTable(const aParams: IvcmExecuteParams);
begin
 StyleEditor_ReloadStyleTable_Execute;
end;

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

{$If not defined(NoVCM)}
procedure TPrimStyleEditorExampleForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimStyleEditorExampleForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_StyleEditor, nil);
  PublishOpWithResult(en_StyleEditor, op_ReloadStyleTable, StyleEditor_ReloadStyleTable, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimStyleEditorExampleForm.MakeControls;
begin
 inherited;
 f_TextSource := TnscTextSource.Create(Self);
 f_TextSource.Name := 'TextSource';
 with AddUsertype(utStyleEditorExampleName,
  str_utStyleEditorExampleCaption,
  str_utStyleEditorExampleCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utStyleEditorExampleName
 f_EditorPanel := TvtPanel.Create(Self);
 f_EditorPanel.Name := 'EditorPanel';
 f_EditorPanel.Parent := Self;
 f_Editor := TeeEditorWithoutOperations.Create(Self);
 f_Editor.Name := 'Editor';
 f_Editor.Parent := EditorPanel;
end;

//#UC START# *4AF8665A0079impl*
{$R PrimStyleEditorExample_Form.res}
//#UC END# *4AF8665A0079impl*

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utStyleEditorExampleCaption
 str_utStyleEditorExampleCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimStyleEditorExample
 TtfwClassRef.Register(TPrimStyleEditorExampleForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.