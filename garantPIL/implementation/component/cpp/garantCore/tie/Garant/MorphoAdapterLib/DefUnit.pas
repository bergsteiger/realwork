unit DefUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "MorphoAdapterLib"
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/tie/Garant/MorphoAdapterLib/DefUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::MorphoAdapterLib::Def
//
// ���������� � ���� �����-��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

type
 IMorphoAdapter = interface(IUnknown)
  {* ������� ��� �����-���������� }
   ['{2261F9E6-0615-4910-8D58-098D1EA2CE2C}']
   function Normalize(aWord: PChar;
    var aOut: PChar): size; stdcall;
     {* ������������ }
 end;//IMorphoAdapter

 IMlmaRu = interface(IUnknown)
  {* API ���������� mlma }
   ['{A835EF81-9A98-422C-9454-C4F9C14848F5}']
   function Lemmatize(aWord: PChar;
    aOptions: unsigned short;
    var aLemm: PChar;
    var aLIDs: pointer;
    var aGram: PChar;
    aNlemm: unsigned short;
    aNLID: unsigned short;
    aNgram: unsigned short): short; stdcall;
     {* mlmaruLemmatize }
   function BuildForm(aWord: PChar;
    aId: Cardinal;
    aOptions: unsigned short;
    aForm: Byte;
    var aRes: PChar;
    aLen: unsigned short): short; stdcall;
     {* mlmaruBuildForm }
   function CheckWord(aWord: PChar;
    aOptions: unsigned short): short; stdcall;
     {* mlmaruCheckWord }
   function BuildFormGi(aWord: PChar;
    aLexId: Cardinal;
    aOptions: unsigned short;
    aGrInfo: unsigned short;
    aFlags: Byte;
    var aDest: PChar;
    aCcDest: unsigned short): short; stdcall;
     {* mlmaruBuildFormGI }
   function CheckHelp(aWord: PChar;
    var aList: PChar): short; stdcall;
     {* mlmaruCheckHelp }
 end;//IMlmaRu

 IMorphoManager = interface(IUnknown)
  {* ��������� ��� �������������/��������������� ���������� }
   ['{4B31F9B1-ECFE-4C7F-B82A-0F93D4C488BE}']
   procedure Init(aBasePath: PChar); stdcall;
     {* ������������� }
   procedure Done; stdcall;
     {* ��������������� }
 end;//IMorphoManager

implementation

end.