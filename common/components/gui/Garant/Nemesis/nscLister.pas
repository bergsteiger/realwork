unit nscLister;

(*-----------------------------------------------------------------------------
 Название:   nscLister
 Автор:      М. Морозов
 Назначение:
 Версия:
   $Id: nscLister.pas,v 1.15 2014/07/02 14:45:30 lulin Exp $
 История:
   $Log: nscLister.pas,v $
   Revision 1.15  2014/07/02 14:45:30  lulin
   - собираем библиотеки.

   Revision 1.14  2014/02/19 09:08:50  morozov
   {RequestLink: 294584542}

   Revision 1.13  2014/02/13 11:48:41  morozov
   {RequestLink: 294584542}

   Revision 1.12  2011/04/18 17:38:14  lulin
   {RequestLink:263750840}.

   Revision 1.11  2011/04/18 17:13:22  lulin
   {RequestLink:263750840}.

   Revision 1.10  2007/10/17 11:00:04  mmorozov
   - change: отказываемся от шаблона для публикации операций, т.к. для Desing-Time использование шаблона недопустимо;

   Revision 1.9  2007/10/17 09:27:08  mmorozov
   - new: публикация операций "Выделить все", "Снять выделение" выделена в отдельный шаблон;

   Revision 1.8  2007/02/13 11:44:30  mmorozov
   - new: заголовок дерева (TvtHeader) использует таблицу стилей (CQ: OIT5-24283);

   Revision 1.7  2005/04/20 08:55:58  demon
   - new behavior: Свойство OnClickHeader переехало в TvtListerHeader , а у TvtCustomLister оно исчезло (изменение от Василия)

   Revision 1.6  2005/03/21 08:00:33  mmorozov
   new: опубликовано свойство TnscLister.StyleId;

   Revision 1.5  2005/03/14 15:11:22  mmorozov
   - использование property TvtCustomLister.UseStyleTable;

   Revision 1.4  2005/02/21 17:36:15  lulin
   - удалено ненужное свойство.

   Revision 1.3  2005/02/21 16:54:10  lulin
   - удалено ненужное свойство.

   Revision 1.2  2004/12/25 09:11:32  mmorozov
   new: published property OnGetItemTextHint;

   Revision 1.1  2004/12/09 10:17:12  mmorozov
   new: наследник TvtLister используемый в проекте Немезис;

-----------------------------------------------------------------------------*)

interface

uses
  Classes,
  Messages,

  l3InternalInterfaces,
  l3Types,

  vtLister,

  vcmExternalInterfaces
  ;

type

  TnscCustomLister = class(TvtCustomLister,
                           {$IfNDef NoVCM}
                           IvcmOperationsProvider,
                           {$EndIf  NoVCM}
                           Il3CommandPublisherInfo
                           )
  {* - компонент TvtCutomLister используемый в Немезисе. }
  private
  // internal fields
    f_Published : Boolean;
  private
  // Il3CommandPublisherInfo
    function IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
      {-}
  protected
  // IvcmOperationsProvider
    {$IfNDef NoVCM}
    procedure ProvideOps(const aPublisher : IvcmOperationsPublisher);
      virtual;
      {* - предоставить список доступных операций. }
    {$EndIf  NoVCM}  
  protected
  // operation handlers
    {$IfNDef NoVCM}
    procedure DeselectAllExecute(const aParams : IvcmExecuteParamsPrim);
    procedure DeselectAllTest(const aParams : IvcmTestParamsPrim);
      {-}
    procedure SelectAllExecute(const aParams : IvcmExecuteParamsPrim);
    procedure SelectAllTest(const aParams : IvcmTestParamsPrim);
      {-}
    {$EndIf  NoVCM}  
    function DoIsCommandPublished(Cmd: Tl3OperationCode): Boolean;
      virtual;
      {-}
  protected
  // property methods
    function pm_GetIsEmpty: Boolean;
      {* - наличие элементов в дереве. }
  protected
  // properties
    property IsEmpty: Boolean
      read pm_GetIsEmpty;
      {-}
  public
  //public methods
    constructor Create(AOwner : TComponent);
      override;
      {-}
  end;//TnscCustomLister

  TnscLister = class(TnscCustomLister)
  {* - компонент для DesignTime. }
  published
  // published properties
    property Images;
    property AutoRowHeight;
    property BorderStyle;
    property Columns;
    property Header;
    property IntegralHeight;
    property MultiSelect;
    property InternalSelector;
    property ProtectColor;
    property RowHeight;
    property ScrollStyle;
    property SelectColor;
    property SelectNonFocusColor;
    property ShowHeader;
    property UseTabStops;
    property PickedList;
    property TriplePicked;
    property MultiStrokeItem;
    property ReadOnly;
    property ViewOptions;
    property ActionElementMode;
    property StyleId;

    property OnCharToItem;
    property OnGetStrItem;
    property OnGetPCharItem;
    property OnGetItemImageIndex; //OnGetItemBitmap;
    property OnGetItemColor;
    property OnGetItemFont;
    property OnGetItemCursor;
    property OnGetItemStatus;
    property OnGetItemTextHint;
    property OnIsSelected;
    property OnSelect;
    property OnSelectChange;
    property OnSelectChanged;
    property OnTopIndexChanged;
    property OnCurrentChanged;
    property OnCountChanged;
    property OnUserCommand;
    property OnIsCommandProcessed;

    {inherited properties}
    property Align;
    property Color;
    property Controller;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Anchors;
    property Constraints;

    {inherited events}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnActionElement;
    property OnResize;
  end;

implementation

uses
  Windows,
  StdCtrls,
  ovcConst,

  l3Base,

  OfficeLike_Text_Controls
  ;

{$IfNDef NoVCM}
const
 cenEdit = en_Edit;
   copSelectAll   = op_SelectAll;
   copDeselectAll = op_Deselect;

{ TnsLister }

procedure TnscCustomLister.ProvideOps(
 const aPublisher: IvcmOperationsPublisher);
begin
 f_Published := true;
 with aPublisher do
 begin
  PublishOp(cenEdit,
            copSelectAll,
            SelectAllExecute,
            SelectAllTest);
  PublishOp(cenEdit,
            copDeselectAll,
            DeselectAllExecute,
            DeselectAllTest);
 end;//with aPublisher do
end;//ProvideOps

procedure TnscCustomLister.SelectAllExecute(
  const aParams : IvcmExecuteParamsPrim);
begin
 {$IfNDef DesignTimeLibrary}
 vlbSelectAllItems;
 {$EndIf  DesignTimeLibrary}
end;

procedure TnscCustomLister.DeselectAllExecute(const aParams : IvcmExecuteParamsPrim);
begin
 {$IfNDef DesignTimeLibrary}
 vlbDeselectAllItems;
 {$EndIf  DesignTimeLibrary}
end;

procedure TnscCustomLister.DeselectAllTest(const aParams : IvcmTestParamsPrim);
begin
 aParams.Op.Flag[vcm_ofEnabled] := not IsEmpty and MultiSelect;
end;

procedure TnscCustomLister.SelectAllTest(const aParams : IvcmTestParamsPrim);
begin
 aParams.Op.Flag[vcm_ofEnabled] := not IsEmpty and MultiSelect;
end;
{$EndIf NoVCM}

function TnscCustomLister.DoIsCommandPublished(Cmd: Tl3OperationCode): Boolean;
  // virtual;
  {-}
begin
 Result := Cmd in [ccAllSelect, ccAllDeselect];
end;//DoIsCommandPublished

function TnscCustomLister.IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
begin
 Result := f_Published and DoIsCommandPublished(Cmd);
end;//IsCommandPublished

constructor TnscCustomLister.Create(AOwner : TComponent);
// override;
{-}
begin
 inherited Create(AOwner);
 UseStyleTable := True;
end;//Create

function TnscCustomLister.pm_GetIsEmpty: Boolean;
  // override;
  {* - наличие элементов в дереве. }
begin
 Result := Total > 0;
end;//pm_GetIsEmpty

end.
