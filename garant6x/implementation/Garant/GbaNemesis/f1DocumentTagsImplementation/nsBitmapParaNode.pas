unit nsBitmapParaNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsBitmapParaNode.pas"
// Начат: 2005/06/23 16:38:20
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsBitmapParaNode
//
// Параграф с картинкой.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsLeafParaNode,
  evBitmapPara_Wrap,
  k2Base,
  l3Variant
  ;

type
 TnsBitmapParaPictureGetter = class(TevBitmapParaPictureGetter)
 public
 // overridden public methods
   class function GetPicture(aTag: Tl3Variant;
     aProp: Tk2Prop;
     out Data: Tl3Variant): Boolean; override;
 end;//TnsBitmapParaPictureGetter

 TnsBitmapParaNode = class(TnsLeafParaNode)
  {* Параграф с картинкой. }
 protected
 // overridden protected methods
   function DoGetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; override;
 end;//TnsBitmapParaNode

implementation

uses
  SysUtils,
  l3Interfaces,
  StartUnit,
  BaseTypesUnit,
  DataAdapter,
  k2Tags,
  ExternalObjectUnit,
  nsExternalObjectPrim,
  l3Memory,
  l3BaseStream,
  k2SizedMemoryPool,
  k2RawData_Const
  ;

// start class TnsBitmapParaPictureGetter

class function TnsBitmapParaPictureGetter.GetPicture(aTag: Tl3Variant;
  aProp: Tk2Prop;
  out Data: Tl3Variant): Boolean;
//#UC START# *4F4B9CB401AF_4F4B9D41030A_var*
var
 l_ID : Integer;
 l_EO : IExternalObject;
 l_S  : TnsExternalObjectStream;
 l_MP : Tk2RawData;
(* l_St : IStream;
 l_Read    : Large;
 l_Written : Large;*)
//#UC END# *4F4B9CB401AF_4F4B9D41030A_var*
begin
//#UC START# *4F4B9CB401AF_4F4B9D41030A_impl*
 Result := false;
 if (aProp.TagIndex = k2_tiData) then
 begin
  l_ID := aTag.IntA[k2_tiExternalHandle];
  if (l_ID > 0) then
  begin
   try
    defDataAdapter.CommonInterfaces.GetPicture(l_ID, l_EO);
   except
    on ECanNotFindData do
    begin
     // - тут положим заглушку, чтобы адаптер больше не дёргать
     l_MP := Tk2RawData.Create;
     try
      aTag.AttrW[k2_tiData, nil] := l_MP;
      Data := l_MP;
     finally
      FreeAndNil(l_MP);
     end;//try..finally
     Result := true;
     Exit;
    end;//on ECanNotFindData
   end;//try..except
   try
    Assert(l_EO <> nil);
    l_S := TnsExternalObjectStream.Create(l_EO);
    try
     l_MP := Tk2RawData.CreateFromIStream(l_S);
     try
(*      l_St := l_MP As IStream;
      {$IfDef nsTest}
      Dec(g_IStreamCopyTo_Guard);
      try
      {$EndIf nsTest}
       IStream(l_S).CopyTo(l_St, High(Large), l_Read, l_Written);
      {$IfDef nsTest}
      finally
       Inc(g_IStreamCopyTo_Guard);
      end;//try..finally
      {$EndIf nsTest}
      //StoreTagAtom(aProp, l_MP);*)
      aTag.AttrW[k2_tiData, nil] := l_MP;
      Data := l_MP;
     finally
      FreeAndNil(l_MP);
     end;//try..finally
     Result := true;
    finally
     FreeAndNil(l_S);
    end;//try..finally
   finally
    l_EO := nil
   end;//try..finally
  end;//l_ID > 0
 end;//aProp.TagIndex = k2_tiData
//#UC END# *4F4B9CB401AF_4F4B9D41030A_impl*
end;//TnsBitmapParaPictureGetter.GetPicture

function TnsBitmapParaNode.DoGetSubAtom(aProp: Tk2Prop;
  out Data: Tl3Variant): Boolean;
//#UC START# *4C6D1D450332_467FCDDA0064_var*
//#UC END# *4C6D1D450332_467FCDDA0064_var*
begin
//#UC START# *4C6D1D450332_467FCDDA0064_impl*
 Result := inherited DoGetSubAtom(aProp, Data);
//#UC END# *4C6D1D450332_467FCDDA0064_impl*
end;//TnsBitmapParaNode.DoGetSubAtom

initialization
//#UC START# *4F4B9D7102FE*
 g_BitmapParaPictureGetter := TnsBitmapParaPictureGetter;
//#UC END# *4F4B9D7102FE*

end.