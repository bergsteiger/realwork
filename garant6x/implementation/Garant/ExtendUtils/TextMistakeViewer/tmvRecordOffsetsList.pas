unit tmvRecordOffsetsList;

interface

// <no_string>

uses
  l3Interfaces,
  l3Base,
  l3SimpleDataContainer,
  l3Types,
  l3Core,
  l3Memory,

  tmvInterfaces
  ;

type
  _ItemType_ = ItmvRecordOffsets;
  _l3InterfaceRefList_Parent_ = Tl3SimpleDataContainer;
  {$Include l3InterfaceRefList.imp.pas}
  TtmvRecordOffsetsList = class(_l3InterfaceRefList_);

implementation

uses
  SysUtils,
  Classes,
  RTLConsts,

  l3Except,
  l3MinMax
  ;

type _l3InterfaceRefList_R_ = TtmvRecordOffsetsList;

{$Include l3InterfaceRefList.imp.pas}

end.
