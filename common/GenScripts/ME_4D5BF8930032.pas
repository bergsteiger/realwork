unit l3ProtoObjectComparable;

// ������: "w:\common\components\rtl\Garant\L3\l3ProtoObjectComparable.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3ProtoObjectComparable = class(Tl3ProtoObject)
  public
   function CompareWith(anOther: Tl3ProtoObjectComparable): Integer; virtual; abstract;
 end;//Tl3ProtoObjectComparable

implementation

uses
 l3ImplUses
;

end.
