unit arInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editor"
// Модуль: "w:/archi/source/projects/Archi/Editor/arInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> archi::Editor::arInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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