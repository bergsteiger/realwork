{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.ImageList;

interface

uses
  System.Classes, System.Generics.Collections, System.UITypes, System.RTLConsts;

type
  TImageLink = class;

  /// <summary> The shared base class of lists of images (see <b>Vcl.ImgList.TCustomImageList</b>,
  /// <b>FMX.ImgList.TCustomImageList</b>). This class contains only simple methods for notify changes to
  /// <b>TImageLink</b></summary>
  TBaseImageList = class(TComponent)
  strict private
    FUpdateCount: Integer;
    FLinks: TList<TImageLink>;
    FChanged: Boolean;
  private
    function GetLinkCount: Integer;
    function GetLinks(const Index: Integer): TImageLink;
  protected
    /// <summary> Adding link into an array <b>Links</b> </summary>
    procedure AddLink(Link: TImageLink);
    /// <summary> Removing link from array <b>Links</b> </summary>
    procedure DeleteLink(Link: TImageLink);
    /// <summary>Number of elements in the array <b>Links</b></summary>
    property LinkCount: Integer read GetLinkCount;
    /// <summary> The array of references to instances of <b>TImageLink</b> for send notification of changes</summary>
    property Links[const Index: Integer]: TImageLink read GetLinks;
    /// <summary> The method should perform several actions to reflect changes in the image list. Never call this
    /// method yourself, but you can to use calling <b>Change</b></summary>
    procedure DoChange; virtual; abstract;
    /// <summary> The getter of property <b>Count</b>. This method must be overridden in heir </summary>
    function GetCount: Integer; virtual; abstract;
    procedure Updated; override;
    procedure Loaded; override;
  public
    procedure BeforeDestruction; override;
    /// <summary> This method must be called in case if there were some changes in the image list. It executes the
    /// method <b>DoChange</b>. If the instance is in a state Loading, Destroying, Updating, then the method
    /// <b>DoChange</b> won't be called immediately, but it will executes after end of updating and loading</summary>
    procedure Change; virtual;
    /// <summary> The first calling of this method sets the state <b>csUpdating</b>. Used when mass changes properties
    /// for prevent multiple calling <b>DoChange</b> </summary>
    procedure BeginUpdate;
    /// <summary> The last calling of this method resets the state <b>csUpdating</b>. See also <b>BeginUpdate</b> </summary>
    procedure EndUpdate;
    /// <summary>The number of images in the list </summary>
    property Count: Integer read GetCount;
  end;

  /// <summary> The base class that is used for notify some objects when TBaseImageList changed </summary>
  TImageLink = class
  private
    [Weak] FImages: TBaseImageList;
    FImageIndex: TImageIndex;
    FIgnoreIndex: Boolean;
    FOnChange: TNotifyEvent;
    FIgnoreImages: Boolean;
    procedure SetImageList(const Value: TBaseImageList);
    procedure SetImageIndex(const Value: TImageIndex);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    /// <summary> The virtual method that is called after change of properties <b>Images</b> and <b>ImageIndex</b>.
    /// This takes into account the properties <b>IgnoreIndex</b>, <b>IgnoreImages</b>. This method call the event
    /// <b>OnChange</b> </summary>
    procedure Change; virtual;
    /// <summary> Reference to list of images</summary>
    property Images: TBaseImageList read FImages write SetImageList;
    /// <summary> Ordinal number of image from <b>Images</b></summary>
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex;
    /// <summary> If this property is true then we won't call method <b>Change</b> when changing property
    /// <b>ImageIndex</b> </summary>
    property IgnoreIndex: Boolean read FIgnoreIndex write FIgnoreIndex;
    /// <summary> If this property is true then we won't call method <b>Change</b> when changing property <b>Images</b>
    /// </summary>
    property IgnoreImages: Boolean read FIgnoreImages write FIgnoreImages;
    /// <summary> The event handler that is happens after change of properties <b>Images</b> and <b>ImageIndex</b>.
    /// This takes into account the properties <b>IgnoreIndex</b>, <b>IgnoreImages</b>.</summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

{$REGION 'TBaseImageList'}
procedure TBaseImageList.BeforeDestruction;
var
  I: Integer;
begin
  if FLinks <> nil then
  begin
    for I := LinkCount - 1 downto 0 do
      FLinks[I].Images := nil;
    FLinks.DisposeOf;
    FLinks := nil;
  end;
  inherited;
end;

procedure TBaseImageList.AddLink(Link: TImageLink);
begin
  if Link <> nil then
  begin
    if FLinks = nil then
      FLinks := TList<TImageLink>.Create;
    if not FLinks.Contains(Link) then
      FLinks.Add(Link);
    Link.FImages := Self;
  end;
end;

procedure TBaseImageList.DeleteLink(Link: TImageLink);
begin
  if Link <> nil then
  begin
    if FLinks <> nil then
    begin
      FLinks.Remove(Link);
      if FLinks.Count = 0 then
      begin
        FLinks.DisposeOf;
        FLinks := nil;
      end;
    end;
    Link.FImages := nil;
  end;
end;

function TBaseImageList.GetLinkCount: Integer;
begin
  if FLinks <> nil then
    Result := FLinks.Count
  else
    Result := 0;
end;

function TBaseImageList.GetLinks(const Index: Integer): TImageLink;
begin
  if (Index < 0) or (Index >= LinkCount) then
    raise EListError.CreateFMT(sArgumentOutOfRange_Index, [Index, LinkCount]);
  Result := FLinks[Index];
end;

procedure TBaseImageList.Change;
begin
  FChanged := True;
  if [csLoading, csDestroying, csUpdating] * ComponentState = [] then
  begin
    DoChange;
    FChanged := False;
  end;
end;

procedure TBaseImageList.Updated;
begin
  inherited;
  if FChanged then
    Change;
end;

procedure TBaseImageList.Loaded;
begin
  inherited;
  if FChanged then
    Change;
end;

procedure TBaseImageList.BeginUpdate;
begin
  if FUpdateCount = 0 then
    Updating;
  Inc(FUpdateCount);
end;

procedure TBaseImageList.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      Updated;
  end;
end;

{$ENDREGION}

{$REGION 'TImageLink'}

constructor TImageLink.Create;
begin
  inherited;
  FImageIndex := -1;
end;

destructor TImageLink.Destroy;
begin
  if FImages <> nil then
    FImages.DeleteLink(Self);
  inherited;
end;

procedure TImageLink.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    if not IgnoreIndex then
      Change;
  end;
end;

procedure TImageLink.SetImageList(const Value: TBaseImageList);
begin
  if Value <> FImages then
  begin
    if FImages <> nil then
      FImages.DeleteLink(Self);
    if Value <> nil then
      Value.AddLink(Self);
    if not IgnoreImages then
      Change;
  end;
end;

procedure TImageLink.Change;
begin
  if Assigned(OnChange) then
    OnChange(FImages);
end;

{$ENDREGION}

end.
