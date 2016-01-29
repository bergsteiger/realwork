unit m4DictTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m4"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/m4/m4DictTypes.pas"
// �����: 18.09.2009 17:40
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::m4::Dict::m4DictTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m4\m4Define.inc}

interface

type
 Tm4DictItemID = System.Integer;
  {* ������������� �������� ������� }

 Tm4WordID = System.Integer;
  {* ����� � ������ }

 Tm4DictItemAddr = record
   rID : Tm4DictItemID;
   rDictionaryID : Integer;
 end;//Tm4DictItemAddr

function Tm4DictItemAddr_C(anID: Tm4DictItemID;
    aDictionaryID: Integer): Tm4DictItemAddr;

implementation

function Tm4DictItemAddr_C(anID: Tm4DictItemID;
       aDictionaryID: Integer): Tm4DictItemAddr;
//#UC START# *4ABA24E701F2_4ABA246700B4_var*
//#UC END# *4ABA24E701F2_4ABA246700B4_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4ABA24E701F2_4ABA246700B4_impl*
 Result.rID := anID;
 Result.rDictionaryID := aDictionaryID;
//#UC END# *4ABA24E701F2_4ABA246700B4_impl*
end;//Tm4DictItemAddr.C

end.