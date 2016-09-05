unit dsChronology;
 {* ���������� ��������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsChronology.pas"
// ���������: "ViewAreaControllerImp"
// ������� ������: "TdsChronology" MUID: (53BFEDC40225)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsChildDocument
 , afwInterfaces
 , nevTools
 , l3Interfaces
;

type
 TdsChronology = class(TdsChildDocument)
  {* ���������� ��������� ���� }
  protected
   function DoGet_PreviewCaleeArea: TafwPreviewCaleeArea; override;
   function MakeContainer: InevDocumentContainer; override;
    {* ������������ ��������� ��������� }
   function DoGetDocumentShortName: Il3CString; override;
 end;//TdsChronology
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , nsChronologyDocumentContainer
 , l3String
 , IOUnit
 //#UC START# *53BFEDC40225impl_uses*
 //#UC END# *53BFEDC40225impl_uses*
;

const
 {* ������������ ������ Chronology Local Const }
 str_OldDocumentNamePrefix: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OldDocumentNamePrefix'; rValue : '������� �');
  {* '������� �' }
 str_NewDocumentNamePrefix: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NewDocumentNamePrefix'; rValue : '���������� ��������� ����');
  {* '���������� ��������� ����' }

function TdsChronology.DoGet_PreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *49589999029F_53BFEDC40225_var*
//#UC END# *49589999029F_53BFEDC40225_var*
begin
//#UC START# *49589999029F_53BFEDC40225_impl*
 Result := afw_pcaChronology;
//#UC END# *49589999029F_53BFEDC40225_impl*
end;//TdsChronology.DoGet_PreviewCaleeArea

function TdsChronology.MakeContainer: InevDocumentContainer;
 {* ������������ ��������� ��������� }
//#UC START# *4C6AB38800F3_53BFEDC40225_var*
//#UC END# *4C6AB38800F3_53BFEDC40225_var*
begin
//#UC START# *4C6AB38800F3_53BFEDC40225_impl*
 Result := TnsChronologyDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_53BFEDC40225_impl*
end;//TdsChronology.MakeContainer

function TdsChronology.DoGetDocumentShortName: Il3CString;
//#UC START# *53D8E620037C_53BFEDC40225_var*
//#UC END# *53D8E620037C_53BFEDC40225_var*
begin
//#UC START# *53D8E620037C_53BFEDC40225_impl*
 Result := inherited DoGetDocumentShortName;
 if not l3IsNil(Result) then
  Result := l3StringReplace(Result, str_OldDocumentNamePrefix.AsWStr, str_NewDocumentNamePrefix.AsWStr, []);
//#UC END# *53D8E620037C_53BFEDC40225_impl*
end;//TdsChronology.DoGetDocumentShortName

initialization
 str_OldDocumentNamePrefix.Init;
 {* ������������� str_OldDocumentNamePrefix }
 str_NewDocumentNamePrefix.Init;
 {* ������������� str_NewDocumentNamePrefix }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
