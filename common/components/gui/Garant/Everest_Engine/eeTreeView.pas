unit eeTreeView;
 {* Компонент для импорта отображения дерева. Для конечного использования. }

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeTreeView.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TeeTreeView" MUID: (494B949E022B)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , l3TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , eeInterfaces
 , eeTreeViewExport
 , Messages
;

type
 TeeCurrentChanged = procedure(aSender: TObject;
  aNewCurrent: Integer;
  aOldCurrent: Integer) of object;
  {* событие для обработки изменения текущего элемента }

 TeeNewCharPressed = procedure(aChar: AnsiChar) of object;
  {* событие для внешней обработки WMChar }

 TeeMakeTreeSource = procedure(out theTree: Il3SimpleTree) of object;

 TeeGetItemImage = function(aSender: TObject;
  anIndex: Integer;
  var aImages: TCustomImageList): Integer of object;
  {* событие для определения иконки элемента }

 TeeActionElement = procedure(aSender: TObject;
  anIndex: Integer) of object;
  {* событие для обработки "двойного клика" на элементе }

 TeeBeforeExpandNode = function(Sender: TObject;
  const CNode: IeeNode;
  anExpand: Boolean): Boolean of object;

 TeeExpandNodeEvent = procedure(Sender: TObject;
  const CNode: IeeNode) of object;

 TeeCustomTreeView = class(TeeTreeViewExport)
  {* Компонент для импорта отображения дерева }
  private
   f_OnMakeTreeSource: TeeMakeTreeSource;
   f_BeforeExpand: TeeBeforeExpandNode;
   f_OnExpand: TeeExpandNodeEvent;
   f_OnCollapse: TeeExpandNodeEvent;
   f_OnNewCharPressed: TeeNewCharPressed;
  protected
   procedure vlbProcessingChar(const aMsg: TWMChar); override;
    {* processing new pressed char }
   function MakeTreeStruct: Il3SimpleTree; override;
   function DoOnExpand(Expand: Boolean;
    const CNode: Il3SimpleNode): Boolean; override;
    {* если CNode = nil значит выполнили операцию свернуть\развернуть все }
  public
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
 l3ImplUses
 , Windows
 , l3Const
 , l3Types
 , eeNode
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TeeCustomTreeView.vlbProcessingChar(const aMsg: TWMChar);
 {* processing new pressed char }
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
end;//TeeCustomTreeView.vlbProcessingChar

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
 {* если CNode = nil значит выполнили операцию свернуть\развернуть все }
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
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeCustomTreeView);
 {* Регистрация TeeCustomTreeView }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeTreeView);
 {* Регистрация TeeTreeView }
{$IfEnd} // NOT Defined(NoScripts)

end.
