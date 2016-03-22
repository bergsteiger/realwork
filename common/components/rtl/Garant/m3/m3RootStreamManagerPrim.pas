unit m3RootStreamManagerPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3"
// ������: "w:/common/components/rtl/Garant/m3/m3RootStreamManagerPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::m3CoreObjects::Tm3RootStreamManagerPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3StoreHeaderDataPrim,
  m3RootStreamManagerPrimPrim
  ;

type
 Tm3RootStreamManagerPrim = {abstract} class(Tm3RootStreamManagerPrimPrim)
 protected
 // property methods
   function pm_GetRootStorageFATElement: Int64; virtual; abstract;
 public
 // public methods
   function StoreHeaderDataClass: Rm3StoreHeaderDataPrim; virtual; abstract;
   procedure RemoveFATElementAtPos(aPosition: Int64); virtual; abstract;
   function AllocNewFATElement: Int64; virtual; abstract;
   function ReadOnly: Boolean; virtual; abstract;
 public
 // public properties
   property RootStorageFATElement: Int64
     read pm_GetRootStorageFATElement;
 end;//Tm3RootStreamManagerPrim

implementation

uses
  m3Exceptions,
  SysUtils
  ;

end.