unit arInterfaces;

// Модуль: "w:\archi\source\projects\Archi\Editor\arInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , l3Interfaces
;

type
 IInfoOut = interface
  ['{6F7B46BD-A994-43D8-B879-BACC11B55687}']
  procedure AddString(const aStr: AnsiString;
   aFormat: Tl3ClipboardFormat = cf_Text);
  procedure StartData;
  procedure EndData;
 end;//IInfoOut

 TarFillDocInfo = procedure(const lInfoOut: IInfoOut) of object;
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppClientSide)

end.
