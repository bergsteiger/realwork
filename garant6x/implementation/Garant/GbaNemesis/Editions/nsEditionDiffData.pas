unit nsEditionDiffData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Editions"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/nsEditionDiffData.pas"
// �����: 10.08.2009 12:19
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������������� �������::CompareEditions::Editions::Editions::TnsEditionDiffData
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  eeInterfaces,
  EditionsInterfaces,
  nsCompareEditionsInfoPrim
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsEditionDiffData = class(TnsCompareEditionsInfoPrim, InsEditionDiffData)
 public
 // public methods
   class function Make(const aDoc: IDocument;
     const aPara: IeeLeafPara;
     const aDocumentForReturn: TnsDocumentForReturnInfo): InsEditionDiffData; reintroduce;
     {* ��������� ������� TnsEditionDiffData.Make }
 end;//TnsEditionDiffData
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsEditionDiffData

class function TnsEditionDiffData.Make(const aDoc: IDocument;
  const aPara: IeeLeafPara;
  const aDocumentForReturn: TnsDocumentForReturnInfo): InsEditionDiffData;
var
 l_Inst : TnsEditionDiffData;
begin
 l_Inst := Create(aDoc, aPara, aDocumentForReturn);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

{$IfEnd} //not Admin AND not Monitorings

end.