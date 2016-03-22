{$IfNDef m3CustomHeaderStream_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3CustomHeaderStream.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::m3::HeaderStream::m3CustomHeaderStream
//
// Поток с заголовком-идентификатором
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define m3CustomHeaderStream_imp}
 _m3HeaderIDSupplier_Parent_ = Tm3BaseHeaderStream;
 {$Include ..\m3\m3HeaderIDSupplier.imp.pas}
 _m3CustomHeaderStream_ = {mixin} class(_m3HeaderIDSupplier_)
  {* Поток с заголовком-идентификатором }
 private
 // private fields
   HeaderDataCompare : _HeaderType_;
 protected
 // realized methods
   procedure DoLoadHeader; override;
     {* загружает заголовок в память }
   procedure DoSaveHeader(aForceSave: Boolean); override;
     {* сохраняет заголовок }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public fields
   HeaderData : _HeaderType_;
 protected
 // protected methods
   class function NeedHeaderAlignment: Boolean; virtual;
 public
 // public methods
   constructor Create(const aStream: IStream;
     aAccess: Integer); reintroduce;
   class function DefaultHeaderValue: _HeaderType_; virtual; abstract;
 end;//_m3CustomHeaderStream_

{$Else m3CustomHeaderStream_imp}

{$Include ..\m3\m3HeaderIDSupplier.imp.pas}

// start class _m3CustomHeaderStream_

constructor _m3CustomHeaderStream_.Create(const aStream: IStream;
  aAccess: Integer);
//#UC START# *53FF2351033E_53FDCEC40006_var*

 procedure AutoCreateHeader;
 begin//AutoCreateHeader
  {$IFDEF _m3AUTOCREATEHEADER1}
  if (InnerStream <> nil) then
  begin
   LockHeader;
   try
    if (m2COMGetSize(InnerStream) = 0) then
    begin
     Assert(m2COMCheckAccess(m2COMModeAccess(m2COMGetStatStgMode(InnerStream)), STGM_WRITE));
     FHeaderLoaded:=1;
     SaveHeader(True);
    end;//m2COMGetSize(_Stream) = 0
   finally
    UnlockHeader;
   end;//try..finally
  end;//_Stream <> nil
  {$ENDIF}
 end;//AutoCreateHeader
                                         
//#UC END# *53FF2351033E_53FDCEC40006_var*
begin
//#UC START# *53FF2351033E_53FDCEC40006_impl*
 if NeedHeaderAlignment then
  FHeaderSize := CAnyGUIDLength + SizeOf(LongInt) + SizeOf(Integer) + cHeaderFullSize
 else
  FHeaderSize := CAnyGUIDLength + SizeOf(HeaderData);
 inherited Create(aStream, aAccess);
 HeaderData := DefaultHeaderValue;
 HeaderDataCompare := HeaderData;
 if not Self.ReadOnly then
  AutoCreateHeader;
 DefaultInitAction;
 if (InnerStream <> nil) then
  if (m2COMGetStatStgMode(InnerStream) AND STGM_WRITE = 0) then
   m2COMSetPosition(Int64(FHeaderSize), InnerStream);
//#UC END# *53FF2351033E_53FDCEC40006_impl*
end;//_m3CustomHeaderStream_.Create

class function _m3CustomHeaderStream_.NeedHeaderAlignment: Boolean;
//#UC START# *5408826C0072_53FDCEC40006_var*
//#UC END# *5408826C0072_53FDCEC40006_var*
begin
//#UC START# *5408826C0072_53FDCEC40006_impl*
 Result := true;
//#UC END# *5408826C0072_53FDCEC40006_impl*
end;//_m3CustomHeaderStream_.NeedHeaderAlignment

procedure _m3CustomHeaderStream_.DoLoadHeader;
//#UC START# *53FDFDD90071_53FDCEC40006_var*
var
 LBodyCRC        : LongInt;
 LHeaderID       : AnsiString;
 LHeaderFullSize : LongInt;
 LPosition       : Int64;
 l_AlignBytes    : array [1..cHeaderFullSize - SizeOf(HeaderData)] of AnsiChar;
//#UC END# *53FDFDD90071_53FDCEC40006_var*
begin
//#UC START# *53FDFDD90071_53FDCEC40006_impl*
 LPosition := m2COMGetPosition(InnerStream);
 try
  m2COMSetPosition(0, InnerStream);

  m2COMCLSIDFromStream(InnerStream, LHeaderID);
  m2CheckValue(LHeaderID = GUIDToString(HeaderID));

  if NeedHeaderAlignment then
  begin
   m2COMReadBuffer(InnerStream, LBodyCRC, SizeOf(LBodyCRC));

   m2COMReadBuffer(InnerStream, LHeaderFullSize, SizeOf(LHeaderFullSize));
   m2CheckValue(LHeaderFullSize = cHeaderFullSize);

   m2COMReadBuffer(InnerStream, HeaderData, SizeOf(HeaderData));
   m2COMReadBuffer(InnerStream, l_AlignBytes, SizeOf(l_AlignBytes));
  end//NeedHeaderAligment
  else
   m2COMReadBuffer(InnerStream, HeaderData, SizeOf(HeaderData));
  Assert(m2COMGetPosition(InnerStream) = FHeaderSize);
 finally
  m2COMSetPosition(LPosition, InnerStream);
 end;//try..finally
 HeaderDataCompare := HeaderData;
//#UC END# *53FDFDD90071_53FDCEC40006_impl*
end;//_m3CustomHeaderStream_.DoLoadHeader

procedure _m3CustomHeaderStream_.DoSaveHeader(aForceSave: Boolean);
//#UC START# *53FDFDF503CE_53FDCEC40006_var*
var
 LBodyCRC  : LongInt;
 LPosition : Int64;
 l_Fake    : Int64;
 LHeaderFullSize : LongInt;
 l_AlignBytes    : array [1..cHeaderFullSize - SizeOf(HeaderData)] of AnsiChar;
//#UC END# *53FDFDF503CE_53FDCEC40006_var*
begin
//#UC START# *53FDFDF503CE_53FDCEC40006_impl*
 if aForceSave or
    (m2MEMCompare(@HeaderData, @HeaderDataCompare, SizeOf(HeaderData)) <> 0) then
 begin
  HeaderDataCompare := HeaderData;
  LPosition := m2COMGetPosition(InnerStream);
  try
   LBodyCRC := 0;
   if aForceSave then
   begin
    if l3IFail(InnerStream.Seek(0, STREAM_SEEK_SET, l_Fake)) then
     Exit;
    m2COMCLSIDToStream(InnerStream, GUIDToString(HeaderID));
   end//AForcedSave
   else
   if l3IFail(InnerStream.Seek(CAnyGUIDLength, STREAM_SEEK_SET, l_Fake)) then
    Exit;
   if NeedHeaderAlignment then
   begin
    m2COMWriteBuffer(InnerStream, LBodyCRC, SizeOf(LBodyCRC));
    LHeaderFullSize := cHeaderFullSize;
    m2COMWriteBuffer(InnerStream, LHeaderFullSize, SizeOf(LHeaderFullSize));
    m2COMWriteBuffer(InnerStream, HeaderData, SizeOf(HeaderData));
    l3FillChar(l_AlignBytes, SizeOf(l_AlignBytes));
    m2COMWriteBuffer(InnerStream, l_AlignBytes, SizeOf(l_AlignBytes));
   end//NeedHeaderAligment
   else
    m2COMWriteBuffer(InnerStream, HeaderData, SizeOf(HeaderData));
   Assert(m2COMGetPosition(InnerStream) = FHeaderSize);
  finally
   InnerStream.Seek(lPosition, STREAM_SEEK_SET, l_Fake);
  end;//try..finally
 end;//AForcedSave..
//#UC END# *53FDFDF503CE_53FDCEC40006_impl*
end;//_m3CustomHeaderStream_.DoSaveHeader

procedure _m3CustomHeaderStream_.Cleanup;
//#UC START# *479731C50290_53FDCEC40006_var*
//#UC END# *479731C50290_53FDCEC40006_var*
begin
//#UC START# *479731C50290_53FDCEC40006_impl*
 try
  DefaultDoneAction;
 finally
  inherited;
 end;//try..finally 
//#UC END# *479731C50290_53FDCEC40006_impl*
end;//_m3CustomHeaderStream_.Cleanup

{$EndIf m3CustomHeaderStream_imp}
