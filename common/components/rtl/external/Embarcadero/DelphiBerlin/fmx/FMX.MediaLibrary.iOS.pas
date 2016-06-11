{*******************************************************}
{                                                       }
{        Delphi FireMonkey media store for IOS          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MediaLibrary.IOS;

interface

{$SCOPEDENUMS ON}

procedure RegisterMediaLibraryServices;

implementation

uses
  System.SysUtils, System.Classes, System.Types, System.Math, System.Generics.Collections,
  FMX.MediaLibrary, FMX.Types, FMX.Types3D, FMX.Controls,
  FMX.Platform, FMX.Graphics, FMX.Helpers.iOS, iOSapi.MediaPlayer, iOSapi.Foundation, iOSapi.UIKit, iOSapi.CoreGraphics,
  Macapi.ObjectiveC, Macapi.Helpers, iOSapi.AssetsLibrary, System.TypInfo, Macapi.ObjCRuntime, FMX.Consts;

type
  TImageDelegate = class;
  TImageManagerCocoa = class;

  TSaveImageRequest = class
  private
    [Weak] FImageManager: TImageManagerCocoa;
    FImage: UIImage;
    FOnCompletion: TWriteImageCompletionEvent;
    procedure PerformResultOfSavingPhoto(assetURL: NSURL; error: NSError);
  public
    constructor Create(const AImageManager: TImageManagerCocoa; const AImage: UIImage; const AHandler: TWriteImageCompletionEvent);
    procedure Save;
  end;

  TImageManagerCocoa = class(TInterfacedObject, IFMXTakenImageService, IFMXCameraService, IFMXPhotoLibrary)
  private
    FImageDelegate: TImageDelegate;
    FImagePicker: UIImagePickerController;
    FPopoverController: UIPopoverController;
    FSaveImageRequests: TList<TSaveImageRequest>;
  protected
    procedure TakeImage(const AControl: TControl; const ASourceType: UIImagePickerControllerSourceType);
    procedure SaveImageToSavedPhotosAlbum(const AImage: UIImage; const AOnResult: TWriteImageCompletionEvent = nil);
  public
    constructor Create;
    destructor Destroy; override;
    class function IsAvailableSourceType(const ASourceType: UIImagePickerControllerSourceType): Boolean;
    procedure ClosePopover;
    { IFMXTakenImage }
    procedure TakeImageFromLibrary(const AControl: TControl; const ARequiredResolution: TSize; const AEditable: Boolean;
      const AOnDidFinishTaking: TOnDidFinishTaking; const AOnDidCancelTaking: TOnDidCancelTaking); overload;
    procedure TakeImageFromLibrary(const AControl: TControl; const AParams: TParamsPhotoQuery); overload;
    { IFMXPhotoLibrary }
    procedure AddImageToSavedPhotosAlbum(const ABitmap: TBitmap; const AWriteImageCompletionEvent: TWriteImageCompletionEvent = nil);
    { IFMXCameraService }
    procedure TakePhoto(const AControl: TControl; const ARequiredResolution: TSize; const AEditable: Boolean;
      const AOnDidFinishTaking: TOnDidFinishTaking; const AOnDidCancelTaking: TOnDidCancelTaking); overload;
    procedure TakePhoto(const AControl: TControl; const AParams: TParamsPhotoQuery); overload;
  end;

  TImageDelegate = class(TOCLocal, UIImagePickerControllerDelegate)
  private
    [Weak] FImageManager: TImageManagerCocoa;
    FParams: TParamsPhotoQuery;
  protected
    procedure DoDidFinishTaking(const AImage: TBitmap);
    procedure DoDidCancelTaking;
    procedure HidePicker(const APicker: UIImagePickerController);
    function GetAngleOfImageOrientation(const AImage: UIImage): Single;
  public
    constructor Create(const AImageManager: TImageManagerCocoa);
    property Params: TParamsPhotoQuery read FParams write FParams;
    { UIImagePickerControllerDelegate }
    procedure imagePickerController(picker: UIImagePickerController; didFinishPickingImage: UIImage; editingInfo: NSDictionary); overload; cdecl;
    procedure imagePickerController(picker: UIImagePickerController; didFinishPickingMediaWithInfo: NSDictionary); overload; cdecl;
    procedure imagePickerControllerDidCancel(picker: UIImagePickerController); cdecl;
  end;

  TShareService = class(TInterfacedObject, IFMXShareSheetActionsService)
  strict private
    FActivityViewController: UIActivityViewController;
    FActivityItems: NSMutableArray;
    FPopoverController: UIPopoverController;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ReleaseOldSharingController;
    { IFMXShareSheetActionsService }
    procedure Share(const AControl: TControl; const AText: string; const ABitmap: TBitmap);
  end;

procedure RegisterMediaLibraryServices;
var
  ImageManager: TImageManagerCocoa;
begin
  ImageManager := TImageManagerCocoa.Create;
  if TImageManagerCocoa.IsAvailableSourceType(UIImagePickerControllerSourceTypeCamera) then
    TPlatformServices.Current.AddPlatformService(IFMXCameraService, IInterface(ImageManager));

  if TImageManagerCocoa.IsAvailableSourceType(UIImagePickerControllerSourceTypeSavedPhotosAlbum) then
    TPlatformServices.Current.AddPlatformService(IFMXTakenImageService, IInterface(ImageManager));

  TPlatformServices.Current.AddPlatformService(IFMXPhotoLibrary, IInterface(ImageManager));

  if TOSVersion.Check(6, 0) then
    TPlatformServices.Current.AddPlatformService(IFMXShareSheetActionsService, IInterface(TShareService.Create));
end;

procedure TImageManagerCocoa.ClosePopover;
begin
  if FPopoverController <> nil then
    FPopoverController.dismissPopoverAnimated(True);
end;

constructor TImageManagerCocoa.Create;
begin
  inherited Create;
  FImageDelegate := TImageDelegate.Create(Self);
  FSaveImageRequests := TList<TSaveImageRequest>.Create;
end;

destructor TImageManagerCocoa.Destroy;
begin
  FSaveImageRequests.Free;
  if FImagePicker <> nil then
  begin
    FImagePicker.release;
    FImagePicker.setDelegate(nil);
  end;
  FImageDelegate.DisposeOf;
  if FPopoverController <> nil then
    FPopoverController.release;
  inherited Destroy;
end;

class function TImageManagerCocoa.IsAvailableSourceType(const ASourceType: UIImagePickerControllerSourceType): Boolean;
begin
  Result := TUIImagePickerController.OCClass.isSourceTypeAvailable(ASourceType);
end;

procedure TImageManagerCocoa.AddImageToSavedPhotosAlbum(const ABitmap: TBitmap; const AWriteImageCompletionEvent: TWriteImageCompletionEvent = nil);
var
  OCImage: UIImage;
begin
  OCImage := BitmapToUIImage(ABitmap);
  try
    SaveImageToSavedPhotosAlbum(OCImage, AWriteImageCompletionEvent);
  finally
    OCImage.release;
  end;
end;

procedure TImageManagerCocoa.SaveImageToSavedPhotosAlbum(const AImage: UIImage;
  const AOnResult: TWriteImageCompletionEvent = nil);
var
  SaveImageRequest: TSaveImageRequest;
begin
  SaveImageRequest := TSaveImageRequest.Create(Self, AImage, AOnResult);
  FSaveImageRequests.Add(SaveImageRequest);
  SaveImageRequest.Save;
end;

procedure TImageManagerCocoa.TakeImageFromLibrary(const AControl: TControl; const ARequiredResolution: TSize;
  const AEditable: Boolean; const AOnDidFinishTaking: TOnDidFinishTaking; const AOnDidCancelTaking: TOnDidCancelTaking);
var
  ParamTmp: TParamsPhotoQuery;
begin
  ParamTmp.Editable := AEditable;
  ParamTmp.RequiredResolution := ARequiredResolution;
  ParamTmp.NeedSaveToAlbum := False;
  ParamTmp.OnDidFinishTaking := AOnDidFinishTaking;
  ParamTmp.OnDidCancelTaking := AOnDidCancelTaking;
  TakeImageFromLibrary(AControl, ParamTmp);
end;

procedure TImageManagerCocoa.TakePhoto(const AControl: TControl; const ARequiredResolution: TSize;
  const AEditable: Boolean; const AOnDidFinishTaking: TOnDidFinishTaking; const AOnDidCancelTaking: TOnDidCancelTaking);
var
  ParamTmp: TParamsPhotoQuery;
begin
  ParamTmp.Editable := AEditable;
  ParamTmp.RequiredResolution := ARequiredResolution;
  ParamTmp.NeedSaveToAlbum := False;
  ParamTmp.OnDidFinishTaking := AOnDidFinishTaking;
  ParamTmp.OnDidCancelTaking := AOnDidCancelTaking;
  TakePhoto(AControl, ParamTmp);
end;

procedure TImageManagerCocoa.TakeImage(const AControl: TControl; const ASourceType: UIImagePickerControllerSourceType);

  procedure ShowInFullScreen;
  var
    Window: UIWindow;
  begin
    Window := SharedApplication.keyWindow;
    if (Window <> nil) and (Window.rootViewController <> nil) then
      Window.rootViewController.presentModalViewController(FImagePicker, True);
  end;

  procedure ShowInPopover;
  var
    Window: UIWindow;
    PopoverRect: CGRect;
    AbsolutePos: TPointF;
  begin
    Window := SharedApplication.keyWindow;
    if AControl <> nil then
    begin
      AbsolutePos := AControl.LocalToAbsolute(PointF(0, 0));
      if AControl.Scene <> nil then
        AbsolutePos := AControl.Scene.LocalToScreen(AbsolutePos);
      PopoverRect := CGRectMake(AbsolutePos.X, AbsolutePos.Y, AControl.Width, AControl.Height);
    end
    else
      PopoverRect := CGRectMake(0, 0, 0, 0);
    if FPopoverController = nil then
      FPopoverController := TUIPopoverController.Alloc;
    FPopoverController.initWithContentViewController(FImagePicker);
    FPopoverController.presentPopoverFromRect(
      PopoverRect, Window.rootViewController.View, UIPopoverArrowDirectionUp, True);
  end;

  procedure ShowPicker;
  begin
    // Camera for iPad is showed only in full screen on iPad and iPhone
    if not IsPad or (ASourceType = UIImagePickerControllerSourceTypeCamera) then
      ShowInFullScreen
    else
      ShowInPopover;
  end;

begin
  if IsAvailableSourceType(ASourceType) then
  begin
    if FImagePicker <> nil then
    begin
      FImagePicker.setDelegate(nil);
      FImagePicker.release;
    end;
    FImagePicker := TUIImagePickerController.Create;
    FImagePicker.retain;
    FImagePicker.setDelegate(FImageDelegate.GetObjectID);

    FImagePicker.setSourceType(ASourceType);
    FImagePicker.setAllowsEditing(FImageDelegate.Params.Editable);
    ShowPicker;
  end;
end;

procedure TImageManagerCocoa.TakeImageFromLibrary(const AControl: TControl; const AParams: TParamsPhotoQuery);
var
  ParamsTmp: TParamsPhotoQuery;
begin
  ParamsTmp := AParams;
  ParamsTmp.NeedSaveToAlbum := False;
  FImageDelegate.Params := ParamsTmp;
  TakeImage(AControl, UIImagePickerControllerSourceTypePhotoLibrary)
end;

procedure TImageManagerCocoa.TakePhoto(const AControl: TControl; const AParams: TParamsPhotoQuery);
begin
  FImageDelegate.Params := AParams;
  TakeImage(AControl, UIImagePickerControllerSourceTypeCamera);
end;

{ TImageDelegate }

constructor TImageDelegate.Create(const AImageManager: TImageManagerCocoa);
begin
  inherited Create;
  FImageManager := AImageManager;
end;

procedure TImageDelegate.DoDidCancelTaking;
begin
  if Assigned(Params.OnDidCancelTaking) then
    Params.OnDidCancelTaking;
end;

procedure TImageDelegate.DoDidFinishTaking(const AImage: TBitmap);
begin
  if Assigned(Params.OnDidFinishTaking) then
    Params.OnDidFinishTaking(AImage);
end;

function TImageDelegate.GetAngleOfImageOrientation(const AImage: UIImage): Single;
begin
  case AImage.imageOrientation of
    UIImageOrientationDown,
    UIImageOrientationDownMirrored:
      Result := 180;
    UIImageOrientationLeft,
    UIImageOrientationLeftMirrored:
      Result := -90;
    UIImageOrientationRight,
    UIImageOrientationRightMirrored:
      Result := 90;
    UIImageOrientationUp,
    UIImageOrientationUpMirrored:
      Result := 0;
  else
    Result := 0;
  end;
end;

procedure TImageDelegate.HidePicker(const APicker: UIImagePickerController);
begin
  if (FImageManager <> nil) and IsPad and (APicker.sourceType <> UIImagePickerControllerSourceTypeCamera) then
    FImageManager.ClosePopover
  else
    APicker.dismissModalViewControllerAnimated(True);
end;

procedure TImageDelegate.imagePickerController(picker: UIImagePickerController; didFinishPickingImage: UIImage;
  editingInfo: NSDictionary);
var
  Bitmap: TBitmap;
  RotationAngle: Single;
begin
  HidePicker(picker);
  RotationAngle := GetAngleOfImageOrientation(didFinishPickingImage);
  Bitmap := UIImageToBitmap(didFinishPickingImage, RotationAngle, Params.RequiredResolution);
  try
    DoDidFinishTaking(Bitmap);
    if Params.NeedSaveToAlbum then
      FImageManager.SaveImageToSavedPhotosAlbum(didFinishPickingImage);
  finally
    Bitmap.DisposeOf;
  end;
end;

procedure TImageDelegate.imagePickerController(picker: UIImagePickerController; didFinishPickingMediaWithInfo: NSDictionary);
var
  Bitmap: TBitmap;
  ImageTmp: UIImage;
  RotationAngle: Single;
begin
  HidePicker(picker);
  if Params.Editable then
    ImageTmp := TUIImage.Wrap(didFinishPickingMediaWithInfo.objectForKey((UIImagePickerControllerEditedImage as ILocalObject).GetObjectID))
  else
    ImageTmp := TUIImage.Wrap(didFinishPickingMediaWithInfo.objectForKey((UIImagePickerControllerOriginalImage as ILocalObject).GetObjectID));
  RotationAngle := GetAngleOfImageOrientation(ImageTmp);
  Bitmap := UIImageToBitmap(ImageTmp, RotationAngle, Params.RequiredResolution);
  try
    DoDidFinishTaking(Bitmap);
    if Params.NeedSaveToAlbum then
      FImageManager.SaveImageToSavedPhotosAlbum(ImageTmp);
  finally
    Bitmap.DisposeOf;
  end;
end;

procedure TImageDelegate.imagePickerControllerDidCancel(picker: UIImagePickerController);
begin
  DoDidCancelTaking;
  HidePicker(picker);
end;

{ TSharingService }

constructor TShareService.Create;
begin
  inherited;
  FActivityItems := TNSMutableArray.Create;
end;

destructor TShareService.Destroy;
begin
  ReleaseOldSharingController;
  FActivityItems.release;
  inherited;
end;

procedure TShareService.ReleaseOldSharingController;
var
  Pop: UIPopoverController;
begin
  if FPopoverController <> nil then
    FPopoverController.release;
  Pop := FPopoverController;

  if FActivityViewController <> nil then
  begin
    FActivityViewController.release;
    FActivityViewController := nil;
  end;
end;

procedure TShareService.Share(const AControl: TControl; const AText: string; const ABitmap: TBitmap);

  procedure ShowForPhone;
  var
    Window: UIWindow;
  begin
    Window := SharedApplication.keyWindow;
    if (Window <> nil) and (Window.rootViewController <> nil) then
      Window.rootViewController.presentModalViewController(FActivityViewController, True);
  end;

  procedure ShowForPad;
  var
    Window: UIWindow;
    PopoverRect: CGRect;
    AbsolutePos: TPointF;
  begin
    Window := SharedApplication.keyWindow;
    if AControl <> nil then
    begin
      AbsolutePos := AControl.LocalToAbsolute(PointF(0, 0));
      if AControl.Scene <> nil then
        AbsolutePos := AControl.Scene.LocalToScreen(AbsolutePos);
      PopoverRect := CGRectMake(AbsolutePos.X, AbsolutePos.Y, AControl.Width, AControl.Height);
    end
    else
      PopoverRect := CGRectMake(0, 0, 0, 0);
    FPopoverController := TUIPopoverController.Alloc;
    FPopoverController.initWithContentViewController(FActivityViewController);
    FPopoverController.presentPopoverFromRect(PopoverRect, Window.rootViewController.View, UIPopoverArrowDirectionAny, True);
  end;

  procedure ShowActionsSheet;
  begin
    if IsPad then
      ShowForPad
    else
      ShowForPhone;
  end;

var
  OCImage: UIImage;
begin
  Assert((ABitmap <> nil) or not AText.IsEmpty);
  FActivityItems.removeAllObjects;

  if not AText.IsEmpty then
    FActivityItems.addObject((StrToNSStr(AText) as ILocalObject).GetObjectID);

  if (ABitmap <> nil) and not ABitmap.IsEmpty then
  begin
    OCImage := BitmapToUIImage(ABitmap);
    FActivityItems.addObject((OCImage as ILocalObject).GetObjectID);
  end;

  try
    if FActivityItems.count > 0 then
    begin
      ReleaseOldSharingController;
      FActivityViewController := TUIActivityViewController.alloc;
      FActivityViewController.initWithActivityItems(FActivityItems , nil);
      ShowActionsSheet;
    end;
  finally
    if OCImage <> nil then
      OCImage.release;
  end;
end;

{ TSaveImageRequest }

constructor TSaveImageRequest.Create(const AImageManager: TImageManagerCocoa; const AImage: UIImage; const AHandler: TWriteImageCompletionEvent);
begin
  if AImageManager = nil then
    raise EArgumentNilException.CreateFmt(SWrongParameter, ['AImageManager']);
  if AImage = nil then
    raise EArgumentNilException.CreateFmt(SWrongParameter, ['AImage']);
  FImageManager := AImageManager;
  FImage := AImage;
  FOnCompletion := AHandler;
end;

procedure TSaveImageRequest.PerformResultOfSavingPhoto(assetURL: NSURL; error: NSError);
begin
  try
    if Assigned(FOnCompletion) then
      if error <> nil then
        FOnCompletion(False, NSStrToStr(error.localizedDescription))
      else
        FOnCompletion(True, SImageSaved);
  finally
    // ARC will remove instance of this object, when we remove the single link from FSaveQueue
    FImageManager.FSaveImageRequests.Remove(Self);
  end;
end;

procedure TSaveImageRequest.Save;
var
  AssetsLibrary: ALAssetsLibrary;
begin
  AssetsLibrary := TALAssetsLibrary.Create;
  try
    AssetsLibrary.writeImageToSavedPhotosAlbum(FImage.CGImage, FImage.imageOrientation, PerformResultOfSavingPhoto);
  finally
    AssetsLibrary.release;
  end;
end;

end.
