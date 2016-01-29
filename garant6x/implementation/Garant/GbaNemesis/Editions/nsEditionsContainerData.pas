unit nsEditionsContainerData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/nsEditionsContainerData.pas"
// Начат: 22.10.2009 15:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::CommonObjects::TnsEditionsContainerData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  l3ProtoObject,
  EditionsInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _MnsDocument_Parent_ = Tl3ProtoObject;
 {$Include ..\Editions\MnsDocument.imp.pas}
 TnsEditionsContainerData = class(_MnsDocument_, InsEditionsContainerData)
 public
 // public methods
   constructor Create(const aDoc: IDocument;
     const aDocumentForReturn: TnsDocumentForReturnInfo); reintroduce;
   class function Make(const aDoc: IDocument;
     const aDocumentForReturn: TnsDocumentForReturnInfo): InsEditionsContainerData; reintroduce;
     {* Сигнатура фабрики TnsEditionsContainerData.Make }
 end;//TnsEditionsContainerData
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include ..\Editions\MnsDocument.imp.pas}

// start class TnsEditionsContainerData

constructor TnsEditionsContainerData.Create(const aDoc: IDocument;
  const aDocumentForReturn: TnsDocumentForReturnInfo);
//#UC START# *4AE03BD6033A_4AE03B550243_var*
//#UC END# *4AE03BD6033A_4AE03B550243_var*
begin
//#UC START# *4AE03BD6033A_4AE03B550243_impl*
 inherited Create;
 Init(aDoc, aDocumentForReturn);
//#UC END# *4AE03BD6033A_4AE03B550243_impl*
end;//TnsEditionsContainerData.Create

class function TnsEditionsContainerData.Make(const aDoc: IDocument;
  const aDocumentForReturn: TnsDocumentForReturnInfo): InsEditionsContainerData;
var
 l_Inst : TnsEditionsContainerData;
begin
 l_Inst := Create(aDoc, aDocumentForReturn);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

{$IfEnd} //not Admin AND not Monitorings

end.