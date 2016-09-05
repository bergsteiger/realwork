unit mmmMainFeatures;
 {* �������� ����������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmMainFeatures.pas"
// ���������: "SimpleClass"
// ������� ������: "TmmmMainFeatures" MUID: (490C422B0022)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , mmmTree
 , l3Tree_TLB
;

type
 TmmmMainFeatures = class(TmmmTree)
  {* �������� ����������� }
  protected
   function MakeRoot: Il3RootNode; override;
    {* ������ ������ ������ }
 end;//TmmmMainFeatures
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , nsTypes
 , DynamicTreeUnit
 , nsConst
 , nsMainMenuNode
 //#UC START# *490C422B0022impl_uses*
 //#UC END# *490C422B0022impl_uses*
;

const
 {* ������������ ������ Main Features }
 str_PharmPublishSearch: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PharmPublishSearch'; rValue : '��� �� �������� � ���������������');
  {* '��� �� �������� � ���������������' }

function TmmmMainFeatures.MakeRoot: Il3RootNode;
 {* ������ ������ ������ }
//#UC START# *4909EF6E0361_490C422B0022_var*
//#UC END# *4909EF6E0361_490C422B0022_var*
begin
//#UC START# *4909EF6E0361_490C422B0022_impl*
 Result := inherited MakeRoot;

 nsAddMainMenuDocumentItem(Result,
                           Ord(ns_mntDocument),
                           [52390027, 52390002]); // ���������� ��� ������������� � �������, ��������� � ������� ����������� ������
 nsAddMainMenuItem(Result,
                   Ord(ns_mntPublishSource),
                   str_PharmPublishSearch.AsCStr);
 nsAddMainMenuDocumentItem(Result,
                           Ord(ns_mntDocument),
                           [52390028]); // ���������� �������� ���������
//#UC END# *4909EF6E0361_490C422B0022_impl*
end;//TmmmMainFeatures.MakeRoot

initialization
 str_PharmPublishSearch.Init;
 {* ������������� str_PharmPublishSearch }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
