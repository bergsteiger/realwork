unit ddProgressTypes;

{$I ddDefine.inc }

interface
Uses
 ddUtils;

type
  TddProgressMode = (dd_pmSingle, dd_pmDual);


  TddSpeed = record
    Value   : Integer;
    ValueHi : Integer;
    ValueLo : Integer;
    SizeType: TddSizeType;
    TimeType: TddTimeType;
  end;

const
 ddNullSpeed : TddSpeed =
   (Value:0; ValueHi:0; ValueLo:0; SizeType: dd_stSimple; TimeType: dd_ttSec);

implementation

end.
 