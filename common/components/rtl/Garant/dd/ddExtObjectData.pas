unit ddExtObjectData;
 {* ������ �������� ���������� �� Im3DB, ����� TddExtObjInserter }

// ������: "w:\common\components\rtl\Garant\dd\ddExtObjectData.pas"
// ���������: "SimpleClass"
// ������� ������: "TddExtObjectData" MUID: (5798CC75000A)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , k2SizedMemoryPool
 , l3Memory
;

type
 TddExtObjectData = class(Tk2RawData)
  {* ������ �������� ���������� �� Im3DB, ����� TddExtObjInserter }
  protected
   function GetMemoryStreamClass: Rl3MemoryStream; override;
 end;//TddExtObjectData

implementation

uses
 l3ImplUses
 , ddExtObjectDataStream
;

function TddExtObjectData.GetMemoryStreamClass: Rl3MemoryStream;
//#UC START# *530B3F560201_5798CC75000A_var*
//#UC END# *530B3F560201_5798CC75000A_var*
begin
//#UC START# *530B3F560201_5798CC75000A_impl*
 Result := TddExtObjectDataStream;
//#UC END# *530B3F560201_5798CC75000A_impl*
end;//TddExtObjectData.GetMemoryStreamClass

end.
