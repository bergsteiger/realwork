{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ImgList;

interface

{$SCOPEDENUMS ON}

uses
  System.Generics.Collections, System.Types, System.UITypes, System.Classes, System.ImageList, FMX.ActnList, FMX.Types,
  FMX.Controls, FMX.Graphics, FMX.MultiresBitmap;

type
  TMultiResBitmap = class;
  TCustomSourceItem = class;
  TSourceCollection = class;
  TLayer = class;
  TLayers = class;
  TCustomDestinationItem = class;
  TDestinationCollection = class;
  TCustomImageList = class;
  TImageListClass = class of TCustomImageList;
  TSourceItemClass = class of TCustomSourceItem;
  TDestinationItemClass = class of TCustomDestinationItem;
  TLayerClass = class of TLayer;

  /// <summary>A bitmap item in a TMultiResBitmap multi-resolution
  /// bitmap.</summary>
  TBitmapItem = class(TCustomBitmapItem)
  private
    function GetImageList: TCustomImageList;
  public
    /// <summary> A reference to the list of images to whom belongs to an instance of this class </summary>
    property ImageList: TCustomImageList read GetImageList;
    /// <exception>EArgumentException is raised in case Collection is not <b>TMultiResBitmap</b></exception>
    constructor Create(Collection: TCollection); override;
  published
    property Bitmap;
    property Scale;
  end;

  /// <summary> A multi-resolution bitmap is a collection of bitmap which is used in <b>TCustomSourceItem</b> and
  /// <b>TImageList</b></summary>
  TMultiResBitmap = class(TCustomMultiResBitmap)
  private
    [Weak] FSourceItem: TCustomSourceItem;
    function GetImageList: TCustomImageList;
  protected
    function GetDefaultSize: TSize; override;
    procedure Update(Item: TCollectionItem); override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    /// <exception>EArgumentException is raised in case AOwner is not <b>TCustomSourceItem</b></exception>
    constructor Create(AOwner: TPersistent; ItemClass: TCustomBitmapItemClass);
    /// <summary> A reference to the item of collection to whom belongs to an instance of this class </summary>
    property SourceItem: TCustomSourceItem read FSourceItem;
    property ImageList: TCustomImageList read GetImageList;
  end;

  /// <summary> The item collection (without published properties) contains the original graphical data, which can be
  /// used to obtain images in the image list <b>TCustomImageList</b>. See <b>TSourceCollection</b> </summary>
  /// <remarks> Note that the data stored in fmx, dfm file, even if they are not used </remarks>
  TCustomSourceItem = class(TCollectionItem)
  public const
    DefaultName = 'Item 0';                  // do not localize
    TemporaryName = 'Tmp_' + DefaultName;    // do not localize
    DefaultDesktopSize = 16;
  private
    [Weak] FSource: TSourceCollection;
    FMultiResBitmap: TMultiResBitmap;
    FOldName: string;
    FName: string;
    procedure SetMultiResBitmap(const Value: TMultiResBitmap);
    procedure SetName(const Value: string);
    function UniqueName(const AName: string; const Collection: TCollection): string;
    procedure CheckName(const Name: string; SourceCollection: TSourceCollection);
  protected
    /// <summary> This virtual method must create a instance of TMultiResBitmap. Override this method if you want to
    /// create <b>MultiResBitmap</b> property of your own type </summary>
    function CreateMultiResBitmap: TMultiResBitmap; virtual;
    procedure SetCollection(Value: TCollection); override;
    function GetDisplayName: string; override;
  public
    /// <exception>EArgumentException is raised in case Collection is not <b>TSourceCollection</b></exception>
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    /// <summary> Collection of identical images are optimized for different scales </summary>
    property MultiResBitmap: TMultiResBitmap read FMultiResBitmap write SetMultiResBitmap;
    /// <summary> The case-insensitive name of the item in the collection. This field cannot be empty and must be
    /// unique for his collection. See also <b>TLayer.Name</b> </summary>
    property Name: string read FName write SetName;
    /// <summary> A reference to the Collection to whom belongs to an instance of this class </summary>
    property Source: TSourceCollection read FSource;
  end;

  /// <summary>Represents an item in a TSourceCollection collection.</summary>
  TSourceItem = class (TCustomSourceItem)
  published
    property MultiResBitmap;
    property Name;
  end;

  /// <summary> The collection that contains original graphical data. See <b>TCustomSourceItem</b> </summary>
  TSourceCollection = class(TOwnedCollection)
  private
    [Weak] FImageList: TCustomImageList;
    function GetItem(Index: Integer): TCustomSourceItem;
    procedure SetItem(Index: Integer; const Value: TCustomSourceItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    /// <exception>EArgumentException is raised in case AOwner is not <b>TCustomImageList</b></exception>
    constructor Create(AOwner: TPersistent; ItemClass: TSourceItemClass);
    property ImageList: TCustomImageList read FImageList;
    property Items[Index: Integer]: TCustomSourceItem read GetItem write SetItem; default;
    function Add: TCustomSourceItem;
    /// <summary> Adds or replaces several files into the collection </summary>
    /// <param name="SourceName"> The name of the collection element. If specified name is not found, a new element will
    /// be created. Otherwise, the found element will be changed. If empty, a new element with default
    /// name will be created
    /// <para> See also <b>TCustomMultiResBitmap.AddOrSet</b></para> </param>
    /// <param name="Scales"> The array that contains the scales of added pictures </param>
    /// <param name="FileNames"> The array that contains the file names of added pictures. <b>Scales</b> and
    /// <b>FileNames</b> must have equal lengths </param>
    /// <param name="TransparentColor"> The color that will be substituted with fully transparent color. If set to
    /// <b>TColors.SysNone</b>, no subsitution will be performed.</param>
    /// <param name="Width"> The width (in pixels) of the added image (at a scale of 1) </param>
    /// <param name="Height"> The height (in pixels) of the added image (at a scale of 1). If Width and Height
    ///  parameters are zero (the default), the width and the height of the image specified by FileNames[0] will be used</param>
    /// <returns> New or updated element of the collection</returns>
    function AddOrSet(const SourceName: string; const Scales: array of Single; const FileNames: array of string;
      const TransparentColor: TColor = TColors.SysNone; const Width: Integer = 0;
      const Height: Integer = 0): TCustomSourceItem;
    /// <summary> This method creates a new item in the collection and inserts before the element with the specified
    /// number </summary>
    function Insert(Index: Integer): TCustomSourceItem;
    /// <summary> Case-insensitive search of item by name</summary>
    /// <returns> if successful then the number of the found item, <c>-1</c> otherwise </returns>
    function IndexOf(const Name: string): Integer;
  end;

  /// <summary> The item of collection <b>TLayers</b>, used in <b>TImageList</b> for obtaining graphical data from
  /// <b>TSourceCollection</b>. See <b>TCustomImageList.Source</b>, <b>TCustomImageList.Destination</b> </summary>
  TLayer = class (TCollectionItem)
  private
    [Weak] FLayers: TLayers;
    [Weak] FMultiResBitmap: TMultiResBitmap;
    FMultiResBitmapIsValid: Boolean;
    FName: string;
    FSourceRect: TBounds;
    procedure SetName(const Value: string);
    function GetImageList: TCustomImageList;
    procedure SetSourceRect(const Value: TBounds);
    function GetMultiResBitmap: TMultiResBitmap;
  protected
    procedure SetCollection(Value: TCollection); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    /// <summary> A reference to the collection to whom belongs to an instance of this class </summary>
    property Layers: TLayers read FLayers;
    property ImageList: TCustomImageList read GetImageList;
    /// <summary> Reference to property <b>MultiResBitmap</b> of found item <b>TCustomImageList.Source</b>. The search
    /// is done by property <b>Name</b>. Can be nil.</summary>
    property MultiResBitmap: TMultiResBitmap read GetMultiResBitmap stored False;
  published
    /// <summary> The case-insensitive name of the item in collection Source </summary>
    property Name: string read FName write SetName;
    /// <summary> The coordinates of the rectangular region in the original image <b>MultiResBitmap</b> that will be used to
    /// obtain the final image. Always specify the coordinates for the scale 1. For other scales, these coordinates will
    /// be automatically recalculated. </summary>
    property SourceRect: TBounds read FSourceRect write SetSourceRect;
  end;

  /// <summary> The collection <b>TLayer</b> items, used in <b>TImageList</b> for obtaining graphical data from
  /// <b>TSourceCollection</b>. See <b>TCustomImageList.Source</b>, <b>TCustomImageList.Destination</b> </summary>
  TLayers = class (TOwnedCollection)
  private
    FDestinationItem: TCustomDestinationItem;
    function GetImageList: TCustomImageList;
    function GetItem(Index: Integer): TLayer;
    procedure SetItem(Index: Integer; const Value: TLayer);
  protected
    procedure Update(Item: TCollectionItem); override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TLayerClass);
    /// <summary> A reference to the item to whom belongs to this collection </summary>
    property DestinationItem: TCustomDestinationItem read FDestinationItem;
    /// <summary> A reference to the list of images to whom belongs to this collection </summary>
    property ImageList: TCustomImageList read GetImageList;
    function Add: TLayer;
    function Insert(Index: Integer): TLayer;
    property Items[Index: Integer]: TLayer read GetItem write SetItem; default;
  end;

  /// <summary> The item of collection (without published properties) which contains the data to form the final images
  /// in <b>TImageList</b>. To obtain image, sequentially drawn regions of <b>Source</b> which specified in the
  /// collection <b>Layers</b>. Also performs selection the image with the most appropriate scale for the current scene
  /// and the size of the final image </summary>
  TCustomDestinationItem = class (TCollectionItem)
  public const
    StrDestinationDisplay = '%d (%s)';
  private
    FLayers: TLayers;
    [Weak] FDestination: TDestinationCollection;
    FIsChanged: Boolean;
    procedure SetLayers(const Value: TLayers);
  protected
    /// <summary> This virtual method must create a collection of layers. Override this method if you want to create a
    /// collection of your own type </summary>
    function CreateLayers: TLayers; virtual;
    procedure SetCollection(Value: TCollection); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    /// <summary> The number of <i>not empty</i> items in the <b>Layers</b> collection </summary>
    function LayersCount: Integer;
    /// <summary> This property evaluates to True if there have been some changes, but the notification about redrawing
    /// has not yet been sent </summary>
    property IsChanged: Boolean read FIsChanged;
    /// <summary> The collection that contains references to <b>Source</b> for drawing image. Can be one or more layers
    /// which will drawn sequentially</summary>
    property Layers: TLayers read FLayers write SetLayers;
    /// <summary> A reference to the Collection to whom belongs to this item </summary>
    property Destination: TDestinationCollection read FDestination;
  end;

  /// <summary> The item of collection (with published properties) which contains the data to form the final images
  /// in <b>TImageList</b></summary>
  TDestinationItem = class (TCustomDestinationItem)
  published
    property Layers;
  end;

  /// <summary> The collection which contains the data to form the final images in <b>TImageList</b> </summary>
  TDestinationCollection = class (TOwnedCollection)
  private
    [Weak] FImageList: TCustomImageList;
    function GetItem(Index: Integer): TCustomDestinationItem;
    procedure SetItem(Index: Integer; const Value: TCustomDestinationItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TDestinationItemClass);
    property ImageList: TCustomImageList read FImageList;
    function Add: TCustomDestinationItem;
    function Insert(Index: Integer): TCustomDestinationItem;
    property Items[Index: Integer]: TCustomDestinationItem read GetItem write SetItem; default;
  end;

  /// <summary> List of images. Base class that used in fire monkey without published properties </summary>
  TCustomImageList = class(TBaseImageList)
  private type
    TItemRec = record
      Item: TCustomBitmapItem;
      SourceRect, ItemRect: TRectF;
    end;
  strict private
    FTmpBitmap1: TBitmap;
    FTmpBitmap2: TBitmap;
  private
    FSource: TSourceCollection;
    FDestination: TDestinationCollection;
    FChangedList: TList<Integer>;
    FCache: TObject;
    FTimerHandle: TFmxHandle;
    FPlatformTimer: IFMXTimerService;
    FOnChange: TNotifyEvent;
    FOnChanged: TNotifyEvent;
    procedure SetSource(const Value: TSourceCollection);
    procedure SetDestination(const Value: TDestinationCollection);
    procedure SetCacheSize(const Value: Word);
    function GetCacheSize: Word;
    procedure StartTimer;
    procedure StopTimer;
    procedure TimerProc;
    function GetDormant: Boolean;
    procedure SetDormant(const Value: Boolean);
    function GetItemList(const Size: TSize; const Index: Integer): TList<TItemRec>;
  protected
    /// <summary> Creates a <b>Source</b> collection. Override this method if you want to create your own collection
    /// </summary>
    function CreateSource: TSourceCollection; virtual;
    /// <summary> Creates a <b>Destination</b> collection. Override this method if you want to create your own
    /// collection </summary>
    function CreateDestination: TDestinationCollection; virtual;
    procedure DoChange; override;
    /// <summary> This method called after changes and before notification of all instances of TImageLink. This method
    /// is executing event handler of OnChanged </summary>
    procedure DoChanged; virtual;
    procedure Loaded; override;
    /// <summary> This method is createing instance of TBitmap and drawing all <b>Layers</b> </summary>
    /// <param name="Size"> The size of created Bitmap </param>
    /// <param name="Index"> The zero-based number of item in the collection <b>Destination</b> that used for painting
    /// image</param>
    /// <returns> New instance of TBitmap. If the collection isn't contains the item with specified number or the
    /// item does not contain data then it returns zero</returns>
    function DoBitmap(Size: TSize; const Index: Integer): TBitmap; virtual;
    /// <summary> This method is trying find a bitmap in cache. If successful then returns a bitmap otherwise nil </summary>
    function FindInCache(const Size: TSize; const Index: Integer): TBitmap;
    /// <summary> Adding bitmap into end of cache. If the count of images more than CacheSize, then the first
    /// (the oldest) image will removed </summary>
    procedure AddToCache(const Size: TSize; const Index: Integer; const Bitmap: TBitmap);
    function GetCount: Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure Assign(Source: TPersistent); override;
    /// <summary> Adds or replaces several files in the <b>Source</b> collection, and adds the item to the
    /// <b>Destination</b> collection if it does not exist </summary>
    /// <returns> The number of the new element of <b>Destination</b> or <c>-1</c> if it already exists </returns>
    /// <remarks> See also <b>TSourceCollection.AddOrSet</b></remarks>
    function AddOrSet(const SourceName: string; const Scales: array of Single;
      const FileNames: array of string; const TransparentColor: TColor = TColors.SysNone; const Width: Integer = 0;
      const Height: Integer = 0): TImageIndex;
    /// <summary> Tries to find, in the <b>Source</b> collection, the bitmap item specified by <b>Name</b></summary>
    /// <param name="Name">The name of the item. See <b>TCustomSourceItem.Name</b></param>
    /// <param name="Item">If succed, contains the found bitmap item for scale 1, otherwise is not changed</param>
    /// <param name="Size">If succed, contains the size of the found item, otherwise is not changed</param>
    /// <returns> <c>True</c> if the item is found</returns>
    function BitmapItemByName(const Name: string; var Item: TCustomBitmapItem; var Size: TSize): Boolean;
    /// <summary>Returns the TBitmap object containing the image pointed by <b>Index</b>. Returns <c>nil</c> if the
    /// <b>Index</b> image does not exist.
    /// <para>See also BitmapExists, ClearCache, TBitmap.Assign</para>
    /// <para>The returned bitmap is stored by TCustomImageList in the cache.
    /// Therefore, you must not store references to such bitmaps and must not destroy such bitmaps exolicitly. </para>
    /// </summary>
    function Bitmap(Size: TSizeF; const Index: Integer): TBitmap;
    /// <summary> Returns <c>True</c> if the <b>Index</b> element in the <b>Source</b> collection contains some
    /// graphical data that can be used to create an image </summary>
    function BitmapExists(const Index: Integer): Boolean;
    /// <summary> This method trying to determine the maximum size of layer, which less than input size. If
    /// <b>TLayer.MultiResBitmap</b> has multiple images for different scales, then the search is performed among all
    /// images </summary>
    /// <param name="Index"> The index of item in <b>Destination</b> collection. For this image it determines suitable
    /// size </param>
    /// <param name="Size"> Before executing it contains the original size, after you do this the most suitable size or
    /// source value</param>
    /// <returns> <c>True</c> in case of success, otherwise <c>False</c>. If <c>False</c> then <b>Size</b> does not
    /// change </returns>
    /// <remarks> This method is called from TGlyph if the property <b>Stretch</b> is <c>False</c> </remarks>
    function BestSize(const Index: Integer; var Size: TSize): Boolean; overload;
    function BestSize(const Index: Integer; var Size: TSizeF): Boolean; overload;
    /// <summary> Draws a single picture on the specified canvas </summary>
    ///  <param name="Canvas">The canvas on which will be painted picture</param>
    ///  <param name="Rect">The rectangle in which will be inscribed picture</param>
    ///  <param name="Index">Zero based ordinal number of image</param>
    ///  <param name="Opacity">The transparency of the drawing pictures. By default 1 (completely not transparency)
    /// </param>
    ///  <returns> True if the picture was drawn </returns>
    function Draw(const Canvas: TCanvas; const Rect: TRectF; const Index: Integer; const Opacity: Single = 1): Boolean;
    /// <summary> Helper method for drawing some bitmap. This method used in <b>DoBitmap</b> </summary>
    procedure DrawBitmapToCanvas(const Canvas: TCanvas; const Bitmap: TBitmap; SrcRect, DstRect: TRect;
      const Fast: Boolean = False);
    /// <summary> Removing bitmaps from the internal cache </summary>
    /// <param name="Index">With the default <c>-1</c> value, it removes all bitmaps. Otherwise removes from cache
    /// bitmaps with all sizes but only for the specified <b>Index</b></param>
    procedure ClearCache(const Index: Integer = -1);
    /// <summary> Performs immediate notification about the change of images if there are changes. <para>See also
    /// <b>OnChanged</b>, <b>DoChanged</b>, <b>TImageLink</b>, <b>ImagesChanged</b></para></summary>
    /// <remarks> By default, notifications are sent shortly after the changes. If there are several changes, the count
    /// of notifications isn't increased in order to reduce the number of redrawing of the controls </remarks>
    procedure UpdateImmediately;
    /// <summary> The maximum number of images that can be stored in the cache. If the new image does not fit in the
    /// cache then automatically is deleted the oldest image. If a image has changed, it is automatically removed from
    /// the cache. See ClearCache </summary>
    property CacheSize: Word read GetCacheSize write SetCacheSize;
    /// <summary> Set property <b>Dormant</b> to all items of <b>Source</b>. See TCustomBitmapItem.Dormant </summary>
    property Dormant: Boolean read GetDormant write SetDormant;
    /// <summary> The collection which contains source graphical data. This data used in items of <b>Destination</b> for
    /// produce images. See BitmapItemByName </summary>
    property Source: TSourceCollection read FSource write SetSource;
    /// <summary> The items of this collection contains links to sources. When you specify a certain index of images,
    /// it is formed on the basis of data from this collection. See Bitmap, BitmapExists, Draw </summary>
    property Destination: TDestinationCollection read FDestination write SetDestination;
    /// <summary> If the component isn't in the update state, then event handler is executed immediately after any
    /// change, else after the <b>EndUpdate</b> method. <para>See also <b>DoChange</b>, <b>Change</b></para> </summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    /// <summary> This event handler is invoked shortly after one or more changes were done and before sending the
    /// notification to all of the controls that use the modified image from this image list
    /// <para>See also <b>DoChanged</b>, <b>TImageLink</b></para> </summary>
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  end;

  /// <summary>FireMonkey image lists are collections of multi-resolution
  /// bitmaps.</summary>
  TImageList = class(TCustomImageList)
  published
    property Source;
    property Destination;
    property OnChange;
    property OnChanged;
  end;

  /// <summary>A TGlyphImageLink object is used to install connection between an
  /// Images image list assigned to the TGlyph control and a component owning
  /// this TGlyph control.</summary>
  TGlyphImageLink = class(TImageLink)
  private
    [Weak] FOwner: TComponent;
    FGlyph: IGlyph;
  public
    ///<summary>Default constructor. If AOwner unsupported IGlyph then raised EArgumentException. If AOwner = nil then
    /// raised EArgumentNilException</summary>
    ///<param name="AOwner">The reference to the control with which it interacts. Can't be nil. Must supported
    /// interface IGlyph</param>
    constructor Create(AOwner: TComponent); reintroduce;
    procedure Change; override;
    /// <summary>Control that was defined at calling constructor <b>Create</b> </summary>
    property Owner: TComponent read FOwner;
    /// <summary>Interface of <b>Owner</b> that was defined at calling constructor <b>Create</b> </summary>
    property Glyph: IGlyph read FGlyph;
  end;

  /// <summary>Each TGlyph control has the Images reference to a
  /// TCustomImageList image list and displays the image identified by the
  /// ImageIndex property. The image is scaled to fully fit into the control
  /// area. TGlyph element is included in most styled controls.</summary>
  TGlyph = class(TControl, IGlyph)
  public const
    DesignBorderColor = $A080D080;
  private
    FImageLink: TImageLink;
    FIsChanging: Boolean;
    FIsChanged: Boolean;
    FAutoHide: Boolean;
    FOnChanged: TNotifyEvent;
    FBitmapExists: Boolean;
    FStretch: Boolean;
    function GetImages: TCustomImageList;
    procedure SetImages(const Value: TCustomImageList);
    { IGlyph }
    function GetImageIndex: TImageIndex;
    procedure SetImageIndex(const Value: TImageIndex);
    function GetImageList: TBaseImageList; inline;
    procedure SetImageList(const Value: TBaseImageList);
    function IGlyph.GetImages = GetImageList;
    procedure IGlyph.SetImages = SetImageList;
    procedure SetAutoHide(const Value: Boolean);
    procedure SetStretch(const Value: Boolean);
  protected
    procedure Paint; override;
    procedure Loaded; override;
    procedure DoEndUpdate; override;
    /// <summary> This vitrual method is calling event <b>OnChanged</b> and method <b>Repaint</b>. <b>DoChanged</b>
    /// method is called in <b>ImagesChanged</b>. You shouldn't call this method manually </summary>
    procedure DoChanged; virtual;
    /// <summary> This method is updating properties <b>BitmapExists</b>, and <b>Visible</b> in case if <b>AutoHide</b>
    /// is true </summary>
    procedure UpdateVisible;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    /// <summary> Determines whether the <b>ImageIndex</b> property needs to be stored in the fmx-file</summary>
    /// <returns> <c>True</c> if the <b>ImageIndex</b> property needs to be stored in the fmx-file</returns>
    function ImageIndexStored: Boolean; virtual;
    /// <summary> Determines whether the <b>Images</b> property needs to be stored in the fmx-file </summary>
    /// <returns> <c>True</c> if the <b>Images</b> property needs to be stored in the fmx-file</returns>
    function ImagesStored: Boolean; virtual;
    procedure SetVisible(const Value: Boolean); override;
    function VisibleStored: Boolean; override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    /// <summary> Should be called when you change an instance or reference to instance of <b>TBaseImageList</b> or the
    /// <b>ImageIndex</b> property
    /// <para>See also <b>FMX.ActnList.IGlyph</b></para></summary>
    /// <remarks> This method is executed after change list of images. If TGlyph not in state Loading, Destroying,
    /// Updating then this method call <b>DoChanged</b>, otherwise only set property <b>IsChanged</b> to true</remarks>
    procedure ImagesChanged;
    /// <summary> Is <c>True</c> if <b>Images</b> is not <c>nil</c> and <b>ImageIndex</b> points to an existing picture.
    /// <para>See also <b>UpdateVisible</b>, <b>TCustomImageList.BitmapExists</b></para></summary>
    property BitmapExists: Boolean read FBitmapExists;
    /// <summary> If there have been some changes (which needed to paint) but not executed method DoChanged yet, then
    /// this property is set to True, otherwise False</summary>
    property IsChanged: Boolean read FIsChanged write FIsChanged;
  published
    property Action;
    /// <summary> If <c>True</c>, then: at run time <b>Visible</b> property depends only on <b>BitmapExists</b>'s value;
    /// at designtime <b>Visible</b> is always <c>True</c>. Otherwise, <b>Visible</b>'s value can be set
    /// programmatically</summary>
    property AutoHide: Boolean read FAutoHide write SetAutoHide default True;
    property Enabled;
    property Padding;
    property Margins;
    property Align;
    property Position;
    property Width;
    property Height;
    property Opacity;
    property Visible;
    property Size;
    /// <summary> Specifies whether to stretch the image shown in the glyph control </summary>
    property Stretch: Boolean read FStretch write SetStretch default True;
    ///<summary> Zero based index of an image. The default is <c>-1</c>.
    ///<para> See also <b>FMX.ActnList.IGlyph</b></para></summary>
    ///<remarks> If non-existing index is specified, an image is not drawn and no exception is raised</remarks>
    property ImageIndex: TImageIndex read GetImageIndex write SetImageIndex stored ImageIndexStored;
    ///<summary> The list of images. Can be <c>nil</c>. <para>See also <b>FMX.ActnList.IGlyph</b></para></summary>
    property Images: TCustomImageList read GetImages write SetImages stored ImagesStored;
    /// <summary> This event handler is called after some changes in list of images and before painting </summary>
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnPaint;
    property OnPainting;
  end;

implementation

uses
{$IFDEF MACOS}
  Macapi.CoreFoundation,
{$ENDIF}
  System.SysUtils, System.RTLConsts, System.Math.Vectors, System.Math, FMX.Utils, FMX.Consts, FMX.Platform;

{$REGION 'implementation of TBitmapItem'}
{ TBitmapItem }

constructor TBitmapItem.Create(Collection: TCollection);
begin
  ValidateInheritance(Collection, TMultiResBitmap);
  inherited;
end;

function TBitmapItem.GetImageList: TCustomImageList;
begin
  if Collection <> nil then
    Result := TMultiResBitmap(Collection).ImageList
  else
    Result := nil;
end;

{$ENDREGION}

{$REGION 'implementation of TMultiResBitmap'}
{ TMultiResBitmap }

constructor TMultiResBitmap.Create(AOwner: TPersistent; ItemClass: TCustomBitmapItemClass);
begin
  ValidateInheritance(AOwner, TCustomSourceItem, False);
  inherited Create(AOwner, ItemClass);
  FSourceItem := TCustomSourceItem(AOwner);
end;

function TMultiResBitmap.GetDefaultSize: TSize;
begin
  Result := TSize.Create(TCustomSourceItem.DefaultDesktopSize, TCustomSourceItem.DefaultDesktopSize);
end;

function TMultiResBitmap.GetImageList: TCustomImageList;
begin
  if (SourceItem <> nil) and (SourceItem.Source <> nil) then
    Result := SourceItem.Source.ImageList
  else
    Result := nil;
end;

procedure TMultiResBitmap.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited;
  if SourceItem <> nil then
    SourceItem.Changed(False);
end;

procedure TMultiResBitmap.Update(Item: TCollectionItem);
begin
  inherited;
  if SourceItem <> nil then
    SourceItem.Changed(False);
end;

{$ENDREGION}


{$REGION 'implementation of TCustomSourceItem'}
{ TCustomSourceItem }

constructor TCustomSourceItem.Create(Collection: TCollection);
begin
  inherited;
  FName := UniqueName(DefaultName, Collection);
  FMultiResBitmap := CreateMultiResBitmap;
  FMultiResBitmap.SizeKind := TSizeKind.Source;
end;

destructor TCustomSourceItem.Destroy;
begin
  FMultiResBitmap.Free;
  inherited;
end;

function TCustomSourceItem.CreateMultiResBitmap: TMultiResBitmap;
begin
  Result := TMultiResBitmap.Create(self, TBitmapItem);
end;

function TCustomSourceItem.GetDisplayName: string;
begin
  Result := Name;
end;

procedure TCustomSourceItem.SetMultiResBitmap(const Value: TMultiResBitmap);
begin
  FMultiResBitmap.Assign(Value);
end;

procedure TCustomSourceItem.SetCollection(Value: TCollection);
var
  S: string;
begin
  ValidateInheritance(Value, TSourceCollection);
  S := UniqueName(FName, Value);
  if string.Compare(S, FName, True) <> 0 then
    CheckName(S, TSourceCollection(Value));
  FName := S;
  inherited;
  FSource := TSourceCollection(Collection);
end;

function TCustomSourceItem.UniqueName(const AName: string; const Collection: TCollection): string;
var
  S: string;
  I, J, Index, MaxIndex: Integer;
  Found: Boolean;
  procedure SeparateNameIndex(var S: string; var Index: Integer);
  var I, N: integer;
  begin
    Index := -1;
    I := Length(S) - 1;
    N := 0;
    while (N <= 9) and (I >= 0) and (S.Chars[I] >= '0') and (S.Chars[I] <= '9') do
    begin
      Dec(I);
      Inc(N);
    end;
    if (I >= 0) and (N <= 5) and (N > 0) then
    begin
      Index := String.ToInteger(S.Substring(I + 1));
      S := S.Substring(0, I + 1);
    end;
  end;
begin
  Result := Trim(AName);
  if Collection <> nil then
  begin
    SeparateNameIndex(Result, Index);
    MaxIndex := -1;
    Found := False;
    for I := 0 to Collection.Count - 1 do
    if (Collection.Items[I] <> self) and (Collection.Items[I] is TCustomSourceItem) then
    begin
      S := Trim(TCustomSourceItem(Collection.Items[I]).Name);
      SeparateNameIndex(S, J);
      if string.Compare(S, Result, True) = 0 then
      begin
        MaxIndex := Max(MaxIndex, J);
        if (Index = J) then
          Found := True;
      end;
    end;
    if Found then
    begin
      MaxIndex := Max(MaxIndex + 1, 1);
      Result := Result + IntToStr(MaxIndex);
    end
    else
    begin
      if Index >= 0 then
        Result := Result + IntToStr(Index);
    end;
  end;
end;

procedure TCustomSourceItem.Assign(Source: TPersistent);
var
  Src: TCustomSourceItem;
begin
  if (Source = nil) or (Source is TCustomSourceItem) then
  begin
    Src := TCustomSourceItem(Source);
    if Src = nil then
    begin
      if not MultiResBitmap.Equals(nil) then
      begin
        MultiResBitmap := nil;
        Changed(False);
      end;
      MultiResBitmap := nil;
      Name := UniqueName(DefaultName, Collection);
    end
    else
    begin
      if not MultiResBitmap.Equals(Src.MultiResBitmap) then
      begin
        MultiResBitmap := Src.MultiResBitmap;
        Changed(False);
      end;
      Name := UniqueName(Src.Name, Collection);
    end;
    Changed(False);
  end
  else
    inherited;
end;

procedure TCustomSourceItem.CheckName(const Name: string; SourceCollection: TSourceCollection);
var
  I: Integer;
begin
  if Trim(Name) = '' then
    raise EArgumentException.CreateFMT(SInvalidName, [Name]);
  if SourceCollection <> nil then
  begin
    for I := 0 to SourceCollection.Count - 1 do
      if (SourceCollection.Items[I] <> self) and (string.Compare(Name, SourceCollection.Items[I].Name, True) = 0) then
        raise EArgumentException.CreateFMT(SDuplicateName, [SourceCollection.Items[I].Name]);
  end;
end;

procedure TCustomSourceItem.SetName(const Value: string);
begin
  if FName <> Value then
  begin
    if string.Compare(Value, FName, True) <> 0 then
      CheckName(Value, Source);
    FOldName := FName;
    FName := Value;
    Changed(False);
  end;
end;

{$ENDREGION}
{$REGION 'implementation of TSourceCollection'}
{ TSourceCollection }

constructor TSourceCollection.Create(AOwner: TPersistent; ItemClass: TSourceItemClass);
begin
  ValidateInheritance(AOwner, TCustomImageList, False);
  inherited Create(AOwner, ItemClass);
  FImageList := TCustomImageList(AOwner);
end;

function TSourceCollection.GetItem(Index: Integer): TCustomSourceItem;
begin
  Result := TCustomSourceItem(inherited GetItem(Index))
end;

function TSourceCollection.Add: TCustomSourceItem;
begin
  Result := TCustomSourceItem(inherited Add);
end;

function TSourceCollection.AddOrSet(const SourceName: string; const Scales: array of Single;
  const FileNames: array of string; const TransparentColor: TColor = TColors.SysNone; const Width: Integer = 0;
  const Height: Integer = 0): TCustomSourceItem;
var
  I, CurrentIndex: Integer;
  NewItem: TCustomBitmapItem;
  TmpBitmap: TBitmap;
begin
  if Length(Scales) <> Length(FileNames) then
    raise EArgumentException.Create(sArgumentInvalid);
  if ImageList <> nil then
    ImageList.BeginUpdate;
  try
    CurrentIndex := IndexOf(SourceName);
    if CurrentIndex = -1 then
      Result := Add
    else
    begin
      Result := Items[CurrentIndex];
      Result.MultiResBitmap.Clear;
    end;
    try
      if (CurrentIndex = -1) and not Trim(SourceName).IsEmpty then
        Result.Name := Trim(SourceName);
      Result.MultiResBitmap.TransparentColor := TransparentColor;
      if (Width = 0) and (Height = 0) then
      begin
        Result.MultiResBitmap.SizeKind := TSizeKind.Source;
        Result.MultiResBitmap.Width := TCustomSourceItem.DefaultDesktopSize;
        Result.MultiResBitmap.Height := TCustomSourceItem.DefaultDesktopSize;
        if Length(FileNames) > 0 then
        begin
          TmpBitmap := TBitmap.Create;
          try
            TmpBitmap.LoadFromFile(FileNames[0]);
            Result.MultiResBitmap.Width := Round(TmpBitmap.Width / Scales[0]);
            Result.MultiResBitmap.Height := Round(TmpBitmap.Height / Scales[0]);
          finally
            TmpBitmap.Free;
          end;
        end;
      end
      else
      begin
        if (Width <= 0) or (Height <= 0) then
          raise EArgumentException.Create(sArgumentInvalid);
        Result.MultiResBitmap.SizeKind := TSizeKind.Custom;
        Result.MultiResBitmap.Width := Width;
        Result.MultiResBitmap.Height := Height;
      end;
      for I := 0 to High(Scales) do
      begin
        NewItem := Result.MultiResBitmap.AddOrSet(Scales[I], FileNames[I]);
        NewItem.Dormant := True;
      end;
    except
      if CurrentIndex = -1 then
        Delete(Result.Index);
      raise;
    end;
  finally
    if ImageList <> nil then
      ImageList.EndUpdate;
  end;
end;

function TSourceCollection.IndexOf(const Name: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if string.Compare(Name, Items[I].Name, True) = 0 then
    begin
      Result := I;
      Break;
    end;
end;

function TSourceCollection.Insert(Index: Integer): TCustomSourceItem;
begin
  Result := TCustomSourceItem(inherited Insert(Index));
end;

procedure TSourceCollection.SetItem(Index: Integer; const Value: TCustomSourceItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TSourceCollection.Update(Item: TCollectionItem);
var
  I: Integer;
  LIsChanged: Boolean;
  procedure IntUpdate(Item: TCustomSourceItem);
  var
    I, J: Integer;
    LName, LOldName: string;
  begin
    LName := Item.Name;
    LOldName := Item.FOldName;
    for I := 0 to ImageList.Destination.Count - 1 do
      for J := 0 to ImageList.Destination[I].Layers.Count - 1 do
        if string.Compare(LName, ImageList.Destination[I].Layers[J].Name, True) = 0 then
        begin
          ImageList.Destination[I].FIsChanged := True;
          LIsChanged := True;
          Break;
        end;
    if not LOldName.IsEmpty and (string.Compare(LName, LOldName, True) <> 0) then
      for I := 0 to ImageList.Destination.Count - 1 do
        for J := 0 to ImageList.Destination[I].Layers.Count - 1 do
          if string.Compare(LOldName, ImageList.Destination[I].Layers[J].Name, True) = 0 then
          begin
            ImageList.Destination[I].FIsChanged := True;
            LIsChanged := True;
            Break;
          end;
    for I := 0 to ImageList.Destination.Count - 1 do
      for J := 0 to ImageList.Destination[I].Layers.Count - 1 do
        ImageList.Destination[I].Layers[J].FMultiResBitmapIsValid := False
  end;
begin
  inherited;
  if (ImageList <> nil) and not (csDestroying in ImageList.ComponentState) then
  begin
    LIsChanged := False;
    if Item <> nil then
      IntUpdate(TCustomSourceItem(Item))
    else
    begin
      for I := 0 to Count - 1 do
        IntUpdate(TCustomSourceItem(Items[I]));
    end;
    if not LIsChanged then
      for I := 0 to ImageList.LinkCount - 1 do
        if ImageList.Links[I].IgnoreIndex then
        begin
          LIsChanged := True;
          Break;
        end;
    if LIsChanged then
      ImageList.Change;
  end;
end;

{$ENDREGION}

type
  TLayerBounds = class (TBounds)
  private
    FLayer: TLayer;
  protected
    procedure DoChange; override;
  end;

{ TLayerBounds }

procedure TLayerBounds.DoChange;
begin
  inherited;
  if FLayer <> nil then
    FLayer.Changed(False);
end;

{ TLayer }

constructor TLayer.Create(Collection: TCollection);
begin
  inherited;
  FSourceRect := TLayerBounds.Create(TRectF.Create(0, 0, TCustomSourceItem.DefaultDesktopSize,
    TCustomSourceItem.DefaultDesktopSize));
  TLayerBounds(FSourceRect).FLayer := self;
end;

destructor TLayer.Destroy;
begin
  FSourceRect.Free;
  inherited;
end;

procedure TLayer.Assign(Source: TPersistent);
var
  Src: TLayer;
begin
  if (Source = nil) or (Source is TLayer) then
  begin
    if Source = nil then
      Src := TLayerClass(ClassType).Create(nil)
    else
      Src := TLayer(Source);
    try
      Self.Name := Src.Name;
      Self.SourceRect := Src.SourceRect;
    finally
      if Source = nil then
        Src.Free;
    end;
    Changed(False);
  end
  else
    inherited;
end;

procedure TLayer.SetSourceRect(const Value: TBounds);
begin
  FSourceRect.Assign(Value);
end;

procedure TLayer.SetCollection(Value: TCollection);
begin
  if Collection <> Value then
  begin
    ValidateInheritance(Value, TLayers);
    inherited;
    FMultiResBitmapIsValid := False;
    FLayers := TLayers(Collection);
    Changed(False);
  end;
end;

procedure TLayer.SetName(const Value: string);
var
  V: string;
begin
  V := Trim(Value);
  if string.Compare(FName, V, True) <> 0 then
  begin
    FName := V;
    FMultiResBitmapIsValid := False;
    Changed(False);
  end;
end;

function TLayer.GetMultiResBitmap: TMultiResBitmap;
var
  LName: string;
  I: Integer;
begin
  if ImageList = nil then
  begin
    FMultiResBitmap := nil;
    FMultiResBitmapIsValid := False;
  end
  else if not FMultiResBitmapIsValid then
  begin
    FMultiResBitmap := nil;
    LName := Trim(Name);
    for I := 0 to ImageList.Source.Count - 1 do
      if string.Compare(LName, ImageList.Source[I].Name, True) = 0 then
      begin
        FMultiResBitmap := ImageList.Source[I].MultiResBitmap;
        Break;
      end;
    FMultiResBitmapIsValid := True;
  end;
  Result := FMultiResBitmap;
end;

function TLayer.GetDisplayName: string;
begin
  Result := string.Format('%s (%2.0f;%2.0f;%2.0f;%2.0f)',
                         [Name,
                          SourceRect.Left,
                          SourceRect.Top,
                          SourceRect.Right,
                          SourceRect.Bottom]);
end;

function TLayer.GetImageList: TCustomImageList;
begin
  if (Layers <> nil) and (Layers.DestinationItem <> nil) and (Layers.DestinationItem.Destination <> nil) then
    Result := Layers.DestinationItem.Destination.ImageList
  else
    Result := nil;
end;

{ TLayers }

constructor TLayers.Create(AOwner: TPersistent; ItemClass: TLayerClass);
begin
  ValidateInheritance(AOwner, TCustomDestinationItem, False);
  inherited Create(AOwner, ItemClass);
  FDestinationItem := TCustomDestinationItem(AOwner);
end;

function TLayers.GetImageList: TCustomImageList;
begin
  if (DestinationItem <> nil) and (DestinationItem.Destination <> nil) then
    Result := DestinationItem.Destination.ImageList
  else
    Result := nil;
end;

function TLayers.GetItem(Index: Integer): TLayer;
begin
  Result := TLayer(inherited GetItem(Index));
end;

function TLayers.Add: TLayer;
begin
  Result := TLayer(inherited Add);
end;

function TLayers.Insert(Index: Integer): TLayer;
begin
  Result := TLayer(inherited Insert(Index));
end;

procedure TLayers.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited;
  if DestinationItem <> nil then
    DestinationItem.Changed(False);
end;

procedure TLayers.SetItem(Index: Integer; const Value: TLayer);
begin
  inherited SetItem(Index, Value);
end;

procedure TLayers.Update(Item: TCollectionItem);
begin
  inherited;
  if DestinationItem <> nil then
    DestinationItem.Changed(False);
end;

{ TCustomDestinationItem }

constructor TCustomDestinationItem.Create(Collection: TCollection);
begin
  inherited;
  FLayers := CreateLayers;
end;

destructor TCustomDestinationItem.Destroy;
begin
  FLayers.Free;
  inherited;
end;

procedure TCustomDestinationItem.Assign(Source: TPersistent);
var
  Src: TCustomDestinationItem;
begin
  if (Source = nil) or (Source is TCustomDestinationItem) then
  begin
    Src := TCustomDestinationItem(Source);
    if Source = nil then
      Layers.Clear
    else
      Layers.Assign(Src.Layers);
    Changed(False);
  end
  else
    inherited;
end;

function TCustomDestinationItem.GetDisplayName: string;
var
  N: Integer;
  I: Integer;
  S: string;
begin
  Result := '';
  N := LayersCount;
  if N = 0 then
    Result := SEmpty
  else
  begin
    for I := 0 to Layers.Count - 1 do
    begin
      if Layers[I].MultiResBitmap <> nil then
      begin
        S := Layers[I].Name;
        if Length(S) > 10 then
          S := S.Substring(0, 9) + SChrHorizontalEllipsis;
        if Result <> '' then
          Result := Result + FormatSettings.ListSeparator + ' ';
        Result := Result + S.QuotedString;
        if Length(Result) > 40 then
          Result := Result + SChrHorizontalEllipsis;
      end;
    end;
    Result := string.Format(StrDestinationDisplay, [N, Result]);
  end;
end;

function TCustomDestinationItem.LayersCount: Integer;
var
  I, J: Integer;
begin
  Result := 0;
  if Layers <> nil then
    for I := 0 to Layers.Count - 1 do
      if Layers[I].MultiResBitmap <> nil then
        for J := 0 to Layers[I].MultiResBitmap.Count - 1 do
          if not Layers[I].MultiResBitmap[J].IsEmpty then
          begin
            Inc(Result);
            Break;
          end;
end;

procedure TCustomDestinationItem.SetCollection(Value: TCollection);
begin
  ValidateInheritance(Value, TDestinationCollection);
  inherited;
  FDestination := TDestinationCollection(Collection);
end;

procedure TCustomDestinationItem.SetLayers(const Value: TLayers);
begin
  FLayers.Assign(Value);
end;

function TCustomDestinationItem.CreateLayers: TLayers;
begin
  Result := TLayers.Create(self, TLayer);
end;

{ TDestinationCollection }

constructor TDestinationCollection.Create(AOwner: TPersistent; ItemClass: TDestinationItemClass);
begin
  ValidateInheritance(AOwner, TCustomImageList, False);
  inherited Create(AOwner, ItemClass);
  FImageList := TCustomImageList(AOwner);
end;

function TDestinationCollection.GetItem(Index: Integer): TCustomDestinationItem;
begin
  Result := TCustomDestinationItem(inherited GetItem(Index));
end;

function TDestinationCollection.Add: TCustomDestinationItem;
begin
  Result := TCustomDestinationItem(inherited Add);
end;

function TDestinationCollection.Insert(Index: Integer): TCustomDestinationItem;
begin
  Result := TCustomDestinationItem(inherited Insert(Index));
end;

procedure TDestinationCollection.SetItem(Index: Integer; const Value: TCustomDestinationItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TDestinationCollection.Update(Item: TCollectionItem);
var
  I: Integer;
begin
  inherited;
  if Item <> nil then
    TCustomDestinationItem(Item).FIsChanged := True
  else
    for I := 0 to Count - 1 do
      TCustomDestinationItem(Items[I]).FIsChanged := True;
  if ImageList <> nil then
    ImageList.Change;
end;


type

  TCache = class
  private type
    TBitmapCacheItem = record
      Size: TSize;
      Index: Integer;
      [Weak] Bitmap: TBitmap;
    end;
  private
    FCacheSize: Word;
    FList: TList<TBitmapCacheItem>;
    procedure SetCacheSize(const Value: Word);
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    property CacheSize: Word read FCacheSize write SetCacheSize;
    property Count: Integer read GetCount;
    function Find(const Size: TSize; const Index: Integer): TBitmap;
    procedure Add(const Size: TSize; const Index: Integer; const Bitmap: TBitmap);
    procedure Clear(const Index: Integer = -1);
  end;

{ TCache }

constructor TCache.Create;
begin
  inherited;
end;

destructor TCache.Destroy;
begin
  Clear;
  inherited;
end;

function TCache.Find(const Size: TSize; const Index: Integer): TBitmap;
var
  I: Integer;
  CacheItem: TBitmapCacheItem;
begin
  Result := nil;
  if FList <> nil then
  begin
    if (Size.cx <= 0) and (Size.cy <= 0) then
    begin
      for I := FList.Count - 1 downto 0 do
        if FList[I].Index = Index then
          Exit(FList[I].Bitmap);
    end
    else
      for I := FList.Count - 1 downto 0 do
      begin
        CacheItem := FList[I];
        if (CacheItem.Index = Index) and (CacheItem.Size = Size) then
        begin
          Result := CacheItem.Bitmap;
          if I < FList.Count - 1  then
          begin
            FList.Delete(I);
            FList.Add(CacheItem);
          end;
          Break;
        end;
      end;
  end;
end;

function TCache.GetCount: Integer;
begin
  if FList <> nil then
    Result := FList.Count
  else
    Result := 0;
end;

procedure TCache.Add(const Size: TSize; const Index: Integer; const Bitmap: TBitmap);
var
  NewItem: TBitmapCacheItem;
begin
  if (FCacheSize > 0) and (Bitmap <> nil) then
  begin
    if FList <> nil then
      while FCacheSize <= FList.Count do
      begin
        FList[0].Bitmap.DisposeOf;
        FList.Delete(0);
      end
    else
      FList := TList<TBitmapCacheItem>.Create;
    NewItem.Size := Size;
    NewItem.Index := Index;
    NewItem.Bitmap := Bitmap;
    {$IFDEF AUTOREFCOUNT}
    NewItem.Bitmap.__ObjAddRef;
    {$ENDIF}
    FList.Add(NewItem);
  end;
end;

procedure TCache.Clear(const Index: Integer = -1);
var
  I: Integer;
begin
  if FList <> nil then
  begin
    for I := FList.Count - 1 downto 0 do
      if (Index < 0) or (FList[I].Index = Index) then
      begin
        FList[I].Bitmap.DisposeOf;
        FList.Delete(I);
      end;
    if FList.Count = 0 then
      FreeAndNil(FList);
  end;
end;

procedure TCache.SetCacheSize(const Value: Word);
begin
  if FCacheSize <> Value then
  begin
    if FList <> nil then
    begin
      while Value < FList.Count do
      begin
        FList[0].Bitmap.DisposeOf;
        FList.Delete(0);
      end;
    end;
    FCacheSize := Value;
    if FCacheSize = 0 then
      FreeAndNil(FList);
  end;
end;

{$REGION 'implementation of TCustomImageList'}
{ TCustomImageList }

constructor TCustomImageList.Create(AOwner: TComponent);
begin
  inherited;
  FTimerHandle := TFmxHandle(-1);
  if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, FPlatformTimer) then
    raise EUnsupportedPlatformService.Create('IFMXTimerService');
  FCache := TCache.Create;
  FChangedList := TList<Integer>.Create;
  CacheSize := 8;
  FSource := CreateSource;
  FDestination := CreateDestination;
end;

destructor TCustomImageList.Destroy;
begin
  StopTimer;
  FTmpBitmap1.Free;
  FTmpBitmap2.Free;
  FDestination.Free;
  FSource.Free;
  FChangedList.Free;
  inherited;
end;

procedure TCustomImageList.Assign(Source: TPersistent);
var
  Src: TCustomImageList;
  I: Integer;
begin
  if (Source = nil) or (Source is TCustomImageList) then
  begin
    if Source = nil then
      Src := TImageListClass(ClassType).Create(nil)
    else
      Src := TCustomImageList(Source);
    BeginUpdate;
    try
      Self.Source.BeginUpdate;
      try
        for I := Self.Source.Count - 1 downto Src.Source.Count do
          Self.Source.Delete(I);
        for I := 0 to Self.Source.Count - 1 do
          Self.Source[I].Name := Self.Source[I].UniqueName(TCustomSourceItem.TemporaryName, Self.Source);
        for I := 0 to Src.Source.Count - 1 do
        begin
          if I = Self.Source.Count then
            Self.Source.Add;
          Self.Source[I].Assign(Src.Source[I]);
          if I mod 100 = 0 then
          begin
            Src.Dormant := True;
            Dormant := True;
          end;
        end;
      finally
        Self.Source.EndUpdate;
      end;

      Destination.BeginUpdate;
      try
        for I := Destination.Count - 1 downto Src.Destination.Count do
          Destination.Delete(I);
        for I := 0 to Src.Destination.Count - 1 do
        begin
          if I = Self.Destination.Count then
            Destination.Add;
          Destination[I].Assign(Src.Destination[I]);
          if I mod 100 = 0 then
          begin
            Src.Dormant := True;
            Dormant := True;
          end;
        end;
      finally
        Destination.EndUpdate;
      end;
      Src.Dormant := True;
      Dormant := True;
    finally
      if Source = nil then
        Src.Free;
      EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TCustomImageList.BeforeDestruction;
begin
  inherited;
  FreeAndNil(FCache);
end;

function TCustomImageList.BestSize(const Index: Integer; var Size: TSize): Boolean;
var
  Dest: TCustomDestinationItem;
  LBestSize, CurrentSize: TSize;
  CurrentScale: Single;
  I, L: Integer;
begin
  Result := False;
  if (Index >= 0) and (Index < Count) and not Size.IsZero then
  begin
    Dest := Destination[Index];
    LBestSize := TSize.Create(0, 0);
    for L := 0 to Dest.Layers.Count - 1 do
      if Dest.Layers[L].MultiResBitmap <> nil then
        for I := 0 to Dest.Layers[L].MultiResBitmap.Count - 1 do
        begin
          if not Dest.Layers[L].MultiResBitmap[I].IsEmpty then
          begin
            CurrentScale := Dest.Layers[L].MultiResBitmap[I].Scale;
            CurrentSize := TSize.Create(Round(Dest.Layers[L].SourceRect.Width * CurrentScale),
              Round(Dest.Layers[L].SourceRect.Height * CurrentScale));
          end
          else
            CurrentSize := TSize.Create(0, 0);
          if (CurrentSize.cx <= Size.cx) and (CurrentSize.cy <= Size.cy) and
            (CurrentSize.cx * CurrentSize.cy > LBestSize.cx * LBestSize.cy) then
            LBestSize := CurrentSize;
        end;
    Result := not LBestSize.IsZero;
    if Result then
      Size := LBestSize;
  end;
end;

function TCustomImageList.BestSize(const Index: Integer; var Size: TSizeF): Boolean;
var
  LSize: TSize;
begin
  LSize.cx := Trunc(Size.cx);
  LSize.cy := Trunc(Size.cy);
  Result := BestSize(Index, LSize);
  if Result then
    Size := TSizeF.Create(LSize);
end;

function TCustomImageList.CreateSource: TSourceCollection;
begin
  Result := TSourceCollection.Create(self, TSourceItem);
end;

function TCustomImageList.CreateDestination: TDestinationCollection;
begin
  Result := TDestinationCollection.Create(self, TDestinationItem);
end;

function TCustomImageList.GetCacheSize: Word;
begin
  Result := TCache(FCache).CacheSize;
end;

function TCustomImageList.GetCount: Integer;
begin
  if FDestination <> nil then
    Result := FDestination.Count
  else
    Result := 0;
end;

procedure TCustomImageList.SetCacheSize(const Value: Word);
begin
  if (Value < 1) or (Value > 1024) then
    raise EArgumentException.Create(SInvalidProperty);
  TCache(FCache).CacheSize := Value;
end;

function TCustomImageList.GetDormant: Boolean;
var
  I, J: Integer;
begin
  Result := True;
  for I := 0 to Source.Count - 1 do
    for J := 0 to Source[I].MultiResBitmap.Count - 1 do
      if not Source[I].MultiResBitmap[J].Dormant then
        Exit(False);
end;

procedure TCustomImageList.SetDormant(const Value: Boolean);
var
  I, J: Integer;
begin
  for I := 0 to Source.Count - 1 do
    for J := 0 to Source[I].MultiResBitmap.Count - 1 do
      Source[I].MultiResBitmap[J].Dormant := Value;
  FreeAndNil(FTmpBitmap1);
  FreeAndNil(FTmpBitmap2);
end;

procedure TCustomImageList.SetDestination(const Value: TDestinationCollection);
begin
  FDestination.Assign(Value);
end;

procedure TCustomImageList.SetSource(const Value: TSourceCollection);
begin
  FSource.Assign(Value);
end;

procedure TCustomImageList.DoChange;
var
  I: Integer;
  NeedTimer: Boolean;
begin
  for I := 0 to Destination.Count - 1 do
  if Destination[I].FIsChanged then
  begin
    ClearCache(I);
    if not FChangedList.Contains(I) then
      FChangedList.Add(I);
    Destination[I].FIsChanged := False;
  end;
  NeedTimer := FChangedList.Count > 0;
  if not NeedTimer then
  begin
    for I := 0 to LinkCount - 1 do
      if Links[I].IgnoreIndex then
      begin
        NeedTimer := True;
        Break;
      end;
  end;
  if NeedTimer then
    StartTimer;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TCustomImageList.StartTimer;
begin
  if FTimerHandle = TFmxHandle(-1) then
  begin
    FTimerHandle := FPlatformTimer.CreateTimer(100, TimerProc);
  end;
end;

procedure TCustomImageList.StopTimer;
begin
  if FTimerHandle <> TFmxHandle(-1) then
  begin
    FPlatformTimer.DestroyTimer(FTimerHandle);
    FTimerHandle := TFmxHandle(-1);
  end;
end;

procedure TCustomImageList.TimerProc;
var
  I, J: Integer;
  NeedChanged: Boolean;
begin
  StopTimer;
  DoChanged;
  if LinkCount > 0 then
  begin
    for J := 0 to LinkCount - 1 do
      if Links[J] <> nil then
      begin
        NeedChanged := Links[J].IgnoreIndex;
        if not NeedChanged and (FChangedList <> nil) then
          for I := 0 to FChangedList.Count - 1 do
            if (Links[J].ImageIndex = FChangedList[I]) then
            begin
              NeedChanged := True;
              Break;
            end;
        if NeedChanged then
          Links[J].Change;
      end;
    if FChangedList <> nil then
      FChangedList.Clear;
  end;
end;

procedure TCustomImageList.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

function TCustomImageList.AddOrSet(const SourceName: string; const Scales: array of Single;
  const FileNames: array of string; const TransparentColor: TColor = TColors.SysNone; const Width: Integer = 0;
  const Height: Integer = 0): TImageIndex;
var
  NewSource: TCustomSourceItem;
  I, J: Integer;
  HasDestination: Boolean;
  NewDestination: TCustomDestinationItem;
  NewLayer: TLayer;
begin
  Result := -1;
  BeginUpdate;
  try
    NewSource := Source.AddOrSet(SourceName, Scales, FileNames, TransparentColor, Width, Height);
    if NewSource <> nil then
    begin
      HasDestination := False;
      for I := 0 to Destination.Count -1 do
        for J := 0 to Destination[I].Layers.Count - 1 do
          if string.Compare(NewSource.Name, Destination[I].Layers[J].Name, True) = 0 then
          begin
            HasDestination := True;
            Destination[I].Layers[J].SourceRect.Rect := TRectF.Create(0, 0, NewSource.MultiResBitmap.Width,
              NewSource.MultiResBitmap.Height);
          end;
      if not HasDestination then
      begin
        NewDestination := Destination.Add;
        NewLayer := NewDestination.Layers.Add;
        NewLayer.SourceRect.Rect := TRectF.Create(0, 0, NewSource.MultiResBitmap.Width,
          NewSource.MultiResBitmap.Height);
        NewLayer.Name := NewSource.Name;
        Result := NewDestination.Index;
      end;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomImageList.AddToCache(const Size: TSize; const Index: Integer; const Bitmap: TBitmap);
begin
  if FCache <> nil then
    TCache(FCache).Add(Size, Index, Bitmap);
end;

procedure TCustomImageList.ClearCache(const Index: Integer = -1);
begin
  if FCache <> nil then
    TCache(FCache).Clear(Index);
end;

procedure TCustomImageList.UpdateImmediately;
begin
  if FTimerHandle <> TFmxHandle(-1) then
    TimerProc;
end;

function TCustomImageList.FindInCache(const Size: TSize; const Index: Integer): TBitmap;
begin
  if (FCache <> nil) and (Index <> -1) then
    Result := TCache(FCache).Find(Size, Index)
  else
    Result := nil;
end;

function TCustomImageList.GetItemList(const Size: TSize; const Index: Integer): TList<TItemRec>;
var
  LDest: TCustomDestinationItem;
  LBitmaps: TCustomMultiResBitmap;
  LItem: TItemRec;
  LScale: Single;
  SourceSize: TSize;
  I: Integer;
begin
  Result := nil;
  try
    if (Index >= 0) and (Index < Destination.Count) and (Size.Width >= 1) and (Size.Height >= 1) then
    begin
      LDest := Destination[Index];
      if LDest.Layers.Count > 0 then
      begin
        Result := TList<TItemRec>.Create;
        try
          for I := 0 to LDest.Layers.Count - 1 do
          begin
            LBitmaps := LDest.Layers[I].MultiResBitmap;
            if LBitmaps <> nil then
            begin
              LItem.SourceRect := LDest.Layers[I].SourceRect.Rect;
              SourceSize.cx := Round(LItem.SourceRect.Width);
              SourceSize.cy := Round(LItem.SourceRect.Height);
              LScale := TCustomBitmapItem.ScaleOfBitmap(SourceSize, Size);
              LItem.Item := LBitmaps.ItemByScale(LScale, False, False);
            end
            else
              LItem.Item := nil;
            if LItem.Item <> nil then
            begin
              LItem.SourceRect.Left := LItem.SourceRect.Left * LItem.Item.Scale;
              LItem.SourceRect.Top := LItem.SourceRect.Top * LItem.Item.Scale;
              LItem.SourceRect.Right := LItem.SourceRect.Right * LItem.Item.Scale;
              LItem.SourceRect.Bottom := LItem.SourceRect.Bottom * LItem.Item.Scale;
              LItem.ItemRect := TRectF.Create(0, 0, LItem.Item.Width, LItem.Item.Height);
              if not TRectF.Intersect(LItem.SourceRect, LItem.ItemRect).IsEmpty then
                Result.Add(LItem);
            end;
          end;
        finally
          if Result.Count = 0 then
            FreeAndNil(Result);
        end;
      end;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TCustomImageList.Loaded;
begin
  inherited;
  UpdateImmediately;
end;

procedure TCustomImageList.DrawBitmapToCanvas(const Canvas: TCanvas; const Bitmap: TBitmap; SrcRect, DstRect: TRect;
  const Fast: Boolean = False);

  procedure Enlarge(const SrcBitmap: TBitmap; const SrcRect, DstRect: TRect);
  var
    TmpR: TRectF;
  begin
    if FTmpBitmap1 = nil then
      FTmpBitmap1 := TBitmap.Create;
    TmpR := TRectF.Create(0, 0, SrcRect.Width, SrcRect.Height);
    FTmpBitmap1.SetSize(SrcRect.Width, SrcRect.Height);
    FTmpBitmap1.Clear(TAlphaColorRec.Null);
    if FTmpBitmap1.Canvas.BeginScene then
    try
      FTmpBitmap1.Canvas.DrawBitmap(SrcBitmap, TRectF.Create(SrcRect), TmpR, 1, True);
    finally
      FTmpBitmap1.Canvas.EndScene;
    end;
    Canvas.DrawBitmap(FTmpBitmap1, TmpR, TRectF.Create(DstRect), 1, Fast);
  end;

  function CurrentBitmap(const SrcBitmap: TBitmap; var SrcRect: TRect): TBitmap;
  var
    CrossRect, DstRect: TRect;
  begin
    CrossRect := TRect.Intersect(SrcRect, TRect.Create(0, 0, SrcBitmap.Width, SrcBitmap.Height));
    if (CrossRect <> SrcRect) and (SrcBitmap <> nil) then
    begin
      if not CrossRect.IsEmpty then
      begin
        if FTmpBitmap2 = nil then
          FTmpBitmap2 := TBitmap.Create;
        FTmpBitmap2.SetSize(Round(SrcRect.Width), Round(SrcRect.Height));
        FTmpBitmap2.Clear(TAlphaColorRec.Null);
        if FTmpBitmap2.Canvas.BeginScene then
        try
          DstRect.TopLeft := TPoint.Create(-Min(0, SrcRect.Left), -Min(0, SrcRect.Top));
          DstRect.Width := CrossRect.Width;
          DstRect.Height := CrossRect.Height;
          FTmpBitmap2.Canvas.DrawBitmap(SrcBitmap, TRectF.Create(CrossRect), TRectF.Create(DstRect), 1, Fast);
          SrcRect := TRect.Create(0, 0, FTmpBitmap2.Width, FTmpBitmap2.Height);
        finally
          FTmpBitmap2.Canvas.EndScene;
        end;
        Result := FTmpBitmap2;
      end
      else
        Result := nil;
    end
    else
      Result := SrcBitmap;
  end;

var
  Delta: TPointF;
  MinDelta: Single;
  LBitmap: TBitmap;
begin
  Delta := TPointF.Create(DstRect.Width - SrcRect.Width, DstRect.Height - SrcRect.Height);
  MinDelta := Min(Delta.X, Delta.Y);
  LBitmap := CurrentBitmap(Bitmap, SrcRect);
  if LBitmap <> nil then
  begin
    if SameValue(MinDelta, 0, TEpsilon.Position) then
      Canvas.DrawBitmap(LBitmap, TRectF.Create(SrcRect), TRectF.Create(DstRect), 1, True)
    else if MinDelta < 0 then
      Canvas.DrawBitmap(LBitmap, TRectF.Create(SrcRect), TRectF.Create(DstRect), 1, Fast)
    else
      Enlarge(LBitmap, SrcRect, DstRect);
  end;
end;

function TCustomImageList.DoBitmap(Size: TSize; const Index: Integer): TBitmap;
var
  I: Integer;
  DstRect, SrcRect: TRect;
  LItems: TList<TItemRec>;
begin
  Result := nil;
  try
    LItems := GetItemList(Size, Index);
    try
      if LItems <> nil then
      begin
        Result := TBitmap.Create(Size.cx, Size.cy);
        Result.BitmapScale := 1;
        Result.Clear(TColorRec.Null);
        if Result.Canvas.BeginScene then
        try
          for I := 0 to LItems.Count - 1 do
          begin
            SrcRect := LItems[I].SourceRect.Round;
            DstRect := TCustomBitmapItem.RectOfBitmap(SrcRect.Size, Size);
            DrawBitmapToCanvas(Result.Canvas, LItems[I].Item.Bitmap, SrcRect, DstRect);
          end;
        finally
          Result.Canvas.EndScene;
        end;
      end;
    finally
      LItems.Free;
      FreeAndNil(FTmpBitmap1);
      FreeAndNil(FTmpBitmap2);
    end;
  except
    FreeAndNil(Result);
    Raise;
  end;
end;

function TCustomImageList.BitmapItemByName(const Name: string; var Item: TCustomBitmapItem; var Size: TSize): Boolean;
var
  I: Integer;
  LItem: TCustomBitmapItem;
begin
  Result := False;
  I := Source.IndexOf(Name);
  if I >= 0 then
  begin
    LItem := Source[I].MultiResBitmap.ItemByScale(1, False, False);
    if LItem = nil then
      LItem := Source[I].MultiResBitmap.ItemByScale(1, False, True);
    if LItem <> nil then
    begin
      Result := True;
      Item := LItem;
      Size := TSize.Create(Round(Item.Width / Item.Scale), Round(Item.Height / Item.Scale));
    end;
  end;
end;

function TCustomImageList.Bitmap(Size: TSizeF; const Index: Integer): TBitmap;
var
  LSize: TSize;
begin
  LSize := Size.Round;
  if (Index >= 0) and (Index < Destination.Count) and (LSize.Width >= 1) and (LSize.Height >= 1) then
  begin
    Result := FindInCache(LSize, Index);
    if Result = nil then
    begin
      try
        Result := DoBitmap(LSize, Index);
        AddToCache(LSize, Index, Result);
      except
        FreeAndNil(Result);
        Raise;
      end;
    end;
  end
  else
    Result := nil;
end;

function TCustomImageList.BitmapExists(const Index: Integer): Boolean;
var
  LItems: TList<TItemRec>;
  LSize: TSize;
begin
  Result := FindInCache(TSize.Create(0, 0), Index) <> nil;
  if not Result then
  begin
    LSize := TSize.Create(TCustomSourceItem.DefaultDesktopSize, TCustomSourceItem.DefaultDesktopSize);
    LItems := GetItemList(LSize, Index);
    try
      Result := LItems <> nil;
    finally
      LItems.Free;
    end;
  end;
end;

function TCustomImageList.Draw(const Canvas: TCanvas; const Rect: TRectF; const Index: Integer;
  const Opacity: Single = 1): Boolean;
var
  Scale: Single;
  Size: TSizeF;
  TopLeft, BottomRight: TPointF;
  LBitmap: TBitmap;
begin
  Result := False;
  if Canvas <> nil then
  begin
    Scale := Canvas.Scale;
    Size.cx := Round(Rect.Width * Scale);
    Size.cy := Round(Rect.Height * Scale);
    LBitmap := Bitmap(Size, Index);
    if LBitmap <> nil then
    begin
      Size := TSizeF.Create(LBitmap.Width / Scale, LBitmap.Height / Scale);
      TopLeft := Canvas.AlignToPixel(TPointF.Create(Rect.Left + (Rect.Width - Size.cx) / 2,
        Rect.Top + (Rect.Height - Size.cy) / 2));
      BottomRight := TopLeft;
      BottomRight.Offset(Size);
      BottomRight := Canvas.AlignToPixel(BottomRight);
      Canvas.DrawBitmap(LBitmap, TRectF.Create(0, 0, LBitmap.Width, LBitmap.Height),
        TRectF.Create(TopLeft.X, TopLeft.Y, BottomRight.X, BottomRight.Y), Opacity, True);
      Result := True;
    end;
  end;
end;

{$ENDREGION}

{$REGION 'implementation of TGlyphImageLink'}

constructor TGlyphImageLink.Create(AOwner: TComponent);
var
  LGlyph: IGlyph;
begin
  if AOwner = nil then
    raise EArgumentNilException.Create(SArgumentNil);
  if not AOwner.GetInterface(IGlyph, LGlyph) then
    raise EArgumentException.CreateFMT(SUnsupportedInterface, [AOwner.ClassName, 'IGlyph']);
  inherited Create;
  FOwner := AOwner;
  FGlyph := LGlyph;
end;

procedure TGlyphImageLink.Change;
begin
  if not (csDestroying in Owner.ComponentState) then
  begin
    Glyph.ImagesChanged;
    inherited;
  end;
end;

{$ENDREGION}

{$REGION 'implementation of TGlyph'}

type
  TGlyphImageLinkEx = class(TGlyphImageLink)
  protected
    procedure Change; override;
  public
    constructor Create(AOwner: TGlyph); reintroduce;
  end;

{ TGlyphImageLinkEx }

constructor TGlyphImageLinkEx.Create(AOwner: TGlyph);
begin
  inherited Create(AOwner);
end;

procedure TGlyphImageLinkEx.Change;
begin
  if not (csDestroying in Owner.ComponentState) then
  begin
    if not (csLoading in Owner.ComponentState) then
      TGlyph(Owner).UpdateVisible;
    Glyph.ImagesChanged;
  end;
end;

{ TGlyph }

constructor TGlyph.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(False);
  HitTest := False;
  FStretch := True;
  FAutoHide := True;
  TabStop := False;
  FImageLink := TGlyphImageLinkEx.Create(Self);
end;

destructor TGlyph.Destroy;
begin
  FImageLink.DisposeOf;
  inherited;
end;

procedure TGlyph.AfterConstruction;
begin
  inherited;
  UpdateVisible;
end;

procedure TGlyph.Loaded;
begin
  inherited;
  UpdateVisible;
end;

procedure TGlyph.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
  Repaint;
end;

procedure TGlyph.DoEndUpdate;
begin
  inherited;
  if FIsChanged then
    ImagesChanged;
end;

procedure TGlyph.ActionChange(Sender: TBasicAction; CheckDefaults: Boolean);
begin
  if (Sender is TCustomAction) and not CheckDefaults then
  begin
    ImageIndex := TCustomAction(Sender).ImageIndex;
    if (TCustomAction(Sender).ActionList <> nil) and (TCustomAction(Sender).ActionList.Images is TCustomImageList) then
      Images := TCustomImageList(TCustomAction(Sender).ActionList.Images)
    else
      Images := nil;
  end;
  inherited;
end;

procedure TGlyph.ImagesChanged;
begin
  if not FIsChanging then
  begin
    if ([csLoading, csDestroying, csUpdating] * ComponentState = []) and not IsUpdating then
    begin
      FIsChanging := True;
      try
        UpdateVisible;
        DoChanged;
      finally
        FIsChanged := False;
        FIsChanging := False;
      end;
    end
    else
      FIsChanged := True;
  end;
end;

procedure TGlyph.SetVisible(const Value: Boolean);
begin
  if FAutoHide then
    inherited SetVisible(((csDesigning in ComponentState) and not Locked and not FInPaintTo) or BitmapExists)
  else
    inherited;
end;

function TGlyph.VisibleStored: Boolean;
begin
  if FAutoHide then
    Result := False
  else
    Result := inherited;
end;

procedure TGlyph.Paint;
const
  MinCrossSize = 3;
  MaxCrossSize = 13;
var
  TextRect, ImgRect, BitmapRect: TRectF;
  CrossSize, ScreenScale: Single;
  Bitmap: TBitmap;
  BitmapSize: TSize;
begin
  inherited;
  if [csLoading, csDestroying] * ComponentState = [] then
  begin
    BitmapSize := TSize.Create(0, 0);
    Bitmap := nil;
    ImgRect := LocalRect;
    if Scene <> nil then
      ScreenScale := Scene.GetSceneScale
    else
      ScreenScale := 1;
    if (Images <> nil) and (ImgRect.Width >= 1) and (ImgRect.Height >= 1) and (ImageIndex <> -1) and
      ([csLoading, csUpdating, csDestroying] * Images.ComponentState = []) then
    begin
      BitmapSize := TSize.Create(Round(ImgRect.Width * ScreenScale), Round(ImgRect.Height * ScreenScale));
      if not Stretch then
        Images.BestSize(ImageIndex, BitmapSize);
      Bitmap := Images.Bitmap(BitmapSize, ImageIndex)
    end;
    if (csDesigning in ComponentState) and not Locked then
      DrawDesignBorder(DesignBorderColor, DesignBorderColor);
    if Bitmap <> nil then
    begin
      BitmapRect := TRectF.Create(0, 0, Bitmap.Width, Bitmap.Height);
      ImgRect := TRectF.Create(CenteredRect(ImgRect.Round, TRectF.Create(0, 0, Bitmap.Width / ScreenScale,
        Bitmap.Height/ ScreenScale).Round));
      Canvas.DrawBitmap(Bitmap, BitmapRect, ImgRect, AbsoluteOpacity, True);
    end;
    if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
    begin
      TextRect := LocalRect;
      TextRect.Inflate(0.5, 0.5);
      Canvas.Stroke.Kind := TBrushKind.Solid;
      Canvas.Stroke.Color := TAlphaColorRec.Darkgray;
      Canvas.Stroke.Dash := TStrokeDash.Solid;
      CrossSize := Trunc(Min(MaxCrossSize, Min(TextRect.Width, TextRect.Height) / 6)) + 1;
      if CrossSize >= MinCrossSize then
      begin
        TextRect.TopLeft.Offset(2, 2);
        TextRect.BottomRight := TextRect.TopLeft;
        TextRect.BottomRight.Offset(CrossSize, CrossSize);
        if Bitmap = nil then
        begin
          if Images = nil then
            Canvas.Stroke.Color := TAlphaColorRec.Red;
          Canvas.DrawLine(TextRect.TopLeft, TextRect.BottomRight, AbsoluteOpacity);
          Canvas.DrawLine(TPointF.Create(TextRect.Right, TextRect.Top), TPointF.Create(TextRect.Left, TextRect.Bottom),
            AbsoluteOpacity);
          TextRect := TRectF.Create(TextRect.Left, TextRect.Bottom, Width, Height);
        end;
        if ImageIndex <> -1 then
        begin
          Canvas.Font.Family := 'Small Font';
          Canvas.Font.Size := 7;
          TextRect.Bottom := TextRect.Top + Canvas.TextHeight(Inttostr(ImageIndex));
          if TextRect.Bottom <= Height then
          begin
            Canvas.Fill.Color := TAlphaColorRec.Darkgray;
            Canvas.FillText(TextRect, Inttostr(ImageIndex), False, AbsoluteOpacity, [], TTextAlign.Leading,
              TTextAlign.Leading);
          end;
        end;
      end;
    end;
  end;
end;

function TGlyph.GetImageList: TBaseImageList;
begin
  Result := GetImages;
end;

procedure TGlyph.SetImageList(const Value: TBaseImageList);
begin
  ValidateInheritance(Value, TCustomImageList);
  SetImages(TCustomImageList(Value));
end;

function TGlyph.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(TCustomSourceItem.DefaultDesktopSize, TCustomSourceItem.DefaultDesktopSize);
end;

function TGlyph.GetImageIndex: TImageIndex;
begin
  Result := FImageLink.ImageIndex;
end;

procedure TGlyph.UpdateVisible;
begin
  FBitmapExists := (Images <> nil) and Images.BitmapExists(ImageIndex);
  if FAutoHide then
    Visible := FBitmapExists;
end;

procedure TGlyph.SetAutoHide(const Value: Boolean);
begin
  if FAutoHide <> Value then
  begin
    FAutoHide := Value;
    if (csLoading in ComponentState) and not FAutoHide then
      Visible := True
    else
      UpdateVisible;
  end;
end;

procedure TGlyph.SetImageIndex(const Value: TImageIndex);
begin
  if FImageLink.ImageIndex <> Value then
    FImageLink.ImageIndex := Value;
end;

function TGlyph.ImageIndexStored: Boolean;
begin
  Result := ActionClient or (ImageIndex <> -1);
end;

function TGlyph.GetImages: TCustomImageList;
begin
  Result := TCustomImageList(FImageLink.Images);
end;

procedure TGlyph.SetImages(const Value: TCustomImageList);
begin
  FImageLink.Images := Value;
end;

procedure TGlyph.SetStretch(const Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    Repaint;
  end;
end;

function TGlyph.ImagesStored: Boolean;
begin
  if ActionClient then
    Result := True
  else
    Result := Images <> nil;
end;

{$ENDREGION}

initialization
  StartClassGroup(TFmxObject);
  ActivateClassGroup(TFmxObject);
  GroupDescendentsWith(FMX.ImgList.TCustomImageList, TFmxObject);
  GroupDescendentsWith(FMX.ImgList.TGlyph, TFmxObject);
end.
