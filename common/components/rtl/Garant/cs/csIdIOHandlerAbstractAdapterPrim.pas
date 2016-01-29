unit csIdIOHandlerAbstractAdapterPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csIdIOHandlerAbstractAdapterPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Core::TcsIdIOHandlerAbstractAdapterPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  Classes,
  CsObject
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsIdIOHandlerAbstractAdapterPrim = {abstract} class(TCsObject)
 public
 // public methods
   procedure WriteBufferFlush; virtual; abstract;
   function ReadChar: AnsiChar; virtual; abstract;
   function ReadCardinal: Cardinal; virtual; abstract;
   function ReadDateTime: TDateTime; virtual; abstract;
   function ReadLn: AnsiString; virtual; abstract;
   function ReadInt64: Int64; virtual; abstract;
   procedure ReadStream(aStream: TStream;
     aSize: Int64 = -1); virtual; abstract;
   function ReadInteger: Integer; virtual; abstract;
   function ReadSmallInt: SmallInt; virtual; abstract;
   procedure WriteLn(const aString: AnsiString); virtual; abstract;
   procedure WriteCardinal(aValue: Cardinal); virtual; abstract;
   procedure WriteInt64(aValue: Int64); virtual; abstract;
   procedure WriteStream(aStream: TStream;
     aByteCount: Int64 = 0); virtual; abstract;
   procedure WriteChar(aValue: AnsiChar); virtual; abstract;
   procedure WriteSmallInt(aValue: SmallInt); virtual; abstract;
   procedure WriteInteger(aValue: Integer); virtual; abstract;
   procedure WriteDateTime(aValue: TDateTime); virtual; abstract;
   function WaitForReadData(aTimeout: Integer): Boolean; virtual; abstract;
   procedure WriteLargeStr(const aString: AnsiString); virtual; abstract;
   function ReadLargeStr: AnsiString; virtual; abstract;
 end;//TcsIdIOHandlerAbstractAdapterPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}


{$IfEnd} //not Nemesis
end.