
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express side bar control                                    }
{                                                                   }
{       Copyright (c) 1998-2001 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxsbar;

{$I dxSBVer.inc}

interface

uses Classes, Controls, Windows, SysUtils, ExtCtrls, Graphics, Buttons,
StdCtrls, Forms, Messages, Menus, CommCtrl{$IFDEF DELPHI4}, ImgList, ActnList{$ENDIF};

type
  TdxSideBarStore = class;
  TdxStoredSideItem = class;
  TdxSideBarItem = class;

  TdxSideBarItemClickEvent = procedure(Sender: TObject; Item: TdxSideBarItem) of object;

  {$IFDEF DELPHI4}
  TdxSideBarItemActionLink = class(TActionLink)
  protected
    FClient: TdxStoredSideItem;

    procedure AssignClient(AClient: TObject); override;

    function IsCaptionLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;

    procedure SetCaption(const Value: string); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetVisible(Value: Boolean); override;
  end;

  TdxSideBarItemActionLinkClass = class of TdxSideBarItemActionLink;
  {$ENDIF}

  TdxStoredSideItem = class(TComponent)
  private
    FCategory: Integer;
    FCaption: string;
    FEnabled: Boolean;
    FHint: string;
    FLargeImage: Integer;
    FSmallImage: Integer;
    FOnClick: TdxSideBarItemClickEvent;
    FStore: TdxSideBarStore;
    FPopupMenu: TPopupMenu;
    FAvailableInCustomizeForm: Boolean;
  {$IFDEF DELPHI4}
    FActionLink: TdxSideBarItemActionLink;
  {$ENDIF}

  {$IFDEF DELPHI4}
    function GetAction: TBasicAction;
  {$ENDIF}

  {$IFDEF DELPHI4}
    procedure SetAction(Value: TBasicAction);
  {$ENDIF}
    procedure SetCaption(Value: string);
    procedure SetCategory(Value: Integer);
    procedure SetEnabled(Value: Boolean);
    procedure SetHint(Value: string);
    procedure SetLargeImage(Value: Integer);
    procedure SetSmallImage(Value: Integer);
    procedure SetStore(Value: TdxSideBarStore);

  {$IFDEF DELPHI4}
    procedure DoActionChange(Sender: TObject);
    function IsCaptionStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsHintStored: Boolean;
    function IsImageIndexStored: Boolean;
  {$ENDIF}
  protected
    procedure DoClick(Sender: TObject; Item: TdxSideBarItem);
    procedure ReadState(Reader: TReader); override;
    procedure SetParentComponent(AParent: TComponent); override;
  {$IFDEF DELPHI4}
    procedure Loaded; override;
  {$ENDIF}
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;

  {$IFDEF DELPHI4}
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
    function GetActionLinkClass: TdxSideBarItemActionLinkClass; dynamic;
  {$ENDIF}

  {$IFDEF DELPHI4}
    property ActionLink: TdxSideBarItemActionLink read FActionLink write FActionLink;
  {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    property AvailableInCustomizeForm: Boolean read FAvailableInCustomizeForm write FAvailableInCustomizeForm;
    property Store: TdxSideBarStore read FStore write SetStore;
  published
  {$IFDEF DELPHI4}
    property Action: TBasicAction read GetAction write SetAction;
  {$ENDIF}
    property Caption: string read FCaption write SetCaption {$IFDEF DELPHI4} stored IsCaptionStored{$ENDIF};
    property Category: Integer read FCategory write SetCategory;
    property Enabled: Boolean read FEnabled write SetEnabled {$IFDEF DELPHI4} stored IsEnabledStored{$ENDIF};
    property Hint: string read FHint write SetHint{$IFDEF DELPHI4} stored IsHintStored{$ENDIF};
    property LargeImage: Integer read FLargeImage write SetLargeImage {$IFDEF DELPHI4} stored IsImageIndexStored{$ENDIF};
    property SmallImage: Integer read FSmallImage write SetSmallImage;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property OnClick: TdxSideBarItemClickEvent read FOnClick write FOnClick;
  end;

  TdxSideBar = class;

  TdxSideBarStoreDesigner = class(TForm)
  protected
    Store: TdxSideBarStore;

    procedure CloseSideBarStoreEditor; virtual; abstract;
    procedure SideBarStoreEditorUpdate; virtual; abstract;
    procedure SideBarStoreEditorUpdateItem(AItem: TdxStoredSideItem); virtual; abstract;
  end;

  TdxSideBarStoreCustomizeForm = class(TForm)
  protected
    Store: TdxSideBarStore;

    procedure BeginCustomizing;
    procedure EndCustomizing;
  end;

  TdxSideBarStore = class(TComponent)
  private
    FList: TList;
    FBars: TList;
    FCategories: TStrings;
    FLargeImages: TImageList;
    FSmallImages: TImageList;
    FSmallChangeLink: TChangeLink;
    FLargeChangeLink: TChangeLink;
    FDefaultLargeImage: Integer;
    FDefaultSmallImage: Integer;
    FIsCustomizing: Boolean;

    function GetCount: Integer;
    function GetSideBarCount: Integer;
    function GetItem(Index: Integer): TdxStoredSideItem;
    function GetSideBar(Index: Integer): TdxSideBar;
    procedure SetCategories(Value: TStrings);
    procedure SetDefaultLargeImage(Value: Integer);
    procedure SetDefaultSmallImage(Value: Integer);
    procedure SetLargeImages(Value: TImageList);
    procedure SetSmallImages(Value: TImageList);
    procedure DestroyItems;
    procedure OnChangeLink(Sender: TObject);
    procedure RedrawBars;
    procedure RemoveBarItem(StoredItem: TdxStoredSideItem);
  protected
  {$IFDEF DELPHI3}
     procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ELSE}
     procedure GetChildren(Proc: TGetChildProc); override;
  {$ENDIF}
     procedure SetName(const Value: TComponentName); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    Designer: TdxSideBarStoreDesigner;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddItem(Item: TdxStoredSideItem);
    procedure ExchangeItems(Item1, Item2: TdxStoredSideItem);
    procedure RemoveItem(Item: TdxStoredSideItem);
    procedure UpdateItem(Item: TdxStoredSideItem);
    function GetCountByCategory(St: string): Integer;
    function GetItemByCategory(St: string; Index: Integer): TdxStoredSideItem;
    function GetItemsByCategory(St: string; List: TList): Integer;
    procedure Customize;
    procedure UpdateEditorItem(Item: TdxStoredSideItem);
    property Count: Integer read GetCount;
    property IsCustomizing: Boolean read FIsCustomizing;
    property Items[Index: Integer]: TdxStoredSideItem read GetItem;
    property SideBarCount: Integer read GetSideBarCount;
    property SideBars[Index: Integer]: TdxSideBar read GetSideBar;
  published
    property Categories: TStrings read FCategories write SetCategories;
    property DefaultLargeImage: Integer read FDefaultLargeImage write SetDefaultLargeImage;
    property DefaultSmallImage: Integer read FDefaultSmallImage write SetDefaultSmallImage;
    property LargeImages: TImageList read FLargeImages write SetLargeImages;
    property SmallImages: TImageList read FSmallImages write SetSmallImages;
  end;

  TdxSideGroups = class;
  TdxSideGroup = class;
  TdxSideBarItems = class;

  TdxSideBarItem = class(TCollectionItem)
  private
    FCaption: string;
    FIsDefault: Boolean;
    FLargeImage: Integer;
    FSmallImage: Integer;
    FStoredItem: TdxStoredSideItem;
    FCustomData: string;
    FHint: string;
    FObject: TObject;
    FTag: LongInt;
    FEnabled: Boolean;

    function GetCaption: string;
    function GetEnabled: Boolean;
    function GetHint: string;
    function GetGroup: TdxSideGroup;
    function GetSideBar: TdxSideBar;
    function GetLargeImage: Integer;
    function GetSmallImage: Integer;
    procedure SetCaption(Value: string);
    procedure SetEnabled(Value: Boolean);
    procedure SetHint(Value: string);
    procedure SetIsDefault(Value: Boolean);
    procedure SetLargeImage(Value: Integer);
    procedure SetSmallImage(Value: Integer);
    procedure SetStoredItem(Value: TdxStoredSideItem);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function MakeVisible: Boolean;
    function IsSelected: Boolean;
    function IsFocused: Boolean;
    function IsFullVisible: Boolean;
    function Visible: Boolean;

    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Group: TdxSideGroup read GetGroup;
    property SideBar: TdxSideBar read GetSideBar;
    property ItemObject: TObject read FObject write FObject;
  published
    property Caption: string read GetCaption write SetCaption;
    property CustomData: string read FCustomData write FCustomData;
    property Hint: string read GetHint write SetHint;
    property Index;
    property IsDefault: Boolean read FIsDefault write SetIsDefault;
    property LargeImage: Integer read GetLargeImage write SetLargeImage;
    property SmallImage: Integer read GetSmallImage write SetSmallImage;
    property StoredItem: TdxStoredSideItem read FStoredItem write SetStoredItem;
    property Tag: LongInt read FTag write FTag;
  end;

  TdxSideBarItems = class(TCollection)
  private
    Group: TdxSideGroup;
    SideBar: TdxSideBar;

    function GetItem(Index: Integer): TdxSideBarItem;
    procedure SetItem(Index: Integer; Value: TdxSideBarItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TdxSideGroup);

    function Add: TdxSideBarItem;
    property Items[Index: Integer]: TdxSideBarItem read GetItem write SetItem; default;
  end;

  TdxSideGroupIconType = (dxsgLargeIcon, dxsgSmallIcon);

  TdxSideGroup = class(TCollectionItem)
  private
    FItems: TdxSideBarItems;
    FTopVisibleItem: Integer;
    FCaption: string;
    FIconType: TdxSideGroupIconType;
    FIsAssigning: Boolean;
    FVisible: Boolean;
    FTag: Integer;
    FDestroying: Boolean;

    function GetActive: Boolean;
    function GetItemCount: Integer;
    procedure SetCaption(Value: string);
    procedure SetIconType(Value: TdxSideGroupIconType);
    procedure SetItems(Value: TdxSideBarItems);
    procedure SetTopVisibleItem(Value: Integer);
    procedure SetVisible(Value: Boolean);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure MakeActive;
    function GetVisibleCount: Integer;
    function SideBar: TdxSideBar;

    property Active: Boolean read GetActive;
    property ItemCount: Integer read GetItemCount;
    property TopVisibleItem: Integer read FTopVisibleItem write SetTopVisibleItem;
    property Tag: Integer read FTag write FTag;
  published
    property Caption: string read FCaption write SetCaption;
    property Index;
    property IconType: TdxSideGroupIconType read FIconType write SetIconType;
    property Items: TdxSideBarItems read FItems write SetItems;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TdxSideGroups = class(TCollection)
  private
    SideBar: TdxSideBar;

    function GetItem(Index: Integer): TdxSideGroup;
    function GetVisibleItem(Index: Integer): TdxSideGroup;
    function GetVisibleCount: Integer;
    procedure SetItem(Index: Integer; Value: TdxSideGroup);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TdxSideBar);

    function Add: TdxSideGroup;
    property Items[Index: Integer]: TdxSideGroup read GetItem write SetItem; default;
    property VisibleItems[Index: Integer]: TdxSideGroup read GetVisibleItem;
    property VisibleCount: Integer read GetVisibleCount;
  end;

  TdxSideBarChangeGroupCaptionEvent = procedure(Sender: TObject; Group: TdxSideGroup) of object;
  TdxSideBarDragDropItemEvent = procedure(Sender: TObject; Source, Target: TdxSideBarItem;
                                   IsCopy: Boolean) of object;
  TdxSideBarDeleteItemEvent = procedure(Sender: TObject; Item: TdxSideBarItem) of object;

  TdxSideBarFillStyle = (bfsNone, bfsHorz, bfsVert);

  TdxSideBarBackGround = class(TPersistent)
  private
    FBeginColor: TColor;
    FEndColor: TColor;
    FOnChange: TNotifyEvent;
    FFillStyle: TdxSideBarFillStyle;
    FStep: Integer;

    procedure SetBeginColor(Value: TColor);
    procedure SetEndColor(Value: TColor);
    procedure SetFillStyle(Value: TdxSideBarFillStyle);
    procedure SetStep(Value: Integer);
    procedure DoChange;
  public
    constructor Create;
    function IsUsed: Boolean;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property BeginColor: TColor read FBeginColor write SetBeginColor;
    property EndColor: TColor read FEndColor write SetEndColor;
    property FillStyle: TdxSideBarFillStyle read FFillStyle write SetFillStyle;
    property Step: Integer read FStep write SetStep default 2;
  end;

  TdxsbPaintStyle = (sbpsStandard, sbpsFlat, sbpsXP, sbpsW2K);

  TdxSideBarPainter = class;
  TdxSideBarViewInfo = class;

  TdxSideGroupViewInfo = class
  private
    FViewInfo: TdxSideBarViewInfo;
    FGroup: TdxSideGroup;
    FRect: TRect;

    function GetCaption: String;
    function GetPainter: TdxSideBarPainter;
  public
    constructor Create(AViewInfo: TdxSideBarViewInfo; AGroup: TdxSideGroup; ARect: TRect);

    function Index: Integer;    

    property Group: TdxSideGroup read FGroup;
    property Caption: String read GetCaption;
    property Painter: TdxSideBarPainter read GetPainter;
    property Rect: TRect read FRect;
    property ViewInfo: TdxSideBarViewInfo read FViewInfo;
  end;

  TdxSideBarDragSourcePosition = (sbdspTop, sbdspBottom, sbdspIn);

  TdxSideItemViewInfo = class
  private
    FViewInfo: TdxSideBarViewInfo;
    FItem: TdxSideBarItem;
    FImageRect: TRect;
    FCaptionRect: TRect;

    function GetCaption: String;
    function GetImageIndex: Integer;
    function GetImageList: TImageList;
    function GetPainter: TdxSideBarPainter;
  public
    constructor Create(AViewInfo: TdxSideBarViewInfo; AItem: TdxSideBarItem; AImageRect, ACaptionRect: TRect);

    function Index: Integer;
    function IsPartialVisible: Boolean;
    function Bottom: Integer;
    function Top: Integer;
    function ImageBorderRect: TRect;
    function ItemBorderRect: TRect; virtual;
    function FocusedCaptionRect: TRect;
    function GetItemDragSourceSpace(APosition: TdxSideBarDragSourcePosition): TRect;

    property Caption: String read GetCaption;
    property ImageIndex: Integer read GetImageIndex;
    property ImageList: TImageList read GetImageList;
    property Item: TdxSideBarItem read FItem;
    property Painter: TdxSideBarPainter read GetPainter;
    property CaptionRect: TRect read FCaptionRect;
    property ImageRect: TRect read FImageRect;
    property ViewInfo: TdxSideBarViewInfo read FViewInfo;
  end;

  TdxSideItemViewInfoClass = class of TdxSideItemViewInfo;

  TdxSideBarViewInfo = class
  private
    FPainter: TdxSideBarPainter;
    FGroups: TList;
    FItems: TList;
    FIsReady: Boolean;
    FItemsRect: TRect;
    FTopScrollButtonRect: TRect;
    FBottomScrollButtonRect: TRect;    

    function GetGroup(Index: Integer): TdxSideGroupViewInfo;
    function GetItem(Index: Integer): TdxSideItemViewInfo;
    
    function GetItemCorrectedCaptionRect(ACaption: String; ARect: TRect): TRect;
  protected
    function CreateGroup(AGroup: TdxSideGroup; ARect: TRect): TdxSideGroupViewInfo; virtual;
    procedure CreateGroups;
    procedure ClearGroups;
    function GetItemInfoClass: TdxSideItemViewInfoClass; virtual;
    function CreateItem(AItem: TdxSideBarItem; ATop: Integer): TdxSideItemViewInfo; virtual;
    procedure CreateItems;
    procedure ClearItems;
    function GetGroupHeight: Integer; virtual;
    function GetPaintRect: TRect; virtual;
    function GetGroupOffSet: Integer; virtual;
    function GetImageBorderOffSet: Integer; virtual;
    function GetItemViewInfo(AItem: TdxSideBarItem): TdxSideItemViewInfo;
    function GetItemImageRect(AItem: TdxSideBarItem; ATop: Integer): TRect;
    function GetItemCaptionRect(AItem: TdxSideBarItem; ATop: Integer; AImageRect: TRect): TRect;
    function GetItemEditRect(AItem: TdxSideBarItem; ACaption: String): TRect;

    function GetDrawEdgeFlag: Integer;
        
    function GetItemHeight: Integer;
    function GetLargeImageHeight: Integer;
    function GetLargeImageWidth: Integer;
    function GetSmallImageHeight: Integer;
    function GetSmallImageWidth: Integer;

    procedure CalcItemsRect;
    procedure CalcScrollButtonsRect;

    function GroupIndexOf(AGroup: TdxSideGroupViewInfo): Integer;
    function ItemIndexOf(AItem: TdxSideItemViewInfo): Integer;

    property ItemsRect: TRect read FItemsRect;
    property TopScrollButtonRect: TRect read FTopScrollButtonRect;
    property BottomScrollButtonRect: TRect read FBottomScrollButtonRect;
  public
    constructor Create(APainter: TdxSideBarPainter); virtual;
    destructor Destroy; override;
    function SideBar: TdxSideBar;
    procedure Clear;
    procedure CalcViewInfo;
    procedure Unready;

    function GroupCount: Integer;
    function ItemCount: Integer;

    function GetGroupViewInfoByGroup(AGroup: TdxSideGroup): TdxSideGroupViewInfo;
    function GetItemViewInfoByItem(AItem: TdxSideBarItem): TdxSideItemViewInfo;

    function ActiveGroupViewInfo: TdxSideGroupViewInfo;
    function GetGroupViewInfoAtPos(p: TPoint): TdxSideGroupViewInfo;
    function GetGroupAtPos(p: TPoint): TdxSideGroup;
    function GetItemViewInfoAtPos(p: TPoint): TdxSideItemViewInfo;
    function GetItemAtPos(p: TPoint): TdxSideBarItem;
    function GetNearestItemViewInfoAtPost(p: TPoint; var APosition: TdxSideBarDragSourcePosition): TdxSideItemViewInfo;
    function GetNearestItemAtPost(p: TPoint; var APosition: TdxSideBarDragSourcePosition): TdxSideBarItem;    

    function IsTopScrollButtonVisible: Boolean;
    function IsBottomScrollButtonVisible: Boolean;
    function IsPtTopScrollButton(pt: TPoint): Boolean;
    function IsPtBottomScrollButton(pt: TPoint): Boolean;        

    property IsReady: Boolean read FIsReady;
    property Painter: TdxSideBarPainter read FPainter;
    property Groups[Index: Integer]: TdxSideGroupViewInfo read GetGroup;
    property Items[Index: Integer]: TdxSideItemViewInfo read GetItem;
  end;

  TdxSideBarViewInfoClass = class of TdxSideBarViewInfo;

  TdxSideBarPainter = class
  private
    FSideBar: TdxSideBar;
    FViewInfo: TdxSideBarViewInfo;
  protected
    function ClientHeight: Integer;
    function ClientWidth: Integer;
    procedure ExcludeClipRect(ARect: TRect);
    procedure IntersectClipRect(ARect: TRect);

    function CreateViewInfo: TdxSideBarViewInfo; virtual;

    procedure ScrollGroups;

    procedure DrawFillRect(ARect: TRect);
    procedure DrawGroups;
    procedure DrawItems;
    procedure DrawBorder; virtual;
    procedure DrawGroup(AGroupViewInfo: TdxSideGroupViewInfo); virtual;
    procedure DrawItem(AItemViewInfo: TdxSideItemViewInfo); virtual;
    procedure DrawItemCaption(AItemViewInfo: TdxSideItemViewInfo); virtual;
    procedure DrawImageRect(AItemViewInfo: TdxSideItemViewInfo; ARect: TRect); virtual;   
    procedure DrawItemImage(AItemViewInfo: TdxSideItemViewInfo); virtual;
    procedure DrawItemImageBorder(AItemViewInfo: TdxSideItemViewInfo); virtual;
    procedure DrawScrollButtons; virtual;
    procedure DrawDragDestinationArrow; virtual;
  public
    constructor Create(ASideBar: TdxSideBar); virtual;
    destructor Destroy; override;
    function Canvas: TCanvas;
    function DC: HDC;
    procedure NeedRecalViewInfo;

    procedure Paint;
    procedure InvalidateGroup(AGroup: TdxSideGroup);
    procedure InvalidateItem(AItem: TdxSideBarItem); virtual;
    procedure InvalidateItemImage(AItem: TdxSideBarItem);
    procedure InvalidateItemImageBorder(AItem: TdxSideBarItem); virtual;
    procedure InvalidateItems;
    procedure InvalidateScrollButtons;

    function IsGroupFocused: Boolean; virtual;

    property SideBar: TdxSideBar read FSideBar;
    property ViewInfo: TdxSideBarViewInfo read FViewInfo;
  end;

  TdxSideBarPainterClass = class of TdxSideBarPainter;

  TdxSideBar = class(TCustomPanel)
  private
    FLargeImages: TImageList;
    FSmallImages: TImageList;
    FSmallChangeLink: TChangeLink;
    FLargeChangeLink: TChangeLink;

    FActiveGroupIndex: Integer;
    FOldActiveGroup: TdxSideGroup;
    FActiveGroup: TdxSideGroup;
    FGroups: TdxSideGroups;
    FStore: TdxSideBarStore;
    FGroupFont: TFont;
    FItemFont: TFont;
    FRenameGroup: TdxSideGroup;
    FRenameItem: TdxSideBarItem;
    FRenameEdit: TEdit;
    FCanSelected: Boolean;
    FHintWindow: THintWindow;
    FHintWindowShowing: Boolean;
    FHintTimerID: Integer;
    FSelectedItem: TdxSideBarItem;
    FOnDeleteItem: TdxSideBarDeleteItemEvent;
    FOnChangeActiveGroup: TNotifyEvent;
    FOnChangeFocusedItem: TNotifyEvent;
    FOnChangeSelectedItem: TNotifyEvent;
    FOnChangeGroupCaption: TdxSideBarChangeGroupCaptionEvent;
    FSpaceHeight: Integer;
    FScrollDelay: Integer;
    FScrollButtonUpIsDown: Boolean;
    FScrollButtonDownIsDown: Boolean;
    FScrollTimerID: Integer;
    FMouseFocusedItem: TdxSideBarItem;
    FMouseFocusedItemIsDown: Boolean;
    FMouseFocusedGroup: TdxSideGroup;
    FMouseFocusedGroupIsDown: Boolean;
    FDestDropItem: TdxSideBarItem;
    FDropItemPosition: TdxSideBarDragSourcePosition;
    FEnableDraging: Boolean;
    FDragMode: TDragMode;
    FPointDragging: TPoint;
    FGroupPopupMenu: TPopupMenu;
    FItemPopupMenu: TPopupMenu;
    FTransparentImages: Boolean;
    FImageList: TImageList;
    FAssignFlag: Boolean;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FOnAfterEdit: TNotifyEvent;
    FOnBeforeEdit: TNotifyEvent;
    FOnDragDropItem: TdxSideBarDragDropItemEvent;
    FOnItemClick: TdxSideBarItemClickEvent;
    FBkPicture: TPicture;
    FBkGround: TdxSideBarBackGround;
    FPaintStyle: TdxsbPaintStyle;
    FRegistryPath: string;
    FStoreInRegistry: Boolean;
    FIsMakingUpdate: Boolean;
    FGroupHeightOffSet: Integer;
    FShowGroups: Boolean;
    FDestroying: Boolean;
    FPainter: TdxSideBarPainter;

    function GetGroupCount: Integer;
    function GetPainter: TdxSideBarPainter;
    function GetViewInfo: TdxSideBarViewInfo;
    procedure SetActiveGroup(Value: TdxSideGroup);
    procedure SetActiveGroupIndex(Value: Integer);
    procedure SetBkGround(Value: TdxSideBarBackGround);
    procedure SetBkPicture(Value: TPicture);
    procedure SetCanSelected(Value: Boolean);
    procedure SetGroupFont(Value: TFont);
    procedure SetGroups(Value: TdxSideGroups);
    procedure SetGroupHeightOffSet(Value: Integer);
    procedure SetItemFont(Value: TFont);
    procedure SetLargeImages(Value: TImageList);
    procedure SetSmallImages(Value: TImageList);
    procedure SetPaintStyle(Value: TdxsbPaintStyle);
    procedure SetScrollDelay(Value: Integer);
    procedure SetShowGroups(Value: Boolean);
    procedure SetSpaceHeight(Value: Integer);
    procedure SetStore(Value: TdxSideBarStore);
    procedure SetTransparentImages(Value: Boolean);
    procedure SetDestDropItem(Value: TdxSideBarItem);
    procedure SetDropItemPosition(Value: TdxSideBarDragSourcePosition);
    procedure SetDestDropItemandPosition(AItem: TdxSideBarItem; APosition: TdxSideBarDragSourcePosition);
    procedure SetMouseFocusedItem(Item: TdxSideBarItem);
    procedure SetSelectedItem(Item: TdxSideBarItem);

    procedure HintActivate(AShow: Boolean);

    function GetVisibleGroup(Index: Integer): TdxSideGroup;
    function GetVisibleIndexByGroup(AGroup: TdxSideGroup): Integer;

    function GetFocusedItem(X, Y: Integer): TdxSideBarItem;
    function GetTopVisibleToMakeItemVisible(AItem: TdxSideBarItem): Integer;
    function GetDestDropItemViewInfo: TdxSideItemViewInfo;

    procedure RenameEditExit(Sender: TObject);
    procedure DoGroupMouseFocused(Group: TdxSideGroup; IsDown: Boolean);
    procedure DoItemMouseFocused(Item: TdxSideBarItem; IsDown: Boolean);
    procedure DoItemSelected(Item: TdxSideBarItem);
    procedure DoBkPictureChange(Sender: TObject);
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;

    procedure OnChangeLink(Sender: TObject);
    procedure OnFontChange(Sender: TObject);
  protected
    procedure Paint; override;
    procedure RepaintAll;
    procedure InvalidateGroup(AGroup: TdxSideGroup);
    procedure InvalidateItem(AItem: TdxSideBarItem);
    procedure InvalidateItemImage(AItem: TdxSideBarItem);
    procedure InvalidateItemImageBorder(AItem: TdxSideBarItem);
    procedure InvalidateItems(AUpdateCalcInfo: Boolean);
    procedure InvalidateScrollButtons;

    procedure WndProc(var Message: TMessage); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
        X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
        X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DoItemClick(Item: TdxSideBarItem); virtual;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    function CreatePainter: TdxSideBarPainter; virtual;
    function VisibleGroupCount: Integer;

    property DestDropItem: TdxSideBarItem read FDestDropItem write SetDestDropItem;
    property DestDropItemViewInfo: TdxSideItemViewInfo read GetDestDropItemViewInfo;
    property DropItemPosition: TdxSideBarDragSourcePosition read FDropItemPosition write SetDropItemPosition;
    property MouseFocusedItemIsDown: Boolean read FMouseFocusedItemIsDown;
    property Painter: TdxSideBarPainter read GetPainter;
    property ViewInfo: TdxSideBarViewInfo read GetViewInfo;
    property VisibleGroups[Index: Integer]: TdxSideGroup read GetVisibleGroup;
  public
    property IsMakingUpdate: Boolean read FIsMakingUpdate write FIsMakingUpdate;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    class function XPBackgroundColor: COLORREF;
    class function XPSelectedItemColor: COLORREF;    

    procedure Assign(Source: TPersistent); override;
    function GetGroupAtPos(p: TPoint): TdxSideGroup;
    function GetItemAtPos(p: TPoint): TdxSideBarItem;
    function GetPopupGroup: TdxSideGroup;
    function IsGroupEditing: Boolean;
    function IsItemEditing: Boolean;
    function IsEditing: Boolean;
    procedure EditGroup(Group: TdxSideGroup);
    procedure EditItem(Item: TdxSideBarItem);
    procedure EndEdit(Accept: Boolean);

    function GetSmallImages: TImageList;
    function GetLargeImages: TImageList;

    procedure LoadFromRegistry(ARegistryPath: string);
    procedure SaveToRegistry(ARegistryPath: string);

    property ActiveGroup: TdxSideGroup read FActiveGroup write SetActiveGroup;
    property EditControl: TEdit read FRenameEdit;
    property EditingGroup: TdxSideGroup read FRenameGroup;
    property EditingItem: TdxSideBarItem read FRenameItem;
    property FocusedItem: TdxSideBarItem read FMouseFocusedItem;
    property GroupCount: Integer read GetGroupCount;
    property SelectedItem: TdxSideBarItem read FSelectedItem write DoItemSelected;
  published
    property Align default alLeft;
    property BkGround: TdxSideBarBackGround read FBkGround write SetBkGround;
    property BkPicture: TPicture read FBkPicture write SetBkPicture;
    property Color default clGrayText;
    property CanSelected: Boolean read FCanSelected write SetCanSelected;
    property GroupFont: TFont read FGroupFont write SetGroupFont;
    property Groups: TdxSideGroups read FGroups write SetGroups;
    // Have to be defined after property Groups !
    property ActiveGroupIndex: Integer read FActiveGroupIndex write SetActiveGroupIndex;
    property GroupPopupMenu: TPopupMenu read FGroupPopupMenu write FGroupPopupMenu;
    property GroupHeightOffSet: Integer read FGroupHeightOffSet write SetGroupHeightOffSet;
    property ItemFont: TFont read FItemFont write SetItemFont;
    property ItemPopupMenu: TPopupMenu read FItemPopupMenu write FItemPopupMenu;
    property LargeImages: TImageList read FLargeImages write SetLargeImages;
    property PaintStyle: TdxsbPaintStyle read FPaintStyle write SetPaintStyle default sbpsFlat;
    property SmallImages: TImageList read FSmallImages write SetSmallImages;
    property ScrollDelay: Integer read FScrollDelay write SetScrollDelay;
    property SpaceHeight: Integer read FSpaceHeight write SetSpaceHeight;
    property Store: TdxSideBarStore read FStore write SetStore;
    property TransparentImages: Boolean read FTransparentImages write SetTransparentImages;
    property RegistryPath: string read FRegistryPath write FRegistryPath;
    property ShowGroups: Boolean read FShowGroups write SetShowGroups;
    property StoreInRegistry: Boolean read FStoreInRegistry write FStoreInRegistry;
    property OnItemClick: TdxSideBarItemClickEvent read FOnItemClick write FOnItemClick;
    property OnDeleteItem: TdxSideBarDeleteItemEvent read FOnDeleteItem write FOnDeleteItem;
    property OnChangeActiveGroup: TNotifyEvent read FOnChangeActiveGroup write FOnChangeActiveGroup;
    property OnChangeFocusedItem: TNotifyEvent read FOnChangeFocusedItem write FOnChangeFocusedItem;
    property OnChangeGroupCaption: TdxSideBarChangeGroupCaptionEvent
             read FOnChangeGroupCaption write FOnChangeGroupCaption;
    property OnChangeSelectedItem: TNotifyEvent read FOnChangeSelectedItem
             write FOnChangeSelectedItem;
    property BorderStyle;
    property DragCursor;
    property DragMode read FDragMode write FDragMode;
    property Enabled;
    property Ctl3D;
    property Locked;
    property ParentColor;
    property ParentCtl3D;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnAfterEdit: TNotifyEvent read FOnAfterEdit write FOnAfterEdit;
    property OnBeforeEdit: TNotifyEvent read FOnBeforeEdit write FOnBeforeEdit;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragDropItem: TdxSideBarDragDropItemEvent read FOnDragDropItem
                            write FOnDragDropItem;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;

    {$IFDEF DELPHI4}
    property Anchors;
    property Constraints;
    property OnStartDock;
    property OnEndDock;
    {$ENDIF}
  end;

  TdxSideBarPopupMenuOption = (sbmIconType, sbmAddGroup, sbmRemoveGroup,
    sbmCustomize, sbmRenameGroup, sbmRenameItem, sbmRemoveItem);

  TdxSideBarPopupMenuOptions = set of TdxSideBarPopupMenuOption;

  TdxSideBarPopupMenu = class(TPopupMenu)
  private
    FOptions: TdxSideBarPopupMenuOptions;
    List: TList;
    Bar: TdxSideBar;
    Group: TdxSideGroup;
    FOnAfterClick: TNotifyEvent;
    FOnPopupClose: TNotifyEvent;
  protected
    procedure BarMenuClick(Sender: TObject);
    procedure DestroyBarItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Popup(X, Y: Integer); override;
  published
    property Options: TdxSideBarPopupMenuOptions read FOptions write FOptions;
    property OnAfterClick: TNotifyEvent read FOnAfterClick write FOnAfterClick;
    property OnPopupClose: TNotifyEvent read FOnPopupClose write FOnPopupClose;
  end;

  EdxSideBarError = class(Exception);

  TdxSideBarDragObject = class(TObject)
  private
    FStoredItem: TdxStoredSideItem;
    FItem: TdxSideBarItem;
    FDeleteItem: Boolean;
    FDragObject: TDragControlObject;
    FCancelDrag: Boolean;
  public
    constructor Create(Control: TControl; var DragObject: TDragObject;
              AItem: TdxSideBarItem; AStoredItem: TdxStoredSideItem);
    destructor Destroy; override;
    function EndDrag(Target: TObject; X, Y: Integer): TdxSideBarItem;

    property CancelDrag: Boolean read FCancelDrag write FCancelDrag;
    property DeleteItem: Boolean read FDeleteItem write FDeleteItem;
    property Item: TdxSideBarItem read FItem;
    property StoredItem: TdxStoredSideItem read FStoredItem;
  end;

var
  dxSideBarDragObject: TdxSideBarDragObject;

 //Group scrolling variable. Change them to change the speed of the group scrolling
 dxSideBarGroupScrollStep: Integer = 1;
 dxSideBarGroupScrollIncrement: Integer = 2;
 dxSideBarGroupScrollTimeToIncrement: Integer = 50; 

implementation
{$R dxsbar.res}

uses dxsbstrs, dxsbarcs, Registry, TypInfo;

const
  ScrollButtonHeight = 16;
  ScrollButtonIndention = 3;

  dxSideBarHintShowDelay = 3000;
  dxSideBarDragCursor = -1121;
  dxSideBarDragCopyCursor = -1122;
  dxSideBarDragDeleteCursor = -1123;
  dxSideBarGroupCursor = -1125;

  dxSideBarDefaultLargeImageHeight = 32;
  dxSideBarDefaultLargeImageWidth = 32;
  dxSideBarDefaultSmallImageHeight = 16;
  dxSideBarDefaultSmallImageWidth = 16;

  dxSideBarDragArrowHeight = 9;

procedure DrawBmpOnCanvas(ACanvas: TCanvas; APicture: TPicture;
  ADrawRect: TRect; AWidth, AHeight: Integer);
var
  dLeft, dTop, dWidth, dHeight, sLeft, sTop : Integer;
  ABmp: TBitmap;
  ACreatedFlag: Boolean;
begin
  ABmp := nil;
  ACreatedFlag := False;
  if (APicture.Graphic is TBitmap) then
    ABmp := APicture.Bitmap;
  if (APicture.Graphic is TIcon) or (APicture.Graphic is TMetaFile) then
  begin
    ABmp := TBitmap.Create;
    ABmp.Height := APicture.Graphic.Height;
    ABmp.Width := APicture.Graphic.Height;
    ABmp.Canvas.Draw(0, 0, APicture.Graphic);
    ACreatedFlag := True;
  end;

  if (ABmp = nil) then begin
    ACanvas.FillRect(ADrawRect);
    Exit;
  end;
  dTop := ADrawRect.Top;
  while (dTop < ADrawRect.Bottom) do begin
     if (dTop mod ABmp.Height <> 0) then
       sTop := dTop - (dTop div ABmp.Height) * ABmp.Height
     else sTop := 0;
     dHeight := ABmp.Height - sTop;
     if (dTop + dHeight > ADrawRect.Bottom) then
       dHeight := ADrawRect.Bottom - dTop;
     dLeft := ADrawRect.Left;
     while (dLeft < ADrawRect.Right) do begin
       if (dLeft mod ABmp.Width <> 0) then
         sLeft := dLeft - (dLeft div ABmp.Width) * ABmp.Width
       else sLeft := 0;
       dWidth := ABmp.Width - sLeft;
       if (dLeft + dWidth > ADrawRect.Right) then
         dWidth := ADrawRect.Right - dLeft;
       BitBlt(ACanvas.Handle, dLeft, dTop, dWidth, dHeight,
         ABmp.Canvas.Handle, sLeft, sTop, SRCCOPY);
       Inc(dLeft, dWidth);
     end;
     Inc(dTop, dHeight);
  end;
  if ACreatedFlag then
    ABmp.Free;
end;

procedure DrawDifColorsOnCanvas(ACanvas: TCanvas; ABeginColor, AEndColor: TColor;
          cdXY: Integer; AIsHorz: Boolean; ADrawRect: TRect; AWidth, AHeight: Integer);
var
  r: TRect;
  FBeginColor, FEndColor, FColor: Integer;
  FBeginColorB, FBeginColorG, FBeginColorR: Byte;
  FEndColorB, FEndColorG, FEndColorR: Byte;
  dColorB, dColorG, dColorR: Real;
  FColorB, FColorG, FColorR: Real;
  brh: HBRUSH;
  FHeight: Integer;
begin

  FBeginColor := ColorToRGB(ABeginColor);
  FEndColor := ColorToRGB(AEndColor);

  FBeginColorB := GetBValue(FBeginColor);
  FBeginColorG := GetGValue(FBeginColor);
  FBeginColorR := GetRValue(FBeginColor);

  FEndColorB := GetBValue(FEndColor);
  FEndColorG := GetGValue(FEndColor);
  FEndColorR := GetRValue(FEndColor);

  if AIsHorz then
    FHeight := AHeight
  else FHeight := AWidth;
  dColorB := (FEndColorB - FBeginColorB) * cdXY /FHeight;
  dColorG := (FEndColorG - FBeginColorG) * cdXY /FHeight;
  dColorR := (FEndColorR - FBeginColorR) * cdXY /FHeight;

  r := ADrawRect;
  if AIsHorz then begin
    r.Top := ADrawRect.Top;
    FColorB := FBeginColorB + dColorB * r.Top / cdXY;
    FColorG := FBeginColorG + dColorG * r.Top / cdXY;
    FColorR := FBeginColorR + dColorR * r.Top / cdXY;
    while (r.Top < ADrawRect.Bottom) do begin
      r.Bottom := r.Top + cdXY;
      if (r.Bottom > ADrawRect.Bottom) then
        r.Bottom := ADrawRect.Bottom;
      FColor := {PALETTE}RGB(Trunc(FColorR), Trunc(FColorG), Trunc(FColorB));
      brh := CreateSolidBrush(FColor);
      Windows.FillRect(ACanvas.Handle, r, brh);
      DeleteObject(brh);
      if (r.Top mod cdXY <> 0) then
        Dec(r.Top, r.Top mod cdXY);
      Inc(r.Top, cdXY);
      FColorB := FColorB + dColorB;
      FColorG := FColorG + dColorG;
      FColorR := FColorR + dColorR;
    end;
  end else begin
    r.Left := ADrawRect.Left;
    FColorB := FBeginColorB + dColorB * r.Left / cdXY;
    FColorG := FBeginColorG + dColorG * r.Left / cdXY;
    FColorR := FBeginColorR + dColorR * r.Left / cdXY;
    while (r.Left < ADrawRect.Right) do begin
      r.Right := r.Left + cdXY;
      if (r.Right > ADrawRect.Right) then
        r.Right := ADrawRect.Right;
      FColor := {PALETTE}RGB(Trunc(FColorR), Trunc(FColorG), Trunc(FColorB));
      brh := CreateSolidBrush(FColor);
      Windows.FillRect(ACanvas.Handle, r, brh);
      DeleteObject(brh);
      if (r.Left mod cdXY <> 0) then
        Dec(r.Left, r.Left mod cdXY);
      Inc(r.Left, cdXY);
      FColorB := FColorB + dColorB;
      FColorG := FColorG + dColorG;
      FColorR := FColorR + dColorR;
    end;
  end;
//  ACanvas.Brush.Color := OldColor;
end;

function GetClippedString(DC: HDC; const S: string; Rect: TRect): string;
var
  Width, Len: Integer;
  Size: TSize;
begin
  if S = '' then Result := ''
  else
  begin
    Width := Rect.Right - Rect.Left;
    for Len := Length(S) downto 0 do
    begin
      GetTextExtentPoint32(DC, PChar(Copy(S, 1, Len)), Len, Size);
      if Size.cX <= Width then Break;
    end;
    Result := Copy(S, 1, Len);
  end;
end;

function GetFontHeight(AFont: TFont): Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, AFont.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;


type
{TStoredSideBarItemsStoreStrings}
TStoredSideBarItemsStoreStrings = class(TStringList)
private
  Owner: TdxSideBarStore;

  procedure ChangeCategory(OldCategory, NewCategory: Integer);
public
  constructor Create(AOwner: TdxSideBarStore);
  procedure Clear; override;
  procedure Delete(Index: Integer); override;
  procedure Insert(Index: Integer; const S: string); override;
  procedure Exchange(Index1, Index2: Integer); override;
  procedure Move(CurIndex, NewIndex: Integer); override;
end;

{TStoredSideBarItemsStoreStrings}

constructor TStoredSideBarItemsStoreStrings.Create(AOwner: TdxSideBarStore);
begin
  inherited Create;
  Owner := AOwner;
  if not (csLoading in Owner.ComponentState) then
    Add(LoadStr(DXSB_DEFAULTGROUP));
end;

procedure TStoredSideBarItemsStoreStrings.ChangeCategory(OldCategory, NewCategory: Integer);
var
  I: Integer;
  List: TList;
begin
  if (OldCategory > -1) and (OldCategory < Count)
  and (NewCategory > -1) and (NewCategory < Count) then begin
    List := TList.Create;
    Owner.GetItemsByCategory(Strings[OldCategory], List);
    for I := 0 to List.Count - 1 do
      TdxStoredSideItem(List[I]).Category := NewCategory;
    List.Free;
  end;
end;

procedure TStoredSideBarItemsStoreStrings.Clear;
begin
  if (Owner.Count > 0) and not (csLoading in Owner.ComponentState) then
    raise EdxSideBarError.Create(LoadStr(DXSB_CANTDELETEGROUP))
  else begin
    inherited Clear;
    if not (csLoading in Owner.ComponentState) then
      Add(LoadStr(DXSB_DEFAULTGROUP));
  end;

end;

procedure TStoredSideBarItemsStoreStrings.Delete(Index: Integer);
var
  I: Integer;
begin
  if (Index > -1 ) and (Index < Count) and (Owner.GetCountByCategory(Strings[Index]) > 0) then
    raise EdxSideBarError.Create(LoadStr(DXSB_CANTDELETEGROUP))
  else begin
    if (Index > -1 ) and (Index < Count) then
      for I := Index to Count - 1 do
        ChangeCategory(I + 1, I);
    inherited Delete(Index);
  end;
  if Count = 0 then
      Add(LoadStr(DXSB_DEFAULTGROUP));
end;

procedure TStoredSideBarItemsStoreStrings.Insert(Index: Integer; const S: string);
var
  I: Integer;
begin
  inherited Insert(Index, S);
  if (Index < Count) and (Index > -1) then
    for I := Count -  1  downto Index + 1 do
      ChangeCategory(I - 1, I);
end;

procedure TStoredSideBarItemsStoreStrings.Exchange(Index1, Index2: Integer);
var
  I: Integer;
  List1: TList;
  List2: TList;
begin
  if (Index1 > -1) and (Index1 < Count)
  and (Index2 > -1) and (Index2 < Count) then begin
    List1 := TList.Create;
    List2 := TList.Create;
    Owner.GetItemsByCategory(Strings[Index1], List1);
    Owner.GetItemsByCategory(Strings[Index2], List2);
    for I := 0 to List1.Count - 1 do
      TdxStoredSideItem(List1[I]).Category := Index2;
    for I := 0 to List2.Count - 1 do
      TdxStoredSideItem(List2[I]).Category := Index1;
    List1.Free;
    List2.Free;
  end;
  inherited Exchange(Index1, Index2);
end;

procedure TStoredSideBarItemsStoreStrings.Move(CurIndex, NewIndex: Integer);
var
  I: Integer;
begin
  if (CurIndex < NewIndex) then begin
    for I := CurIndex + 1 to NewIndex do
      ChangeCategory(I, I - 1);
  end else
    for I := NewIndex to CurIndex - 1 do
      ChangeCategory(I, I + 1);
  inherited Move(CurIndex, NewIndex);
end;

{$IFDEF DELPHI4}

{ TdxSideBarItemActionLink }

procedure TdxSideBarItemActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TdxStoredSideItem;
end;

function TdxSideBarItemActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked and
    (FClient.Caption = (Action as TCustomAction).Caption);
end;

function TdxSideBarItemActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

function TdxSideBarItemActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TdxSideBarItemActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.LargeImage = (Action as TCustomAction).ImageIndex);
end;

procedure TdxSideBarItemActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TdxSideBarItemActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TdxSideBarItemActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TdxSideBarItemActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then FClient.LargeImage := Value;
end;

procedure TdxSideBarItemActionLink.SetVisible(Value: Boolean);
begin
  FClient.Enabled := Value and inherited IsEnabledLinked and TCustomAction(FClient.Action).Enabled;
end;
{$ENDIF}


{TdxStoredSideItem}
constructor TdxStoredSideItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCaption := LoadStr(DXSB_DEFAULTITEMCAPTION);
  FLargeImage := -1;
  FSmallImage := -1;
  FEnabled := True;
  FAvailableInCustomizeForm := True;
end;

destructor TdxStoredSideItem.Destroy;
begin
  if (FStore <> nil) then
    FStore.RemoveItem(Self);
{$IFDEF DELPHI4}
  if FActionLink <> nil then
  begin
    FActionLink.Free;
    FActionLink := nil;
  end;
{$ENDIF}

  inherited Destroy;
end;

{$IFDEF DELPHI4}
procedure TdxStoredSideItem.Loaded;
begin
  inherited;
  if Action <> nil then ActionChange(Action, True);
end;
{$ENDIF}

procedure TdxStoredSideItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPopupMenu) then FPopupMenu := nil;
  if (Operation = opRemove) and (AComponent = FStore) then  Store := nil;
{$IFDEF DELPHI4}
  if (Operation = opRemove) and (AComponent = Action) then Action := nil;
{$ENDIF}
end;

function TdxStoredSideItem.GetParentComponent: TComponent;
begin
  Result := FStore;
end;

function TdxStoredSideItem.HasParent: Boolean;
begin
  HasParent := True;
end;


procedure TdxStoredSideItem.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TdxSideBarStore then Store := TdxSideBarStore(Reader.Parent);
end;

procedure TdxStoredSideItem.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then Store := AParent as TdxSideBarStore;
end;

{$IFDEF DELPHI4}
procedure TdxStoredSideItem.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  if Action is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Caption = '') or (Self.Caption = LoadStr(DXSB_DEFAULTITEMCAPTION)) then
        Self.Caption := Caption;
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if not CheckDefaults or (Self.LargeImage = -1) then
        Self.LargeImage := ImageIndex;
    end;
end;

function TdxStoredSideItem.GetActionLinkClass: TdxSideBarItemActionLinkClass;
begin
  Result := TdxSideBarItemActionLink;
end;
{$ENDIF}


{$IFDEF DELPHI4}
function TdxStoredSideItem.GetAction: TBasicAction;
begin
  if FActionLink = nil then Result := nil
  else Result := FActionLink.Action;
end;
{$ENDIF}

{$IFDEF DELPHI4}
procedure TdxStoredSideItem.SetAction(Value: TBasicAction);
begin
  if Value = nil then
  begin
    if FActionLink <> nil then
      FActionLink.Free;
    FActionLink := nil;
  end
  else
  begin
    if (Value is TCustomAction) and (csDesigning in Value.ComponentState) then
      TCustomAction(Value).DisableIfNoHandler := False;
    if FActionLink = nil then
      FActionLink := GetActionLinkClass.Create(Self);
    FActionLink.Action := Value;
    FActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
    Value.FreeNotification(Self);
  end;
end;
{$ENDIF}

procedure TdxStoredSideItem.SetCaption(Value: string);
begin
  if (FCaption <> Value) then begin
    FCaption := Value;
    if (FStore <> nil) then
      FStore.UpdateItem(Self);
  end;
end;

procedure TdxStoredSideItem.SetEnabled(Value: Boolean);
begin
  if (FEnabled <> Value) then begin
    FEnabled := Value;
    if (FStore <> nil) then
      FStore.UpdateItem(Self);
  end;
end;

procedure TdxStoredSideItem.SetHint(Value: string);
begin
  if (FHint <> Value) then begin
    FHint := Value;
    if (FStore <> nil) then
      FStore.UpdateItem(Self);
  end;
end;

procedure TdxStoredSideItem.DoClick(Sender: TObject; Item: TdxSideBarItem);
begin
{$IFDEF DELPHI4}
  if Assigned(FOnClick) then
    FOnClick(Sender, Item)
  else if FActionLink <> nil then FActionLink.Execute;
{$ELSE}
  if Assigned(FOnClick) then FOnClick(Sender, Item);
{$ENDIF}
end;

procedure TdxStoredSideItem.SetCategory(Value: Integer);
begin
  if (csLoading in ComponentState) then
    FCategory := Value
  else
    if (FStore <> nil) and (Value > - 1)
    and (Value < FStore.Categories.Count) then begin
      FCategory := Value;
      FStore.UpdateEditorItem(Self)
    end;
end;

procedure TdxStoredSideItem.SetLargeImage(Value: Integer);
begin
  if (FLargeImage <> Value) then begin
    FLargeImage := Value;
    if (FStore <> nil) then
      FStore.UpdateItem(Self);
  end;
end;

procedure TdxStoredSideItem.SetSmallImage(Value: Integer);
begin
  if (FSmallImage <> Value) then begin
    FSmallImage := Value;
    if (FStore <> nil) then
      FStore.UpdateItem(Self);
  end;
end;

procedure TdxStoredSideItem.SetStore(Value: TdxSideBarStore);
begin
  if (FStore <> Value) then begin
    if (FStore <> nil) then
      FStore.RemoveItem(Self);
    FStore := Value;
    if (FStore <> nil) then begin
      FStore.AddItem(Self);
      if not (csLoading in ComponentState) then
        Category := 0;
    end;
  end;
end;

{$IFDEF DELPHI4}
procedure TdxStoredSideItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

function TdxStoredSideItem.IsCaptionStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsCaptionLinked;
end;

function TdxStoredSideItem.IsEnabledStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

function TdxStoredSideItem.IsHintStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsHintLinked;
end;

function TdxStoredSideItem.IsImageIndexStored: Boolean;
begin
  Result := (FActionLink = nil) or not FActionLink.IsImageIndexLinked;
end;
{$ENDIF}


procedure TdxSideBarStoreCustomizeForm.BeginCustomizing;
begin
  Store.FIsCustomizing := True;
end;

procedure TdxSideBarStoreCustomizeForm.EndCustomizing;
begin
  Store.FIsCustomizing := False;
end;


{TdxSideBarStore}
constructor TdxSideBarStore.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList := TList.Create;
  FBars := TList.Create;
  FCategories := TStoredSideBarItemsStoreStrings.Create(Self);
  FLargeChangeLink := TChangeLink.Create;
  FSmallChangeLink := TChangeLink.Create;
  FLargeChangeLink.OnChange := OnChangeLink;
  FSmallChangeLink.OnChange := OnChangeLink;
  FDefaultLargeImage := -1;
  FDefaultSmallImage := -1;

  Designer := nil;
end;

destructor TdxSideBarStore.Destroy;
begin
  FSmallChangeLink.Free;
  FLargeChangeLink.Free;
  if (Designer <> nil) then
    Designer.Free;
  DestroyItems;
  FCategories.Free;
  FBars.Free;
  FList.Free;
  inherited Destroy;
end;

procedure TdxSideBarStore.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then begin
    if (AComponent = LargeImages) then LargeImages := nil;
    if (AComponent = SmallImages) then SmallImages := nil;
  end;
end;

procedure TdxSideBarStore.DestroyItems;
var
  Item: TdxStoredSideItem;
begin
  while FList.Count > 0 do
  begin
    Item := FList.Last;
    RemoveItem(Item);
    Item.Free;
  end;
end;

{$IFDEF DELPHI3}
procedure TdxSideBarStore.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Items[I].Owner = Root then Proc(Items[I]);
end;
{$ELSE}
procedure TdxSideBarStore.GetChildren(Proc: TGetChildProc);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Items[I].Owner <> Self then Proc(Items[I]);
end;
{$ENDIF}

procedure TdxSideBarStore.SetName(const Value: TComponentName);
var
  I: Integer;
  OldName, ItemName, NamePrefix: TComponentName;
  item: TdxStoredSideItem;
begin
  OldName := Name;
  inherited SetName(Value);
  if (csDesigning in ComponentState) and (Name <> OldName) then
    for I := 0 to Count - 1 do begin
      item := Items[I];
      if item.Owner = Owner then begin
        itemName := item.Name;
        NamePrefix := itemName;
        if Length(NamePrefix) > Length(OldName) then begin
          SetLength(NamePrefix, Length(OldName));
          if CompareText(OldName, NamePrefix) = 0 then begin
            System.Delete(itemName, 1, Length(OldName));
            System.Insert(Value, itemName, 1);
            try
              item.Name := itemName;
            except
              on EComponentError do
            end;
          end;
        end;
      end;
    end;
  if (Designer <> nil) then
     Designer.SideBarStoreEditorUpdate;
end;

function TdxSideBarStore.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TdxSideBarStore.GetSideBarCount: Integer;
begin
  Result := FBars.Count;
end;

function TdxSideBarStore.GetItem(Index: Integer): TdxStoredSideItem;
begin
  if (Index > -1) and (Index < Count) then
    Result := TdxStoredSideItem(FList[INdex])
  else Result := nil;
end;

function TdxSideBarStore.GetSideBar(Index: Integer): TdxSideBar;
begin
  Result := nil;
  if (Index > -1) and (Index < FBars.Count) then
    Result := TdxSideBar(FBars[Index]);
end;

procedure TdxSideBarStore.SetCategories(Value: TStrings);
var
  I: Integer;
begin
  if (Value.Count = 0) then begin
    Categories.Clear;
    Exit;
  end;
  if (Value.Count < FCategories.Count) then begin
    for I := Value.Count to FCategories.Count - 1 do
      if (GetCountByCategory(FCategories[I]) > 0) then begin
        raise EdxSideBarError.Create(LoadStr(DXSB_CANTDELETEGROUP));
        Exit;
      end;
    while Value.Count < Categories.Count do
       FCategories.Delete(FCategories.Count - 1);
  end else begin
    for I := FCategories.Count to Value.Count - 1 do
       FCategories.Add(Value[I]);
  end;
    for I := 0 to Value.Count - 1 do
       FCategories[I]:= Value[I];
end;

procedure TdxSideBarStore.SetDefaultLargeImage(Value: Integer);
begin
  if (Value >= -1) and (FDefaultLargeImage <> Value) then begin
    FDefaultLargeImage := Value;
    RedrawBars;
  end;
end;

procedure TdxSideBarStore.SetDefaultSmallImage(Value: Integer);
begin
  if (Value >= -1) and (FDefaultSmallImage <> Value) then begin
    FDefaultSmallImage := Value;
    RedrawBars;
  end;
end;

procedure TdxSideBarStore.SetLargeImages(Value: TImageList);
begin
  if (FLargeImages <> Value) then begin
    if (FLargeImages <> nil) and not (csDestroying in  FLargeImages.ComponentState) then
      FLargeImages.UnRegisterChanges(FLargeChangeLink);
    FLargeImages := Value;
    if (FLargeImages <> nil) then
    begin
      FLargeImages.RegisterChanges(FLargeChangeLink);
      FLargeImages.FreeNotification(Self);
    end;
    if not (csDestroying in  ComponentState) then
    begin
      RedrawBars;
      if (Designer <> nil) then
        Designer.SideBarStoreEditorUpdate;
    end;
  end;
end;

procedure TdxSideBarStore.SetSmallImages(Value: TImageList);
begin
  if (FSmallImages <> Value) then begin
    if (FSmallImages <> nil) and not (csDestroying in  FSmallImages.ComponentState) then
      FSmallImages.UnRegisterChanges(FSmallChangeLink);
    FSmallImages := Value;
    if (FSmallImages <> nil) then
    begin
      FSmallImages.RegisterChanges(FSmallChangeLink);
      FSmallImages.FreeNotification(Self);
    end;
    if not (csDestroying in  ComponentState) then
    begin
      RedrawBars;
      if (Designer <> nil) then
        Designer.SideBarStoreEditorUpdate;
    end;  
  end;
end;

function TdxSideBarStore.GetCountByCategory(St: string): Integer;
var
  Index, I: Integer;
begin
  Result := 0;
  Index := FCategories.IndexOf(St);
  if (Index > -1) then
    for I := 0 to Count - 1 do
      if (Items[I].Category = Index) then
        Inc(Result);
end;

function TdxSideBarStore.GetItemByCategory(St: string; Index: Integer): TdxStoredSideItem;
var
  List: TList;
begin
  Result := nil;
  List := TList.Create;
  GetItemsByCategory(St, List);
  if (Index < List.Count) then
    Result := TdxStoredSideItem(List[Index]);
  List.Free;
end;

function TdxSideBarStore.GetItemsByCategory(St: string; List: TList): Integer;
var
  Index, I: Integer;
begin
  List.Clear;
  Index := FCategories.IndexOf(St);
  if (Index > -1) then
    for I := 0 to Count - 1 do
      if (Items[I].Category = Index) then
        List.Add(Items[I]);
  Result := List.Count;
end;

procedure TdxSideBarStore.AddItem(Item: TdxStoredSideItem);
begin
  FList.Add(Item);
end;

procedure TdxSideBarStore.ExchangeItems(Item1, Item2: TdxStoredSideItem);
var
  Index1, Index2: Integer;
begin
  Index1 := FList.IndexOf(Item1);
  Index2 := FList.IndexOf(Item2);
  if (Index1 > -1) and (Index2 > -1) then
    FList.Exchange(Index1, Index2);
end;

procedure TdxSideBarStore.RemoveItem(Item: TdxStoredSideItem);
begin
  RemoveBarItem(Item);
  FList.Remove(Item);
end;

procedure TdxSideBarStore.OnChangeLink(Sender: TObject);
begin
  RedrawBars;
end;

procedure TdxSideBarStore.RedrawBars;
var
  I: Integer;
begin
  for I := 0 to FBars.Count - 1 do
    SideBars[I].RepaintAll;
end;

procedure TdxSideBarStore.RemoveBarItem(StoredItem: TdxStoredSideItem);
var
  I, j, k: Integer;
begin
  if (csDestroying in ComponentState) then Exit;
  for I := 0 to FBars.Count - 1 do
    if not (csDestroying in SideBars[I].ComponentState)
    and (SideBars[I].Groups <> nil) then
      for j := 0 to SideBars[I].Groups.Count - 1 do begin
         k := 0;
         while k < SideBars[I].Groups[j].Items.Count do begin
           if (SideBars[I].Groups[j].Items[k].StoredItem = StoredItem) then
             SideBars[I].Groups[j].Items[k].Free
           else Inc(k);
         end;
      end;
end;

procedure TdxSideBarStore.UpdateItem(Item: TdxStoredSideItem);
begin
  RedrawBars;
  UpdateEditorItem(Item);
end;

procedure TdxSideBarStore.Customize;
begin
  SideBarCustomize(Self);
end;

procedure TdxSideBarStore.UpdateEditorItem(Item: TdxStoredSideItem);
begin
  if (Designer <> nil) then
     Designer.SideBarStoreEditorUpdateItem(Item);
end;

{TdxSideBarItem}
constructor TdxSideBarItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FIsDefault := True;
  FEnabled := True;
  FLargeImage := -1;
  FSmallImage := -1;
end;

destructor TdxSideBarItem.Destroy;
var
  IsSelectedFlag: Boolean;
  NeedRepaint: Boolean;
  Bar: TdxSideBar;
begin
  IsSelectedFlag := False;
  NeedRepaint := False;
  Bar := SideBar;
  if (Bar <> nil) and  not (csDestroying in Bar.ComponentState) then begin
    NeedRepaint := Visible and not Bar.FDestroying;
    if (Bar.IsEditing) then
      Bar.EndEdit(False);
    if (Bar.FSelectedItem = Self) then
      IsSelectedFlag := True;
    if (Bar.FMouseFocusedItem = Self) then
      Bar.FMouseFocusedItem := nil;
  end;
  if (Bar <> nil) and Assigned(Bar.FOnDeleteItem) then
    Bar.FOnDeleteItem(Bar, Self);
  inherited Destroy;
  if (IsSelectedFlag) then
    Bar.SetSelectedItem(nil);
  if NeedRepaint then
    Bar.InvalidateItems(True);
end;

procedure TdxSideBarItem.Assign(Source: TPersistent);
var
  item: TdxSideBarItem;
begin
  if (Source is TdxSideBarItem) then begin
    item := TdxSideBarItem(Source);
    FStoredItem := item.StoredItem;
    FHint := item.Hint;
    FIsDefault := item.IsDefault;
    FCaption := item.Caption;
    FTag := item.Tag;
    FCustomData := item.CustomData;
    FLargeImage := item.LargeImage;
    FSmallImage := item.SmallImage;
    FEnabled := item.Enabled;
  end else inherited Assign(Source);
end;

function TdxSideBarItem.MakeVisible;
begin
  Result := IsFullVisible and Group.Active;
  if not Result and Group.Active then
    Group.TopVisibleItem := SideBar.GetTopVisibleToMakeItemVisible(self);
end;

function TdxSideBarItem.IsSelected: Boolean;
begin
  Result := SideBar.SelectedItem = self;
end;

function TdxSideBarItem.IsFocused: Boolean;
begin
  Result := SideBar.FocusedItem = self;
end;

function TdxSideBarItem.IsFullVisible: Boolean;
begin
  Result := (SideBar.ViewInfo.GetItemViewInfoByItem(self) <> nil)
    and not SideBar.ViewInfo.GetItemViewInfoByItem(self).IsPartialVisible;
end;


function TdxSideBarItem.Visible: Boolean;
begin
  Result := SideBar.ViewInfo.GetItemViewInfoByItem(self) <> nil;
end;

function TdxSideBarItem.GetCaption: string;
begin
  if (FStoredItem <> nil) and IsDefault then
    Result := FStoredItem.Caption
  else Result := FCaption;
end;

function TdxSideBarItem.GetEnabled: Boolean;
begin
  if (FStoredItem <> nil) and IsDefault then
    Result := FStoredItem.Enabled
  else Result := FEnabled;
end;

function TdxSideBarItem.GetHint: string;
begin
  if (FStoredItem <> nil) and IsDefault then
    Result := FStoredItem.Hint
  else Result := FHint;
end;

function TdxSideBarItem.GetGroup: TdxSideGroup;
begin
  if (Collection <> nil) then
   Result := TdxSideBarItems(Collection).Group
  else Result := nil;
end;

function TdxSideBarItem.GetSideBar: TdxSideBar;
begin
  if Group <> nil then
    Result := Group.SideBar
  else Result := nil;
end;

function TdxSideBarItem.GetLargeImage: Integer;
begin
  if (FStoredItem <> nil) and IsDefault then
    Result := FStoredItem.LargeImage
  else Result := FLargeImage;
end;

function TdxSideBarItem.GetSmallImage: Integer;
begin
  if (FStoredItem <> nil) and IsDefault then
    Result := FStoredItem.SmallImage
  else Result := FSmallImage;
end;

procedure TdxSideBarItem.SetCaption(Value: string);
var
  ABar: TdxSideBar;
begin
  if (FCaption <> Value) then begin
    FCaption := Value;
    if (FStoredItem <> nil) and (FCaption <> FStoredItem.Caption) then
      IsDefault := False;
    if (Collection <> nil)  then begin
      ABar := TdxSideBarItems(Collection).SideBar;
      if (ABar <> nil) and (ABar.ActiveGroup <> nil) and Visible then
        ABar.InvalidateItems(True);
    end;
  end;
end;

procedure TdxSideBarItem.SetEnabled(Value: Boolean);
var
  ABar: TdxSideBar;
begin
  if (FEnabled <> Value) then
  begin
    FEnabled := Value;
    if (FStoredItem <> nil) and (FEnabled <> FStoredItem.Enabled) then
      IsDefault := False;
    if (Collection <> nil)  then begin
      ABar := TdxSideBarItems(Collection).SideBar;
      if (ABar <> nil) and (ABar.ActiveGroup <> nil) and Visible then
        ABar.InvalidateItems(False);
    end;    
  end;
end;

procedure TdxSideBarItem.SetHint(Value: string);
begin
  if (FHint <> Value) then begin
    FHint := Value;
    if (FStoredItem <> nil) and (FHint <> FStoredItem.Hint) then
      IsDefault := False;
  end;
end;

procedure TdxSideBarItem.SetIsDefault(Value: Boolean);
begin
  FIsDefault := Value;
  if (FStoredItem <> nil) and (Value) then begin
    Caption := FStoredItem.Caption;
    Hint := FStoredItem.Hint;
    Enabled := FStoredItem.Enabled;
    LargeImage := FStoredItem.LargeImage;
    SmallImage := FStoredItem.SmallImage;
  end;
end;

procedure TdxSideBarItem.SetLargeImage(Value: Integer);
begin
  if (FLargeImage <> Value) then begin
    FLargeImage := Value;
    if (FStoredItem <> nil) and (FLargeImage <> FStoredItem.LargeImage) then
      IsDefault := False;
    if (Collection <> nil) and
    (TdxSideBarItems(Collection).SideBar.ActiveGroup =
    TdxSideBarItems(Collection).Group) then
      TdxSideBarItems(Collection).SideBar.InvalidateItems(False);
  end;
end;

procedure TdxSideBarItem.SetSmallImage(Value: Integer);
begin
  if (FSmallImage <> Value) then begin
    FSmallImage := Value;
    if (FStoredItem <> nil) and (FSmallImage <> FStoredItem.SmallImage) then
      IsDefault := False;
    if (Collection <> nil) and
    (TdxSideBarItems(Collection).SideBar.ActiveGroup =
    TdxSideBarItems(Collection).Group) then
      TdxSideBarItems(Collection).SideBar.InvalidateItems(False);
  end;
end;

procedure TdxSideBarItem.SetStoredItem(Value: TdxStoredSideItem);
begin
  if (Value <> FStoredItem) then begin
    FStoredItem := Value;
    if (FStoredItem <> nil) and (Collection <> nil)
    and not (csLoading in TdxSideBarItems(Collection).SideBar.ComponentState) then begin
      FCaption := FStoredItem.Caption;
      FSmallImage := FStoredItem.SmallImage;
      FLargeImage := FStoredItem.LargeImage;
      Tag := FStoredItem.Tag;
      FIsDefault := True;
      TdxSideBarItems(Collection).SideBar.RepaintAll;
    end;
  end;
end;

{TdxSideBarItems}
constructor TdxSideBarItems.Create(AOwner: TdxSideGroup);
begin
  inherited Create(TdxSideBarItem);
  Group := AOwner;
  SideBar := TdxSideGroups(Group.Collection).SideBar;
end;

procedure TdxSideBarItems.Update(Item: TCollectionItem); 
begin
  if (SideBar <> nil) and (SideBar.Owner <> nil)
  and not (csLoading in SideBar.Owner.ComponentState)
  and (SideBar.ActiveGroup = Group) then
    SideBar.InvalidateItems(True);
end;

function TdxSideBarItems.Add: TdxSideBarItem;
begin
  Result := TdxSideBarItem(inherited Add);
end;

function TdxSideBarItems.GetItem(Index: Integer): TdxSideBarItem;
begin
  Result := TdxSideBarItem(inherited Items[Index]);
end;

procedure TdxSideBarItems.SetItem(Index: Integer; Value: TdxSideBarItem);
begin
  Items[Index].Assign(Value);
end;


{TdxSideGroup}
constructor TdxSideGroup.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FItems := TdxSideBarItems.Create(Self);
  FCaption := LoadStr(DXSB_DEFAULTGROUPCAPTION);
  FTopVisibleItem := 0;
  FIconType := dxsgLargeIcon;
  FIsAssigning := False;
  FVisible := True;
  if not (csLoading in SideBar.ComponentState) then
  begin
    if (SideBar.FActiveGroup = nil) then
      SideBar.ActiveGroup := Self;
    SideBar.RepaintAll;
  end;
end;

destructor TdxSideGroup.Destroy;
var
  Bar: TdxSideBar;
  IsGroupActive: Boolean;
begin
  FDestroying := True;
  Bar := SideBar;
  IsGroupActive := Active;
  if Bar <> nil then
  begin
    if Bar.FMouseFocusedGroup = Self then
      Bar.FMouseFocusedGroup := nil;
    if Bar.FOldActiveGroup = Self then
      Bar.FOldActiveGroup := nil;
    if Bar.IsEditing then
      Bar.EndEdit(False);
  end;
  FItems.Free;
  FItems := nil;
  inherited Destroy;
  if (Bar <> nil) and not Bar.FDestroying then
  begin
    if IsGroupActive then
      Bar.ActiveGroup := nil;
    if Bar.ActiveGroup <> nil then
      Bar.FActiveGroupIndex := Bar.GetVisibleIndexByGroup(Bar.ActiveGroup);
    Bar.RepaintAll;
  end;
end;

procedure TdxSideGroup.MakeActive;
begin
  SideBar.ActiveGroup := Self;
end;

function TdxSideGroup.GetActive: Boolean;
begin
  Result := SideBar.ActiveGroup = Self;
end;

function TdxSideGroup.GetItemCount: Integer;
begin
  if FItems = nil then
    Result := 0
  else
    Result := FItems.Count;
end;

function TdxSideGroup.SideBar: TdxSideBar;
begin
  Result := TdxSideGroups(Collection).SideBar;
end;

function TdxSideGroup.GetVisibleCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  if (Active) and (FTopVisibleItem > -1) and (Items.Count > 0) then
  begin
    I := FTopVisibleItem;
    while (I < Items.Count) and Items[I].Visible do
    begin
      Inc(I);
      Inc(Result);
    end;
  end;
end;

procedure TdxSideGroup.SetCaption(Value: string);
var
  Bar: TdxSideBar;
begin
  if (FCaption <> Value) then begin
    FCaption := Value;
    if FIsAssigning then Exit;
    Bar := SideBar;
    if (Bar <> nil) and
    not ((csLoading in Bar.ComponentState) or (csDestroying in Bar.ComponentState)) then begin
      if Assigned(Bar.OnChangeGroupCaption) then
        Bar.OnChangeGroupCaption(Self, Self);
        Bar.InvalidateGroup(self); 
    end;
  end;
end;

procedure TdxSideGroup.SetIconType(Value: TdxSideGroupIconType);
begin
  if (FIconType <> Value) then begin
    FIconType := Value;
    if (TopVisibleItem <> 0) then
      TopVisibleItem := 0;
    if FIsAssigning then Exit;
    if (SideBar <> nil) and not (csLoading in SideBar.ComponentState)
    and (Self = SideBar.ActiveGroup) then
      SideBar.InvalidateItems(True);;
  end;
end;

procedure TdxSideGroup.SetItems(Value: TdxSideBarItems);
begin
  FTopVisibleItem := 0;
  FItems.Assign(Value);
  if (FItems.Count > 0) then
    FTopVisibleItem := 0;
end;

procedure TdxSideGroup.SetTopVisibleItem(Value: Integer);
begin
  if (FTopVisibleItem <> Value)
  and (Value > -1) and (Value < Items.Count) then begin
    FTopVisibleItem := Value;
    if (SideBar <> nil) and not (csLoading in SideBar.ComponentState)
    and (SideBar.ActiveGroup = Self) then
     SideBar.InvalidateItems(True);
  end;
end;

procedure TdxSideGroup.SetVisible(Value: Boolean);
begin
  if (FVisible <> Value) then
  begin
    FVisible := Value;
    if (SideBar <> nil) and not (csLoading in SideBar.ComponentState) then
      SideBar.RepaintAll;
  end;
end;

procedure TdxSideGroup.Assign(Source: TPersistent);
begin
  if (Source is TdxSideGroup) then begin
    FIsAssigning := True;
    Caption := TdxSideGroup(Source).Caption;
    IconType := TdxSideGroup(Source).IconType;
    Visible := TdxSideGroup(Source).Visible;
    SetItems(TdxSideGroup(Source).Items);
    FIsAssigning := False;
  end
  else inherited Assign(Source);
end;


{TdxSideGroups}
constructor TdxSideGroups.Create(AOwner: TdxSideBar);
begin
  inherited Create(TdxSideGroup);
  SideBar := AOwner;
end;

function TdxSideGroups.Add: TdxSideGroup;
begin
  Result := TdxSideGroup(inherited Add);
end;

function TdxSideGroups.GetItem(Index: Integer): TdxSideGroup;
begin
  Result := TdxSideGroup(inherited Items[Index]);
end;

function TdxSideGroups.GetVisibleItem(Index: Integer): TdxSideGroup;
var
  I: Integer;
  j: Integer;
begin
  Result := nil;
  j := 0;
  for I := 0 to Count - 1 do
  begin
    if (Items[I].Visible) then
    begin
      if (Index = j) then
        Result := Items[I];
      Inc(j);
    end;
  end;
end;

function TdxSideGroups.GetVisibleCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if (Items[I].Visible) then
      Inc(Result);
end;

procedure TdxSideGroups.SetItem(Index: Integer; Value: TdxSideGroup);
begin
  Items[Index].Assign(Value);
end;

procedure TdxSideGroups.Update(Item: TCollectionItem);
begin
  if (SideBar <> nil) and (SideBar.Owner <> nil)
  and not (csLoading in SideBar.Owner.ComponentState)
  and not (csDestroying in SideBar.ComponentState)
  and (Count > 0) then begin
    if (SideBar.FActiveGroup = nil) or (SideBar.FActiveGroup.FDestroying) then
      SideBar.ActiveGroup := Items[0]
    else SideBar.RepaintAll;
  end;
end;


{TdxSideBarBackGround}
constructor TdxSideBarBackGround.Create;
begin
  inherited Create;
  FBeginColor := clGrayText;
  FEndColor := clGrayText;
  FFillStyle := bfsNone;
  FStep := 2;
end;

function TdxSideBarBackGround.IsUsed: Boolean;
begin
  Result := (FFillStyle <> bfsNone) and (FBeginColor <> EndColor);
end;

procedure TdxSideBarBackGround.SetBeginColor(Value: TColor);
begin
  if (FBeginColor <> Value) then begin
    FBeginColor := Value;
    DoChange;
  end;
end;

procedure TdxSideBarBackGround.SetEndColor(Value: TColor);
begin
  if (FEndColor <> Value) then begin
    FEndColor := Value;
    DoChange;
  end;
end;

procedure TdxSideBarBackGround.SetFillStyle(Value: TdxSideBarFillStyle);
begin
  if (FFillStyle <> Value) then begin
    FFillStyle := Value;
    DoChange;
  end;
end;

procedure TdxSideBarBackGround.SetStep(Value: Integer);
begin
  if (Value <> FStep) and (Value > 0) then
  begin
    FStep := Value;
    DoChange;
  end;
end;

procedure TdxSideBarBackGround.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{TSideBarRenameEdit}
type
TSideBarRenameEdit = class(TEdit)
private
  procedure WMKeyDown(var Message: TMessage); message WM_KEYDOWN;
protected
  procedure CreateParams(var Params: TCreateParams); override;
  procedure KeyPress(var Key: Char); override;
end;

procedure TSideBarRenameEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_BORDER;
  if (TdxSideBar(Owner).FRenameItem <> nil) then begin
    if (TdxSideBar(Owner).ActiveGroup.IconType = dxsgLargeIcon) then
      Params.Style := Params.Style or   ES_MULTILINE or ES_CENTER or ES_AUTOHSCROLL
    else Params.Style := Params.Style or ES_LEFT or ES_AUTOHSCROLL;
  end;
end;

procedure TSideBarRenameEdit.KeyPress(var Key: Char);
var
  r: TRect;
  St: string;
begin
  inherited KeyPress(Key);
  if (TdxSideBar(Owner).FRenameItem <> nil) then begin
    if (TdxSideBar(Owner).ActiveGroup.IconType = dxsgLargeIcon) then
      St := Text + Key
    else St := '';
    r:= TdxSideBar(Owner).ViewInfo.GetItemEditRect(TdxSideBar(Owner).FRenameItem, St);
    InflateRect(r, 2, 2);
    if (Left <> r.Left) or (Width <> r.Right - r.Left)
    or (Height <> r.Bottom - r.Top) or (Top <> r.Top) then begin
      Top := r.Top;
      Left := r.Left;
      Width := r.Right - r.Left;
      Height := r.Bottom - r.Top;
    end;
  end;
end;

procedure TSideBarRenameEdit.WMKeyDown(var Message: TMessage);
begin
  if (Message.wparam = VK_RETURN) or (Message.wparam = VK_ESCAPE) then begin
     TdxSideBar(Owner).EndEdit(Message.wparam = VK_RETURN);
     Exit;
  end;
  inherited;
end;

procedure ScrollButtonsTimerProc(Wnd: HWnd; Msg, TimerID, SysTime: Longint); stdcall;
var
  Bar: TdxSideBar;
begin
  Bar := TdxSideBar(FindControl(wnd));
  if Bar = nil then Exit;
  Bar.FScrollButtonUpIsDown := Bar.FScrollButtonUpIsDown and Bar.ViewInfo.IsTopScrollButtonVisible;
  Bar.FScrollButtonDownIsDown := Bar.FScrollButtonDownIsDown and Bar.ViewInfo.IsBottomScrollButtonVisible;
  if Bar.FScrollButtonUpIsDown or Bar.FScrollButtonDownIsDown then begin
   Bar.FDestDropItem := nil;
   Bar.FDropItemPosition := sbdspIn;
   if Bar.FScrollButtonUpIsDown then
      Bar.ActiveGroup.TopVisibleItem:= Bar.ActiveGroup.TopVisibleItem - 1;
    if Bar.FScrollButtonDownIsDown then
      Bar.ActiveGroup.TopVisibleItem := Bar.ActiveGroup.TopVisibleItem + 1;
  end else begin //!!! Kill itself !!!
    KillTimer(Bar.Handle, Bar.FScrollTimerID);
    Bar.FScrollTimerID := -1;
  end;
end;

procedure HintTimerProc(Wnd: HWnd; Msg, TimerID, SysTime: Longint); stdcall;
var
  Bar: TdxSideBar;
begin
  Bar := TdxSideBar(FindControl(wnd));
  if Bar = nil then Exit;
  Bar.HintActivate(False);
  Bar.Hint := '';
  Bar.ShowHint := True;
  KillTimer(Bar.Handle, Bar.FHintTimerID);
  Bar.FHintTimerID := -1;
end;

{TdxSideGroupViewInfo}
constructor TdxSideGroupViewInfo.Create(AViewInfo: TdxSideBarViewInfo; AGroup: TdxSideGroup; ARect: TRect);
begin
  FViewInfo := AViewInfo;
  FGroup := AGroup;
  FRect := ARect;
end;

function TdxSideGroupViewInfo.GetPainter: TdxSideBarPainter;
begin
  Result := ViewInfo.Painter;
end;

function TdxSideGroupViewInfo.Index: Integer;
begin
  Result := ViewInfo.GroupIndexOf(self);
end;

function TdxSideGroupViewInfo.GetCaption: String;
begin
  Result := GetClippedString(Painter.DC, Group.Caption, Rect);
end;


{TdxSideItemViewInfo}
constructor TdxSideItemViewInfo.Create(AViewInfo: TdxSideBarViewInfo; AItem: TdxSideBarItem; AImageRect, ACaptionRect: TRect);
begin
  FViewInfo := AViewInfo;
  FItem := AItem;
  FImageRect := AImageRect;
  FCaptionRect := ACaptionRect;
end;

function TdxSideItemViewInfo.GetPainter: TdxSideBarPainter;
begin
  Result := ViewInfo.Painter;
end;

function TdxSideItemViewInfo.Index: Integer;
begin
  Result := ViewInfo.ItemIndexOf(self);
end;

function TdxSideItemViewInfo.IsPartialVisible: Boolean;
begin
  Result := Bottom > ViewInfo.ItemsRect.Bottom;
end;

function TdxSideItemViewInfo.Bottom: Integer;
begin
  if CaptionRect.Bottom > ImageBorderRect.Bottom then
    Result := CaptionRect.Bottom
  else Result := ImageBorderRect.Bottom;
end;

function TdxSideItemViewInfo.Top: Integer;
begin
  if CaptionRect.Top < ImageBorderRect.Top then
    Result := CaptionRect.Top
  else Result := ImageBorderRect.Top;  
end;

function TdxSideItemViewInfo.ImageBorderRect: TRect;
begin
  Result := ImageRect;
  InflateRect(Result, ViewInfo.GetImageBorderOffSet, ViewInfo.GetImageBorderOffSet);
end;

function TdxSideItemViewInfo.ItemBorderRect: TRect;
begin
  Result := ImageBorderRect;
end;

function TdxSideItemViewInfo.FocusedCaptionRect: TRect;
begin
  Result := CaptionRect;
  if (Item.Group.IconType = dxsgLargeIcon) then
    Result.Top := ImageRect.Bottom
  else Result.Left := ImageRect.Right;  
end;

function TdxSideItemViewInfo.GetItemDragSourceSpace(APosition: TdxSideBarDragSourcePosition): TRect;
begin
  Result := ViewInfo.ItemsRect;
  case APosition of
    sbdspTop:
      begin
        Result.Bottom := Top;
        Result.Top := Result.Bottom - dxSideBarDragArrowHeight + 1;
      end;
    sbdspBottom:
      begin
        Result.Top := Bottom;
        Result.Bottom := Result.Top + dxSideBarDragArrowHeight - 1;
      end;
    sbdspIn:
      begin
        Result.Top := Top;
        Result.Bottom := Bottom;
      end;
  end;
end;

function TdxSideItemViewInfo.GetCaption: String;
begin
  Result := Item.Caption;
end;

function TdxSideItemViewInfo.GetImageIndex: Integer;
begin
  if Item.Group.IconType = dxsgLargeIcon then
    Result := Item.LargeImage
  else Result := Item.SmallImage; 
end;

function TdxSideItemViewInfo.GetImageList: TImageList;
begin
  if Item.Group.IconType = dxsgLargeIcon then
    Result := Painter.SideBar.GetLargeImages
  else Result := Painter.SideBar.GetSmallImages;
end;

{TdxSideBarViewInfo}
constructor TdxSideBarViewInfo.Create(APainter: TdxSideBarPainter);
begin
  FPainter := APainter;
  FGroups := TList.Create;
  FItems := TList.Create;
end;

destructor TdxSideBarViewInfo.Destroy;
begin
  Clear;
  FGroups.Free;
  FItems.Free;
  inherited Destroy;
end;

procedure TdxSideBarViewInfo.Clear;
begin
  ClearGroups;
  ClearItems;
end;

procedure TdxSideBarViewInfo.Unready;
begin
  FIsReady := False;
end;

procedure TdxSideBarViewInfo.CalcViewInfo;
begin
  Clear;
  CreateGroups;
  CalcItemsRect;
  CreateItems;
  CalcScrollButtonsRect;

  FIsReady := True;
end;

function TdxSideBarViewInfo.SideBar: TdxSideBar;
begin
  Result := Painter.SideBar;
end;

function TdxSideBarViewInfo.GroupCount: Integer;
begin
  Result := FGroups.Count;
end;

function TdxSideBarViewInfo.ItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxSideBarViewInfo.GetGroup(Index: Integer): TdxSideGroupViewInfo;
begin
  Result := TdxSideGroupViewInfo(FGroups[Index]);
end;

function TdxSideBarViewInfo.GetItem(Index: Integer): TdxSideItemViewInfo;
begin
  Result := TdxSideItemViewInfo(FItems[Index]);
end;

function TdxSideBarViewInfo.GroupIndexOf(AGroup: TdxSideGroupViewInfo): Integer;
begin
  Result := FGroups.IndexOf(AGroup);
end;

function TdxSideBarViewInfo.ItemIndexOf(AItem: TdxSideItemViewInfo): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

function TdxSideBarViewInfo.GetGroupViewInfoByGroup(AGroup: TdxSideGroup): TdxSideGroupViewInfo;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to GroupCount - 1 do
    if Groups[i].Group = AGroup then
    begin
      Result := Groups[i];
      break;
    end;
end;

function TdxSideBarViewInfo.GetItemViewInfoByItem(AItem: TdxSideBarItem): TdxSideItemViewInfo;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ItemCount - 1 do
    if Items[i].Item = AItem then
    begin
      Result := Items[i];
      break;
    end;
end;

function TdxSideBarViewInfo.ActiveGroupViewInfo: TdxSideGroupViewInfo;
begin
  Result := nil;
  if (SideBar.ActiveGroup <> nil) then
    Result := GetGroupViewInfoByGroup(SideBar.ActiveGroup);
end;

function TdxSideBarViewInfo.GetGroupViewInfoAtPos(p: TPoint): TdxSideGroupViewInfo;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to GroupCount - 1 do
    if ptInRect(Groups[i].Rect, p) then
    begin
      Result := Groups[i];
      break;
    end;
end;

function TdxSideBarViewInfo.GetGroupAtPos(p: TPoint): TdxSideGroup;
var
  AGroupViewInfo: TdxSideGroupViewInfo;
begin
  AGroupViewInfo := GetGroupViewInfoAtPos(p);
  if AGroupViewInfo <> nil then
    Result := AGroupViewInfo.Group
  else Result := nil;
end;

function TdxSideBarViewInfo.GetItemViewInfoAtPos(p: TPoint): TdxSideItemViewInfo;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ItemCount - 1 do
    if ptInRect(Items[i].FocusedCaptionRect, p) or ptInRect(Items[i].ItemBorderRect, p) then
    begin
      Result := Items[i];
      break;
    end;
end;

function TdxSideBarViewInfo.GetItemAtPos(p: TPoint): TdxSideBarItem;
var
  AItemViewInfo: TdxSideItemViewInfo;
begin
  AItemViewInfo := GetItemViewInfoAtPos(p);
  if AItemViewInfo <> nil then
    Result := AItemViewInfo.Item
  else Result := nil;
end;

function TdxSideBarViewInfo.GetNearestItemViewInfoAtPost(p: TPoint; var APosition: TdxSideBarDragSourcePosition): TdxSideItemViewInfo;
var
  I: Integer;
begin
  Result := nil;
  APosition := sbdspIn;
  if not PtInRect(ItemsRect, p) then
    exit;
  if ItemCount > 0 then
    APosition := sbdspBottom
  else APosition := sbdspTop;  
  for i := 0 to ItemCount - 1 do
  begin
    Result := Items[i];
    if (p.Y <= Result.Bottom) then
    begin
      if p.Y < Result.Top then
        APosition := sbdspTop
      else APosition := sbdspIn;
      break;
    end;
  end;
end;

function TdxSideBarViewInfo.GetNearestItemAtPost(p: TPoint; var APosition: TdxSideBarDragSourcePosition): TdxSideBarItem;
var
  AItemViewInfo: TdxSideItemViewInfo;
begin
  AItemViewInfo := GetNearestItemViewInfoAtPost(p, APosition);
  if AItemViewInfo <> nil then
    Result := AItemViewInfo.Item
  else Result := nil;
end;

function TdxSideBarViewInfo.IsTopScrollButtonVisible: Boolean;
begin
  Result := FTopScrollButtonRect.Left < FTopScrollButtonRect.Right;
end;

function TdxSideBarViewInfo.IsBottomScrollButtonVisible: Boolean;
begin
 Result := FBottomScrollButtonRect.Left < FBottomScrollButtonRect.Right;
end;

function TdxSideBarViewInfo.IsPtTopScrollButton(pt: TPoint): Boolean;
begin
  Result := PtInRect(FTopScrollButtonRect, pt);
end;

function TdxSideBarViewInfo.IsPtBottomScrollButton(pt: TPoint): Boolean;
begin
  Result := PtInRect(FBottomScrollButtonRect, pt);
end;

function TdxSideBarViewInfo.CreateGroup(AGroup: TdxSideGroup; ARect: TRect): TdxSideGroupViewInfo;
begin
  Result := TdxSideGroupViewInfo.Create(self, AGroup, ARect);
end;

procedure TdxSideBarViewInfo.CreateGroups;
var
  i: Integer;
  APaintRect: TRect;
  AGroupHeight: Integer;
  ATop_Bottom: Integer;
begin
  if (not SideBar.ShowGroups or (SideBar.ActiveGroup = nil)) then exit;

  APaintRect := GetPaintRect;
  AGroupHeight := GetGroupHeight;

  Painter.Canvas.Font := SideBar.GroupFont;

  ATop_Bottom := APaintRect.Top;
  for i := 0 to SideBar.ActiveGroup.Index do
    if (SideBar.Groups[i].Visible) then
    begin
      FGroups.Add(CreateGroup(SideBar.Groups[i], Rect(APaintRect.Left, ATop_Bottom,
        APaintRect.Right, ATop_Bottom + AGroupHeight)));
      Inc(ATop_Bottom, AGroupHeight + GetGroupOffSet);
    end;

  ATop_Bottom := APaintRect.Bottom;
  for i := SideBar.GroupCount - 1 downto SideBar.ActiveGroup.Index + 1 do
    if (SideBar.Groups[i].Visible) then
    begin
      FGroups.Add(CreateGroup(SideBar.Groups[i], Rect(APaintRect.Left, ATop_Bottom - AGroupHeight,
        APaintRect.Right, ATop_Bottom)));
      Dec(ATop_Bottom, AGroupHeight + GetGroupOffSet);
    end;
end;

procedure TdxSideBarViewInfo.ClearGroups;
var
  i: Integer;
begin
  for i := 0 to GroupCount - 1 do
    Groups[i].Free;
  FGroups.Clear;
end;

procedure TdxSideBarViewInfo.CalcItemsRect;
var
  AGroupViewInfo: TdxSideGroupViewInfo;
begin
  FItemsRect := GetPaintRect;
  InflateRect(FItemsRect, -1, -1);
  AGroupViewInfo := ActiveGroupViewInfo;
  if AGroupViewInfo <> nil then
  begin
    FItemsRect.Top := AGroupViewInfo.Rect.Bottom;
    if AGroupViewInfo.Index + 1 < GroupCount then
    begin
      AGroupViewInfo := Groups[GroupCount - 1];
      FItemsRect.Bottom := AGroupViewInfo.Rect.Top;
    end;
  end;
end;

procedure TdxSideBarViewInfo.CalcScrollButtonsRect;
begin
  SetRectEmpty(FTopScrollButtonRect);
  SetRectEmpty(FBottomScrollButtonRect);

  if (ItemCount = 0) then
    Exit;

  if Items[0].Item.Index > 0 then
  begin
    FTopScrollButtonRect := ItemsRect;
    FTopScrollButtonRect.Left := FTopScrollButtonRect.Right - ScrollButtonHeight;
    FTopScrollButtonRect.Bottom := FTopScrollButtonRect.Top + ScrollButtonHeight;
    OffSetRect(FTopScrollButtonRect, - SideBar.SpaceHeight, SideBar.SpaceHeight);
  end;
  if (Items[ItemCount - 1].Item.Index + 1 < SideBar.ActiveGroup.ItemCount)
  or (Items[ItemCount - 1].IsPartialVisible) then
  begin
    FBottomScrollButtonRect := ItemsRect;
    FBottomScrollButtonRect.Left := FBottomScrollButtonRect.Right - ScrollButtonHeight;
    FBottomScrollButtonRect.Top := FBottomScrollButtonRect.Bottom - ScrollButtonHeight;    
    OffSetRect(FBottomScrollButtonRect, - SideBar.SpaceHeight, - SideBar.SpaceHeight);
  end;
end;

function TdxSideBarViewInfo.GetItemInfoClass: TdxSideItemViewInfoClass;
begin
  Result := TdxSideItemViewInfo;
end;

function TdxSideBarViewInfo.CreateItem(AItem: TdxSideBarItem; ATop: Integer): TdxSideItemViewInfo;
var
  ACaptionRect, AImageRect: TRect;
begin
  AImageRect := GetItemImageRect(AItem, ATop);
  ACaptionRect := GetItemCaptionRect(AItem, ATop, AImageRect);
  Result := GetItemInfoClass.Create(self, AItem, AImageRect, ACaptionRect);
end;

procedure TdxSideBarViewInfo.CreateItems;
var
  ATop: Integer;
  AItemViewInfo: TdxSideItemViewInfo;
  i: Integer;
begin
  if (SideBar.ActiveGroup = nil) then exit;
  Painter.Canvas.Font.Assign(SideBar.ItemFont);
  ATop := ItemsRect.Top;
  for i := SideBar.ActiveGroup.TopVisibleItem to SideBar.ActiveGroup.ItemCount - 1 do
  begin
    Inc(ATop, SideBar.SpaceHeight);
    if ATop >= ItemsRect.Bottom then
      break;
    AItemViewInfo := CreateItem(SideBar.ActiveGroup.Items[i], ATop);
    ATop := AItemViewInfo.Bottom;
    FItems.Add(AItemViewInfo);
  end;
end;

procedure TdxSideBarViewInfo.ClearItems;
var
  i: Integer;
begin
  for i := 0 to ItemCount - 1 do
    Items[i].Free;
  FItems.Clear;
end;

function TdxSideBarViewInfo.GetGroupHeight: Integer;
begin
  Result := SideBar.GroupHeightOffSet * 2;
  if (Result = 0) then
    Result := 4;
  Inc(Result, GetFontHeight(SideBar.GroupFont));
end;

function TdxSideBarViewInfo.GetPaintRect: TRect;
begin
  Result := SideBar.ClientRect;
end;

function TdxSideBarViewInfo.GetGroupOffSet: Integer;
begin
  Result := 1;
end;

function TdxSideBarViewInfo.GetImageBorderOffSet: Integer;
begin
  Result := 1;
end;

function TdxSideBarViewInfo.GetItemViewInfo(AItem: TdxSideBarItem): TdxSideItemViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ItemCount - 1 do
    if Items[I].Item = AItem then
    begin
      Result := Items[I];
      break;
    end;
end;

function TdxSideBarViewInfo.GetItemImageRect(AItem: TdxSideBarItem; ATop: Integer): TRect;
begin
  with GetPaintRect do
    SetRect(Result, Left, SideBar.SpaceHeight, Right, Bottom);
  if (SideBar.ActiveGroup.IconType = dxsgLargeIcon) then begin
    Result.Bottom := Result.Top + GetLargeImageHeight;
    Inc(Result.Left, (Result.Right - Result.Left -  GetLargeImageWidth) div 2);
    Result.Right := Result.Left + GetLargeImageWidth;
  end
  else
  begin
    Inc(Result.Left, SideBar.SpaceHeight);
    Result.Right := Result.Left + GetSmallImageWidth;
    if GetItemHeight > GetSmallImageHeight then
      Inc(Result.Top, (GetItemHeight - GetSmallImageHeight) div 2);
    Result.Bottom := Result.Top + GetSmallImageHeight
  end;
  OffSetRect(Result, 0, ATop);
end;

function TdxSideBarViewInfo.GetItemCorrectedCaptionRect(ACaption: String; ARect: TRect): TRect;
var
  AHeight: Integer;
begin
  Result := ARect;
  AHeight := DrawText(Painter.DC, PChar(ACaption), Length(ACaption),
    Result, GetDrawEdgeFlag or DT_CALCRECT);
  if (SideBar.ActiveGroup.IconType = dxsgLargeIcon) then
  begin
    OffSetRect(Result, ((ItemsRect.Right - ItemsRect.Left) - (Result.Right - Result.Left)) div 2, 0);
    Result.Bottom := Result.Top + AHeight;
  end else
  begin
    if Result.Right > ItemsRect.Right - SideBar.SpaceHeight then
      Result.Right := ItemsRect.Right - SideBar.SpaceHeight;
  end;
end;

function TdxSideBarViewInfo.GetItemCaptionRect(AItem: TdxSideBarItem; ATop: Integer; AImageRect: TRect): TRect;
begin
  if (SideBar.ActiveGroup.IconType = dxsgLargeIcon) then
  begin
    Result := ItemsRect;
    Result.Top := AImageRect.Bottom + SideBar.SpaceHeight;
  end
  else
  begin
    Result.Top := ATop + SideBar.SpaceHeight;
    if (GetItemHeight  < GetSmallImageHeight) then
      Inc(Result.Top, (GetSmallImageHeight - GetItemHeight) div 2);
    Result.Bottom := Result.Top + GetItemHeight;
    Result.Left := AImageRect.Right + SideBar.SpaceHeight;
    Result.Right := SideBar.ClientWidth - Result.Top - SideBar.SpaceHeight;
  end;
  Result := GetItemCorrectedCaptionRect(AItem.Caption, Result);
end;

function TdxSideBarViewInfo.GetItemEditRect(AItem: TdxSideBarItem; ACaption: String): TRect;
var
  AItemViewInfo: TdxSideItemViewInfo;
begin
  AItemViewInfo := GetItemViewInfoByItem(AItem);
  if AItemViewInfo = nil then
  begin
    SetRectEmpty(Result);
    exit;
  end;
  if (SideBar.ActiveGroup.IconType = dxsgLargeIcon) then
  begin
    Result := ItemsRect;
    Result.Top := AItemViewInfo.ImageRect.Bottom + SideBar.SpaceHeight;
  end
  else
  begin
    Result := AItemViewInfo.CaptionRect;
    Result.Right := ItemsRect.Right;
  end;
  Result := GetItemCorrectedCaptionRect(ACaption, Result);
end;

function TdxSideBarViewInfo.GetDrawEdgeFlag: Integer;
begin
  if (SideBar.ActiveGroup.IconType = dxsgLargeIcon) then
    Result := DT_CENTER or DT_WORDBREAK or DT_EDITCONTROL
  else Result := DT_LEFT or DT_VCENTER or DT_SINGLELINE;
  Result := Result or DT_NOPREFIX;
end;

function TdxSideBarViewInfo.GetItemHeight: Integer;
begin
  Result := GetFontHeight(SideBar.ItemFont) + 2;
  if (GetSmallImageHeight > Result) then
    Result := GetSmallImageHeight;
end;

function TdxSideBarViewInfo.GetLargeImageHeight: Integer;
begin
  if (SideBar.GetLargeImages <> nil) then
    Result := SideBar.GetLargeImages.Height
  else Result := dxSideBarDefaultLargeImageHeight;
end;

function TdxSideBarViewInfo.GetLargeImageWidth: Integer;
begin
  if (SideBar.GetLargeImages <> nil) then
    Result := SideBar.GetLargeImages.Width
  else Result := dxSideBarDefaultLargeImageWidth;
end;

function TdxSideBarViewInfo.GetSmallImageHeight: Integer;
begin
  if (SideBar.GetSmallImages <> nil) then
    Result := SideBar.GetSmallImages.Height
  else Result := dxSideBarDefaultSmallImageHeight;
end;

function TdxSideBarViewInfo.GetSmallImageWidth: Integer;
begin
  if (SideBar.GetSmallImages <> nil) then
    Result := SideBar.GetSmallImages.Width
  else Result := dxSideBarDefaultSmallImageWidth;
end;

{TdxSideBarPainter}
constructor TdxSideBarPainter.Create(ASideBar: TdxSideBar);
begin
  FSideBar := ASideBar;
  FViewInfo := CreateViewInfo;
end;

destructor TdxSideBarPainter.Destroy;
begin
  FViewInfo.Free;
  inherited Destroy;
end;

function TdxSideBarPainter.IsGroupFocused: Boolean;
begin
  Result := False;
end;

procedure TdxSideBarPainter.Paint;
begin
  if (SideBar.ActiveGroup <> nil) and (SideBar.FOldActiveGroup <> nil)
  and (SideBar.ActiveGroup <> SideBar.FOldActiveGroup)
  and (ViewInfo.GroupCount > 0) then
    ScrollGroups;

  if not ViewInfo.IsReady then
    ViewInfo.CalcViewInfo;

  DrawGroups;
  DrawBorder;
  DrawScrollButtons;
  DrawItems;
  DrawFillRect(SideBar.ClientRect);
  DrawDragDestinationArrow;
end;

procedure TdxSideBarPainter.InvalidateGroup(AGroup: TdxSideGroup);
var
  AGroupViewInfo: TdxSideGroupViewInfo;
begin
  AGroupViewInfo := ViewInfo.GetGroupViewInfoByGroup(AGroup);
  if (AGroupViewInfo <> nil) then
    Windows.InvalidateRect(SideBar.Handle, @AGroupViewInfo.Rect, True);
end;

procedure TdxSideBarPainter.InvalidateItem(AItem: TdxSideBarItem);
var
  Rgn1, Rgn2: HRGN;
  AItemViewInfo: TdxSideItemViewInfo;
begin
  AItemViewInfo := ViewInfo.GetItemViewInfoByItem(AItem);
  if (AItemViewInfo = nil) then exit;
  with AItemViewInfo.ImageRect do
    Rgn1 := CreateRectRgn(Left - 1, Top - 1, Right + 1, Bottom + 1);
  with AItemViewInfo.CaptionRect do
    Rgn2 := CreateRectRgn(Left, Top, Right, Bottom);
  CombineRgn(Rgn1, Rgn1, Rgn2, RGN_OR);
  DeleteObject(Rgn2);
  with ViewInfo.ItemsRect do
    Rgn2 := CreateRectRgn(Left, Top, Right, Bottom);
  CombineRgn(Rgn1, Rgn1, Rgn2, RGN_AND);
  DeleteObject(Rgn2);
  Windows.InvalidateRgn(SideBar.Handle, Rgn1, True);
  DeleteObject(Rgn1);
end;

procedure TdxSideBarPainter.InvalidateItemImage(AItem: TdxSideBarItem);
var
  ARect: TRect;
  AItemViewInfo: TdxSideItemViewInfo;
begin
  AItemViewInfo := ViewInfo.GetItemViewInfoByItem(AItem);
  if (AItemViewInfo <> nil) then
  begin
    ARect := AItemViewInfo.ImageBorderRect;
    if ARect.Bottom > ViewInfo.ItemsRect.Bottom then
      ARect.Bottom := ViewInfo.ItemsRect.Bottom;
    InvalidateRect(SideBar.Handle, @ARect, True);
  end;
end;

procedure TdxSideBarPainter.InvalidateItemImageBorder(AItem: TdxSideBarItem);
var
  ARect: TRect;
  AItemViewInfo: TdxSideItemViewInfo;
  Rgn1, Rgn2: HRGN;
begin
  AItemViewInfo := ViewInfo.GetItemViewInfoByItem(AItem);
  if (AItemViewInfo <> nil) then
  begin
    ARect := AItemViewInfo.ItemBorderRect;
    with AItemViewInfo.ItemBorderRect do
      Rgn1 := CreateRectRgn(Left - 1, Top - 1, Right + 1, Bottom + 1);
    with AItemViewInfo.ImageRect do
      Rgn2 := CreateRectRgn(Left, Top, Right, Bottom);
    CombineRgn(Rgn1, Rgn1, Rgn2, RGN_XOR);
    DeleteObject(Rgn2);
    with ViewInfo.ItemsRect do
      Rgn2 := CreateRectRgn(Left, Top, Right, Bottom);
    CombineRgn(Rgn1, Rgn1, Rgn2, RGN_AND);
    DeleteObject(Rgn2);
    Windows.InvalidateRgn(SideBar.Handle, Rgn1, True);
    DeleteObject(Rgn1);
  end;
end;

procedure TdxSideBarPainter.InvalidateItems;
var
  Rgn1, Rgn2: HRGN;
  i: Integer;
begin
  with ViewInfo.GetPaintRect do
    Rgn1 := CreateRectRgn(Left, Top, Right, Bottom);
  for i := 0 to ViewInfo.GroupCount - 1 do
  begin
    with ViewInfo.Groups[i].Rect do
      Rgn2 := CreateRectRgn(Left, Top, Right, Bottom);
    CombineRgn(Rgn1, Rgn1, Rgn2, RGN_XOR);
    DeleteObject(Rgn2);
  end;
  Windows.InvalidateRgn(SideBar.Handle, Rgn1, True);
  DeleteObject(Rgn1);
end;

procedure TdxSideBarPainter.InvalidateScrollButtons;
var
  Rgn1, Rgn2: HRGN;
begin
  if not ViewInfo.IsTopScrollButtonVisible and not ViewInfo.IsTopScrollButtonVisible then
    exit;
  with ViewInfo.TopScrollButtonRect do
    Rgn1 := CreateRectRgn(Left, Top, Right, Bottom);
  with ViewInfo.BottomScrollButtonRect do
    Rgn2 := CreateRectRgn(Left, Top, Right, Bottom);
  CombineRgn(Rgn1, Rgn1, Rgn2, RGN_OR);
  Windows.InvalidateRgn(SideBar.Handle, Rgn1, True);
  DeleteObject(Rgn1);
  DeleteObject(Rgn2);
end;

function TdxSideBarPainter.CreateViewInfo: TdxSideBarViewInfo;
begin
  Result := TdxSideBarViewInfo.Create(self);
end;

function TdxSideBarPainter.Canvas: TCanvas;
begin
  Result := SideBar.Canvas;
end;

function TdxSideBarPainter.DC: HDC;
begin
  Result := Canvas.Handle;
end;

procedure TdxSideBarPainter.NeedRecalViewInfo;
begin
  ViewInfo.Unready;
end;

function TdxSideBarPainter.ClientHeight: Integer;
begin
  Result := SideBar.ClientHeight;
end;

function TdxSideBarPainter.ClientWidth: Integer;
begin
  Result := SideBar.ClientWidth;
end;

procedure TdxSideBarPainter.ExcludeClipRect(ARect: TRect);
begin
  Windows.ExcludeClipRect(DC, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
end;

procedure TdxSideBarPainter.IntersectClipRect(ARect: TRect);
begin
  Windows.IntersectClipRect(DC, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
end;

procedure TdxSideBarPainter.DrawBorder;
begin
end;

procedure TdxSideBarPainter.ScrollGroups;

  function IsTopScrolling: Boolean;
  begin
    Result := SideBar.FOldActiveGroup.Index > SideBar.ActiveGroup.Index;
  end;

var
  r, rs: TRect;
  FStep, FdStep: Integer;
  FirstTime, NextTime: Integer;
begin
  r := ViewInfo.ItemsRect;
  r.Left := ViewInfo.GetPaintRect.Left;
  r.Right := ViewInfo.GetPaintRect.Right;
  if IsTopScrolling then
  begin
    r.Top := ViewInfo.GetGroupViewInfoByGroup(SideBar.ActiveGroup).Rect.Bottom;
    FdStep := 1;
  end
  else
  begin
    r.Bottom := ViewInfo.GetGroupViewInfoByGroup(SideBar.ActiveGroup).Rect.Bottom;
    FdStep := -1;
  end;

  FirstTime := GetTickCount;
  FStep := dxSideBarGroupScrollStep;
  while (r.Bottom - r.Top > ViewInfo.GetGroupHeight) do
  begin
    if IsTopScrolling then
    begin
      rs := r;
      rs.Bottom := rs.Top + FStep;
      Inc(r.Top, FStep);
    end  
    else
    begin
      rs := r;
      rs.Top := rs.Bottom - FStep;
      Dec(r.Bottom, FStep);
    end;
    ScrollWindowEx(SideBar.Handle, 0, FStep * FdStep, @r, @r, 0, nil, 0);

    DrawFillRect(rs);

    NextTime := GetTickCount;
    if (NextTime - FirstTime) > dxSideBarGroupScrollTimeToIncrement then
    begin
      FirstTime := NextTime;
      Inc(FStep, dxSideBarGroupScrollIncrement);
    end;
  end;
  SideBar.FOldActiveGroup := nil;
end;

procedure TdxSideBarPainter.DrawFillRect(ARect: TRect);
begin
  if (SideBar.BkPicture.Graphic = nil) or (SideBar.BkPicture.Graphic.Empty) then begin
    if (SideBar.BkGround.IsUsed) then
      DrawDifColorsOnCanvas(Canvas, SideBar.BkGround.BeginColor, SideBar.BkGround.EndColor,
        SideBar.BkGround.Step, (SideBar.BkGround.FillStyle = bfsHorz), ARect, ClientWidth, ClientHeight)
    else
    begin
      Canvas.Brush.Color := SideBar.Color;
      Canvas.FillRect(ARect);
    end;
  end else DrawBmpOnCanvas(Canvas, SideBar.BkPicture, ARect, ClientWidth, ClientHeight);
end;

procedure TdxSideBarPainter.DrawGroups;
var
  i: Integer;
begin
  for i := 0 to ViewInfo.GroupCount - 1 do
    DrawGroup(ViewInfo.Groups[i]);
end;

procedure TdxSideBarPainter.DrawItems;
var
  i: Integer;
begin
  for i := 0 to ViewInfo.ItemCount - 1 do
    DrawItem(ViewInfo.Items[i]);
end;

procedure TdxSideBarPainter.DrawGroup(AGroupViewInfo: TdxSideGroupViewInfo);
begin
end;

procedure TdxSideBarPainter.DrawItem(AItemViewInfo: TdxSideItemViewInfo);
begin
  DrawItemImage(AItemViewInfo);
  DrawItemCaption(AItemViewInfo);  
end;

{$IFDEF DELPHI4}
const
  DT_END_ELLIPSIS = $8000;
{$ENDIF}

procedure TdxSideBarPainter.DrawItemCaption(AItemViewInfo: TdxSideItemViewInfo);
var
  Flag: Integer;
  OldColor: TColor;
  ARect: TRect;
begin
  if (SideBar.ActiveGroup.IconType = dxsgLargeIcon) then
    Flag := ViewInfo.GetDrawEdgeFlag
  else  Flag := ViewInfo.GetDrawEdgeFlag or DT_END_ELLIPSIS;

  Canvas.Brush.Style := bsClear;
  Canvas.Font := SideBar.ItemFont;
  ARect := AItemViewInfo.CaptionRect;

  DrawFillRect(ARect);

  if AItemViewInfo.Item.Enabled then
    DrawText(DC, PChar(AItemViewInfo.Caption), Length(AItemViewInfo.Caption), ARect, Flag)
  else
  begin
    OldColor := Canvas.Font.Color;
    Canvas.Font.Color := clbtnHighLight;
    Canvas.Brush.Style := bsClear;
    OffsetRect(ARect, 1, 1);
    DrawText(DC, PChar(AItemViewInfo.Caption), Length(AItemViewInfo.Caption), ARect, Flag);
    Canvas.Font.Color := clbtnShadow;
    OffsetRect(ARect, -1, -1);
    DrawText(DC, PChar(AItemViewInfo.Caption), Length(AItemViewInfo.Caption), ARect, Flag);
    Canvas.Font.Color := OldColor;
  end;

   ExcludeClipRect(AItemViewInfo.CaptionRect);
end;

procedure TdxSideBarPainter.DrawImageRect(AItemViewInfo: TdxSideItemViewInfo; ARect: TRect);
begin
  DrawFillRect(ARect);
end;

procedure TdxSideBarPainter.DrawItemImage(AItemViewInfo: TdxSideItemViewInfo);

  function GetRGBColor(Value: TColor): DWORD;
  begin
    Result := ColorToRGB(Value);
    case Result of
      clNone: Result := CLR_NONE;
      clDefault: Result := CLR_DEFAULT;
    end;
  end;

const
  DrawingStyles: array[TDrawingStyle] of Longint = (ILD_FOCUS,
    ILD_SELECTED, ILD_NORMAL, ILD_TRANSPARENT);
  Images: array[TImageType] of Longint = (0, ILD_MASK);
var
  ARect: TRect;
begin
  ARect := AItemViewInfo.ImageBorderRect;
  DrawImageRect(AItemViewInfo, ARect);
  if (AItemViewInfo.ImageList = nil) or (AItemViewInfo.ImageIndex < 0)
  or (AItemViewInfo.ImageIndex >= AItemViewInfo.ImageList.Count) then
    exit;

  with AItemViewInfo.ImageList do
    if HandleAllocated then
    begin
      ImageList_DrawEx(Handle, AItemViewInfo.ImageIndex, DC,
         AItemViewInfo.ImageRect.Left, AItemViewInfo.ImageRect.Top, 0, 0,
        GetRGBColor(BkColor), GetRGBColor(BlendColor),
        DrawingStyles[DrawingStyle] or Images[ImageType]);
    end;
  DrawItemImageBorder(AItemViewInfo);
  if ARect.Bottom > ViewInfo.ItemsRect.Bottom then
    ARect.Bottom := ViewInfo.ItemsRect.Bottom;
  ExcludeClipRect(ARect);
end;

procedure TdxSideBarPainter.DrawItemImageBorder(AItemViewInfo: TdxSideItemViewInfo);
var
  ARect: TRect;
begin
  if not AItemViewInfo.Item.Enabled then exit;
  ARect := AItemViewInfo.ItemBorderRect;
  if (AItemViewInfo.Item.IsSelected)
  or (AItemViewInfo.Item.IsFocused and SideBar.MouseFocusedItemIsDown) then
  begin
    DrawEdge(DC, ARect, BDR_SUNKENINNER, BF_RECT);
  end else
  begin
    if AItemViewInfo.Item.IsFocused then
      DrawEdge(DC, ARect, BDR_RAISEDOUTER, BF_RECT);
  end;
  if AItemViewInfo.Item.IsFocused or AItemViewInfo.Item.IsSelected then
  begin
    if (AItemViewInfo.ItemBorderRect.Left < AItemViewInfo.ImageBorderRect.Left)
    or (AItemViewInfo.ItemBorderRect.Top < AItemViewInfo.ImageBorderRect.Top) then
    begin
      with ARect do
      begin
        ExcludeClipRect(Rect(Left, Top, Left + 1, Bottom)); //[
        ExcludeClipRect(Rect(Right - 1, Top, Right, Bottom)); //]
        ExcludeClipRect(Rect(Left, Top, Right, Top + 1)); //-
        ExcludeClipRect(Rect(Left, Bottom - 1, Right, Bottom)); //_
      end;
    end;
  end;
end;

procedure TdxSideBarPainter.DrawScrollButtons;
Const
  ConstPushed: Array[False..True] of Integer =
  (0, DFCS_PUSHED);
begin
  if ViewInfo.IsTopScrollButtonVisible then
  begin
    DrawFrameControl(Canvas.Handle, ViewInfo.TopScrollButtonRect, DFC_SCROLL,
      DFCS_SCROLLUP or ConstPushed[(dxSideBarDragObject = nil) and SideBar.FScrollButtonUpIsDown]);
    ExcludeClipRect(ViewInfo.TopScrollButtonRect);
  end;
  if ViewInfo.IsBottomScrollButtonVisible then
  begin
    DrawFrameControl(Canvas.Handle, ViewInfo.BottomScrollButtonRect, DFC_SCROLL,
      DFCS_SCROLLDOWN or ConstPushed[(dxSideBarDragObject = nil) and SideBar.FScrollButtonDownIsDown]);
    ExcludeClipRect(ViewInfo.BottomScrollButtonRect);
  end;
end;

procedure TdxSideBarPainter.DrawDragDestinationArrow;
var
  p1, p2, p3: TPoint;
  r: TRect;
  OldColor: TColor;
  fdY: Integer;

  function HasTopTriangle: Boolean;
  begin
    Result := (SideBar.DropItemPosition <> sbdspTop) or ((SideBar.DestDropItemViewInfo <> nil)
        and (SideBar.DestDropItemViewInfo.Index > 0));
  end;

  function HasBottomTriangle: Boolean;
  begin
    Result := (SideBar.DropItemPosition <> sbdspBottom) or ((SideBar.DestDropItemViewInfo <> nil)
        and (SideBar.DestDropItemViewInfo.Index + 1 < ViewInfo.ItemCount));
  end;

begin
  if SideBar.DropItemPosition = sbdspIn then
    exit;
  if SideBar.DestDropItemViewInfo <> nil then
    r := SideBar.DestDropItemViewInfo.GetItemDragSourceSpace(SideBar.DropItemPosition)
  else
  begin
    r := ViewInfo.ItemsRect;
    r.Bottom := r.Top + dxSideBarDragArrowHeight - 1;
  end;
  InflateRect(r, - SideBar.SpaceHeight, 0);

  OldColor := Canvas.Brush.Color;
  Canvas.Brush.Color := clBlack;

  Canvas.MoveTo(r.Left + dxSideBarDragArrowHeight, r.Top + dxSideBarDragArrowHeight div 2);
  Canvas.LineTo(r.Right - dxSideBarDragArrowHeight, r.Top + dxSideBarDragArrowHeight div 2);

  p3.Y := r.Top + dxSideBarDragArrowHeight div 2;
  fdY := 0;
  if HasTopTriangle then
    p1.Y := r.Top
  else
  begin
    p1.Y := p3.Y;
    fdY := 1;
  end;
  if HasBottomTriangle then
    p2.Y := r.Bottom
  else
  begin
    p2.Y := p3.Y;
    fdY := -1;
  end;

  p3.X := r.Left + dxSideBarDragArrowHeight - 1;
  p1.X := r.Left;
  p2.X := r.Left;

  Canvas.Polyline([p1, p2, p3, p1]);
  Canvas.FloodFill(p3.X - dxSideBarDragArrowHeight div 2, p3.Y + fdy, clBlack, fsBorder);

  p3.X := r.Right - dxSideBarDragArrowHeight + 1;
  p1.X := r.Right;
  p2.X := r.Right;
  Canvas.Polyline([p1, p2, p3, p1]);
  Canvas.FloodFill(p3.X + dxSideBarDragArrowHeight div 2, p3.Y+ fdy, clBlack, fsBorder);
  Canvas.Brush.Color := OldColor;
end;

{TdxSideBarStandardPainter}
type
TdxSideBarStandardViewInfo = class(TdxSideBarViewInfo)
protected
  function GetPaintRect: TRect; override;
end;

TdxSideBarStandardPainter = class(TdxSideBarPainter)
protected
  function CreateViewInfo: TdxSideBarViewInfo; override;
public
  procedure DrawGroup(AGroupViewInfo: TdxSideGroupViewInfo); override;
end;

TdxSideBarFlatViewInfo = class(TdxSideBarViewInfo)
protected
  function GetGroupHeight: Integer; override;
  function GetPaintRect: TRect; override;
end;

TdxSideBarFlatPainter = class(TdxSideBarPainter)
protected
  function CreateViewInfo: TdxSideBarViewInfo; override;
public
  procedure DrawBorder; override;
  procedure DrawGroup(AGroupViewInfo: TdxSideGroupViewInfo); override;
  function IsGroupFocused: Boolean; override;
end;

TdxSideItemW2KViewInfo = class(TdxSideItemViewInfo)
public
  function ItemBorderRect: TRect; override;
end;

TdxSideBarW2KViewInfo = class(TdxSideBarFlatViewInfo)
public
  function GetItemInfoClass: TdxSideItemViewInfoClass; override;
end;

TdxSideBarW2KPainter = class(TdxSideBarFlatPainter)
protected
  function CreateViewInfo: TdxSideBarViewInfo; override;
end;

TdxSideBarXPViewInfo = class(TdxSideBarViewInfo)
protected
  function GetGroupHeight: Integer; override;
  function GetPaintRect: TRect; override;
  function GetGroupOffSet: Integer; override;
  function GetImageBorderOffSet: Integer; override;    
end;

TdxSideBarXPPainter = class(TdxSideBarPainter)
protected
  function CreateViewInfo: TdxSideBarViewInfo; override;
  procedure InvalidateItemImageBorder(AItem: TdxSideBarItem); override;
public
  procedure DrawBorder; override;
  procedure DrawGroup(AGroupViewInfo: TdxSideGroupViewInfo); override;
  procedure DrawImageRect(AItemViewInfo: TdxSideItemViewInfo; ARect: TRect); override;
  procedure DrawItemImageBorder(AItemViewInfo: TdxSideItemViewInfo); override;
  function IsGroupFocused: Boolean; override;
end;


{TdxSideBarStandardPainter}
function TdxSideBarStandardViewInfo.GetPaintRect: TRect;
var
  dxy: Integer;
begin
  Result := SideBar.ClientRect;
  if SideBar.ShowGroups then
  begin
    dxy := SideBar.BevelWidth;
    if (SideBar.BorderStyle = bsSingle) then
     Inc(dxy, SideBar.BorderWidth);
    InflateRect(Result, - dxy,  - dxy);
    Inc(Result.Top, 1);
    Inc(Result.Bottom, 1);
  end;
end;

function TdxSideBarStandardPainter.CreateViewInfo: TdxSideBarViewInfo;
begin
  Result := TdxSideBarStandardViewInfo.Create(self);
end;

procedure TdxSideBarStandardPainter.DrawGroup(AGroupViewInfo: TdxSideGroupViewInfo);
var
  r: TRect;
  DrawCaption: string;
begin
  Canvas.Font := SideBar.GroupFont;
  Canvas.Brush.Color := clBtnFace;
  r := DrawButtonFace(Canvas, AGroupViewInfo.Rect, 1, bsNew, True, False, False);
  DrawCaption := GetClippedString(DC, AGroupViewInfo.Caption, r);
  DrawText(DC, PChar(DrawCaption), Length(DrawCaption), r, DT_CENTER or DT_VCENTER
        or DT_SINGLELINE or DT_END_ELLIPSIS or DT_NOPREFIX);
  ExcludeClipRect(AGroupViewInfo.Rect);
end;

{TdxSideBarFlatPainter}
function TdxSideBarFlatViewInfo.GetGroupHeight: Integer;
begin
  Result := SideBar.GroupHeightOffSet * 2;
  if (Result = 0) then
    Result := 8;
  Inc(Result, GetFontHeight(SideBar.GroupFont));
end;

function TdxSideBarFlatViewInfo.GetPaintRect: TRect;
begin
  if SideBar.ShowGroups then
    SetRect(Result, 1, 1, SideBar.ClientWidth - 1, SideBar.ClientHeight)
  else SetRect(Result, 1, 0, SideBar.ClientWidth - 1, SideBar.ClientHeight);
end;

function TdxSideBarFlatPainter.CreateViewInfo: TdxSideBarViewInfo;
begin
  Result := TdxSideBarFlatViewInfo.Create(self);
end;

procedure TdxSideBarFlatPainter.DrawBorder;
var
  r: TRect;
begin
  SetRect(r, 0, 0, ClientWidth, ClientHeight);
  DrawEdge(DC, r, BDR_SUNKENOUTER, BF_RECT);
  InflateRect(r, -1, -1);
  IntersectClipRect(r);
end;

procedure TdxSideBarFlatPainter.DrawGroup(AGroupViewInfo: TdxSideGroupViewInfo);
var
  r, r1: TRect;
begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.Font := SideBar.GroupFont;
  r := AGroupViewInfo.Rect;

  InflateRect(r, -1, -1);
  r1 := r;
  DrawText(DC, PChar(AGroupViewInfo.Caption),
         Length(AGroupViewInfo.Caption), r1,
         DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS or DT_NOPREFIX);
  DrawText(DC, PChar(AGroupViewInfo.Caption),
         Length(AGroupViewInfo.Caption), r1,
         DT_CENTER or DT_VCENTER or DT_CALCRECT or DT_END_ELLIPSIS or DT_NOPREFIX);
  if (r1.Right > r.Right) then
  begin
    r1.Left := r.Left;
    r1.Right := r.Right;
  end;

  OffSetRect(r1, ((r.Right - r.Left) - (r1.Right - r1.Left)) div 2,
    ((r.Bottom - r.Top) - (r1.Bottom - r1.Top)) div 2);
  ExcludeClipRect(r1);
  Canvas.FillRect(r);

  InflateRect(r, 1, 1);
  if (SideBar.FMouseFocusedGroup = AGroupViewInfo.Group) then
  begin
    if not SideBar.FMouseFocusedGroupIsDown then
    begin
      DrawEdge(DC, r, BDR_RAISEDINNER, BF_TOPLEFT);
      DrawEdge(DC, r, BDR_RAISEDOUTER, BF_BOTTOMRIGHT);
      InflateRect(r, -1, -1);
      DrawEdge(DC, r, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
      Dec(r.Bottom);
      Dec(r.Right);
    end
    else
    begin
      DrawEdge(DC, r, BDR_SUNKENINNER, BF_TOPLEFT);
      DrawEdge(DC, r, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
      InflateRect(r, -1, -1);
      DrawEdge(DC, r, BDR_SUNKENOUTER, BF_TOPLEFT);
      Inc(r.Top);
      Inc(r.Left);
    end;
  end
  else
  begin
    DrawEdge(DC, r, BDR_RAISEDINNER, BF_TOPLEFT);
    DrawEdge(DC, r, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
  end;
  r := AGroupViewInfo.Rect;
  if AGroupViewInfo.Group.Active then
  begin
    Inc(r.Bottom);
    DrawEdge(DC, r, BDR_RAISEDOUTER, BF_BOTTOM);
  end;
  ExcludeClipRect(r);
end;

function TdxSideBarFlatPainter.IsGroupFocused: Boolean;
begin
  Result := True;
end;


{TdxSideItemW2KViewInfo}
function TdxSideItemW2KViewInfo.ItemBorderRect: TRect;
begin
  Result := inherited ImageBorderRect;
  Result.Left := ViewInfo.ItemsRect.Left;
  Result.Right := ViewInfo.ItemsRect.Right;
  if Result.Bottom < CaptionRect.Bottom then
    Result.Bottom := CaptionRect.Bottom;
  Dec(Result.Top, Painter.SideBar.SpaceHeight);
  Inc(Result.Bottom, Painter.SideBar.SpaceHeight - 1);  
end;

{TdxSideBarW2KViewInfo}
function TdxSideBarW2KViewInfo.GetItemInfoClass: TdxSideItemViewInfoClass;
begin
  Result := TdxSideItemW2KViewInfo;
end;

{TdxSideBarW2KPainter}
function TdxSideBarW2KPainter.CreateViewInfo: TdxSideBarViewInfo;
begin
  Result := TdxSideBarW2KViewInfo.Create(self);
end;

{TdxSideBarXPViewInfo}
function TdxSideBarXPViewInfo.GetGroupHeight: Integer;
begin
  Result := SideBar.GroupHeightOffSet * 2;
  if (Result = 0) then
    Result := 8;
  Inc(Result, GetFontHeight(SideBar.GroupFont));
end;

function TdxSideBarXPViewInfo.GetPaintRect: TRect; 
begin
  if SideBar.ShowGroups then
    SetRect(Result, 1, 1, SideBar.ClientWidth - 1, SideBar.ClientHeight - 1)
  else SetRect(Result, 1, 0, SideBar.ClientWidth - 1, SideBar.ClientHeight);
end;

function TdxSideBarXPViewInfo.GetGroupOffSet: Integer;
begin
  Result := 0;
end;

function TdxSideBarXPViewInfo.GetImageBorderOffSet: Integer;
begin
  Result := 5;
end;


{TdxSideBarXPPainter}
function TdxSideBarXPPainter.CreateViewInfo: TdxSideBarViewInfo;
begin
  Result := TdxSideBarXPViewInfo.Create(Self);
end;

procedure TdxSideBarXPPainter.InvalidateItemImageBorder(AItem: TdxSideBarItem);
var
  r: TRect;
  AItemViewInfo: TdxSideItemViewInfo;
begin
  AItemViewInfo := ViewInfo.GetItemViewInfoByItem(AItem);
  if AItemViewInfo = nil then
    exit;
  r := AItemViewInfo.ImageBorderRect;
  InvalidateRect(SideBar.Handle, @r, True);
end;

procedure TdxSideBarXPPainter.DrawBorder;
var
  r: TRect;
begin
  SetRect(r, 0, 0, ClientWidth, ClientHeight);
  DrawEdge(DC, r, BDR_SUNKENOUTER, BF_RECT);
  InflateRect(r, -1, -1);
  IntersectClipRect(r);  
end;

procedure TdxSideBarXPPainter.DrawGroup(AGroupViewInfo: TdxSideGroupViewInfo);
var
  r, r1: TRect;
begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.Font := SideBar.GroupFont;
  r := AGroupViewInfo.Rect;

  InflateRect(r, -1, -1);
  r1 := r;
  DrawText(DC, PChar(AGroupViewInfo.Caption),
         Length(AGroupViewInfo.Caption), r1,
         DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS or  DT_NOPREFIX);
  DrawText(DC, PChar(AGroupViewInfo.Caption),
         Length(AGroupViewInfo.Caption), r1,
         DT_CENTER or DT_VCENTER or DT_CALCRECT or DT_END_ELLIPSIS or DT_NOPREFIX);
  if (r1.Right > r.Right) then
  begin
    r1.Left := r.Left;
    r1.Right := r.Right;
  end;

  OffSetRect(r1, ((r.Right - r.Left) - (r1.Right - r1.Left)) div 2,
    ((r.Bottom - r.Top) - (r1.Bottom - r1.Top)) div 2);
  ExcludeClipRect(r1);
  Canvas.FillRect(r);

  InflateRect(r, 1, 1);
  if (SideBar.FMouseFocusedGroup = AGroupViewInfo.Group) then
  begin
    if not SideBar.FMouseFocusedGroupIsDown then
    begin
      DrawEdge(DC, r, BDR_RAISEDINNER, BF_TOPLEFT);
      DrawEdge(DC, r, BDR_RAISEDOUTER, BF_BOTTOMRIGHT);
      InflateRect(r, -1, -1);
      DrawEdge(DC, r, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
      Dec(r.Bottom);
      Dec(r.Right);
    end
    else
    begin
      DrawEdge(DC, r, BDR_SUNKENINNER, BF_TOPLEFT);
      DrawEdge(DC, r, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
      InflateRect(r, -1, -1);
      DrawEdge(DC, r, BDR_SUNKENOUTER, BF_TOPLEFT);
      Inc(r.Top);
      Inc(r.Left);
    end;
  end
  else
  begin
    DrawEdge(DC, r, BDR_RAISEDINNER, BF_TOPLEFT);
    DrawEdge(DC, r, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
  end;
  ExcludeClipRect(AGroupViewInfo.Rect);
end;

procedure TdxSideBarXPPainter.DrawImageRect(AItemViewInfo: TdxSideItemViewInfo; ARect: TRect);
var
  brush: HBrush;
begin
  if (AItemViewInfo.Item.IsSelected)or (AItemViewInfo.Item.IsFocused)then
  begin
    brush := CreateSolidBrush(TdxSideBar.XPSelectedItemColor);
    Windows.FillRect(DC, ARect, brush);
    DeleteObject(brush);
  end else DrawFillRect(ARect);
end;

procedure TdxSideBarXPPainter.DrawItemImageBorder(AItemViewInfo: TdxSideItemViewInfo);
var
  ARect: TRect;
  OldColor: TColor;
begin
  ARect := AItemViewInfo.ImageBorderRect;
  if (AItemViewInfo.Item.IsSelected)or (AItemViewInfo.Item.IsFocused)then
  begin
    OldColor := Canvas.Brush.Color;
    Canvas.Brush.Color := clActiveCaption;
    Canvas.FrameRect(ARect);
    Canvas.Brush.Color := OldColor;
  end;
end;

function TdxSideBarXPPainter.IsGroupFocused: Boolean;
begin
  Result := True;
end;

{TdxSideBar}
constructor TdxSideBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if (FPainter <> nil) then
  begin
    FPainter.Free;
    FPainter := nil;
  end;
  FPaintStyle := sbpsFlat;

  ControlStyle := ControlStyle - [csSetCaption, csAcceptsControls];
  FGroups := TdxSideGroups.Create(Self);
  FGroupFont := TFont.Create;
  FGroupFont.OnChange := OnFontChange;
  FItemFont := TFont.Create;
  FImageList := TImageList.Create(Self);
  FItemFont.Color := clWindow;
  FItemFont.OnChange := OnFontChange;
  FBkPicture := TPicture.Create;
  FBkPicture.OnChange := DoBkPictureChange;
  Color := clGrayText;
  FBkGround := TdxSideBarBackGround.Create;
  FBkGround.OnChange := DoBkPictureChange;

  FActiveGroupIndex := 0;
  FActiveGroup := nil;
  FScrollTimerID := -1;
  FHintTimerID := -1;
  FSpaceHeight := 7;
  FScrollDelay := 300;
  BevelInner := bvNone;
  BevelOuter := bvNone;

  FLargeChangeLink := TChangeLink.Create;
  FSmallChangeLink := TChangeLink.Create;
  FLargeChangeLink.OnChange := OnChangeLink;
  FSmallChangeLink.OnChange := OnChangeLink;

  Align := alLeft;
  Height := 300;
  Width := 150;
  FEnableDraging := False;  
  FDestDropItem := nil;
  FDropItemPosition := sbdspIn;
  FTransparentImages := False;
  FAssignFlag := False;
  FOldActiveGroup := nil;
  FCanSelected := False;
  FHintWindow := THintWindow.Create(Self);
  FHintWindowShowing := False;
  FGroupHeightOffSet := 0;
  FDestroying := False;

  FShowGroups := True;

end;

destructor TdxSideBar.Destroy;
begin
  if StoreInRegistry and not (csDesigning in ComponentState) and (RegistryPath <> '') then
    SaveToRegistry(RegistryPath);

  FDestroying := True;
  FLargeChangeLink.Free;
  FSmallChangeLink.Free;

  Store := nil;
  FHintWindow.Free;
  FImageList.Free;
  FGroupFont.Free;
  FItemFont.Free;
  FGroups.Free;
  FBkPicture.Free;
  FBkGround.Free;

  if (FPainter <> nil) then
    FPainter.Free;
  
  inherited Destroy;
end;

procedure TdxSideBar.Loaded;
begin
  inherited Loaded;
  {load from registry}
  if StoreInregistry and not (csDesigning in ComponentState) and (RegistryPath <> '') then
    LoadFromRegistry(RegistryPath);
  if (ActiveGroup = nil) then
    ActiveGroupIndex := 0;
end;

procedure TdxSideBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  Painter.NeedRecalViewInfo;
end;

function GetRealColor(AColor: COLORREF): COLORREF;
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetNearestColor(DC, AColor);
  ReleaseDC(0, DC);
end;

function GetLightColor(ABtnFaceColorPart, AHighlightColorPart, AWindowColorPart: Integer): COLORREF;
var
  ABtnFaceColor, AHighlightColor, AWindowColor: COLORREF;

  function GetLightIndex(ABtnFaceValue, AHighlightValue, AWindowValue: Byte): Integer;
  begin
    Result :=
      MulDiv(ABtnFaceValue, ABtnFaceColorPart, 100) +
      MulDiv(AHighlightValue, AHighlightColorPart, 100) +
      MulDiv(AWindowValue, AWindowColorPart, 100);
    if Result < 0 then Result := 0;
    if Result > 255 then Result := 255;
  end;

begin
  ABtnFaceColor := GetSysColor(COLOR_BTNFACE);
  AHighlightColor := GetSysColor(COLOR_HIGHLIGHT);
  AWindowColor := GetSysColor(COLOR_WINDOW);
  if (ABtnFaceColor = 0) or (ABtnFaceColor = $FFFFFF) then
    Result := AHighlightColor
  else
    Result := RGB(
      GetLightIndex(GetRValue(ABtnFaceColor), GetRValue(AHighlightColor), GetRValue(AWindowColor)),
      GetLightIndex(GetGValue(ABtnFaceColor), GetGValue(AHighlightColor), GetGValue(AWindowColor)),
      GetLightIndex(GetBValue(ABtnFaceColor), GetBValue(AHighlightColor), GetBValue(AWindowColor)));
end;


class function TdxSideBar.XPBackgroundColor: COLORREF;

  function GetLightValue(Value: Byte): Byte;
  begin
    Result := Value + MulDiv(255 - Value, 16, 100);
  end;

begin
  Result := GetSysColor(COLOR_BTNFACE);
  Result := RGB(
    GetLightValue(GetRValue(Result)),
    GetLightValue(GetGValue(Result)),
    GetLightValue(GetBValue(Result)));
  Result := GetRealColor(Result);
end;

class function TdxSideBar.XPSelectedItemColor: COLORREF;
begin
  Result := GetRealColor(GetLightColor(-2, 30, 72));
end;

procedure TdxSideBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then begin
    if (AComponent = FGroupPopupMenu) then FGroupPopupMenu := nil;
    if (AComponent = FItemPopupMenu) then FItemPopupMenu := nil;
    if (AComponent = FStore) then Store := nil;
    if (AComponent = LargeImages) then LargeImages := nil;
    if (AComponent = SmallImages) then SmallImages := nil;
  end
end;


procedure TdxSideBar.Assign(Source: TPersistent);
begin
  if (Source is TdxSideBar) then begin
    FAssignFlag := True;
    FMouseFocusedGroup := nil;
    Store := TdxSideBar(Source).Store;
    SetGroups(TdxSideBar(Source).Groups);
    SmallImages := TdxSideBar(Source).SmallImages;
    LargeImages := TdxSideBar(Source).LargeImages;
    FAssignFlag := False;
    RepaintAll;
  end;

end;

function TdxSideBar.GetGroupCount: Integer;
begin
  Result := FGroups.Count;
end;

function TdxSideBar.GetPainter: TdxSideBarPainter;
begin
  if FPainter = nil then
    FPainter := CreatePainter;
  Result := FPainter;  
end;

function TdxSideBar.GetViewInfo: TdxSideBarViewInfo;
begin
  Result := Painter.ViewInfo;
end;

procedure TdxSideBar.SetActiveGroup(Value: TdxSideGroup);
{$IFDEF DELPHI4}
var
  I: Integer;
{$ENDIF}
begin
  {$IFDEF DELPHI4}
  if (Store <> nil) and not (csDesigning in Store.ComponentState) then
    for I := 0 to Store.Count - 1 do
      with Store.Items[I] do
        if FActionLink <> nil then FActionLink.Update;
  {$ENDIF}

  if (Value <> nil) and not Value.Visible then
    Value := nil;

  if (FActiveGroup <> Value) or ((FActiveGroup <> nil) and (not FActiveGroup.Visible))
  and not (csDestroying in ComponentState) then
  begin
    DoItemMouseFocused(nil, False);

    SetMouseFocusedItem(nil);
    FMouseFocusedItemIsDown := False;
    SetDestDropItemandPosition(nil, sbdspIn);
    if (Value = nil) and (VisibleGroupCount > 0) then
      FActiveGroup := VisibleGroups[0]
    else FActiveGroup := Value;
    if FActiveGroup <> nil then
    begin
     ActiveGroupIndex := GetVisibleIndexByGroup(FActiveGroup);
     FActiveGroup.FTopVisibleItem := 0;
    end
    else ActiveGroupIndex := -1;
    if Assigned(FOnChangeActiveGroup) then
      FOnChangeActiveGroup(Self);
    RepaintAll;
  end;
end;

procedure TdxSideBar.SetActiveGroupIndex(Value: Integer);
begin
  if (FActiveGroupIndex <> Value) then
  begin
    FOldActiveGroup := FActiveGroup;
    if ((Value < 0) or (Value >= VisibleGroupCount)) and (VisibleGroupCount > 0) then
      FActiveGroupIndex := 0
    else FActiveGroupIndex := Value;
  end;
  if (VisibleGroupCount > 0) and (FActiveGroupIndex < VisibleGroupCount) then
    ActiveGroup := VisibleGroups[FActiveGroupIndex];
end;

procedure TdxSideBar.SetBkGround(Value: TdxSideBarBackGround);
begin
  FBkGround := Value;
  RepaintAll;
end;

procedure TdxSideBar.SetBkPicture(Value: TPicture);
begin
  FBkPicture.Assign(Value);
end;

procedure TdxSideBar.SetCanSelected(Value: Boolean);
begin
  if (FCanSelected <> Value) then begin
    if (FSelectedItem <> nil) then
      DoItemSelected(nil);
    FCanSelected := Value;      
  end;
end;

procedure TdxSideBar.SetGroupFont(Value: TFont);
begin
  FGroupFont.Assign(Value);
  RepaintAll;
end;

procedure TdxSideBar.SetGroups(Value: TdxSideGroups);
begin
  FGroups.Assign(Value);
  ActiveGroupIndex := 0;
  RepaintAll;
end;

procedure TdxSideBar.SetGroupHeightOffSet(Value: Integer);
begin
  if (FGroupHeightOffSet <> Value) and (Value > -1) and (Value < 10) then
  begin
    FGroupHeightOffSet := Value;
    RepaintAll;
  end;
end;

procedure TdxSideBar.SetItemFont(Value: TFont);
begin
  FItemFont.Assign(Value);
  RepaintAll;
end;

procedure TdxSideBar.SetLargeImages(Value: TImageList);
begin
  if (FLargeImages <> Value) then begin
    if (FLargeImages <> nil) and not (csDestroying in  FLargeImages.ComponentState) then
      FLargeImages.UnRegisterChanges(FLargeChangeLink);
    FLargeImages := Value;
    if (FLargeImages <> nil) then
    begin
      FLargeImages.RegisterChanges(FLargeChangeLink);
      FLargeImages.FreeNotification(Self);
    end;
    RepaintAll;
  end;
end;

procedure TdxSideBar.SetSmallImages(Value: TImageList);
begin
  if (FSmallImages <> Value) then begin
    if (FSmallImages <> nil) and not (csDestroying in  FSmallImages.ComponentState) then
      FSmallImages.UnRegisterChanges(FSmallChangeLink);
    FSmallImages := Value;
    if (FSmallImages <> nil) then
    begin
      FSmallImages.RegisterChanges(FSmallChangeLink);
      FSmallImages.FreeNotification(Self);
    end;
    RepaintAll;
  end;
end;

procedure TdxSideBar.SetPaintStyle(Value: TdxsbPaintStyle);
begin
  if (FPaintStyle <> Value) then
  begin
    FPaintStyle := Value;
    FPainter.Free;
    FPainter := nil;
    if (BorderStyle <> bsNone) then
      BorderStyle := bsNone
    else if HandleAllocated then
      RepaintAll;
  end;
end;

procedure TdxSideBar.SetStore(Value: TdxSideBarStore);
begin
  if (FStore <> Value) then begin
    if not (csLoading in ComponentState) then
      FGroups.Clear;
    FActiveGroup := nil;  
    FMouseFocusedGroup := nil;
    if not (csDestroying in ComponentState) {and (csDesigning in ComponentState)} then
      RepaintAll;
    if (FStore <> nil) and not (csDestroying in FStore.ComponentState) then
      FStore.FBars.Remove(Self);
    FStore := Value;
    if (FStore <> nil) then
      FStore.FBars.Add(Self);
  end;
end;

procedure TdxSideBar.SetTransparentImages(Value: Boolean);
begin
  if (FTransparentImages <> Value) then begin
    FTransparentImages := Value;
    RepaintAll;
  end;
end;

procedure TdxSideBar.SetScrollDelay(Value: Integer);
begin
  if (Value > 0) then
   FScrollDelay := Value;
end;

procedure TdxSideBar.SetShowGroups(Value: Boolean);
begin
  if (FShowGroups <> Value) then
  begin
    FShowGroups := Value;
    RepaintAll;
  end;
end;

procedure TdxSideBar.SetSpaceHeight(Value: Integer);
begin
  if (FSpaceHeight <> Value) and (Value > 4) then begin
    FSpaceHeight := Value;
    InvalidateItems(True);
  end;
end;

procedure TdxSideBar.OnChangeLink(Sender: TObject);
begin
  RepaintAll;
end;

procedure TdxSideBar.OnFontChange(Sender: TObject);
begin
  RepaintAll;
end;

procedure TdxSideBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
  Group: TdxSideGroup;
  Item: TdxSideBarItem;
begin
  if (csDesigning in ComponentState) then
  begin
    inherited  MouseDown(Button, Shift, X, Y);
    Exit;
  end;
  if (Button = mbRight) then begin
    PopupMenu := nil;
    item := GetFocusedItem(X, Y);
    if (item <> nil) then begin
      if (item.StoredItem <> nil) and (item.StoredItem.PopupMenu <> nil) then
        PopupMenu := item.StoredItem.PopupMenu
      else PopupMenu := FItemPopupMenu;
    end;
    if (PopupMenu = nil) then
      PopupMenu := FGroupPopupMenu;
  end;

  inherited  MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) then begin
    // IsRenameGroup  or Is RenameItem ?
    if (IsEditing) then begin
      EndEdit(True);
      Exit;
    end;
    p.X := X;
    p.Y := Y;
    Group := GetGroupAtPos(p);
    if (Group <> nil) then
      DoGroupMouseFocused(Group, True)
    else begin
      if ViewInfo.IsPtTopScrollButton(p) then
      begin
        FScrollButtonUpIsDown := True;
        FScrollTimerID := SetTimer(Handle, 1, FScrollDelay, @ScrollButtonsTimerProc);
        FActiveGroup.TopVisibleItem:= FActiveGroup.TopVisibleItem - 1;
      end else
      if ViewInfo.IsPtBottomScrollButton(p) then
       begin
         FScrollButtonDownIsDown := True;
         FScrollTimerID := SetTimer(Handle, 1, FScrollDelay, @ScrollButtonsTimerProc);
         FActiveGroup.TopVisibleItem:= FActiveGroup.TopVisibleItem + 1;
       end
       else
       begin
         item := GetFocusedItem(X, Y);
         if (item <> nil) then begin
           DoItemMouseFocused(Item, True);
           if (CanSelected) then
             DoItemSelected(Item);
           FEnableDraging := True;
           FPointDragging.X := X;
           FPointDragging.Y := Y;
         end;
     end;
   end;
 end;
end;

procedure TdxSideBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Item: TdxSideBarItem;
  Group: TdxSideGroup;
begin
  inherited  MouseUp(Button, Shift, X, Y);
  if (csDesigning in ComponentState) then Exit;

  if (GetCapture = Handle) then
    ReleaseCapture;
  if not (Button = mbLeft) or (IsGroupEditing) then Exit;

  if {(FPaintStyle = sbpsFlat) and} (FMouseFocusedGroup <> nil) then
  begin
    DoGroupMouseFocused(FMouseFocusedGroup, False);
    if (GetGroupAtPos(Point(X, Y)) = FMouseFocusedGroup) then
      ActiveGroup := FMouseFocusedGroup
    else
    begin
      Group := FMouseFocusedGroup;
      FMouseFocusedGroup := nil;
      InvalidateGroup(Group);
    end;
  end;
  if FScrollButtonDownIsDown or FScrollButtonUpIsDown then begin
    FScrollButtonDownIsDown := False;
    FScrollButtonUpIsDown := False;
    InvalidateScrollButtons;
  end else
  if not Dragging and FEnableDraging then begin
    FEnableDraging := False;
    item := GetFocusedItem(X, Y);
    if (item <> nil) then
       DoItemClick(item);
  end;
end;

procedure TdxSideBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Item, OldItem: TdxSideBarItem;
  Group: TdxSideGroup;
begin
  inherited MouseMove(Shift, X, Y);

  Group := GetGroupAtPos(Point(X, Y));
  if not (ssLeft in Shift) then
    DoGroupMouseFocused(Group, False)
  else
    if (FMouseFocusedGroup <> Group) then
    begin
      FMouseFocusedGroupIsDown := False;
      if (FMouseFocusedGroup <> nil) then
        InvalidateGroup(FMouseFocusedGroup);
    end else
      if (FMouseFocusedGroup <> nil) then
        DoGroupMouseFocused(FMouseFocusedGroup, True);
  OldItem := FMouseFocusedItem;
  Item := GetFocusedItem(X, Y);
  if not FEnableDraging then
    DoItemMouseFocused(Item, False);

  if not (csDesigning in ComponentState) and (DragMode = dmAutomatic) and FShowGroups then begin
    if FEnableDraging and (((Item = nil) and (OldItem <> nil))
    or ((Item <> nil) and ((X < FPointDragging.X - 5) or (X > FPointDragging.X + 5)
    or (Y < FPointDragging.Y - 5) or (Y > FPointDragging.Y + 5)))) then begin
      if (FMouseFocusedItem = nil) then
        FMouseFocusedItem := OldItem;
      inherited DragMode := dmAutomatic;
      FEnableDraging := False;
      BeginDrag(True);
    end
    else inherited DragMode := dmManual;
  end;
end;

procedure TdxSideBar.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if (ActiveGroup = nil) then
    inherited
  else Message.Result := 1;
end;

procedure TdxSideBar.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (FMouseFocusedGroup <> nil) then
    SetCursor(Screen.Cursors[dxSideBarGroupCursor])
  else
    inherited;
end;

procedure TdxSideBar.Paint;
begin
  if FAssignFlag or IsMakingUpdate then
    Exit;

  Painter.Paint;
end;

procedure TdxSideBar.RepaintAll;
begin
  if (csDestroying in  ComponentState) or not HandleAllocated then
    exit;

  ViewInfo.CalcViewInfo;
  Invalidate;
end;

procedure TdxSideBar.InvalidateGroup(AGroup: TdxSideGroup);
begin
  if HandleAllocated then
    Painter.InvalidateGroup(AGroup);
end;

procedure TdxSideBar.InvalidateItem(AItem: TdxSideBarItem);
begin
  if HandleAllocated then
    Painter.InvalidateItem(AItem);
end;

procedure TdxSideBar.InvalidateItemImage(AItem: TdxSideBarItem);
begin
  if HandleAllocated then
    Painter.InvalidateItemImage(AItem);
end;

procedure TdxSideBar.InvalidateItemImageBorder(AItem: TdxSideBarItem);
begin
  if HandleAllocated then
    Painter.InvalidateItemImageBorder(AItem);
end;

procedure TdxSideBar.InvalidateItems(AUpdateCalcInfo: Boolean);
begin
  if HandleAllocated then
  begin
    if AUpdateCalcInfo then
      ViewInfo.CalcViewInfo;
    Painter.InvalidateItems;
  end;  
end;

procedure TdxSideBar.InvalidateScrollButtons;
begin
  if HandleAllocated then
    Painter.InvalidateScrollButtons;
end;

procedure TdxSideBar.WndProc(var Message: TMessage);
begin
  if (FHintWindowShowing) then
    with Message do
      if ((Msg >= WM_KEYFIRST) and (Msg <= WM_KEYLAST)) or
        ((Msg = CM_ACTIVATE) or (Msg = CM_DEACTIVATE)) or
        (Msg = CM_APPKEYDOWN) or (Msg = CM_APPSYSCOMMAND) or
        (Msg = WM_COMMAND) or ((Msg > WM_MOUSEMOVE) and
        (Msg <= WM_MOUSELAST)) or (Msg = WM_NCMOUSEMOVE) then
         HintActivate(False);
  inherited WndProc(Message);
end;

function TdxSideBar.GetVisibleGroup(Index: Integer): TdxSideGroup;
var
  i, AIndex: Integer;
begin
  Result := nil;
  AIndex := 0;
  for i := 0 to Groups.Count - 1 do
    if Groups[i].Visible then
    begin
      if (AIndex = Index) then
      begin
        Result := Groups[i];
        break;
      end;
      Inc(AIndex);
    end;
end;

function TdxSideBar.GetVisibleIndexByGroup(AGroup: TdxSideGroup): Integer;
var
  i, VisibleIndex: Integer;
begin
  Result := -1;
  VisibleIndex := 0;
  for i := 0 to Groups.Count - 1 do
    if Groups[i].Visible then
    begin
      if (Groups[i] = AGroup) then
      begin
        Result := VisibleIndex;
        break;
      end;
      Inc(VisibleIndex);
    end;
end;

procedure TdxSideBar.HintActivate(AShow: Boolean);
var
  r: TRect;
  p: TPoint;
  AHint: string;
  AItemViewInfo: TdxSideItemViewInfo;
begin
  FHintWindowShowing := False;
  AShow := AShow and (FMouseFocusedItem <> nil) and (FMouseFocusedItem.Hint <> '');
  if AShow and not Dragging then begin
    AItemViewInfo := ViewInfo.GetItemViewInfoByItem(FMouseFocusedItem);
    if AItemViewInfo <> nil then
    begin
      if (not AItemViewInfo.IsPartialVisible) then
        r := AItemViewInfo.CaptionRect
      else r := AItemViewInfo.ImageRect;
    end;
    p.Y := r.Bottom + 2;
    p.X := 0;
    p := ClientToScreen(p);
    SetRect(r, 0, 0, Width - 2 * FSpaceHeight, 0);
    AHint := GetShortHint(FMouseFocusedItem.Hint);
    r := FHintWindow.CalcHintRect(r.Right - r.Left, AHint, nil);
    if (FMouseFocusedItem.Group.IconType = dxsgLargeIcon) then
      Inc(p.X , (Width - r.Right + r.Left) div 2)
    else Inc(p.X , FSpaceHeight);
    OffsetRect(r, p.X, p.Y);
    InflateRect(r, 1, 1);
    if (FHintTimerID <> -1) then
      KillTimer(Handle, FHintTimerID);
    FHintWindow.Color := Application.HintColor;
    FHintWindow.ActivateHint(r, AHint);
    FHintWindowShowing := True;
    FHintTimerID := SetTimer(Handle, 1, dxSideBarHintShowDelay, @HintTimerProc);
    ShowHint := False;
    Hint := GetLongHint(FMouseFocusedItem.Hint);
  end else begin
    if (FHintTimerID <> -1) then begin
      KillTimer(Handle, FHintTimerID);
      FHintTimerID := -1;
    end;
    if IsWindowVisible(FHintWindow.Handle) then
     ShowWindow(FHintWindow.Handle, SW_HIDE);
  end;
end;

function TdxSideBar.GetGroupAtPos(p: TPoint): TdxSideGroup;
begin
  Result := ViewInfo.GetGroupAtPos(p);
end;

function TdxSideBar.GetPopupGroup: TdxSideGroup;
var
 p: TPoint;
begin
  GetCursorPos(p);
  p := ScreenToCLient(p);
  Result := GetGroupAtPos(p);
  if (Result = nil) then
    Result := FActiveGroup;
end;

function TdxSideBar.GetItemAtPos(p: TPoint): TdxSideBarItem;
begin
  Result := ViewInfo.GetItemAtPos(p);
end;

function TdxSideBar.IsGroupEditing: Boolean;
begin
  Result := FRenameGroup <> nil;
end;

function TdxSideBar.IsItemEditing: Boolean;
begin
  Result := FRenameItem <> nil;
end;

function TdxSideBar.IsEditing: Boolean;
begin
  Result := IsGroupEditing or IsItemEditing;
end;

procedure TdxSideBar.EditGroup(Group: TdxSideGroup);
var
  r: TRect;
begin
  if (FRenameGroup <> nil) or (FRenameItem <> nil) then
    EndEdit(True);
  FRenameGroup := Group;

  FRenameEdit := TSideBarRenameEdit.Create(Self);
  r := ViewInfo.GetGroupViewInfoByGroup(Group).Rect;
  with FRenameEdit do begin
    Parent := Self;
    BorderStyle := bsNone;
    OnExit := RenameEditExit;
    Font := FGroupFont;
    Top := r.Top;
    Left := r.Left;
    Width := r.Right - r.Left;
    Height := r.Bottom - r.Top;
    Text := Group.Caption;
    Font := FGroupFont;
    Font.Color := clWindowText;
  end;
  if Assigned(FOnBeforeEdit) then
     FOnBeforeEdit(Self);
  FRenameEdit.SetFocus;
end;

procedure TdxSideBar.EditItem(Item: TdxSideBarItem);
var
  r: TRect;
  AItemViewInfo: TdxSideItemViewInfo;
begin
  if (FRenameGroup <> nil) or (FRenameItem <> nil) then
    EndEdit(True);

  ActiveGroup := Item.Group;
  Item.MakeVisible;

  AItemViewInfo := ViewInfo.GetItemViewInfoByItem(Item);
  if AItemViewInfo = nil then
    exit;

  FRenameItem := Item;
  FRenameEdit := TSideBarRenameEdit.Create(Self);
  r := AItemViewInfo.CaptionRect;
  InflateRect(r, 2, 2);  
  with FRenameEdit do begin
    Parent := Self;
    BorderStyle := bsNone;
    OnExit := RenameEditExit;
    Font := FGroupFont;
    Top := r.Top;
    Left := r.Left;
    Width := r.Right - r.Left + 2;
    Height := r.Bottom - r.Top;
    Font := FItemFont;
    Font.Color := clWindowText;
    Text := Item.Caption;
  end;
  if Assigned(FOnBeforeEdit) then
     FOnBeforeEdit(Self);
  FRenameEdit.SetFocus;
  SendMessage(FRenameEdit.Handle, EM_SETSEL, 0, 1000);
end;


procedure TdxSideBar.EndEdit(Accept: Boolean);
begin
  if (FRenameEdit.Text <> '') and Accept then
  begin
    if (FRenameGroup <> nil) then
      FRenameGroup.Caption := FRenameEdit.Text;
    if (FRenameItem <> nil) then
      FRenameItem.Caption := FRenameEdit.Text;
  end;
  if Assigned(FOnAfterEdit) then
    FOnAfterEdit(Self);
  FRenameEdit.Free;
  FRenameEdit := nil;    
  FRenameGroup := nil;
  FRenameItem := nil;
  RepaintAll;
end;

function TdxSideBar.GetLargeImages: TImageList;
begin
  Result := FLargeImages;
  if (Result = nil) and (Store <> nil) then
    Result := Store.FLargeImages;
end;

function TdxSideBar.GetSmallImages: TImageList;
begin
  Result := FSmallImages;
  if (Result = nil) and (Store <> nil) then
    Result := Store.FSmallImages;
end;

procedure TdxSideBar.RenameEditExit(Sender: TObject);
begin
  EndEdit(True);
end;

procedure TdxSideBar.DoItemClick(Item: TdxSideBarItem);
begin
  if (Item <> nil) and not Item.Enabled then Exit;
  if (Item <> nil) and (Item.StoredItem <> nil) then
    Item.StoredItem.DoClick(Self, Item);
  if (Assigned(FOnItemClick))
  and ((Item.StoredItem = nil) or not Assigned(Item.StoredItem.FOnClick)) then
    FOnItemClick(Self, Item);
end;

function TdxSideBar.GetFocusedItem(X, Y: Integer): TdxSideBarItem;
var
  p: TPoint;
begin
  p.X := X;
  p.Y := Y;
  Result := GetItemAtPos(p);
end;

function TdxSideBar.GetTopVisibleToMakeItemVisible(AItem: TdxSideBarItem): Integer;
var
  OldTopVisible: Integer;
begin
  Result := 0;
  if ViewInfo.ItemCount = 0 then exit;
  if AItem.Index < ViewInfo.Items[0].Item.Index then
    Result := AItem.Index
  else
  begin
    OldTopVisible := ActiveGroup.TopVisibleItem;
    while not AItem.IsFullVisible do
    begin
      ActiveGroup.FTopVisibleItem := ActiveGroup.FTopVisibleItem + 1;
      Result := ActiveGroup.TopVisibleItem;
      ViewInfo.CalcViewInfo;
    end;
     ActiveGroup.FTopVisibleItem := OldTopVisible;
    ViewInfo.CalcViewInfo;
  end;  
end;

function TdxSideBar.GetDestDropItemViewInfo: TdxSideItemViewInfo;
begin
  if DestDropItem <> nil then
    Result := ViewInfo.GetItemViewInfo(DestDropItem)
  else Result := nil;
end;


procedure TdxSideBar.SetMouseFocusedItem(Item: TdxSideBarItem);
begin
  if (Item <> FMouseFocusedItem) then begin
    FMouseFocusedItem := Item;
    if Assigned(FOnChangeFocusedItem) then
      FOnChangeFocusedItem(Self);
  end;
end;

procedure TdxSideBar.SetSelectedItem(Item: TdxSideBarItem);
begin
  if (Item <> FSelectedItem) then begin
    FSelectedItem := Item;
    if Assigned(FOnChangeSelectedItem) then
      FOnChangeSelectedItem(Self);
  end;
end;

procedure TdxSideBar.DoGroupMouseFocused(Group: TdxSideGroup; IsDown: Boolean);
var
  OldGroup: TdxSideGroup;
  OldDown: Boolean;
begin
  if (FMouseFocusedGroup <> Group) or (FMouseFocusedGroupIsDown <> IsDown) then begin
    OldGroup := FMouseFocusedGroup;
    FMouseFocusedGroup := Group;
    OldDown := IsDown;
    FMouseFocusedGroupIsDown := IsDown;
    if (OldGroup <> nil) and ((OldGroup <> Group) or (IsDown = OldDown))
    and Painter.IsGroupFocused then
      InvalidateGroup(OldGroup);
    if (Group <> nil) and (OldGroup <> Group) and Painter.IsGroupFocused then
      InvalidateGroup(Group);
  end;
end;

procedure TdxSideBar.DoItemMouseFocused(Item: TdxSideBarItem; IsDown: Boolean);
var
  HintFlag: Boolean;
begin
  if (FMouseFocusedItem <> Item) or (FMouseFocusedItemIsDown <> IsDown) then begin
    if (FMouseFocusedItem <> nil) and (FMouseFocusedItem <> Item) and(FMouseFocusedItem <> FSelectedItem) then
       InvalidateItemImageBorder(FMouseFocusedItem);
    if ShowHint and (Item <> FMouseFocusedItem) then
      HintActivate(False);
    HintFlag := Item <> FMouseFocusedItem;
    SetMouseFocusedItem(Item);
    if ShowHint and not IsDown and HintFlag then
        HintActivate(True);
    FMouseFocusedItemIsDown := IsDown;
    if (FMouseFocusedItem <> nil) and(FMouseFocusedItem <> FSelectedItem) and FMouseFocusedItem.Enabled then
      InvalidateItemImageBorder(FMouseFocusedItem);
  end;
end;

procedure TdxSideBar.DoItemSelected(Item: TdxSideBarItem);
begin
  if not CanSelected then Exit;
  if (FSelectedItem <> Item) and (FSelectedItem <> nil) then
    InvalidateItemImageBorder(FSelectedItem);

  SetSelectedItem(Item);

  if (FSelectedItem <> nil) and (FSelectedItem.Collection <> nil)
  and FSelectedItem.Enabled then
    InvalidateItemImageBorder(FSelectedItem);
end;

procedure TdxSideBar.DoBkPictureChange(Sender: TObject);
begin
  RepaintAll;
end;

procedure TdxSideBar.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TdxSideBar.CMMouseLeave(var Message: TMessage);
var
  Group: TdxSideGroup;
begin
  inherited;
  if (dxSideBarDragObject <> nil) then
    SetDestDropItemandPosition(nil, sbdspIn)
  else DoItemMouseFocused(nil, False);
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
  if (FMouseFocusedGroup <> nil) then
  begin
    Group := FMouseFocusedGroup;
    FMouseFocusedGroup := nil;
    InvalidateGroup(Group); 
  end;
end;

procedure TdxSideBar.SetDestDropItemandPosition(AItem: TdxSideBarItem; APosition: TdxSideBarDragSourcePosition);
var
  OldItemViewInfo: TdxSideItemViewInfo;
  OldPosition: TdxSideBarDragSourcePosition;

procedure InvalidateSpace(AItemViewInfo: TdxSideItemViewInfo; APosition: TdxSideBarDragSourcePosition);
var
  r: TRect;
begin
  if (AItemViewInfo <> nil) then
  begin
    r := AItemViewInfo.GetItemDragSourceSpace(APosition);
    InflateRect(r, 0, 1);
    InvalidateRect(Handle, @r, True);
  end;
end;

procedure InvalidateArrow;
begin
  InvalidateSpace(OldItemViewInfo, OldPosition);
  InvalidateSpace(DestDropItemViewInfo, DropItemPosition);
end;

begin
  if (DestDropItem = AItem) and (DropItemPosition = APosition) then
    exit;
  OldItemViewInfo := DestDropItemViewInfo;
  OldPosition := FDropItemPosition;
  FDestDropItem := AItem;
  FDropItemPosition := APosition;
  InvalidateArrow;
end;

procedure TdxSideBar.SetDestDropItem(Value: TdxSideBarItem);
begin
  SetDestDropItemandPosition(Value, DropItemPosition);
end;

procedure TdxSideBar.SetDropItemPosition(Value: TdxSideBarDragSourcePosition);
begin
  SetDestDropItemandPosition(DestDropItem, Value);
end;

procedure TdxSideBar.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
    var Accept: Boolean);

  procedure Doexit;
  begin
    if Assigned(OnDragOver) then
    OnDragOver(Self, Source, X, Y, State, Accept);
    Exit;
  end;

var
  p: TPoint;
  r: TRect;
  AItemViewInfo: TdxSideItemViewInfo;
  APosition: TdxSideBarDragSourcePosition;
begin
  if (dxSideBarDragObject = nil) or (ActiveGroup = nil) then begin
    Accept := ActiveGroup = nil;
    Doexit;
    Exit;
  end;

  p := Point(X, Y);
  Accept := False;

  if (GetGroupAtPos(p) <> nil) then begin
    ActiveGroup := GetGroupAtPos(p);
    DoExit;
    Exit;
  end;

  if (FScrollTimerID = -1) then
    FScrollTimerID := SetTimer(Handle, 1, FScrollDelay, @ScrollButtonsTimerProc);

  FScrollButtonUpIsDown := False;
  FScrollButtonDownIsDown := False;
  if ViewInfo.IsTopScrollButtonVisible then begin
    r := ViewInfo.ItemsRect;
    r.Bottom := r.Top +  SpaceHeight +  ScrollButtonHeight;
    if (Y > r.Top) and (Y < r.Bottom) then begin
      FScrollButtonUpIsDown := True;
      DoItemMouseFocused(nil, False);
      Doexit;
      Exit;
    end;
  end;
  if ViewInfo.IsBottomScrollButtonVisible then
  begin
    r := ViewInfo.ItemsRect;
    r.Top := r.Bottom -  SpaceHeight - ScrollButtonHeight;
    if (Y > r.Top) and (Y < r.Bottom) then begin
      FScrollButtonDownIsDown := True;
      DoItemMouseFocused(nil, False);
      DoExit;
      Exit;
    end;
  end;

  DoItemMouseFocused(GetFocusedItem(X, Y), False);

  AItemViewInfo := ViewInfo.GetNearestItemViewInfoAtPost(p, APosition);
  if AItemViewInfo <> nil then
    SetDestDropItemandPosition(AItemViewInfo.Item, APosition)
  else SetDestDropItemandPosition(nil, APosition);
  Accept := (APosition <> sbdspIn) or (AItemViewInfo <> nil);
  Doexit;
end;

procedure TdxSideBar.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  if (dxSideBarDragObject <> nil) then
  begin
    dxSideBarDragObject.EndDrag(Target, X, Y);
    if Target = nil then
      RepaintAll;
  end;
  inherited;
end;

procedure TdxSideBar.DoStartDrag(var DragObject: TDragObject);
var
  Item: TdxSideBarItem;
  p: TPoint;
begin
  inherited;
  GetCursorPos(p);
  p := ScreenToClient(p);
  Item := FMouseFocusedItem;
  if (Item <> nil) then begin
    dxSideBarDragObject := TdxSideBarDragObject.Create(Self, DragObject, Item, nil);
  end;
end;

procedure TdxSideBar.LoadFromRegistry(ARegistryPath: string);
var
  Registry: TRegistry;

  function GetStoredItemByName(ASt: string): TdxStoredSideItem;
  var
    I: Integer;
  begin
    Result := nil;
    if (ASt <> '') and (Store <> nil)  then
      for I := 0 to Store.Count - 1 do
        if (CompareText(Store.Items[I].Name, ASt) = 0) then
        begin
          Result := Store.Items[I];
          Break;
        end;
  end;


  procedure ReadGroupItems(const AKey: string; AGroup: TdxSideGroup);
  var
    I, ItemCount: Integer;
  begin
    with Registry do
    begin
      if ValueExists('ItemCount') then ItemCount := ReadInteger('ItemCount')
      else ItemCount := 0;
      CloseKey;
      for I := 0 to ItemCount - 1 do
        if OpenKey(AKey + '\Item' + IntToStr(I), False) then
          with AGroup.Items.Add do
            try
              if (Store <> nil) then
                StoredItem := GetStoredItemByName(ReadString('StoredItem'));
              Caption := ReadString('Caption');
              CustomData := ReadString('CustomData');
              Hint := ReadString('Hint');
              IsDefault := ReadBool('IsDefault');
              LargeImage := ReadInteger('LargeImage');
              SmallImage := ReadInteger('SmallImage');
              Tag := ReadInteger('Tag');
            finally
              CloseKey;
            end;
    end;
  end;

var
  AGroupCount: Integer;
  AGroup: TdxSideGroup;
  I: Integer;
  AKey: string;
begin
  Registry := TRegistry.Create;
  with Registry do
    if OpenKey(ARegistryPath, False) then
    begin
      if ValueExists('GroupCount') then AGroupCount := ReadInteger('GroupCount')
      else AGroupCount := 0;

      if (AGroupCount > 0) then
         Groups.Clear;

      for I := 0 to AGroupCount - 1 do
      begin
        AGroup := Groups.Add;
        AKey := ARegistryPath + '\Group' + IntToStr(I);
        if OpenKey(AKey, False) then
        begin
          AGroup.Caption := ReadString('Caption');
          AGroup.IconType := TdxSideGroupIconType(ReadInteger('IconType'));
          ReadGroupItems(AKey, AGroup);
        end;
      end;  
    end;
  Registry.Free;
end;

procedure TdxSideBar.SaveToRegistry(ARegistryPath: string);
var
  Registry, SubRegistry: TRegistry;
  Keys, SubKeys: TStringList;

  procedure WriteGroupItems(const AKey: string; AGroup: TdxSideGroup);
  var
    I: Integer;
  begin
    with Registry do
    begin
      WriteInteger('ItemCount', AGroup.ItemCount);
      CloseKey;
      for I := 0 to AGroup.ItemCount - 1 do
        if OpenKey(AKey + '\Item' + IntToStr(I), True) then
          with AGroup.Items[I] do
          begin
            WriteString('Caption', Caption);
            WriteString('CustomData', CustomData);
            WriteString('Hint', Hint);
            WriteBool('IsDefault', IsDefault);
            WriteInteger('LargeImage', LargeImage);
            WriteInteger('SmallImage', SmallImage);
            WriteInteger('Tag', Tag);
            if (StoredItem <> nil) then
              WriteString('StoredItem', StoredItem.Name);
            CloseKey;
          end;
    end;
  end;

var
  I, j: Integer;
  AKey: string;
begin
  if (ARegistryPath = '') then
    Exit;

  Registry := TRegistry.Create;
  with Registry do
    if OpenKey(ARegistryPath, True) then
    begin
      // delete entire previous data from registry
      Keys := TStringList.Create;
      SubKeys := TStringList.Create;
      SubRegistry := TRegistry.Create;
      try
        GetKeyNames(Keys);
        for I := 0 to Keys.Count - 1 do
        begin
          with SubRegistry do
          begin
            OpenKey(ARegistryPath + '\' + Keys[I], False);
            SubRegistry.GetKeyNames(SubKeys);
            for j := 0 to SubKeys.Count - 1 do DeleteKey(SubKeys[j]);
            CloseKey;
          end;
          DeleteKey(Keys[I]);
        end;
      finally
        SubRegistry.Free;
        SubKeys.Free;
        Keys.Free;
      end;

      // write group count
      WriteInteger('GroupCount', Groups.Count);

      // write Groups
      for I := 0 to GroupCount - 1 do
      begin
        AKey := ARegistryPath + '\Group' + IntToStr(I);
        if OpenKey(AKey, True) then
        begin
          WriteString('Caption', Groups[I].Caption);
          WriteInteger('IconType', Ord(Groups[I].IconType));
          WriteGroupItems(AKey, Groups[I]);
        end;
      end;
    end;
  Registry.Free;
end;

var
  SideBarDragObjectHookKey: HHOOK;

function SideBarDragObjectWinProcKey(code: Integer; wparam: WParam; lparam: LParam): LResult; stdcall;
var
  p: TPoint;
begin
  if (wparam = VK_CONTROL) then begin
    GetCursorPos(p);
    Windows.ScreenToClient(GetCapture, p);
    SendMessage(GetCapture, LongInt(WM_MOUSEMOVE), MK_LBUTTON, MAKELONG(p.X, p.Y));
  end;
  Result := CallNextHookEx(SideBarDragObjectHookKey, code, wparam, lparam);
end;

function TdxSideBar.CreatePainter: TdxSideBarPainter;
const
  PainterClasses: Array[TdxsbPaintStyle] of TdxSideBarPainterClass =
        (TdxSideBarStandardPainter,
        TdxSideBarFlatPainter,
        TdxSideBarXPPainter,
        TdxSideBarW2kPainter);
begin
  Result := PainterClasses[PaintStyle].Create(self);
end;

function TdxSideBar.VisibleGroupCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Groups.Count - 1 do
    if Groups[i].Visible then
      Inc(Result);
end;

{ TdxSideBarPopupMenu }
constructor TdxSideBarPopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Bar := nil;
  List := TList.Create;
  FOptions := [sbmIconType, sbmAddGroup, sbmRemoveGroup, sbmCustomize,
    sbmRenameGroup, sbmRenameItem, sbmRemoveItem];
end;

destructor TdxSideBarPopupMenu.Destroy;
begin
  DestroyBarItems;
  List.Free;
  inherited Destroy;
end;

procedure TdxSideBarPopupMenu.Popup(X, Y: Integer);
var
  MenuItem: TMenuItem;
const
  Flags: array[TPopupAlignment] of Word = (TPM_LEFTALIGN, TPM_RIGHTALIGN,
    TPM_CENTERALIGN);

  procedure InsertNewMenuItem(const ACaption: string;  AEnabled, AChecked: Boolean; ATag: LongInt);
  begin
    MenuItem := NewItem(ACaption, 0, AChecked, AEnabled, BarMenuClick, 0, '');
    MenuItem.Tag := ATag;
    Items.Insert(List.Count, MenuItem);
    List.Add(MenuItem);
  end;

begin
  if (List.Count > 0) then
     DestroyBarItems;
  Bar := nil;
  if (PopupComponent <> nil) and (PopupComponent is TdxSideBar) then
  begin
    Bar := PopupComponent As TdxSideBar;
    Group := Bar.GetPopupGroup;

    if (Bar.FocusedItem = nil) then
    begin
      if (sbmIconType in FOptions) and (Group <> nil) then begin
        InsertNewMenuItem(LoadStr(DXSB_LARGEICONTYPE), True, Group.IconType = dxsgLargeIcon, -101);
        InsertNewMenuItem(LoadStr(DXSB_SMALLICONTYPE), True, Group.IconType = dxsgSmallIcon, -102);
      end;
      if (sbmAddGroup in FOptions) or (sbmRemoveGroup in FOptions)
      or (sbmRenameGroup in FOptions) then begin
        if (List.Count > 0) then
           InsertNewMenuItem('-', True, False, 0);
        if (sbmAddGroup in FOptions) then
          InsertNewMenuItem(LoadStr(DXSB_ADDGROUP), True, False, -201);
        if (sbmRemoveGroup in FOptions) then
          InsertNewMenuItem(LoadStr(DXSB_REMOVEGROUP), Group <> nil, False, -202);
        if (sbmRenameGroup in FOptions) then
          InsertNewMenuItem(LoadStr(DXSB_RENAMEGROUP), Group <> nil, False, -203);
      end;
      if (sbmCustomize in FOptions) and (Bar <> nil) and (Bar.Store <> nil)
      and (Group <> nil) then begin
        if (List.Count > 0)  and (TMenuItem(List.Last).Caption <> '-') then
          InsertNewMenuItem('-', True, False, 0);
        InsertNewMenuItem(LoadStr(DXSB_CUSTOMIZE), True, False, -401);
      end;
    end else begin
      if (sbmRemoveItem in FOptions) then
         InsertNewMenuItem(LoadStr(DXSB_REMOVEITEM), True, False, -301);
      if (sbmRenameItem in FOptions) then
         InsertNewMenuItem(LoadStr(DXSB_RENAMEITEM), True, False, -302);
    end;
    if (Items.Count > List.Count) and (List.Count > 0)
      and (TMenuItem(List.Last).Caption <> '-') then
      InsertNewMenuItem('-', True, False, 0);
  end;
  inherited Popup(X, Y);
  if Assigned(FOnPopupClose) then
    FOnPopupClose(Self);
end;

procedure TdxSideBarPopupMenu.BarMenuClick(Sender: TObject);
var
  tag: LongInt;
  gr: TdxSideGroup;
  item: TdxSideBarItem;
begin
  if not (Sender is TMenuItem) then Exit;
  tag := TMenuItem(Sender).Tag;
    case tag of
      -101: Group.IconType := dxsgLargeIcon;
      -102: Group.IconType := dxsgSmallIcon;
      -201:
      begin
        gr := Bar.Groups.Add;
        Bar.EditGroup(gr);
      end;
      -202: Group.Free;
      -203: Bar.EditGroup(Group);
      -301:
       begin
         item := Bar.FocusedItem;
         Bar.FMouseFocusedItem := nil;
         item.Free;
       end;
      -302: Bar.EditItem(Bar.FocusedItem);
      -401: if (Bar.Store <> nil) then Bar.Store.Customize;
    end;
  if Assigned(FOnAfterClick) then FOnAfterClick(Self);
end;

procedure TdxSideBarPopupMenu.DestroyBarItems;
var
  MenuItem: TMenuItem;
begin
  if (Bar <> nil) then
  begin
    while List.Count > 0 do begin
      MenuItem := TMenuItem(List[0]);
      List.Remove(MenuItem);
      MenuItem.Free;
    end;
    Bar := nil;
  end;
end;

{TdxSideBarDragObject}
type
  TtmpDragObject = class(TDragControlObject)
  protected
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  end;

function TtmpDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
var
  wnd: TWinControl;
begin
  if Accepted then begin
    if dxSideBarDragObject.FDeleteItem then
      Result := dxSideBarDragDeleteCursor
      else
      begin
        wnd := FindVCLWindow(Point(X, Y));
        if not (GetKeyState(VK_CONTROL) < 0) and ((dxSideBarDragObject.Item <> nil) or (wnd = nil) or not (wnd is TdxSideBar)) then
          Result := dxSideBarDragCursor
        else
          Result := dxSideBarDragCopyCursor;
      end
   end
   else
     Result := crNoDrop;
   dxSideBarDragObject.FDeleteItem := False;
end;


constructor TdxSideBarDragObject.Create(Control: TControl;
  var DragObject: TDragObject; AItem: TdxSideBarItem; AStoredItem: TdxStoredSideItem);
begin
  inherited Create;
  FDragObject := TtmpDragObject.Create(Control);
  DragObject := FDragObject;
  SideBarDragObjectHookKey := SetWindowsHookEx(WH_KEYBOARD,
   SideBarDragObjectWinProcKey, 0, GetCurrentThreadId);
  FItem := AItem;
  if Item <> nil then
    FStoredItem := Item.StoredItem
  else
    FStoredItem := AStoredItem;
end;

destructor TdxSideBarDragObject.Destroy;
begin
  FDragObject.Free;
  inherited;
end;

function TdxSideBarDragObject.EndDrag(Target: TObject; X, Y: Integer): TdxSideBarItem;
var
  Index: Integer;
  AItem, AFreeItem: TdxSideBarItem;
begin
  AItem := nil;
  AFreeItem := FItem;
  if (Target <> nil) and (Target is TdxSideBar) then
  with TdxSideBar(Target) do
  begin
    if not FCancelDrag then
    begin
      if ActiveGroup = nil then
        Groups.Add;
      Index := -1;
      if ActiveGroup.Items.Count = 0 then
        Index := 0;
      if (DestDropItemViewInfo <> nil) then
        Index := DestDropItemViewInfo.Item.Index;
      if (Index > -1) and ((GetKeyState(VK_CONTROL) < 0) or not ((Item <> nil)
        and (ActiveGroup = Item.Group)
        and (Item.Index = Index))) then
      begin
        if not (GetKeyState(VK_CONTROL) < 0) and (Item <> nil) and (ActiveGroup = Item.Group) then
        begin
          AItem := Item;
          AFreeItem := nil;
        end else
        begin
          AItem := ActiveGroup.Items.Add;
          if DropItemPosition = sbdspBottom then
            Inc(Index);
          if (dxSideBarDragObject.Item <> nil) then
            AItem.Assign(dxSideBarDragObject.Item)
          else AItem.StoredItem := dxSideBarDragObject.StoredItem;
        end;
        AItem.Index := Index;
      end
      else
        Index := -1;
      FDestDropItem := nil;
      FDropItemPosition := sbdspIn;

      if (Assigned(FOnDragDropItem)) then
        FOnDragDropItem(Self, Item, AItem, (GetKeyState(VK_CONTROL) < 0));

      if (AItem <> nil) then
        DoItemSelected(AItem);
      if (AFreeItem <> nil) and (Index > -1) and not (GetKeyState(VK_CONTROL) < 0) then
        AFreeItem.Free;
      FMouseFocusedItem := nil;
    end;
    RepaintAll;
  end;

  UnhookWindowsHookEx(SideBarDragObjectHookKey);
  Result := AItem;
  Self.Free;
  dxSideBarDragObject := nil;
end;

initialization
  Classes.RegisterClass(TdxStoredSideItem);
  dxSideBarDragObject := nil;
  Screen.Cursors[dxSideBarDragCursor] := LoadCursor(HInstance, 'dxSideBarDragCursor');
  Screen.Cursors[dxSideBarDragCopyCursor] := LoadCursor(HInstance, 'dxSideBarDragCopyCursor');
  Screen.Cursors[dxSideBarDragDeleteCursor] := LoadCursor(HInstance, 'dxSideBarDragDeleteCursor');
  Screen.Cursors[dxSideBarGroupCursor] := LoadCursor(HInstance, 'DXSIDEBARGROUPCURSOR');

finalization
  {IFDEF DELPHI4}
  DestroyCursor(Screen.Cursors[dxSideBarGroupCursor]);
  DestroyCursor(Screen.Cursors[dxSideBarDragDeleteCursor]);
  DestroyCursor(Screen.Cursors[dxSideBarDragCopyCursor]);
  DestroyCursor(Screen.Cursors[dxSideBarDragCursor]);
  {ENDIF}
end.
