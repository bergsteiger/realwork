unit evStreamedDataObject;

// ������: "w:\common\components\gui\Garant\Everest\evStreamedDataObject.pas"
// ���������: "SimpleClass"
// ������� ������: "TevStreamedDataObject" MUID: (48EA32DB03E6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , nevTools
 , nevBase
 , evdInterfaces
;

type
 TevStreamedDataObject = class(Tl3CacheableBase, InevStorable)
  protected
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); virtual; abstract;
    {* ��������� ����� � G }
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evDefaultStoreFlags); overload;
    {* ��������� ��������� � G. }
 end;//TevStreamedDataObject

implementation

uses
 l3ImplUses
;

procedure TevStreamedDataObject.Store(const aView: InevView;
 const G: InevTagGenerator;
 aFlags: TevdStoreFlags = evDefaultStoreFlags);
 {* ��������� ��������� � G. }
//#UC START# *47C68BFD011C_48EA32DB03E6_var*
//#UC END# *47C68BFD011C_48EA32DB03E6_var*
begin
//#UC START# *47C68BFD011C_48EA32DB03E6_impl*
 DoStore(G, aFlags);
//#UC END# *47C68BFD011C_48EA32DB03E6_impl*
end;//TevStreamedDataObject.Store

end.
