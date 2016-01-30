unit m3LinkedStream;

// Модуль: "w:\common\components\rtl\Garant\m3\m3LinkedStream.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3CustomStream
;

type
 Tm3LinkedStream = {abstract} class(Tm3CustomStream)
  protected
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
 l3ImplUses
 , ComObj
 , m2COMLib
 , ActiveX
;

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
