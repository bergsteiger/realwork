unit eeTreeView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeTreeView.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::Tree::TeeTreeView
//
// Компонент для импорта отображения дерева. Для конечного использования.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  l3TreeInterfaces,
  eeInterfaces,
  eeTreeViewExport
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  Messages
  ;

type
 TeeCurrentChanged = procedure (aSender: TObject;
  aNewCurrent: Integer;
  aOldCurrent: Integer) of object;

 TeeNewCharPressed = procedure (aChar: AnsiChar) of object;

 TeeMakeTreeSource = procedure (out theTree: Il3SimpleTree) of object;

 TeeGetItemImage = function (aSender: TObject;
  anIndex: Integer;
  var aImages: TCustomImageList): Integer of object;

 TeeActionElement = procedure (aSender: TObject;
  anIndex: Integer) of object;

 TeeBeforeExpandNode = function (Sender: TObject;
  const CNode: IeeNode;
  anExpand: Boolean): Boolean of object;

 TeeExpandNodeEvent = procedure (Sender: TObject;
  const CNode: IeeNode) of object;

 TeeCustomTreeView = class(TeeTreeViewExport)
  {* Компонент для импорта отображения дерева }
 private
 // private fields
   f_OnMakeTreeSource : TeeMakeTreeSource;
    {* Поле для свойства OnMakeTreeSource}
   f_BeforeExpand : TeeBeforeExpandNode;
    {* Поле для свойства BeforeExpand}
   f_OnExpand : TeeExpandNodeEvent;
    {* Поле для свойства OnExpand}
   f_OnCollapse : TeeExpandNodeEvent;
    {* Поле для свойства OnCollapse}
   f_OnNewCharPressed : TeeNewCharPressed;
    {* Поле для свойства OnNewCharPressed}
 protected
 // overridden protected methods
   procedure VlbProcessingChar(const aMsg: TWMChar); override;
     {* processing new pressed char }
   function MakeTreeStruct: Il3SimpleTree; override;
   function DoOnExpand(Expand: Boolean;
     const CNode: Il3SimpleNode): Boolean; override;
     {* если CNode = nil значит выполнили операцию свернуть\развернуть все }
 public
 // public properties
   property TreeView: IeeTreeView
     read pm_GetTreeView;
     {* дерево, отображаемое компонентом. }
   property OnMakeTreeSource: TeeMakeTreeSource
     read f_OnMakeTreeSource
     write f_OnMakeTreeSource;
   property BeforeExpand: TeeBeforeExpandNode
     read f_BeforeExpand
     write f_BeforeExpand;
   property OnExpand: TeeExpandNodeEvent
     read f_OnExpand
     write f_OnExpand;
   property OnCollapse: TeeExpandNodeEvent
     read f_OnCollapse
     write f_OnCollapse;
   property OnNewCharPressed: TeeNewCharPressed
     read f_OnNewCharPressed
     write f_OnNewCharPressed;
 end;//TeeCustomTreeView

//#UC START# *494B949E022Bci*
//#UC END# *494B949E022Bci*
//#UC START# *494B949E022Bcit*
//#UC END# *494B949E022Bcit*
 TeeTreeView = class(TeeCustomTreeView)
  {* Компонент для импорта отображения дерева. Для конечного использования. }
//#UC START# *494B949E022Bpubl*
    published
    // published properties
      property Align;
        {-}
      property BorderStyle;
        {-}
      property TabOrder;
        {-}
      property Header;
        {-}
      property ShowHeader;
        {-}
      property PopupMenu;
        {-}
      property Controller;
        {-}
      property PickedList;
        {-}
      property ShowRoot;
        {-}  
      property DblClickOnFolder;
        {-}
      property Images;
        {-}
      property MultiSelect;
        {-}
      property MultiStrokeItem;
        {-}
      property ActionElementMode;
        {-}
      property ViewOptions;
        {-}
      property NeedStatus;
        {-}
      property ClearTreeStructOnSaveState;
        {-}
      property StyleId;
        {-}
      property AllowWithoutCurrent;
        {-}
    published
    // published events
      property OnSelectChange;
        {-}
      property OnSelectChanged;
        {-}
      property OnGetItemPickImage;
        {-}
      property OnGetItemIconHint;
        {-}
      property OnRMouseDown;
        {-}
      property OnLMouseDown;
        {-}
      property OnMakeTreeSource;
        {-}
      property OnExpand;
        {* -сообщение о развертывании узла дерева}
      property OnCollapse;
        {* -сообщение о свертывании узла дерева}
      property BeforeExpand;
        {-}
      property OnValidateCurrent;
        {-}
      property OnGetItemStyle;
        {-}
      property OnGetItemCursor;
        {-}
      property OnGetItemImage;
        {-}
      property OnGetItemTextHint;
        {-}
      property OnActionElement;
        {-}
      property OnCurrentChanged;
        {-}
      property OnTreeChanged;
        {-}
      property OnRootChanged;
        {-}
      property OnSelectCountChanged;
        {-}
      property OnFormatStatusInfo;
        {-}
      property OnGetItemFont;
        {-}
      property OnNewCharPressed;
        {-}
      property OnBeforeWake;
        {-}
      property OnAfterWake;
        {-}
      property OnAfterFirstPaint;
        {-}
      property OnCheckFocusedInPaint;
        {-}
      property OnCanBeginDrag;
        {- dnd support}
      property OnCanAcceptData;
        {- dnd support}
      property OnDoDrop;
        {- dnd support}
      property DragAndDropSupported;
        {- dnd support}
      property FooterCaption;
        {-}
      property FooterVisible;
        {-}
      property FooterFont;
        {-}
      property FooterStyleID;
        {-}
      property OnFooterClick;
        {-}
      property FooterActiveFont;
        {-}
      property FooterActiveStyleID;
        {-}
//#UC END# *494B949E022Bpubl*
 end;//TeeTreeView

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  Windows,
  l3Const,
  l3Types,
  eeNode
  ;

// start class TeeCustomTreeView

procedure TeeCustomTreeView.VlbProcessingChar(const aMsg: TWMChar);
//#UC START# *5152C04F0258_531F287D025D_var*
 function IsNumPlus: Boolean;
 begin
  Result := Tl3MakeWord(Tl3MakeLong(aMsg.KeyData).Hi).Lo = 78;
 end;
//#UC END# *5152C04F0258_531F287D025D_var*
begin
//#UC START# *5152C04F0258_531F287D025D_impl*
 if Assigned(f_OnNewCharPressed) then
 begin
  if not IsNumPlus then
   f_OnNewCharPressed(AnsiChar(aMsg.CharCode));
 end
 else
  inherited;
//#UC END# *5152C04F0258_531F287D025D_impl*
end;//TeeCustomTreeView.VlbProcessingChar

function TeeCustomTreeView.MakeTreeStruct: Il3SimpleTree;
//#UC START# *515EF1880228_531F287D025D_var*
//#UC END# *515EF1880228_531F287D025D_var*
begin
//#UC START# *515EF1880228_531F287D025D_impl*
 Result := nil;
 if Assigned(f_OnMakeTreeSource) then
  f_OnMakeTreeSource(Result);
 if (Result = nil) then
  Result := inherited MakeTreeStruct;
//#UC END# *515EF1880228_531F287D025D_impl*
end;//TeeCustomTreeView.MakeTreeStruct

function TeeCustomTreeView.DoOnExpand(Expand: Boolean;
  const CNode: Il3SimpleNode): Boolean;
//#UC START# *51629C9B00C2_531F287D025D_var*
//#UC END# *51629C9B00C2_531F287D025D_var*
begin
//#UC START# *51629C9B00C2_531F287D025D_impl*
 if not Assigned(f_BeforeExpand) OR
    f_BeforeExpand(Self, TeeNode.Make(CNode), Expand) then
 begin
  Result := inherited DoOnExpand(Expand, CNode);
  if Result then
  begin
   if Expand then
   begin
    if Assigned(f_OnExpand) then
     f_OnExpand(Self, TeeNode.Make(CNode));
   end
   else
   begin
    if Assigned(f_OnCollapse) then
     f_OnCollapse(Self, TeeNode.Make(CNode));
   end;//Expand
  end;//Result
 end
 else
  Result := false;
//#UC END# *51629C9B00C2_531F287D025D_impl*
end;//TeeCustomTreeView.DoOnExpand

//#UC START# *494B949E022Bimpl*
//#UC END# *494B949E022Bimpl*

initialization
{$If not defined(NoScripts)}
// Регистрация TeeCustomTreeView
 TtfwClassRef.Register(TeeCustomTreeView);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TeeTreeView
 TtfwClassRef.Register(TeeTreeView);
{$IfEnd} //not NoScripts

end.