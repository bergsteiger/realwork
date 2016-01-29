unit evCustomStyleManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evCustomStyleManager.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi::Everest::CustomStyleManager::TevCustomStyleManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  l3ProtoObject,
  l3Variant
  ;

(*
 MevCustomStyleManager = PureMixIn
  {* �������� ������� TevCustomStyleManager }
   function IsAbolishedDocumentLink(aSeg: Tl3Variant;
    const aPara: InevPara): Boolean;
   function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 end;//MevCustomStyleManager
*)

type
 IevCustomStyleManager = interface(IUnknown)
  {* ��������� ������� TevCustomStyleManager }
   ['{3E2B89CD-5B2D-400C-9EC9-FDA3B57A0C23}']
  // MevCustomStyleManager
   function IsAbolishedDocumentLink(aSeg: Tl3Variant;
    const aPara: InevPara): Boolean;
   function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 end;//IevCustomStyleManager

 TevCustomStyleManager = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : IevCustomStyleManager;
    {* ���� ��� �������� Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: IevCustomStyleManager);
 public
 // realized methods
   function IsAbolishedDocumentLink(aSeg: Tl3Variant;
     const aPara: InevPara): Boolean;
   function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // public properties
   property Alien: IevCustomStyleManager
     write pm_SetAlien;
     {* ������� ���������� ������� IevCustomStyleManager }
 public
 // singleton factory method
   class function Instance: TevCustomStyleManager;
    {- ���������� ��������� ����������. }
 end;//TevCustomStyleManager

implementation

uses
  l3Base {a}
  ;


// start class TevCustomStyleManager

var g_TevCustomStyleManager : TevCustomStyleManager = nil;

procedure TevCustomStyleManagerFree;
begin
 l3Free(g_TevCustomStyleManager);
end;

class function TevCustomStyleManager.Instance: TevCustomStyleManager;
begin
 if (g_TevCustomStyleManager = nil) then
 begin
  l3System.AddExitProc(TevCustomStyleManagerFree);
  g_TevCustomStyleManager := Create;
 end;
 Result := g_TevCustomStyleManager;
end;


procedure TevCustomStyleManager.pm_SetAlien(const aValue: IevCustomStyleManager);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TevCustomStyleManager.pm_SetAlien

class function TevCustomStyleManager.Exists: Boolean;
 {-}
begin
 Result := g_TevCustomStyleManager <> nil;
end;//TevCustomStyleManager.Exists

function TevCustomStyleManager.IsAbolishedDocumentLink(aSeg: Tl3Variant;
  const aPara: InevPara): Boolean;
//#UC START# *391A810FF759_53AABE1F0383_var*
//#UC END# *391A810FF759_53AABE1F0383_var*
begin
//#UC START# *391A810FF759_53AABE1F0383_impl*
 Result := Assigned(f_Alien) and f_Alien.IsAbolishedDocumentLink(aSeg, aPara);
//#UC END# *391A810FF759_53AABE1F0383_impl*
end;//TevCustomStyleManager.IsAbolishedDocumentLink

function TevCustomStyleManager.IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
//#UC START# *DC1A5D24B383_53AABE1F0383_var*
//#UC END# *DC1A5D24B383_53AABE1F0383_var*
begin
//#UC START# *DC1A5D24B383_53AABE1F0383_impl*
 Result := Assigned(f_Alien) and f_Alien.IsVisitedDocumentLink(aSeg);
//#UC END# *DC1A5D24B383_53AABE1F0383_impl*
end;//TevCustomStyleManager.IsVisitedDocumentLink

procedure TevCustomStyleManager.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//TevCustomStyleManager.ClearFields

end.