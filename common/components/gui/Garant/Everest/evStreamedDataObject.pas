unit evStreamedDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evStreamedDataObject.pas"
// �����: 16.12.2004 14:32
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevStreamedDataObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3CacheableBase,
  nevBase,
  nevTools,
  evdInterfaces
  ;

type
 TevStreamedDataObject = class(Tl3CacheableBase, InevStorable)
 protected
 // realized methods
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evDefaultStoreFlags); overload; 
     {* ��������� ��������� � G. }
 protected
 // protected methods
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); virtual; abstract;
     {* ��������� ����� � G }
 end;//TevStreamedDataObject

implementation

// start class TevStreamedDataObject

procedure TevStreamedDataObject.Store(const aView: InevView;
  const G: InevTagGenerator;
  aFlags: TevdStoreFlags = evDefaultStoreFlags);
//#UC START# *47C68BFD011C_48EA32DB03E6_var*
//#UC END# *47C68BFD011C_48EA32DB03E6_var*
begin
//#UC START# *47C68BFD011C_48EA32DB03E6_impl*
 DoStore(G, aFlags);
//#UC END# *47C68BFD011C_48EA32DB03E6_impl*
end;//TevStreamedDataObject.Store

end.