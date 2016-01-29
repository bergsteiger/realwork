unit m3LinkedStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3LinkedStream.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::Streams::Tm3LinkedStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3CustomStream
  ;

type
 Tm3LinkedStream = {abstract} class(Tm3CustomStream)
 protected
 // overridden protected methods
   procedure DoRead(aBuff: Pointer;
     aSize: Integer;
     var theResult: Integer;
     var theReturn: hResult); override;
   procedure DoWrite(aBuff: Pointer;
     aSize: Integer;
     var theResult: Integer;
     var theReturn: hResult); override;
   function DoGetLocksSupported: Integer; override;
   function DoGetName: WideString; override;
 end;//Tm3LinkedStream

implementation

uses
  ComObj,
  m2COMLib,
  ActiveX
  ;

// start class Tm3LinkedStream

procedure Tm3LinkedStream.DoRead(aBuff: Pointer;
  aSize: Integer;
  var theResult: Integer;
  var theReturn: hResult);
//#UC START# *4FA27CF501C4_53FF125B01D4_var*
//#UC END# *4FA27CF501C4_53FF125B01D4_var*
begin
//#UC START# *4FA27CF501C4_53FF125B01D4_impl*
 Assert(InnerStream <> nil);
 if SUCCEEDED(theReturn) then
  theReturn := InnerStream.Read(ABuff, ASize, @theResult);
//#UC END# *4FA27CF501C4_53FF125B01D4_impl*
end;//Tm3LinkedStream.DoRead

procedure Tm3LinkedStream.DoWrite(aBuff: Pointer;
  aSize: Integer;
  var theResult: Integer;
  var theReturn: hResult);
//#UC START# *4FA27D310344_53FF125B01D4_var*
//#UC END# *4FA27D310344_53FF125B01D4_var*
begin
//#UC START# *4FA27D310344_53FF125B01D4_impl*
 Assert(InnerStream <> nil);
 if SUCCEEDED(theReturn) then
  theReturn := InnerStream.Write(ABuff, ASize, @theResult);
//#UC END# *4FA27D310344_53FF125B01D4_impl*
end;//Tm3LinkedStream.DoWrite

function Tm3LinkedStream.DoGetLocksSupported: Integer;
//#UC START# *4FA2805002E3_53FF125B01D4_var*
//#UC END# *4FA2805002E3_53FF125B01D4_var*
begin
//#UC START# *4FA2805002E3_53FF125B01D4_impl*
 Assert(InnerStream <> nil);
 Result := m2COMGetStatStgLocks(InnerStream);
//#UC END# *4FA2805002E3_53FF125B01D4_impl*
end;//Tm3LinkedStream.DoGetLocksSupported

function Tm3LinkedStream.DoGetName: WideString;
//#UC START# *5412FB880320_53FF125B01D4_var*
//#UC END# *5412FB880320_53FF125B01D4_var*
begin
//#UC START# *5412FB880320_53FF125B01D4_impl*
 Assert(InnerStream <> nil);
 Result := m2COMGetStatStgName(InnerStream);
//#UC END# *5412FB880320_53FF125B01D4_impl*
end;//Tm3LinkedStream.DoGetName

end.