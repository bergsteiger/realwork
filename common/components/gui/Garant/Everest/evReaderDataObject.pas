unit evReaderDataObject;

// Модуль: "w:\common\components\gui\Garant\Everest\evReaderDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevReaderDataObject" MUID: (48EB6945012D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evStreamedDataObject
 , l3Interfaces
 , nevTools
 , nevBase
 , evdInterfaces
 , k2CustomFileReader
;

type
 Rk2CustomReader = class of Tk2CustomFileReader;

 TevReaderDataObject = class(TevStreamedDataObject)
  protected
   f_Stream: IStream;
  protected
   function ReaderClass: Rk2CustomReader; virtual; abstract;
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
    {* сохраняет поток в G }
   procedure ClearFields; override;
  public
   constructor Create(const aStream: IStream); reintroduce;
   class function Make(const aStream: IStream): InevStorable; reintroduce;
 end;//TevReaderDataObject

implementation

uses
 l3ImplUses
 , l3Base
 , l3SysUtils
 , l3Types
 //#UC START# *48EB6945012Dimpl_uses*
 //#UC END# *48EB6945012Dimpl_uses*
;

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
end;//TevReaderDataObject.Make

procedure TevReaderDataObject.DoStore(const G: InevTagGenerator;
 aFlags: TevdStoreFlags);
 {* сохраняет поток в G }
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
begin
 f_Stream := nil;
 inherited;
end;//TevReaderDataObject.ClearFields

end.
