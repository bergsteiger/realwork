unit PrimCompInfo_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimCompInfo_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::PrimCompInfo
//
// Информация о комплекте
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
  l3ObjectList,
  l3ControlsTypes
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  vtPanel
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  vtLabel,
  l3StringIDEx,
  nscTreeViewWithAdapterDragDrop
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _vcmChromeLikeTabIconUpdater_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimCompInfoForm = {abstract form} class(_vcmChromeLikeTabIconUpdater_)
  {* Информация о комплекте }
 private
 // private fields
   f_tvComplectInfo : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства tvComplectInfo}
   f_pnBottom : TvtPanel;
    {* Поле для свойства pnBottom}
   f_pnVisualRepresentationData : TvtPanel;
    {* Поле для свойства pnVisualRepresentationData}
   f_pnVisualRepresentationDataCaption : TvtPanel;
    {* Поле для свойства pnVisualRepresentationDataCaption}
   f_lblVisualRepresentationData : TvtLabel;
    {* Поле для свойства lblVisualRepresentationData}
   f_ControlsToFree : Tl3ObjectList;
    {* Поле для свойства ControlsToFree}
 protected
  procedure MakeControls; override;
 private
 // private methods
   function TvComplectInfoGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   procedure VcmEntityFormSetLocalizationInfo(Sender: TObject;
     const theInfo: AnsiString);
   procedure VcmEntityFormGetLocalizationInfo(Sender: TObject;
     var theInfo: AnsiString);
   procedure InitVisualRepresentationData;
     {* Сигнатура метода InitVisualRepresentationData }
   procedure ReleaseResources;
     {* Сигнатура метода ReleaseResources }
 protected
 // property methods
   function pm_GetControlsToFree: Tl3ObjectList;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
   function DoGetTabImageIndex: Integer; override;
    {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
 private
 // private properties
   property ControlsToFree: Tl3ObjectList
     read pm_GetControlsToFree;
     {* Все динамически создаваемые контролы. }
 public
 // public properties
   property tvComplectInfo: TnscTreeViewWithAdapterDragDrop
     read f_tvComplectInfo;
   property pnBottom: TvtPanel
     read f_pnBottom;
   property pnVisualRepresentationData: TvtPanel
     read f_pnVisualRepresentationData;
   property pnVisualRepresentationDataCaption: TvtPanel
     read f_pnVisualRepresentationDataCaption;
   property lblVisualRepresentationData: TvtLabel
     read f_lblVisualRepresentationData;
     {* Ваш комплект системы ГАРАНТ: }
 end;//TPrimCompInfoForm

 TvcmEntityFormRef = TPrimCompInfoForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  nsUtils,
  nsTreeUtils,
  nsComplectInfoTreeStruct,
  nsSettings,
  ComplectInfoRes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  Gauges,
  nsTypes,
  ComplectUnit,
  DataAdapter
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Graphics,
  Classes,
  SysUtils,
  vtGauge,
  nsTabbedInterfaceTypes,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TPrimCompInfoForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

var
   { Локализуемые строки CompInfo Header Strings }
  str_Name : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Name'; rValue : 'Название');
   { 'Название' }
  str_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Value'; rValue : 'Значение');
   { 'Значение' }

// start class TPrimCompInfoForm

function TPrimCompInfoForm.TvComplectInfoGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *516FC7390348_516FC52E034F_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *516FC7390348_516FC52E034F_var*
begin
//#UC START# *516FC7390348_516FC52E034F_impl*
 l_Node := tvComplectInfo.GetNode(Index);
 try
  if l_Node.GetLevelFor(tvComplectInfo.TreeStruct.RootNode) = 1 then
  begin
   if l_Node.HasChild then
    Result := ciBlocks
   else
    Result := ciMainInfo;
  end//if l_Node.GetLevelFor(tvComplectInfo.TreeStruct.RootNode) = 1 then
  else
  begin
   if l_Node.HasChild then
    Result := ciBlockFolder
   else
    Result := ciBlockInfo;
  end;//if l_Node.GetLevelFor(tvComplectInfo.TreeStruct.RootNode) = 1 then
 finally
  l_Node := nil;
 end;{try..finally}
//#UC END# *516FC7390348_516FC52E034F_impl*
end;//TPrimCompInfoForm.TvComplectInfoGetItemImage

procedure TPrimCompInfoForm.VcmEntityFormSetLocalizationInfo(Sender: TObject;
  const theInfo: AnsiString);
//#UC START# *516FC8600180_516FC52E034F_var*
//#UC END# *516FC8600180_516FC52E034F_var*
begin
//#UC START# *516FC8600180_516FC52E034F_impl*
 if Sender = tvComplectInfo then
  nsSetListHeaderLocalizationInfo(tvComplectInfo.Header, theInfo);
//#UC END# *516FC8600180_516FC52E034F_impl*
end;//TPrimCompInfoForm.VcmEntityFormSetLocalizationInfo

procedure TPrimCompInfoForm.VcmEntityFormGetLocalizationInfo(Sender: TObject;
  var theInfo: AnsiString);
//#UC START# *516FC885021E_516FC52E034F_var*
//#UC END# *516FC885021E_516FC52E034F_var*
begin
//#UC START# *516FC885021E_516FC52E034F_impl*
 if Sender = tvComplectInfo then
  theInfo := nsGetListHeaderLocalizationInfo(tvComplectInfo.Header);
//#UC END# *516FC885021E_516FC52E034F_impl*
end;//TPrimCompInfoForm.VcmEntityFormGetLocalizationInfo

procedure TPrimCompInfoForm.InitVisualRepresentationData;
//#UC START# *53E0F4FA00B8_516FC52E034F_var*
var
 l_HasVisualRepresentation: Boolean;
 l_CI: IComplectInfo;
 l_VRL: IVisualRepresentationList;
 l_Item: TVisualRepresentation;
 l_LastTop, l_LabWidth: Integer;
 I: Integer;
 l_Captions: Tl3ObjectList;
 l_Gauges: Tl3ObjectList;
 l_PercentLabel: TvtLabel;
//#UC END# *53E0F4FA00B8_516FC52E034F_var*
begin
//#UC START# *53E0F4FA00B8_516FC52E034F_impl*
 ReleaseResources;
 
 l_HasVisualRepresentation := False;
 l_LastTop := 0;
 l_LabWidth := 0;
 l_CI := DefDataAdapter.NativeAdapter.MakeComplectInfo;
 try
  l_CI.GetVisualRepresentationData(l_VRL);
  try
   if Assigned(l_VRL) and (l_VRL.Count > 0) then
   begin
    l_Captions := Tl3ObjectList.Create; // метки с названиями градусников
    l_Gauges := Tl3ObjectList.Create; // градусники
    try
     l_Captions.Count := l_VRL.Count;
     l_Gauges.Count := l_Captions.Count;
     for I := 0 to l_Captions.Count - 1 do
     begin
      l_VRL.pm_GetItem(I, l_Item);
      l_Gauges[I] := TvtGauge.Create(Self);
      ControlsToFree.Add(l_Gauges[I]);
      TvtGauge(l_Gauges[I]).Progress := Integer(l_Item.rPercent);
      if Integer(l_Item.rPercent) > 0 then
       l_HasVisualRepresentation := True;
      l_Captions[I] := TvtLabel.Create(Self);
      ControlsToFree.Add(l_Captions[I]);
      with TvtLabel(l_Captions[I]) do
      begin
       CCaption := nsCStr(l_Item.rName);
       Parent := pnVisualRepresentationData;
       Left := 5;
       if l_LastTop = 0 then
        Top := pnVisualRepresentationDataCaption.Height + 5
       else
        Top := l_LastTop + 25;
       l_LastTop := Top;
       if Width > l_LabWidth then
        l_LabWidth := Width;
      end;
     end;
     if not l_HasVisualRepresentation then
      Exit;
     for I := 0 to l_Captions.Count - 1 do
     begin
      with TvtLabel(l_Captions[I]) do
      begin
       Autosize := False; // окончательная настройка заголовков: теперь мы знаем ширину меток
       Width := l_LabWidth;
       Alignment := taRightJustify;
      end;
      with TvtGauge(l_Gauges[I]) do
      begin
       Parent := pnVisualRepresentationData;
       Left := l_LabWidth + 10;
       Top := TvtLabel(l_Captions[I]).Top - 3;
       Height := 20;
       Width := pnVisualRepresentationData.Width - 50 - Left;
       ShowText := False;
       ForeColor := $AA0000;
       BackColor := $FF7777;
       BorderStyle := bsNone;
      end;
      l_PercentLabel := TvtLabel.Create(Self);
      ControlsToFree.Add(l_PercentLabel);
      with l_PercentLabel do // метки с процентами
      begin
       Parent := pnVisualRepresentationData;
       Top := TvtLabel(l_Captions[I]).Top;
       Autosize := False;
       Left := TvtGauge(l_Gauges[I]).Left + TvtGauge(l_Gauges[I]).Width;
       Width := pnVisualRepresentationData.Width - Left;
       Alignment := taCenter;
       CCaption := l3CStr(IntToStr(TvtGauge(l_Gauges[I]).Progress) + '%');
      end;
     end;
     with TvtGauge(l_Gauges[l_Gauges.Count - 1]) do
      pnVisualRepresentationData.Height := Top + Height + 10;
     pnBottom.Height := pnVisualRepresentationData.Height + 2;
    finally
     l3Free(l_Captions);
     l3Free(l_Gauges);
    end;
   end;
  finally
   l_VRL := nil;
  end;
 finally
  l_CI := nil;
  pnBottom.Visible := l_HasVisualRepresentation;
  if not l_HasVisualRepresentation then
   ReleaseResources;
 end;
//#UC END# *53E0F4FA00B8_516FC52E034F_impl*
end;//TPrimCompInfoForm.InitVisualRepresentationData

procedure TPrimCompInfoForm.ReleaseResources;
//#UC START# *53E4A7FA0026_516FC52E034F_var*
var
 I: Integer;
 l_Obj: TObject;
//#UC END# *53E4A7FA0026_516FC52E034F_var*
begin
//#UC START# *53E4A7FA0026_516FC52E034F_impl*
 for I := 0 to ControlsToFree.Count - 1 do
 begin
  l_Obj := ControlsToFree[I];
  FreeAndNil(l_Obj);
 end;
 ControlsToFree.Clear;
//#UC END# *53E4A7FA0026_516FC52E034F_impl*
end;//TPrimCompInfoForm.ReleaseResources

function TPrimCompInfoForm.pm_GetControlsToFree: Tl3ObjectList;
//#UC START# *53E49B0D02C4_516FC52E034Fget_var*
//#UC END# *53E49B0D02C4_516FC52E034Fget_var*
begin
//#UC START# *53E49B0D02C4_516FC52E034Fget_impl*
 if not Assigned(f_ControlsToFree) then
  f_ControlsToFree := Tl3ObjectList.Create;
 Result := f_ControlsToFree;
//#UC END# *53E49B0D02C4_516FC52E034Fget_impl*
end;//TPrimCompInfoForm.pm_GetControlsToFree

procedure TPrimCompInfoForm.Cleanup;
//#UC START# *479731C50290_516FC52E034F_var*
//#UC END# *479731C50290_516FC52E034F_var*
begin
//#UC START# *479731C50290_516FC52E034F_impl*
 ReleaseResources;
 l3Free(f_ControlsToFree);
 inherited;
//#UC END# *479731C50290_516FC52E034F_impl*
end;//TPrimCompInfoForm.Cleanup

procedure TPrimCompInfoForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_516FC52E034F_var*
//#UC END# *47EA4E9002C6_516FC52E034F_var*
begin
//#UC START# *47EA4E9002C6_516FC52E034F_impl*
 inherited;
 InitVisualRepresentationData;
//#UC END# *47EA4E9002C6_516FC52E034F_impl*
end;//TPrimCompInfoForm.FinishDataUpdate

{$If not defined(NoVCM)}
procedure TPrimCompInfoForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_516FC52E034F_var*
//#UC END# *49803F5503AA_516FC52E034F_var*
begin
//#UC START# *49803F5503AA_516FC52E034F_impl*
 inherited;
 TvcmTabbedContainerFormDispatcher.Instance.UpdateTabCaption(As_IvcmEntityForm, DoGetTabCaption);
//#UC END# *49803F5503AA_516FC52E034F_impl*
end;//TPrimCompInfoForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimCompInfoForm.InitControls;
//#UC START# *4A8E8F2E0195_516FC52E034F_var*
//#UC END# *4A8E8F2E0195_516FC52E034F_var*
begin
//#UC START# *4A8E8F2E0195_516FC52E034F_impl*
 inherited;

 Scaled := False;

 with tvComplectInfo do
 begin
  Align := alClient;
  Images := nsComplectInfoRes.ComplectInfoItemImages;
  TreeStruct := TnsComplectInfoTreeStruct.Make;
  ShowHeader := True;
  SettingId := 'stidComplectInfoTree';
  ViewOptions := [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowLines, voShowOpenChip];
  OnGetItemImage := tvComplectInfoGetItemImage;
 end;
 with tvComplectInfo.Header.Sections.Add do
 begin
  Caption := str_Name.AsStr;
  Width := 350;
  AutoResize := False;
  MinWidth := 350;
 end;
 with tvComplectInfo.Header.Sections.Add do
 begin
  Caption := str_Value.AsStr;
  AutoResize := False;
  MinWidth := 20;
 end;

 with pnBottom do
 begin
  Align := alBottom;
  BorderStyle := bsSingle;
  Color := clWindow;
  Height := 400;
  BevelOuter := bvLowered;
 end;
 with pnVisualRepresentationData do
 begin
  Left := 20;
  Top := 1;
  Height := pnBottom.Height - 2;
  Width := 750;
  BorderStyle := bsNone;
  Color := clWhite;
  BevelOuter := bvNone;
 end;
 with pnVisualRepresentationDataCaption do
 begin
  Align := alTop;
  BorderStyle := bsNone;
  Color := clWhite;
  Height := 30;
  BevelOuter := bvNone;
 end;
 with lblVisualRepresentationData do
 begin
  AutoSize := True;
  Font.Style := [fsBold];
  Font.Size := 12;
  Left := 40;
  Top := (pnVisualRepresentationDataCaption.Height - Height) div 2;
 end;
 InitVisualRepresentationData;
//#UC END# *4A8E8F2E0195_516FC52E034F_impl*
end;//TPrimCompInfoForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimCompInfoForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_516FC52E034F_var*
//#UC END# *53F1C6EF02C9_516FC52E034F_var*
begin
//#UC START# *53F1C6EF02C9_516FC52E034F_impl*
 Result := l3CStr(CurUserType.Caption);
//#UC END# *53F1C6EF02C9_516FC52E034F_impl*
end;//TPrimCompInfoForm.DoGetTabCaption
{$IfEnd} //not NoVCM

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
function TPrimCompInfoForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_516FC52E034F_var*
//#UC END# *543E3AA801D0_516FC52E034F_var*
begin
//#UC START# *543E3AA801D0_516FC52E034F_impl*
 Result := NsTabIconIndex(titComplectInfo);
//#UC END# *543E3AA801D0_516FC52E034F_impl*
end;//TPrimCompInfoForm.DoGetTabImageIndex
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

procedure TPrimCompInfoForm.MakeControls;
begin
 inherited;
 f_tvComplectInfo := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvComplectInfo.Name := 'tvComplectInfo';
 f_tvComplectInfo.Parent := Self;
 f_pnBottom := TvtPanel.Create(Self);
 f_pnBottom.Name := 'pnBottom';
 f_pnBottom.Parent := Self;
 f_pnVisualRepresentationData := TvtPanel.Create(Self);
 f_pnVisualRepresentationData.Name := 'pnVisualRepresentationData';
 f_pnVisualRepresentationData.Parent := pnBottom;
 f_pnVisualRepresentationDataCaption := TvtPanel.Create(Self);
 f_pnVisualRepresentationDataCaption.Name := 'pnVisualRepresentationDataCaption';
 f_pnVisualRepresentationDataCaption.Parent := pnVisualRepresentationData;
 f_lblVisualRepresentationData := TvtLabel.Create(Self);
 f_lblVisualRepresentationData.Name := 'lblVisualRepresentationData';
 f_lblVisualRepresentationData.Parent := pnVisualRepresentationDataCaption;
 f_lblVisualRepresentationData.Caption := 'Ваш комплект системы ГАРАНТ:';
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_Name
 str_Name.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_Value
 str_Value.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimCompInfo
 TtfwClassRef.Register(TPrimCompInfoForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.