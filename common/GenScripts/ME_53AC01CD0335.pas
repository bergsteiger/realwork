{$IfNDef evdTagHolder_imp}

// Модуль: "w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas"
// Стереотип: "Impurity"

{$Define evdTagHolder_imp}

 _k2TaggedDataHolder_Parent_ = _evdTagHolder_Parent_;
 {$Include k2TaggedDataHolder.imp.pas}
 _evdTagHolder_ = class(_k2TaggedDataHolder_)
  protected
   function NeedSendRawDataAsBinary: Boolean; virtual;
  public
   procedure SaveToEVD(aStream: TStream;
    const aFilter: Ik2TagGenerator);
   class function CreateTaggedDataFromEVD(aStream: TStream): Tl3Tag;
   procedure LoadFromEVD(aStream: TStream);
 end;//_evdTagHolder_

{$Else evdTagHolder_imp}

{$IfNDef evdTagHolder_imp_impl}

{$Define evdTagHolder_imp_impl}

{$Include k2TaggedDataHolder.imp.pas}

procedure _evdTagHolder_.SaveToEVD(aStream: TStream;
 const aFilter: Ik2TagGenerator);
//#UC START# *53AC1EA102D7_53AC01CD0335_var*
var
 l_Writer : TevdNativeWriter;
 l_Filer  : Tl3CustomFiler;
 l_G      : Ik2TagGenerator;
//#UC END# *53AC1EA102D7_53AC01CD0335_var*
begin
//#UC START# *53AC1EA102D7_53AC01CD0335_impl*
 l_Writer := TevdNativeWriter.Create;
 try
  {$IfDef evdNeedEverestTxt}
  l_Writer.Binary := false;
  {$EndIf evdNeedEverestTxt}
  if NeedSendRawDataAsBinary then
  begin
   l_Writer.NeedOutHeader := True;
   l_Writer.SmallHeader := True;
  end
  else
   l_Writer.NeedOutHeader := false;
  l_Filer := Tl3CustomFiler.Create;
  try
   l_Filer.Mode := l3_fmWrite;
   l_Filer.Stream := aStream;
   try
    l_Filer.Open;
    try
     l_Writer.Filer := l_Filer;
     if (aFilter = nil) then
      l_G := l_Writer
     else
     begin
      (aFilter As Ik2TagGeneratorChainEnd).Link(l_Writer);
      l_G := aFilter;
     end;//aFilter = nil 
     l_G.Start;
     try
      l_G.StartChild(TaggedData.TagType);
      try
//       l_Writer.AddStringAtom(k2_attrHandle, anItem.TaskID);
       TaggedData.WriteTag(l_G);
      finally
       l_G.Finish;
      end;//try..finally
     finally
      l_G.Finish;
     end;//try..finally
    finally
     l_Filer.Close;
    end;//try..finally
   finally
    l_Filer.Stream := nil;
   end;//try..finally
  finally
   FreeAndNil(l_Filer);
  end;//try..finally
 finally
  FreeAndNil(l_Writer);
 end;//try..finally
//#UC END# *53AC1EA102D7_53AC01CD0335_impl*
end;//_evdTagHolder_.SaveToEVD

class function _evdTagHolder_.CreateTaggedDataFromEVD(aStream: TStream): Tl3Tag;
//#UC START# *53BFEC6401A9_53AC01CD0335_var*
var
 l_Reader : TevdNativeReader;
 l_Filer  : Tl3CustomFiler;
 l_Buff   : Tk2DocumentBuffer;
//#UC END# *53BFEC6401A9_53AC01CD0335_var*
begin
//#UC START# *53BFEC6401A9_53AC01CD0335_impl*
 Result := nil;
 l_Reader := TevdNativeReader.Create;
 try
  l_Reader.ReadOnlyOneRoot := true;
  l_Filer := Tl3CustomFiler.Create;
  try
   l_Filer.Mode := l3_fmRead;
   l_Filer.Stream := aStream;
   try
    l_Filer.Open;
    try
     l_Reader.Filer := l_Filer;
     l_Buff := Tk2DocumentBuffer.Create;
     try
      l_Reader.Generator := l_Buff;
      l_Reader.Execute;
      Result := l_Buff.Root.Use;
     finally
      FreeAndNil(l_Buff);
     end;//try..finally
    finally
     l_Filer.Close;
    end;//try..finally
   finally
    l_Filer.Stream := nil;
   end;//try..finally
  finally
   FreeAndNil(l_Filer);
  end;//try..finally
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *53BFEC6401A9_53AC01CD0335_impl*
end;//_evdTagHolder_.CreateTaggedDataFromEVD

procedure _evdTagHolder_.LoadFromEVD(aStream: TStream);
//#UC START# *53BFF34F0025_53AC01CD0335_var*
var
 l_Data : Tl3Tag;
//#UC END# *53BFF34F0025_53AC01CD0335_var*
begin
//#UC START# *53BFF34F0025_53AC01CD0335_impl*
 l_Data := CreateTaggedDataFromEVD(aStream);
 try
  Self.SetTaggedData(l_Data);
  //TaggedData.AssignTag(l_Data);
 finally
  FreeAndNil(l_Data);
 end;//try..finally
//#UC END# *53BFF34F0025_53AC01CD0335_impl*
end;//_evdTagHolder_.LoadFromEVD

function _evdTagHolder_.NeedSendRawDataAsBinary: Boolean;
//#UC START# *549413590379_53AC01CD0335_var*
//#UC END# *549413590379_53AC01CD0335_var*
begin
//#UC START# *549413590379_53AC01CD0335_impl*
 Result := False;
//#UC END# *549413590379_53AC01CD0335_impl*
end;//_evdTagHolder_.NeedSendRawDataAsBinary

{$EndIf evdTagHolder_imp_impl}

{$EndIf evdTagHolder_imp}

