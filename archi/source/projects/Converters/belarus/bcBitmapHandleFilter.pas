unit bcBitmapHandleFilter;

{ $Id: bcBitmapHandleFilter.pas,v 1.1 2016/01/29 14:00:52 fireton Exp $ }

interface
uses
 l3Types,
 l3Variant,
 l3Interfaces,
 k2Interfaces,
 k2TagFilter,
 k2TagGen,

 bcInterfaces;

type
 TbcBitmapHandleFilter = class(Tk2TagFilter, IbcBelanumReceiver)
 private
  f_BelaTopic: Il3CString;
  f_PicIdx: Integer;
  f_TD: IbcTopicDispatcher;
  procedure NewBelaNum(const aBelaNum: Il3CString);
 protected
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
 public
  class function SetTo(var theGenerator: Tk2TagGenerator; const aTD: IbcTopicDispatcher): Pointer; overload;
  procedure StartChild(TypeID: Tl3VariantDef); override;
 end;

implementation
uses
 l3Base,
 l3String,
 k2Tags,
 BitmapPara_Const;

procedure TbcBitmapHandleFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typBitmapPara) and (AtomIndex = k2_tiExternalHandle) then
  Exit; // мы его подменяем, то, что приехало, нужно удалить 
 inherited;
end;

procedure TbcBitmapHandleFilter.NewBelaNum(const aBelaNum: Il3CString);
begin
 if not l3Same(f_BelaTopic, aBelaNum) then
 begin
  f_BelaTopic := aBelaNum;
  f_PicIdx := 0;
 end;
end;

class function TbcBitmapHandleFilter.SetTo(var theGenerator: Tk2TagGenerator; const aTD: IbcTopicDispatcher): Pointer;
var
 l_Filter : TbcBitmapHandleFilter;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l_Filter.f_TD := aTD;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure TbcBitmapHandleFilter.StartChild(TypeID: Tl3VariantDef);
var
 l_ID: Longword;
begin
 inherited;
 if TypeID = k2_typBitmapPara then
 begin
  Inc(f_PicIdx);
  l_ID := f_TD.GetTopic(f_BelaTopic.AsWStr, f_PicIdx);
  Generator.AddIntegerAtom(k2_tiExternalHandle, l_ID);
 end;
end;

end.