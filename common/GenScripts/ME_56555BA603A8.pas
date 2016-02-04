unit evSubCompareInterfaces;

// Модуль: "w:\common\components\gui\Garant\Everest\evSubCompareInterfaces.pas"
// Стереотип: "Interfaces"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
;

type
 TevSCAttrType = (
  sca_Class
  , sca_Type
  , sca_Link
  , sca_Keyword
 );//TevSCAttrType

 IevSCAttrElement = interface
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

 IevSCSub = interface
  ['{A18F81ED-02C6-4669-A68B-A51383DB7795}']
  function Get_Handle: Integer;
  procedure Set_Handle(aValue: Integer);
  function Get_AttrCount: Integer;
  function Get_SubType: TevSCSubType;
  procedure Set_SubType(aValue: TevSCSubType);
  function Get_Attr(aIdx: Integer): IevSCAttrElement;
  procedure Add(const aAttr: IevSCAttrElement);
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
 cSCAttrTypeName: array [TevSCAttrType] of AnsiString = ('класс'
 , 'тип'
 , 'ссылка'
 , 'ключевое слово'
 );
 cSCSubTypeName: array [TevSCSubType] of AnsiString = ('блок'
 , 'метка'
 );

implementation

uses
 l3ImplUses
;

end.
