unit evSubCompareInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evSubCompareInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Everest::evSubCompareInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

type
 TevSCAttrType = (
   sca_Class
 , sca_Type
 , sca_Link
 , sca_Keyword
 );//TevSCAttrType

 IevSCAttrElement = interface(IUnknown)
   ['{9AFC7D71-5025-4849-8A85-3F5C37BD246E}']
   function Get_AttrType: TevSCAttrType;
   function Get_ID: Integer;
   function Get_SubID: Integer;
   property AttrType: TevSCAttrType
     read Get_AttrType;
   property ID: Integer
     read Get_ID;
   property SubID: Integer
     read Get_SubID;
 end;//IevSCAttrElement

 TevSCSubType = (
   sct_Block
 , sct_Label
 );//TevSCSubType

 IevSCSub = interface(IUnknown)
   ['{A18F81ED-02C6-4669-A68B-A51383DB7795}']
   procedure Add(const aAttr: IevSCAttrElement);
   function Get_Handle: Integer;
   procedure Set_Handle(aValue: Integer);
   function Get_AttrCount: Integer;
   function Get_SubType: TevSCSubType;
   procedure Set_SubType(aValue: TevSCSubType);
   function Get_Attr(aIdx: Integer): IevSCAttrElement;
   property Handle: Integer
     read Get_Handle
     write Set_Handle;
   property AttrCount: Integer
     read Get_AttrCount;
   property SubType: TevSCSubType
     read Get_SubType
     write Set_SubType;
   property Attr[aIdx: Integer]: IevSCAttrElement
     read Get_Attr;
 end;//IevSCSub

const
  { cSCAttrTypeName }
 cSCAttrTypeName : array [TevSCAttrType] of AnsiString = (
  'класс'
  , 'тип'
  , 'ссылка'
  , 'ключевое слово'
 );//cSCAttrTypeName
  { cSCSubTypeName }
 cSCSubTypeName : array [TevSCSubType] of AnsiString = (
  'блок'
  , 'метка'
 );//cSCSubTypeName

implementation

end.