{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.HTTPSOAPToPasBind;

interface

uses System.TypInfo;

type
   IHTTPSOAPToPasBind = interface
   ['{FDA9957E-F8A1-4E46-9107-9DB7E90E0DBE}']
{$IFDEF NEXTGEN}
     function BindToPascalByAction(const Action: string; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: string): Boolean;
     function BindToPascalByPath(const Path: string; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: string): Boolean;
{$ELSE !NEXTGEN}
     function BindToPascalByAction(const Action: AnsiString; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: string): Boolean;
     function BindToPascalByPath(const Path: AnsiString; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: string): Boolean;
{$ENDIF NEXTGEN}
   end;

   THTTPSOAPToPasBind = class(TInterfacedObject, IHTTPSOAPToPasBind)
   public
{$IFDEF NEXTGEN}
     function BindToPascalByAction(const Action: string; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: string): Boolean; virtual;
     function BindToPascalByPath(const Path: string; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: string): Boolean; virtual;
{$ELSE !NEXTGEN}
     function BindToPascalByAction(const Action: AnsiString; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: string): Boolean; virtual;
     function BindToPascalByPath(const Path: AnsiString; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: String): Boolean; virtual;
{$ENDIF NEXTGEN}
   end;

implementation

uses Soap.InvokeRegistry;

{$IFDEF NEXTGEN}
function THTTPSOAPToPasBind.BindToPascalByAction(const Action: string; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: string): Boolean;
{$ELSE !NEXTGEN}
function THTTPSOAPToPasBind.BindToPascalByAction(const Action: AnsiString; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: string): Boolean;
{$ENDIF NEXTGEN}
begin
  Result := InvRegistry.GetInfoForURI('', string(Action), AClass, IntfInfo, AMeth);
end;

{$IFDEF NEXTGEN}
function THTTPSOAPToPasBind.BindToPascalByPath(const Path: string;
  var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: String): Boolean;
{$ELSE !NEXTGEN}
function THTTPSOAPToPasBind.BindToPascalByPath(const Path: AnsiString;
  var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: String): Boolean;
{$ENDIF NEXTGEN}
begin
  Result := InvRegistry.GetInfoForURI(string(Path), '', AClass, IntfInfo, AMeth);
end;

end.
