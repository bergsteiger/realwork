unit NOT_FINISHED_jclDebug;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "JEDI"
// ������: "w:/common/components/rtl/external/JEDI/source/windows/NOT_FINISHED_jclDebug.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::JEDI::Windows::jclDebug
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

interface

{$If not defined(notDebugStackTrace)}
type
 TJclStackInfoList = class
 end;//TJclStackInfoList
procedure JclLastExceptStackList;
   {* ��������� ������ JclLastExceptStackList }
{$IfEnd} //not notDebugStackTrace

implementation

{$If not defined(notDebugStackTrace)}
// unit methods

procedure JclLastExceptStackList;
//#UC START# *4B72BEEB00CA_4B72BED1017B_var*
//#UC END# *4B72BEEB00CA_4B72BED1017B_var*
begin
//#UC START# *4B72BEEB00CA_4B72BED1017B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B72BEEB00CA_4B72BED1017B_impl*
end;//JclLastExceptStackList
{$IfEnd} //not notDebugStackTrace
end.