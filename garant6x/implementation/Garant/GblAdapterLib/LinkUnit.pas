unit LinkUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/LinkUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Link
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	DocumentUnit
	;

type

ILinkManager = interface;
{ - ��������������� �������� ILinkManager. }



ILinkManager = interface (IInterface) ['{11E9EBA2-1C78-4469-8558-DB60FFA740C8}']
	function DontUseMe: Pointer;
	procedure GetLinkInfo (
		aDocId: Longword;
		const aId: TTopic;
		aRid: TRedactionID;
		out a: TLinkInfo
	); stdcall; // can raise EInvalidTopicId, EInvalidObjectClass

	// �������� ��������� �������, �� ������� ��������� �������������� ������, �� �����������
	// ��������������. ������������ ��������� �� ������ (obj) � ��� ������� (obj_type). �������������
	// ����� �������� ��������� (missing_info) � �����������, � ����� ������ (�����) ����������
	// ������������� ������ (����� get_missing_info) ����� �������������� ��� �������� ��
	// �������������� ������.
	procedure GetLinkedObject (
		aDocId: Longword;
		const aId: TTopic;
		aRid: TRedactionID;
		out aObjType: TLinkedObjectType;
		out aObj {: IUnknown}
	); stdcall; // can raise EInvalidTopicId, EInvalidObjectClass
end;

implementation
end.