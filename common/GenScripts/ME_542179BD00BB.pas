{$IfNDef m3PersistentList_imp}

// Модуль: "w:\common\components\rtl\Garant\m3\m3PersistentList.imp.pas"
// Стереотип: "Impurity"

{$Define m3PersistentList_imp}

 {$Include m3ListWithFind.imp.pas}
 _m3PersistentList_ = class(_m3ListWithFind_)
  public
   procedure LoadFromStream(const aStream: IStream;
    aPosition: Int64);
   function SaveToStream(const aStream: IStream): Int64;
 end;//_m3PersistentList_

{$Else m3PersistentList_imp}

{$IfNDef m3PersistentList_imp_impl}

{$Define m3PersistentList_imp_impl}

type _Instance_R_ = _m3PersistentList_;

{$Include m3ListWithFind.imp.pas}

procedure _m3PersistentList_.LoadFromStream(const aStream: IStream;
 aPosition: Int64);
//#UC START# *54538D8402D6_542179BD00BB_var*

 procedure __LoadFromStream(const AStream: IStream);

  function __Forward(const AItemPtr: PItemType;
                     const AIndex: LongInt): Boolean;
  begin//__Forward
   Result := true;
   AItemPtr^.Load(aStream);
  end;//__Forward

 var
  LCount    : LongInt;
  LItemsCRC : LongInt;
 begin//__LoadFromStream
  if (AStream.Read(@LCount, SizeOf(LCount), nil) = S_False) then
   Exit;
  if (LCount < 0) then
  // - это костыль к битым данным из Адыгеи
  //   Может быть -1 это тоже неплохо, но надо понять - откуда он там взялся
   Count := 0
  else
   Count := LCount;
  IterateAllF(l3L2IA(@__Forward));
  try
   m2COMReadBuffer(AStream, LItemsCRC, SizeOf(LItemsCRC));
  except
   // - тут список deleted в Лукойле почему-то не читается
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    //Self.Clear;
   end;//on E: Exception
  end;//try..except
 end;//__LoadFromStream

//#UC END# *54538D8402D6_542179BD00BB_var*
begin
//#UC START# *54538D8402D6_542179BD00BB_impl*
 Clear;
 if (APosition <> Int64(-1)) then
 begin
  m2COMSetPosition(APosition,AStream);
  __LoadFromStream(Tm3BuffStream.Make(AStream));
 end;//APosition <> Int64(-1)
//#UC END# *54538D8402D6_542179BD00BB_impl*
end;//_m3PersistentList_.LoadFromStream

function _m3PersistentList_.SaveToStream(const aStream: IStream): Int64;
//#UC START# *54538DB3032A_542179BD00BB_var*

 procedure __SaveToStream(const aStream: IStream);

  function __Forward(aItemPtr: PItemType; aIndex: LongInt): Boolean;
  begin//__Forward
   Result := true;
   aItemPtr^.Save(aStream);
  end;//__Forward

 var
  LCount    : LongInt;
  LItemsCRC : LongInt;
 begin//__SaveToStream
  LCount := Count;
  m2COMWriteBuffer(AStream, LCount, SizeOf(LCount));
  IterateAllF(l3L2IA(@__Forward));
  LItemsCRC := 0;
  m2COMWriteBuffer(AStream, LItemsCRC, SizeOf(LItemsCRC));
 end;//__SaveToStream

//#UC END# *54538DB3032A_542179BD00BB_var*
begin
//#UC START# *54538DB3032A_542179BD00BB_impl*
 if (Count = 0) then
  Result := Int64(-1)
 else
 begin
  Result := m2COMGetPosition(AStream);
  __SaveToStream(Tm3BuffStream.Make(AStream));
 end;//Count = 0
 m2COMTruncate(AStream);
//#UC END# *54538DB3032A_542179BD00BB_impl*
end;//_m3PersistentList_.SaveToStream

{$EndIf m3PersistentList_imp_impl}

{$EndIf m3PersistentList_imp}

