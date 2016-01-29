unit BannerUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/BannerUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Banner
//
// �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	, ExternalObjectUnit
	;

type

IBanner = interface;
{ - ��������������� �������� IBanner. }



// ������
IBanner = interface (IInterface) ['{B869F2FF-7971-44F1-BAA5-F664C978EF7F}']
	function DontUseMe: Pointer;
	// ��������
	procedure GetPicture (
		out aRet {: IExternalObject}
	); stdcall;

	// ������� ������ ������� (���������� ��� IDocument ��� ExternalLink)
	procedure OpenLink (
		out aRet {: IUnknown}
	); stdcall; // can raise ECanNotFindData
end;

implementation
end.