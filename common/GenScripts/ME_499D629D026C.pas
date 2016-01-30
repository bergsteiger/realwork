unit vcmWritersInterfaces;
 {* Интерфейсы писателей }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmWritersInterfaces.pas"
// Стереотип: "Interfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3Interfaces
 , vcmUserControls
;

type
 IvcmXMLWriter = interface(Il3XMLWriter)
  ['{CBFEDC57-720D-40AD-A4F7-F5B8014CDD36}']
  procedure SaveUF(const aString: AnsiString;
   const anUF: IvcmUserFriendlyControl;
   aNeedClose: Boolean = True); overload;
   {* сохраняет объект в поток }
  procedure SaveUF(const aString: AnsiString;
   const anUF: IvcmUserFriendlyControl;
   const aSuffix: AnsiString;
   aNeedClose: Boolean = True); overload;
   {* сохраняет объект в поток }
 end;//IvcmXMLWriter

 IvcmContentWriter = interface(IvcmXMLWriter)
  ['{B3B7A382-6741-405C-B3B1-E17342070E45}']
 end;//IvcmContentWriter
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
