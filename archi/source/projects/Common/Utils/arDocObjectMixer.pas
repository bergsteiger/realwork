unit arDocObjectMixer;

interface

uses
 l3Types,

 daTypes,
 
 k2Interfaces,
 k2TagFilter;

type
 // "Подкладывает" доп поток с "картинкой" в evd-поток
 TarDocObjectMixer = class(Tk2TagFilter)
 private
  fDocId      : TdaDocID;
  fDataHandle : Integer;
  fExternalID : Integer;
  fProcessed  : boolean;
 protected
        {-}
  procedure AddAtomEx(AtomIndex : Long; const Value : Tk2Variant); override;
  procedure DoCloseStructure(NeedUndo: Boolean); override;
 public
  {* - создает экземпляр класа и цепляет его к генератору. }
  //class function SetTo(var theGenerator: Tk2TagGenerator; aDocObject: TarDocObject): Tk2TagGenerator; overload;
  //property DocObject: TarDocObject read f_DocObject write f_DocObject;
 end;

implementation

uses
 Classes,

 l3Base,
 l3Stream,

 k2Tags,

 daSchemeConsts,

 DT_Serv,

 m3StorageInterfaces,

 ExtDataPara_Const,
 BitmapPara_Const,
 Document_Const;

{TarDocObjectMixer}
procedure TarDocObjectMixer.AddAtomEx(AtomIndex : Long; const Value : Tk2Variant);
begin
 if TopType[0].IsKindOf(k2_typDocument) then {заполнение элементарных полей документа}
 begin
  if (AtomIndex = k2_tiInternalHandle) then
   fDocID := TdaDocID(Value.AsInteger);
 end
 else
  if TopType[0].IsKindOf([k2_typBitMapPara, k2_typExtDataPara]) then
  begin
   if (AtomIndex = k2_tiData) then
    fProcessed := True;

   if (AtomIndex = k2_tiInternalHandle) then
    fDataHandle := Value.AsInteger
   else
   if (AtomIndex = k2_tiExternalHandle) then
    fExternalID := Value.AsInteger;
  end;
 Inherited;
end;

procedure TarDocObjectMixer.DoCloseStructure(NeedUndo: Boolean);
  //virtual;
  {-вызывается на закрывающуюся скобку}
 procedure lStreamLoad;
 var
  l_IStream : IStream;
  l_Stream  : TStream;

 begin
  l_IStream := dtGetObjectStream(CurrentFamily, fDocID, fDataHandle, m3_saRead);

  if (l_IStream <> nil) then
  begin
   l3IStream2Stream(l_IStream, l_Stream);
   try
    AddStreamAtom(k2_tiData, l_Stream);
   finally
    l3Free(l_Stream);
   end;
  end;//l_IStream <> nil
 end;

begin
 if not fProcessed and CurrentType.IsKindOf([k2_typBitMapPara, k2_typExtDataPara]) then
 begin
  lStreamLoad;
  fProcessed := True;
 end
 else
 if not fProcessed and CurrentType.IsKindOf(k2_typDocument) then
 begin
  {if DocObject.ObjType = dotImage then
   StartChild(k2_typBitmapPara)
  else}
   StartChild(k2_typExtDataPara);
  try
   lStreamLoad;
  finally
   Finish;
  end;
 end;
 inherited;
end;

{TarObject_CheckExtNumber}
(*function TarObject_CheckExtNumber.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
begin
 Result := (aTagID = -k2_idExtDataPara) or (aTagID = -k2_idBitmapPara);
end;

function TarObject_CheckExtNumber.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := (aID = -k2_idExtDataPara) or (aID = -k2_idBitmapPara);
// if Result then
//  fExtHandlePresent := False;
end;

procedure TarObject_CheckExtNumber.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
begin
 if aLeaf.IntA[k2_tiExternalHandle] = 0 then
  aLeaf.IntA[k2_tiExternalHandle] := GlobalDataProvider.GetFreeExtObjID(CurrentFamily);
 Inherited;
end;
*)

end.