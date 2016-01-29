unit k2ToolPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/k2ToolPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2ToolPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Tag,
  l3Variant
  ;

type
 Tk2ToolPrim = {abstract} class(Tk2Tag, IUnknown)
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
   procedure AfterFree; override;
     {* �������, ���������� ����� ������� ���������� �������� ������ �� ������, �� ����������� � ����������� ������� }
 public
 // public methods
   procedure Assign(Source: Tk2ToolPrim); virtual;
   class function StoreToOldCache: Boolean; virtual;
   procedure SetTagQT(aTag: Tl3Variant); virtual; abstract;
 end;//Tk2ToolPrim

implementation

// start class Tk2ToolPrim

procedure Tk2ToolPrim.Assign(Source: Tk2ToolPrim);
//#UC START# *52BC1DD60298_47F5DAEB0007_var*
//#UC END# *52BC1DD60298_47F5DAEB0007_var*
begin
//#UC START# *52BC1DD60298_47F5DAEB0007_impl*
 Assert(false, '����� Assign ��� ������ �����?');
//#UC END# *52BC1DD60298_47F5DAEB0007_impl*
end;//Tk2ToolPrim.Assign

class function Tk2ToolPrim.StoreToOldCache: Boolean;
//#UC START# *49DF4E12001A_47F5DAEB0007_var*
//#UC END# *49DF4E12001A_47F5DAEB0007_var*
begin
//#UC START# *49DF4E12001A_47F5DAEB0007_impl*
 Result := false;
//#UC END# *49DF4E12001A_47F5DAEB0007_impl*
end;//Tk2ToolPrim.StoreToOldCache

{$If not defined(DesignTimeLibrary)}
class function Tk2ToolPrim.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_47F5DAEB0007_var*
//#UC END# *47A6FEE600FC_47F5DAEB0007_var*
begin
//#UC START# *47A6FEE600FC_47F5DAEB0007_impl*
 Result := not StoreToOldCache;
//#UC END# *47A6FEE600FC_47F5DAEB0007_impl*
end;//Tk2ToolPrim.IsCacheable
{$IfEnd} //not DesignTimeLibrary

procedure Tk2ToolPrim.AfterFree;
//#UC START# *531EEB8503AE_47F5DAEB0007_var*
//#UC END# *531EEB8503AE_47F5DAEB0007_var*
begin
//#UC START# *531EEB8503AE_47F5DAEB0007_impl*
 inherited;
 if (RefCount <= 1) AND StoreToOldCache then
  Cleanup;
//#UC END# *531EEB8503AE_47F5DAEB0007_impl*
end;//Tk2ToolPrim.AfterFree

end.