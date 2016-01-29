unit vcmWritersInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmWritersInterfaces.pas"
// Начат: 19.02.2009 16:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmWritersInterfaces
//
// Интерфейсы писателей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  vcmUserControls
  ;

type
 IvcmXMLWriter = interface(Il3XMLWriter)
   ['{CBFEDC57-720D-40AD-A4F7-F5B8014CDD36}']
   procedure SaveUF(const aString: AnsiString;
    const anUF: IvcmUserFriendlyControl;
    aNeedClose: Boolean = true); overload; 
     {* сохраняет объект в поток }
   procedure SaveUF(const aString: AnsiString;
    const anUF: IvcmUserFriendlyControl;
    const aSuffix: AnsiString;
    aNeedClose: Boolean = true); overload; 
     {* сохраняет объект в поток }
 end;//IvcmXMLWriter

 IvcmContentWriter = interface(IvcmXMLWriter)
   ['{B3B7A382-6741-405C-B3B1-E17342070E45}']
 end;//IvcmContentWriter
{$IfEnd} //not NoVCM

implementation

end.