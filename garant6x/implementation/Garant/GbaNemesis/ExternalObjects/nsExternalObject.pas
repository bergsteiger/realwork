unit nsExternalObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ExternalObjects"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/ExternalObjects/nsExternalObject.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::ExternalObjects::Implementation::TnsExternalObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsExternalObjectPrim
  ;

type
 TnsExternalObject = class(TnsExternalObjectPrim)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TnsExternalObject;
    {- ���������� ��������� ����������. }
 end;//TnsExternalObject

implementation

uses
  l3Base {a}
  ;


// start class TnsExternalObject

var g_TnsExternalObject : TnsExternalObject = nil;

procedure TnsExternalObjectFree;
begin
 l3Free(g_TnsExternalObject);
end;

class function TnsExternalObject.Instance: TnsExternalObject;
begin
 if (g_TnsExternalObject = nil) then
 begin
  l3System.AddExitProc(TnsExternalObjectFree);
  g_TnsExternalObject := Create;
 end;
 Result := g_TnsExternalObject;
end;


class function TnsExternalObject.Exists: Boolean;
 {-}
begin
 Result := g_TnsExternalObject <> nil;
end;//TnsExternalObject.Exists

end.