unit ddPictureFilter;
{ Преобразование сегментов-картинок в абзацы-картинки }

interface

uses evdBufferedFilter, k2Interfaces, k2DocumentBuffer, k2TagGen, evdLeafParaFilter,
  l3Types,
  k2Base
  ;

type
 TddPictureFilter = class(TevdLeafParaFilter)
 private
  f_PicBuffer: Tk2DocumentBuffer;
  function PicBuffer: Tk2DocumentBuffer;
 protected
  procedure Cleanup; override;
        {* - Определяет нужно ли сбрасывать Тег в трубу.  }
  procedure DoWritePara(aLeaf: Tl3Variant); override;
  function  ParaTypeForFiltering: Tk2Type; override;
 public
 end;
                                                                                                           
implementation

uses
 l3Variant,
 l3Interfaces, k2Tags, Math, BitmapPara_Const, evdTypes, l3String, NevTools,
 evSearch, evdStyles, evParaTools, Document_Const, SysUtils, evIntf, Formula_Const, TextPara_Const;

procedure TddPictureFilter.Cleanup;
begin
 inherited;
 f_PicBuffer.Finish;
 FreeAndNil(f_PicBuffer);
end;

procedure TddPictureFilter.DoWritePara(aLeaf: Tl3Variant);
var
 l_ObjectsCount: Integer;
 
  function lp_CheckObjects(aLayer: Tl3Variant; anIndex: Integer): Boolean;

   function lp_ConvertObject(aSeg: Tl3Variant; anIndex: Integer): Boolean;
   var
    l_BitmapPara: Tl3Variant;
    i: Integer;
   begin
    Result := True;
    for i:= 0 to Pred(aSeg.ChildrenCount) do
    begin
     l_BitmapPara:= aSeg.Child[i];
     if l_BitmapPara.IsKindOf(k2_typBitmapPara) then
     begin
      Inc(l_ObjectsCount);
      PicBuffer.StartChild(l_BitmapPara.TagType);
      try
       l_BitmapPara.AsObject.WriteTag(PicBuffer);
      finally
       PicBuffer.Finish;
      end;//try..finally
     end; // l_BitmapPara.IsKindOf(k2_typBitmapPara)
    end; // for i
   end; // lp_ConvertObject

  begin
   Result := True;
   if aLayer.Attr[k2_tiHandle].IsValid and (aLayer.IntA[k2_tiHandle] = Ord(ev_slObjects)) then
   begin
    aLayer.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_ConvertObject));
    Result:= False;
   end;
  end; // lp_CheckObjects

var
 l_ConvertType: Boolean;
 l_Segments: Tl3Variant;
 l_Index: Integer;
 l_nevPara: InevPara;
 l_Searcher: IevSearcher;
 l_Replacer: IevReplacer;
begin
 if aLeaf.Attr[k2_tiSegments].IsValid then
 begin
  l_ObjectsCount:= 0;
  l_Segments := aLeaf.Attr[k2_tiSegments];
  PicBuffer.StartChild(k2_typDocument);
  try
   l_Segments.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckObjects));
  finally
   PicBuffer.Finish;
  end;

  if l_ObjectsCount > 0 then
  begin
   if (aLeaf.Attr[k2_tiText].IsValid) and (aLeaf.PCharLenA[k2_tiText].SLen > l_ObjectsCount) then
   begin
    // Удаляем объекты, записываем абзац. Не съехали ли все остальные сегменты? :(
    aLeaf.QT(InevPara, l_nevPara);
    try
     l_Searcher:= TevStylesSearcher.Make([ev_saObject], Ord(ev_slObjects), ev_spSegments);
     try
      l_Replacer:= TevTextReplacer.Make('');
      try
       EvReplaceInPara(l_nevPara, l_Searcher, l_Replacer);
       Generator.StartChild(aLeaf.TagType);
       try
        aLeaf.AsObject.WriteTag(Generator);
       finally
        Generator.Finish;
       end;//try..finally
      finally
       l_Replacer:= nil;
      end;
     finally
      l_Searcher:= nil;
     end;
    finally
     l_Nevpara:= nil;
    end;
   end; // (aLeaf.Attr[k2_tiText].IsValid) and (aLeaf.PCharLenA[k2_tiText].SLen > 0)
   PicBuffer.Root.WriteTag(Generator);
  end // l_ObjectsCount > 0
  else
   inherited
 end
 else
  inherited
end;

function TddPictureFilter.ParaTypeForFiltering: Tk2Type;
  //virtual;
  {-}
begin
 Result := k2_typTextPara;
end;


function TddPictureFilter.PicBuffer: Tk2DocumentBuffer;
begin
 if f_PicBuffer = nil then
 begin
  f_PicBuffer:= Tk2DocumentBuffer.Create;
  f_PicBuffer.Start;
 end;
 Result := f_PicBuffer;
end;

end.
