unit arInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Editor"
// ������: "w:/archi/source/projects/Archi/Editor/arInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> archi::Editor::arInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  l3Interfaces
  ;

type
 IInfoOut = interface(IUnknown)
   ['{6F7B46BD-A994-43D8-B879-BACC11B55687}']
   procedure AddString(const aStr: AnsiString;
    aFormat: Tl3ClipboardFormat = cf_Text);
   procedure StartData;
   procedure EndData;
 end;//IInfoOut

 TarFillDocInfo = procedure (const lInfoOut: IInfoOut) of object;
{$IfEnd} //AppClientSide

implementation

end.