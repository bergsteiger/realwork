unit msmMEImages;

// Модуль: "w:\common\components\gui\Garant\msm\msmMEImages.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmMEImages" MUID: (57D909F3037B)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmImageNames
 , msmModelElements
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *57D909F3037Bintf_uses*
 , vtPngImgList
 //#UC END# *57D909F3037Bintf_uses*
;

type
 //#UC START# *57D909F3037Bci*
 //#UC END# *57D909F3037Bci*
 //#UC START# *57D909F3037Bcit*
 //#UC END# *57D909F3037Bcit*
 TmsmMEImages = class(Tl3ProtoObject)
  private
   f_ImageNames: TmsmImageNames;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   function GetMEImage(const anElement: ImsmModelElement;
    var aImages: TCustomImageList): Integer;
   class function Instance: TmsmMEImages;
    {* Метод получения экземпляра синглетона TmsmMEImages }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 //#UC START# *57D909F3037Bpubl*
  private
   f_ImageList : TvtNonFixedPngImageList;
 //#UC END# *57D909F3037Bpubl*
 end;//TmsmMEImages

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57D909F3037Bimpl_uses*
 , l3Interfaces
 , l3String
 , hyieutils
 , imageenio
 , vtInterfaces
 , ddConst
 , ddPictDetector
 //#UC END# *57D909F3037Bimpl_uses*
;

var g_TmsmMEImages: TmsmMEImages = nil;
 {* Экземпляр синглетона TmsmMEImages }

procedure TmsmMEImagesFree;
 {* Метод освобождения экземпляра синглетона TmsmMEImages }
begin
 l3Free(g_TmsmMEImages);
end;//TmsmMEImagesFree

function TmsmMEImages.GetMEImage(const anElement: ImsmModelElement;
 var aImages: TCustomImageList): Integer;
//#UC START# *57D90AA201F1_57D909F3037B_var*
var
 l_S : Il3CString;
 l_N : String;
 l_Index : Integer;
 l_IO: TImageEnIO;
 l_Detect : TddPictureFormatDetector;
 l_Name : TmsmImageName;
//#UC END# *57D90AA201F1_57D909F3037B_var*
begin
//#UC START# *57D90AA201F1_57D909F3037B_impl*
 //aImages := nil;
 Result := -1;
 if (anElement <> nil) then
 begin
  l_S := anElement.StringProp['msm:View:ImageFileName'];
  if not l3IsNil(l_S) then
  begin
   l_N := l3Str(l_S);
   l_Name := TmsmImageName_C(l_S, true);
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
  end;//not l3IsNil(l_S)
 end;//anElement <> nil
//#UC END# *57D90AA201F1_57D909F3037B_impl*
end;//TmsmMEImages.GetMEImage

class function TmsmMEImages.Instance: TmsmMEImages;
 {* Метод получения экземпляра синглетона TmsmMEImages }
begin
 if (g_TmsmMEImages = nil) then
 begin
  l3System.AddExitProc(TmsmMEImagesFree);
  g_TmsmMEImages := Create;
 end;
 Result := g_TmsmMEImages;
end;//TmsmMEImages.Instance

class function TmsmMEImages.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmMEImages <> nil;
end;//TmsmMEImages.Exists

procedure TmsmMEImages.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57D909F3037B_var*
//#UC END# *479731C50290_57D909F3037B_var*
begin
//#UC START# *479731C50290_57D909F3037B_impl*
 FreeAndNil(f_ImageNames);
 FreeAndNil(f_ImageList);
 inherited;
//#UC END# *479731C50290_57D909F3037B_impl*
end;//TmsmMEImages.Cleanup

procedure TmsmMEImages.InitFields;
//#UC START# *47A042E100E2_57D909F3037B_var*
//#UC END# *47A042E100E2_57D909F3037B_var*
begin
//#UC START# *47A042E100E2_57D909F3037B_impl*
 inherited;
 f_ImageNames := TmsmImageNames.Create;
 f_ImageNames.Sorted := false;
//#UC END# *47A042E100E2_57D909F3037B_impl*
end;//TmsmMEImages.InitFields

//#UC START# *57D909F3037Bimpl*
//#UC END# *57D909F3037Bimpl*

end.
