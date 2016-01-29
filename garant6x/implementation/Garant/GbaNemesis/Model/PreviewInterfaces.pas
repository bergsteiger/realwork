unit PreviewInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Model"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Model/PreviewInterfaces.pas"
// �����: 10.02.2009 19:51
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 ������� ����������� ���������� �������::LegalDomain::Model::PreviewInterfaces
//
// ���������� Preview
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  afwInterfaces
  ;

type
 TnsSuperPreviewKind = (
   ns_spkDocumentTitles // �������� ����������
 , ns_spkDocumentTexts // ������ ����������
 );//TnsSuperPreviewKind

 InsSuperComplexDocumentPreview = interface(IafwComplexDocumentPreview)
  {* ���������������� ������ ��� ������ (����� ������ � ������ ����������) }
   ['{56B10B20-9903-4541-842C-3918B413AA0C}']
   function pm_GetSuperContentKind: TnsSuperPreviewKind;
   procedure pm_SetSuperContentKind(aValue: TnsSuperPreviewKind);
   function Get_SuperCurrent: IafwComplexDocumentPreview;
   function Get_DocumentTitles: IafwComplexDocumentPreview;
   procedure Set_DocumentTitles(const aValue: IafwComplexDocumentPreview);
   function Get_DocumentTexts: IafwComplexDocumentPreview;
   procedure Set_DocumentTexts(const aValue: IafwComplexDocumentPreview);
   property SuperContentKind: TnsSuperPreviewKind
     read pm_GetSuperContentKind
     write pm_SetSuperContentKind;
     {* ��� ������������� �������� ��������� }
   property SuperCurrent: IafwComplexDocumentPreview
     read Get_SuperCurrent;
   property DocumentTitles: IafwComplexDocumentPreview
     read Get_DocumentTitles
     write Set_DocumentTitles;
   property DocumentTexts: IafwComplexDocumentPreview
     read Get_DocumentTexts
     write Set_DocumentTexts;
 end;//InsSuperComplexDocumentPreview

 InsTreeMultiDocumentPreviewContainer = interface(IUnknown)
   ['{BB02FDBA-2578-468E-84D4-B86944A6BBD1}']
   function Get_ApproxDocCount: Integer;
   procedure Prepare;
   property ApproxDocCount: Integer
     read Get_ApproxDocCount;
 end;//InsTreeMultiDocumentPreviewContainer

 InsTinyPreview = interface(IUnknown)
   ['{61EB5F1D-5DAC-4E88-BF48-476104E0EC6B}']
 end;//InsTinyPreview

implementation

end.