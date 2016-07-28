unit evBitmapPara_Wrap;
 {* Wrapper для параграфов с картинками. }

// Модуль: "w:\common\components\gui\Garant\Everest\evBitmapPara_Wrap.pas"
// Стереотип: "Wrapper"
// Элемент модели: "WevBitmapPara" MUID: (485792C1014E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evPara_Wrap
 , l3Variant
 , k2Base
;

type
 RevBitmapParaPictureGetter = class of TevBitmapParaPictureGetter;

 TevBitmapParaPictureGetter = class
  public
   class function GetPicture(aTag: Tl3Variant;
    aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; virtual;
 end;//TevBitmapParaPictureGetter

 WevBitmapPara = class(WevPara)
  {* Wrapper для параграфов с картинками. }
  protected
   function DoGetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out theData: Tl3Variant): Boolean; virtual;
   function GetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; override;
   function PreGetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; override;
 end;//WevBitmapPara

var g_BitmapParaPictureGetter: RevBitmapParaPictureGetter = nil;

implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
 , evBitmapParaBitmapContainer
 , l3Interfaces
 , Classes
 , l3Base
 , l3InternalInterfaces
 , l3Stream
 , k2SizedMemoryPool
 , k2Long_Const
 , BitmapPara_Const
;

class function TevBitmapParaPictureGetter.GetPicture(aTag: Tl3Variant;
 aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
//#UC START# *4F4B9CB401AF_4F4B991C00A3_var*
//#UC END# *4F4B9CB401AF_4F4B991C00A3_var*
begin
//#UC START# *4F4B9CB401AF_4F4B991C00A3_impl*
 Result := false;
 Data := nil;
//#UC END# *4F4B9CB401AF_4F4B991C00A3_impl*
end;//TevBitmapParaPictureGetter.GetPicture

function WevBitmapPara.DoGetAtomData(AE: Tl3Variant;
 aProp: Tk2CustomProperty;
 out theData: Tl3Variant): Boolean;
//#UC START# *48DD1AB50143_485792C1014E_var*
var
 l_BitmapData      : Tl3Variant;
 l_BitmapContainer : TevBitmapParaBitmapContainer;
 l_IStream         : IStream;
 l_Stream          : TStream;
//#UC END# *48DD1AB50143_485792C1014E_var*
begin
//#UC START# *48DD1AB50143_485792C1014E_impl*
 Result := false;
 Case aProp.TagIndex of
(*  k2_tiHeight :
  begin
   Result := true;
   with AE.Attr[k2_tiObject] do
    if IsValid then
     theData := (Tl3Base(AsObject) As Il3Bitmap).InchHeight
    else
     theData := 100;
  end;//k2_tiHeight
  k2_tiWidth  :
  begin
   Result := true;
   with AE.Attr[k2_tiObject] do
    if IsValid then
    begin
     theData := (Tl3Base(AsObject) As Il3Bitmap).InchWidth;
     Inc(theData, AE.IntA[k2_tiLeftIndent]);
    end//IsValid
    else
     theData := 100;
  end;//k2_tiWidth*)
  k2_tiObject :
  begin
   l_BitmapData := AE.Attr[k2_tiData];
   if l_BitmapData.IsValid then
   begin
    Result := true;
    l_BitmapContainer := TevBitmapParaBitmapContainer.Create(Tk2Type(aProp.AtomType));
    try
     AE.AttrW[aProp.TagIndex, nil] := l_BitmapContainer;
     theData := l_BitmapContainer;
     if l_BitmapData.QI(IStream, l_IStream) then
      try
       l3IStream2Stream(l_IStream, l_Stream);
       try
        l_BitmapContainer.Stream := l_Stream;
        with AE.Attr[k2_tiDPI] do
         if IsValid then
          l_BitmapContainer.DPI := AsLong;
       finally
        FreeAndNil(l_Stream);
       end;//try..finally
      finally
       l_IStream := nil;
      end;//try..finally
    finally
     FreeAndNil(l_BitmapContainer);
    end;//try..finally
   end;//l_BitmapData.IsValid
  end;//k2_tiObject}
  k2_tiData:
   if (g_BitmapParaPictureGetter <> nil) then
    Result := g_BitmapParaPictureGetter.GetPicture(AE, aProp, theData);
 end;//Case aProp.TagIndex
//#UC END# *48DD1AB50143_485792C1014E_impl*
end;//WevBitmapPara.DoGetAtomData

function WevBitmapPara.GetAtomData(AE: Tl3Variant;
 aProp: Tk2CustomProperty;
 out Data: Tl3Variant): Boolean;
//#UC START# *4857A995029E_485792C1014E_var*
//#UC END# *4857A995029E_485792C1014E_var*
begin
//#UC START# *4857A995029E_485792C1014E_impl*
 Result := inherited GetAtomData(AE, aProp, Data);
 if not Result OR
    ((Data = nil) AND
     ((aProp.TagIndex = k2_tiObject) OR
      (aProp.TagIndex = k2_tiData))) then
  Result := DoGetAtomData(AE, aProp, Data);
//#UC END# *4857A995029E_485792C1014E_impl*
end;//WevBitmapPara.GetAtomData

function WevBitmapPara.PreGetAtomData(AE: Tl3Variant;
 aProp: Tk2CustomProperty;
 out Data: Tl3Variant): Boolean;
//#UC START# *48DD0CE60313_485792C1014E_var*
var
 l_Data : Tl3Variant;
//#UC END# *48DD0CE60313_485792C1014E_var*
begin
//#UC START# *48DD0CE60313_485792C1014E_impl*
 Case aProp.TagIndex of
  k2_tiInternalHandle,
  k2_tiExternalHandle:
  begin
   l_Data := AE.Attr[k2_tiData];
   if (l_Data Is Tk2RawData) then
   begin
    Case aProp.TagIndex of
     k2_tiInternalHandle:
      Data := k2_typLong.MakeTag(Tk2RawData(l_Data).InternalID).AsObject;
     k2_tiExternalHandle:
      Data := k2_typLong.MakeTag(Tk2RawData(l_Data).ExternalID).AsObject;
     else
      Assert(false);
    end;//Case aProp.TagIndex
    Result := true;
    Exit;
   end;//l_Data Is Tk2RawData
  end;//k2_tiInternalHandle..
 end;//Case aProp.TagIndex
 Result := inherited PreGetAtomData(AE, aProp, Data);
//#UC END# *48DD0CE60313_485792C1014E_impl*
end;//WevBitmapPara.PreGetAtomData

end.
