unit PreviewInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Model"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Model/PreviewInterfaces.pas"
// Начат: 10.02.2009 19:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Базовые определения предметной области::LegalDomain::Model::PreviewInterfaces
//
// Интерфейсы Preview
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  afwInterfaces
  ;

type
 TnsSuperPreviewKind = (
   ns_spkDocumentTitles // Названия документов
 , ns_spkDocumentTexts // Тексты документов
 );//TnsSuperPreviewKind

 InsSuperComplexDocumentPreview = interface(IafwComplexDocumentPreview)
  {* Суперкомлпексное превью для списка (текст списка и тексты документов) }
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
     {* Тип отображаемого элемента документа }
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