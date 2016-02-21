unit L10nInterfaces;
 {* Интерфейсы для локализации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Model\L10nInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , afwInterfaces
 , l3Interfaces
;

type
 InsStringValueMap = IafwStringValueMap;

 InsSpecialStringValueMap = interface(InsStringValueMap)
  {* мапа "<число> %"-"строковое число" со строковым спец значением "Во весь экран" }
  ['{808A21E0-63EB-4659-AA60-9D0CB1EF937E}']
  function Get_SpecialDisplayName: Il3CString;
  function Get_SpecialValue: Il3CString;
  function Get_MinValue: Integer;
  function Get_MaxValue: Integer;
  property SpecialDisplayName: Il3CString
   read Get_SpecialDisplayName;
  property SpecialValue: Il3CString
   read Get_SpecialValue;
  property MinValue: Integer
   read Get_MinValue;
  property MaxValue: Integer
   read Get_MaxValue;
 end;//InsSpecialStringValueMap

 InsStringsSource = IafwStringsSource;

 TnsValueMapID = TafwValueMapID;

 InsValueMap = IafwValueMap;

 InsStringValueMapFactory = IafwStringValueMapFactory;

 InsStringValueMapManager = IafwStringValueMapManager;

 InsIntegerValueMap = IafwIntegerValueMap;

 InsIntegerValueMapFactory = IafwIntegerValueMapFactory;

 InsIntegerValueMapManager = IafwIntegerValueMapManager;

implementation

uses
 l3ImplUses
;

end.
