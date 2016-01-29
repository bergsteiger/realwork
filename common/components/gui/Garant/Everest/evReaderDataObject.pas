unit evReaderDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В
// Модуль: "w:/common/components/gui/Garant/Everest/evReaderDataObject.pas"
// Начат: 07.10.2008 17:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevReaderDataObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  nevTools,
  k2CustomFileReader,
  evStreamedDataObject,
  nevBase,
  evdInterfaces
  ;

type
 Rk2CustomReader = class of k2CustomFileReader.Tk2CustomFileReader;

 TevReaderDataObject = class(TevStreamedDataObject)
 protected
 // realized methods
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
     {* сохраняет поток в G }
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected fields
   f_Stream : IStream;
 protected
 // protected methods
   function ReaderClass: Rk2CustomReader; virtual; abstract;
 public
 // public methods
   constructor Create(const aStream: IStream); reintroduce;
   class function Make(const aStream: IStream): InevStorable; reintroduce;
     {* Сигнатура фабрики TevReaderDataObject.Make }
 end;//TevReaderDataObject

implementation

uses
  l3Base,
  l3SysUtils,
  l3Types
  ;

// start class TevReaderDataObject

constructor TevReaderDataObject.Create(const aStream: IStream);
//#UC START# *4D3EDD5301AA_48EB6945012D_var*
//#UC END# *4D3EDD5301AA_48EB6945012D_var*
begin
//#UC START# *4D3EDD5301AA_48EB6945012D_impl*
 inherited Create;
 f_Stream := aStream;
//#UC END# *4D3EDD5301AA_48EB6945012D_impl*
end;//TevReaderDataObject.Create

class function TevReaderDataObject.Make(const aStream: IStream): InevStorable;
var
 l_Inst : TevReaderDataObject;
begin
 l_Inst := Create(aStream);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TevReaderDataObject.DoStore(const G: InevTagGenerator;
  aFlags: TevdStoreFlags);
//#UC START# *48EA34990191_48EB6945012D_var*
var
 l_Reader : Tk2CustomFileReader;
 l_Tmp: Int64;
//#UC END# *48EA34990191_48EB6945012D_var*
begin
//#UC START# *48EA34990191_48EB6945012D_impl*
 l_Reader := ReaderClass.Create;
 try
  // Необходимо перемотать на начало ДО Execute, т.к. в противном случае возможно
  // некорректное распознание типа документа
  {OleCheck}(f_Stream.Seek(0, STREAM_SEEK_SET, l_Tmp));
  // ^ Убрано, т.к. - http://mdp.garant.ru/pages/viewpage.action?pageId=121143451&focusedCommentId=121144068#comment-121144068
  l_Reader.Filer.COMStream := f_Stream;
  try
   l_Reader.Generator := G;
   l_Reader.Execute;
  finally
   l_Reader.Filer.COMStream := nil;
  end;//try..finally
 finally
  l3Free(l_Reader);
 end;//try..finally
//#UC END# *48EA34990191_48EB6945012D_impl*
end;//TevReaderDataObject.DoStore

procedure TevReaderDataObject.ClearFields;
 {-}
begin
 f_Stream := nil;
 inherited;
end;//TevReaderDataObject.ClearFields

end.