unit DefUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "MorphoAdapterLib"
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/DefUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::MorphoAdapterLib::Def
//
// ���������� � ���� �����-��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface



type

IMorphoAdapter = interface;
{ - ��������������� �������� IMorphoAdapter. }

IMlmaRu = interface;
{ - ��������������� �������� IMlmaRu. }

IMorphoManager = interface;
{ - ��������������� �������� IMorphoManager. }



// ������� ��� �����-����������
IMorphoAdapter = interface (IInterface) ['{2261F9E6-0615-4910-8D58-098D1EA2CE2C}']
	function DontUseMe: Pointer;
	// ������������
	function Normalize (
		const aWord: PAnsiChar;
		var aOut: PAnsiChar
	): Cardinal; stdcall;
end;

// API ���������� mlma
IMlmaRu = interface (IInterface) ['{A835EF81-9A98-422C-9454-C4F9C14848F5}']
	function DontUseMe: Pointer;
	// mlmaruBuildForm
	function BuildForm (
		const aWord: PAnsiChar;
		aId: Longword;
		aOptions: Word;
		aForm: AnsiChar;
		var aRes: PAnsiChar;
		aLen: Word
	): Smallint; stdcall;

	// mlmaruBuildFormGI
	function BuildFormGi (
		const aWord: PAnsiChar;
		aLexId: Longword;
		aOptions: Word;
		aGrInfo: Word;
		aFlags: AnsiChar;
		var aDest: PAnsiChar;
		aCcDest: Word
	): Smallint; stdcall;

	// mlmaruCheckHelp
	function CheckHelp (
		const aWord: PAnsiChar;
		var aList: PAnsiChar
	): Smallint; stdcall;

	// mlmaruCheckWord
	function CheckWord (
		const aWord: PAnsiChar;
		aOptions: Word
	): Smallint; stdcall;

	// mlmaruLemmatize
	function Lemmatize (
		const aWord: PAnsiChar;
		aOptions: Word;
		var aLemm: PAnsiChar;
		var aLIDs: Pointer;
		var aGram: PAnsiChar;
		aNlemm: Word;
		aNLID: Word;
		aNgram: Word
	): Smallint; stdcall;
end;

// ��������� ��� �������������/��������������� ����������
IMorphoManager = interface (IInterface) ['{4B31F9B1-ECFE-4C7F-B82A-0F93D4C488BE}']
	function DontUseMe: Pointer;
	// ���������������
	procedure Done (); stdcall;

	// �������������
	procedure Init (
		const aBasePath: PAnsiChar
	); stdcall;
end;

implementation
end.