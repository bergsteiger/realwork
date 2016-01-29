unit NOT_FINISHED_l3Memory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Memory.pas"
// �����: 20.10.1998 17:24
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3Memory
//
// �������, ������ � ������� ��� ������ � �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3BaseStream,
  l3ProtoObject,
  l3ProtoDataContainerWithCOMQI
  ;

type
 Tl3Ptr = record
  {* Smart-��������� �� ������. }
 end;//Tl3Ptr

 Tl3CustomMemoryStream = class(Tl3Stream)
 end;//Tl3CustomMemoryStream

 Tl3MemoryStream = class(Tl3CustomMemoryStream)
 end;//Tl3MemoryStream

 Tl3MemoryPoolAdapter = class(Tl3ProtoObject)
 end;//Tl3MemoryPoolAdapter

 Rl3MemoryPoolAdapter = class of Tl3MemoryPoolAdapter;

 Tl3ConstMemoryStream = class(Tl3CustomMemoryStream)
  {* ����������� ����� � ������ (��� ����������������� ������) }
 end;//Tl3ConstMemoryStream

 Tl3HMemoryStream = class(Tl3ConstMemoryStream)
  {* ����������� ����� � ���������� ������ (��� ����������������� ������) }
 end;//Tl3HMemoryStream

 Tl3HPCharStream = class(Tl3HMemoryStream)
  {* ����������� ����� � ���������� ������ �������������� ����� (#0) }
 end;//Tl3HPCharStream

 Tl3HPWideCharStream = class(Tl3HMemoryStream)
  {* ����������� ����� � ���������� ������ �������������� ����� (#0) � ��������� Unicode }
 end;//Tl3HPWideCharStream

 Tl3StringStream = class(Tl3CustomMemoryStream)
 end;//Tl3StringStream

 Tl3IStreamAdapter = class(Tl3Stream)
 end;//Tl3IStreamAdapter

 Rl3MemoryStream = class of Tl3MemoryStream;

 Tl3MemoryPoolPrim = class(Tl3ProtoDataContainerWithCOMQI)
 protected
 // protected methods
   function GetMemoryPoolAdapterClass: Rl3MemoryPoolAdapter; virtual;
   function GetMemoryStreamClass: Rl3MemoryStream; virtual;
 end;//Tl3MemoryPoolPrim

 Tl3MemoryPool = class(Tl3MemoryPoolPrim)
 end;//Tl3MemoryPool

 Tl3SizedMemoryPool = class(Tl3MemoryPool)
 end;//Tl3SizedMemoryPool

 Tl3MemoryChain = record
 end;//Tl3MemoryChain

 Pl3MemoryChain = ^Tl3MemoryChain;

 Tl3BufferStreamMemoryPool = class(Tl3MemoryPoolPrim)
 end;//Tl3BufferStreamMemoryPool

implementation

// start class Tl3MemoryPoolPrim

function Tl3MemoryPoolPrim.GetMemoryPoolAdapterClass: Rl3MemoryPoolAdapter;
//#UC START# *530B3ADB014E_53076BFC02F2_var*
//#UC END# *530B3ADB014E_53076BFC02F2_var*
begin
//#UC START# *530B3ADB014E_53076BFC02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *530B3ADB014E_53076BFC02F2_impl*
end;//Tl3MemoryPoolPrim.GetMemoryPoolAdapterClass

function Tl3MemoryPoolPrim.GetMemoryStreamClass: Rl3MemoryStream;
//#UC START# *530B3F560201_53076BFC02F2_var*
//#UC END# *530B3F560201_53076BFC02F2_var*
begin
//#UC START# *530B3F560201_53076BFC02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *530B3F560201_53076BFC02F2_impl*
end;//Tl3MemoryPoolPrim.GetMemoryStreamClass
end.