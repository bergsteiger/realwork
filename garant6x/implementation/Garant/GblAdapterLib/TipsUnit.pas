unit TipsUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/TipsUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Tips
//
// ����� ���
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	, DynamicTreeUnit
	;

type

ITipsManager = interface;
{ - ��������������� �������� ITipsManager. }



// �������� ������� ���
ITipsManager = interface (IInterface) ['{E7AFD5DA-77C8-4E4E-95C3-D54CBB8CD5D7}']
	function DontUseMe: Pointer;
	// �������� ������� (�� ��������) ����� ���
	procedure GetCurrentTip (
		out aRet {: INodeIndexPath}
	); stdcall;

	function IsExist (): Bytebool; stdcall;

	// ��� ������ ����� ���
	procedure GetTipsTreeRoot (out aRet {: INodeBase}); stdcall;
end;

implementation
end.