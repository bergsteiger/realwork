unit ddParticipantsConst;

interface

uses
 dt_Types;

const
 cParticipants : Array[TlcParticipantType] of String =
       ('Истец', 'Ответчик', 'Третье лицо', 'Заинтересованные лица', 'Кредитор',
        'Должник', 'Иной уполн. орган', 'Арбитражный управляющий', 'Заявитель',
         'Судебный пристав-исполнитель', 'Прокуратура');

implementation

end.
