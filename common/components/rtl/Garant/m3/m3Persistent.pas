unit m3Persistent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3Persistent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3Persistent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  ActiveX,
  l3_String,
  l3ProtoObject
  ;

type
 Tm3Persistent = class(Tl3ProtoObject)
 protected
 // protected methods
   procedure LoadBuff(const aStream: IStream;
     aBuff: Pointer;
     aSize: Integer);
   procedure SaveBuff(const aStream: IStream;
     aBuff: Pointer;
     aSize: Integer);
   procedure LoadWideString(const aStream: IStream;
     aString: Tl3_String);
   procedure SaveWideString(const aStream: IStream;
     aString: Tl3_String);
 public
 // public methods
   procedure Load(const aStream: IStream); virtual; abstract;
   procedure Save(const aStream: IStream); virtual; abstract;
 end;//Tm3Persistent

implementation

uses
  l3Chars,
  m2COMLib
  ;

// start class Tm3Persistent

procedure Tm3Persistent.LoadBuff(const aStream: IStream;
  aBuff: Pointer;
  aSize: Integer);
//#UC START# *545384D7010A_5421799C0066_var*
//#UC END# *545384D7010A_5421799C0066_var*
begin
//#UC START# *545384D7010A_5421799C0066_impl*
 m2COMReadBuffer(AStream,ABuff^,ASize);
//#UC END# *545384D7010A_5421799C0066_impl*
end;//Tm3Persistent.LoadBuff

procedure Tm3Persistent.SaveBuff(const aStream: IStream;
  aBuff: Pointer;
  aSize: Integer);
//#UC START# *5453850B01B3_5421799C0066_var*
//#UC END# *5453850B01B3_5421799C0066_var*
begin
//#UC START# *5453850B01B3_5421799C0066_impl*
 m2COMWriteBuffer(AStream,ABuff^,ASize);
//#UC END# *5453850B01B3_5421799C0066_impl*
end;//Tm3Persistent.SaveBuff

procedure Tm3Persistent.LoadWideString(const aStream: IStream;
  aString: Tl3_String);
//#UC START# *5453853E01FD_5421799C0066_var*
var
 l_Size : LongInt;
//#UC END# *5453853E01FD_5421799C0066_var*
begin
//#UC START# *5453853E01FD_5421799C0066_impl*
 LoadBuff(aStream, @l_Size, SizeOf(l_Size));
 aString.CodePage := CP_Unicode;
 aString.Len := l_Size div SizeOf(WideChar);
 LoadBuff(aStream, PWideChar(aString.St), l_Size);
//#UC END# *5453853E01FD_5421799C0066_impl*
end;//Tm3Persistent.LoadWideString

procedure Tm3Persistent.SaveWideString(const aStream: IStream;
  aString: Tl3_String);
//#UC START# *5453856F0321_5421799C0066_var*
var
 l_Size : LongInt;
//#UC END# *5453856F0321_5421799C0066_var*
begin
//#UC START# *5453856F0321_5421799C0066_impl*
 aString.CodePage := CP_Unicode;
 l_Size := aString.Len * SizeOf(WideChar);
 SaveBuff(AStream, @l_Size, SizeOf(l_Size));
 SaveBuff(AStream, PWideChar(aString.St), l_Size);
//#UC END# *5453856F0321_5421799C0066_impl*
end;//Tm3Persistent.SaveWideString

end.