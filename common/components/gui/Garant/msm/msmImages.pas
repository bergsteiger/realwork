unit msmImages;

// Модуль: "w:\common\components\gui\Garant\msm\msmImages.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmImages" MUID: (57D909F3037B)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmImageNames
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 //#UC START# *57D909F3037Bintf_uses*
 , vtPngImgList
 //#UC END# *57D909F3037Bintf_uses*
;

type
 //#UC START# *57D909F3037Bci*
 //#UC END# *57D909F3037Bci*
 //#UC START# *57D909F3037Bcit*
 //#UC END# *57D909F3037Bcit*
 TmsmImages = class(Tl3ProtoObject)
  private
   f_ImageNames: TmsmImageNames;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   function GetImage(const aFileName: Il3CString;
    var aImages: TCustomImageList): Integer;
   function GetImageForOperation(anIndex: Integer;
    var aImages: TCustomImageList): Integer; overload;
   function GetImagesForOperations: TCustomImageList;
   function GetImageForOperation(anIndex: Integer): Integer; overload;
   class function Instance: TmsmImages;
    {* Метод получения экземпляра синглетона TmsmImages }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 //#UC START# *57D909F3037Bpubl*
  private
   f_ImageList : TvtNonFixedPngImageList;
 //#UC END# *57D909F3037Bpubl*
 end;//TmsmImages

implementation

uses
 l3ImplUses
 , tfwParserService
 , SysUtils
 , l3Base
 //#UC START# *57D909F3037Bimpl_uses*
 //, l3Interfaces
 , l3String
 , hyieutils
 , imageenio
 , vtInterfaces
 , ddConst
 , ddPictDetector
 , tfwScriptingInterfaces
 //#UC END# *57D909F3037Bimpl_uses*
;

var g_TmsmImages: TmsmImages = nil;
 {* Экземпляр синглетона TmsmImages }

procedure TmsmImagesFree;
 {* Метод освобождения экземпляра синглетона TmsmImages }
begin
 l3Free(g_TmsmImages);
end;//TmsmImagesFree

function TmsmImages.GetImage(const aFileName: Il3CString;
 var aImages: TCustomImageList): Integer;
//#UC START# *57EB8E2B00A5_57D909F3037B_var*
var
 l_N : String;
 l_Index : Integer;
 l_IO: TImageEnIO;
 l_Detect : TddPictureFormatDetector;
 l_Name : TmsmImageName;
//#UC END# *57EB8E2B00A5_57D909F3037B_var*
begin
//#UC START# *57EB8E2B00A5_57D909F3037B_impl*
 Result := -1;
 if not l3IsNil(aFileName) then
 begin
  l_N := l3Str(aFileName);
  l_Name := TmsmImageName_C(aFileName, true);
  l_Index := f_ImageNames.IndexOf(l_Name);
  if (l_Index < 0) then
  begin
   if (f_ImageList = nil) then
     f_ImageList := TvtNonFixedPngImageList.Create(nil);
   l_Name.rIsValid := FileExists(l_N);
   l_Index := f_ImageNames.Add(l_Name);
   f_ImageList.AddItem;
   if l_Name.rIsValid then
   begin
    l_IO := TImageEnIO.Create(nil);
    try
     l_Detect := TddPictureFormatDetector.Create;
     try
      l_Detect.Check(l_N);
      Case l_Detect.PictureFormat of
       pictPNG:
        l_IO.LoadFromFilePNG(l_N);
       pictGIF:
        l_IO.LoadFromFileGIF(l_N);
       else
        Assert(false); 
      end;//Case l_Detect.PictureFormat
     finally
      FreeAndNil(l_Detect);
     end;//try..finally
     f_ImageList.AddImage(l_Index, bpp24, l_IO.IEBitmap);
    finally
     FreeAndNil(l_IO);
    end;//try..finally
   end;//l_Name.rIsValid
  end//l_Index < 0
  else
   l_Name.rIsValid := f_ImageNames.ItemSlot(l_Index).rIsValid;
  if (l_Index >= 0) then
  begin
   if not l_Name.rIsValid then
    l_Index := -1;
  end;//l_Index >= 0
  Result := l_Index;
  aImages := f_ImageList;
 end;//not l3IsNil(aFileName)
//#UC END# *57EB8E2B00A5_57D909F3037B_impl*
end;//TmsmImages.GetImage

function TmsmImages.GetImageForOperation(anIndex: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *57EBA4D403A8_57D909F3037B_var*
//#UC END# *57EBA4D403A8_57D909F3037B_var*
begin
//#UC START# *57EBA4D403A8_57D909F3037B_impl*
 if (anIndex < 0) then
  Result := -1
 else
  Result := Self.GetImage(TtfwCStringFactory.C(TtfwParserService.Instance.ResolveIncludedFilePath(IntToStr(anIndex) + '.png')), aImages);
//#UC END# *57EBA4D403A8_57D909F3037B_impl*
end;//TmsmImages.GetImageForOperation

function TmsmImages.GetImagesForOperations: TCustomImageList;
//#UC START# *57EBA51F024C_57D909F3037B_var*
//#UC END# *57EBA51F024C_57D909F3037B_var*
begin
//#UC START# *57EBA51F024C_57D909F3037B_impl*
 Result := nil;
 GetImageForOperation(0, Result);
//#UC END# *57EBA51F024C_57D909F3037B_impl*
end;//TmsmImages.GetImagesForOperations

function TmsmImages.GetImageForOperation(anIndex: Integer): Integer;
//#UC START# *57EBA71D02C5_57D909F3037B_var*
var
 l_IL : TCustomImageList;
//#UC END# *57EBA71D02C5_57D909F3037B_var*
begin
//#UC START# *57EBA71D02C5_57D909F3037B_impl*
 l_IL := nil;
 Result := Self.GetImageForOperation(anIndex, l_IL);
//#UC END# *57EBA71D02C5_57D909F3037B_impl*
end;//TmsmImages.GetImageForOperation

class function TmsmImages.Instance: TmsmImages;
 {* Метод получения экземпляра синглетона TmsmImages }
begin
 if (g_TmsmImages = nil) then
 begin
  l3System.AddExitProc(TmsmImagesFree);
  g_TmsmImages := Create;
 end;
 Result := g_TmsmImages;
end;//TmsmImages.Instance

class function TmsmImages.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmImages <> nil;
end;//TmsmImages.Exists

procedure TmsmImages.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57D909F3037B_var*
//#UC END# *479731C50290_57D909F3037B_var*
begin
//#UC START# *479731C50290_57D909F3037B_impl*
 FreeAndNil(f_ImageNames);
 FreeAndNil(f_ImageList);
 inherited;
//#UC END# *479731C50290_57D909F3037B_impl*
end;//TmsmImages.Cleanup

procedure TmsmImages.InitFields;
//#UC START# *47A042E100E2_57D909F3037B_var*
//#UC END# *47A042E100E2_57D909F3037B_var*
begin
//#UC START# *47A042E100E2_57D909F3037B_impl*
 inherited;
 f_ImageNames := TmsmImageNames.Create;
 f_ImageNames.Sorted := false;
//#UC END# *47A042E100E2_57D909F3037B_impl*
end;//TmsmImages.InitFields

//#UC START# *57D909F3037Bimpl*
//#UC END# *57D909F3037Bimpl*

end.
