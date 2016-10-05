unit msmMEImages;

// Модуль: "w:\common\components\gui\Garant\msm\msmMEImages.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmMEImages" MUID: (57EB966601BF)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmModelElements
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *57EB966601BFintf_uses*
 //#UC END# *57EB966601BFintf_uses*
;

type
 //#UC START# *57EB966601BFci*
 //#UC END# *57EB966601BFci*
 //#UC START# *57EB966601BFcit*
 //#UC END# *57EB966601BFcit*
 TmsmMEImages = class(Tl3ProtoObject)
  public
   function GetMEImage(const anElement: ImsmModelElement;
    var aImages: TCustomImageList): Integer;
   class function Instance: TmsmMEImages;
    {* Метод получения экземпляра синглетона TmsmMEImages }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 //#UC START# *57EB966601BFpubl*
 //#UC END# *57EB966601BFpubl*
 end;//TmsmMEImages

implementation

uses
 l3ImplUses
 , msmImages
 , SysUtils
 , l3Base
 //#UC START# *57EB966601BFimpl_uses*
 //, msmImages
 //#UC END# *57EB966601BFimpl_uses*
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
//#UC START# *57D90AA201F1_57EB966601BF_var*
//#UC END# *57D90AA201F1_57EB966601BF_var*
begin
//#UC START# *57D90AA201F1_57EB966601BF_impl*
 //aImages := nil;
 if (anElement = nil) then
  Result := -1
 else
  Result := TmsmImages.Instance.GetImage(anElement.StringProp['msm:View:ImageFileName'], aImages);
//#UC END# *57D90AA201F1_57EB966601BF_impl*
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

//#UC START# *57EB966601BFimpl*
//#UC END# *57EB966601BFimpl*

end.
