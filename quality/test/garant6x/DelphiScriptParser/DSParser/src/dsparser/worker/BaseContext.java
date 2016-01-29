package dsparser.worker;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.EnumSet;
import java.util.List;



//
public abstract class BaseContext {
	// будем различать следующие типы идентифкаторов
	public enum IdType {
		CONST, VAR, METHOD, UNIT
	}
	
	// Тип сообщения
	public enum MsgType {
		ERROR, WARNING, INFO
	}
	
	// Данные для вывода сообщений, чтобы их выводить в конце куда надо
	protected class MsgData implements Comparable<MsgData> {
		public final String text;
		public final String context_name; 
		public final Symbol symbol;
		public final MsgType msgType;
		
		protected MsgData(MsgType msgType, String text, Symbol symbol) 
		{
			this.msgType = msgType;
			this.text = text;
			this.symbol = symbol;
			this.context_name = BaseContext.this.context_name;
		}

		@Override
		public int compareTo(MsgData o) {
			if (symbol.line == o.symbol.line)
				return symbol.pos - o.symbol.pos;
			else
				return symbol.line - o.symbol.line;
		}
	}

	// Таблица символов для констант
	protected final SymTable consts;
	// Таблица символов для переменных
	protected final SymTable vars;
	
	// Сообщения по результатам анализа корректности использования идентификаторов
	protected final List<MsgData> analysis_messages; 
	
	// Предопределенные идентификаторы, доступные скриптам всегда и везде
	private final static SymTable predefined_consts = new PredefinedSymTable("predefined_consts");
	private final static SymTable predefined_methods = new PredefinedSymTable("predefined_methods");
	
	// Имя контекста (для привязки сообщений)
	protected final String context_name; 
	
	protected BaseContext(String name)
	{
		this.consts = new SymTable();
		this.vars = new SymTable();
		this.analysis_messages = new ArrayList<MsgData>();
		this.context_name = name;		
	}
	
	// Сохраняет сообщение для дальнейшего использования
	private void StoreMessage(MsgType msgType, String text, Symbol symbol)
	{
		analysis_messages.add(new MsgData(msgType, text, symbol));
	}
	
	// Сообщение об ошибке в использовании идентификатора
	protected void Error(String text, Symbol symbol)
	{	
		StoreMessage(MsgType.ERROR, text, symbol);
	}
	
	// Странности в использовании идентификатора
	protected void Warning(String text, Symbol symbol)
	{	
		StoreMessage(MsgType.WARNING, text, symbol);
	}
	
	// Отдает список информации о сообщениях анализа корректности использования идентфикаторов
	protected List<MsgData> GetAnalysisMsgData()
	{
		return analysis_messages;
	}
	
	// Конвертирует внутренний список данных о сообщениях в готовые строки
	private static List<String> MsgDataToStrings(List<MsgData> messages)
	{
		List<String> result = new ArrayList<String>();
		for (MsgData m : messages)
			result.add(String.format(
					"%s : %s : %d:%d : %s: %s",
					m.msgType.name(), m.context_name, m.symbol.line, m.symbol.pos, m.text, m.symbol.name
				));
		return result;			
	}
	
	// Отдает список строк с сообщениями о замеченных недостатках в использовании идентификаторов
	public List<String> GetAnalysisMessages()
	{
		List<MsgData> msg_data = GetAnalysisMsgData();
		Collections.sort(msg_data);		
		return MsgDataToStrings( GetAnalysisMsgData() );		
	}
	
	// Отдает список строк с сообщениями о использовнных идентификаторах
	public List<String> GetUsedSymbolsMessages(int use_threshold)
	{
		final class UseSymMsgComp implements Comparator<MsgData>
		{
			@Override
			public int compare(MsgData left, MsgData right) {
				if (left.symbol.uses_count == right.symbol.uses_count)
					return left.compareTo(right);
				else
					return left.symbol.uses_count - right.symbol.uses_count;
			}
		}
		List<MsgData> msg_data = GetUsedSymbolsMsgData(use_threshold);
		Collections.sort(msg_data, new UseSymMsgComp());
		return MsgDataToStrings(msg_data);		
	}
			
	// Возвращает символ из данного контекста или null, если не найден.
	protected Symbol GetLocalSymbol(
			String name,
			EnumSet<IdType> id_type)
	{		
		if (id_type.contains(IdType.CONST) && consts.IsExists(name))
			return consts.Get(name);
		else if (id_type.contains(IdType.VAR) && vars.IsExists(name))
			return vars.Get(name);
		else if (id_type.contains(IdType.CONST) && predefined_consts.IsExists(name))
			return predefined_consts.Get(name);
		else if (id_type.contains(IdType.METHOD) && predefined_methods.IsExists(name))
			return predefined_methods.Get(name);
		else	 
			return null;
	}
	
	// Вернуть доступный символ заданного типа. 
	protected  abstract Symbol GetAvailableSymbol(
			String name,
			EnumSet<IdType> id_type);
	
	// Говорит доступен ли данный символ в данной позиции для использования
	// т.е. что символ есть, и что он есть раньше чем мы его попытаемся использовать.
	// Ищет только в данном контексте.
	protected boolean IsLocalIdAvailable(
			String name,
			Integer line,
			Integer pos,
			EnumSet<IdType> id_type)
	{			
		Symbol symbol = GetLocalSymbol(name, id_type);
		return (symbol != null) && ((symbol.line < line) || ((symbol.line == line) && (symbol.pos < pos)));
	}
	
	// Проверяет, объявлен ли уже такой идентификатор. И если да, то пишет предупреждение для того чтобы обращали
	// внимание на потенциальные проблемы из-за перегрузки констант или методов (а то по сигнатурам то не отличает)
	protected void CheckIfAnyDeclared(String name, Integer line, Integer pos)
	{
		if (IsLocalIdAvailable(name, line, pos, EnumSet.of(IdType.CONST, IdType.VAR, IdType.METHOD)) )
		{
			Warning("что-то уже объявлено с таким именем  ", new Symbol(name, line, pos));
		}
	}
		
	// Вызывается на объявлении константы.
	public void ConstDeclared(String name, Integer line, Integer pos)
	{
		if (GetLocalSymbol(name, EnumSet.of(IdType.CONST)) != null)
		{
			Error("константа уже объявлена", new Symbol(name, line, pos));
			return;
		}
		else CheckIfAnyDeclared(name, line, pos);	
		//
		consts.Add(name, line, pos);
	}
	
	// Вызывается на объявлении переменной.
	public void VarDeclared(String name, Integer line, Integer pos)
	{
		if (GetLocalSymbol(name, EnumSet.of(IdType.VAR)) != null)
		{
			Error("переменная уже объявлена", new Symbol(name, line, pos));
			return;
		}
		else CheckIfAnyDeclared(name, line, pos);	
		//
		vars.Add(name, line, pos);
	}
	
	// Вызывается на использолвании идентификатора.
	// Проверяет что такое обращение допутимо.
	public void IdUsed(
			String name,
			Integer line,
			Integer pos,
			EnumSet<IdType> id_type)
	{		
		// сначала ищем символ в локальном контексте
		Symbol symbol = GetLocalSymbol(name, id_type);
		if (symbol != null)
		{
			// если нашли то проверяем что он объявлен раньше чем используется
			if (! ((symbol.line < line) || ((symbol.line == line) && (symbol.pos < pos))))
				symbol = null;
		} else {
			// если не нашли в локальном, то ищем вообще
			symbol = GetAvailableSymbol(name, id_type);						
		}
		//
		if (symbol != null)
			symbol.uses_count++;
		else	{			
			Error("неизвестный идентификатор", new Symbol(name, line, pos) );
		}
	}
	
	protected List<MsgData> GetMsgDataForSymTable(SymTable st, String id_type_name, int use_threshold)
	{		
		List<MsgData> result = new ArrayList<MsgData>();
		for (Symbol s : st.GetUsedSymbols(use_threshold))
			if (s.uses_count == 0)
				result.add(new MsgData(MsgType.WARNING, String.format("%s не используется", id_type_name), s));
			else
				result.add(new MsgData(MsgType.INFO, String.format("%s используется %d раз", id_type_name, s.uses_count), s));
		return result;
	}
	
	// Формирует и возвращает данные для сообщений о использованных идентификаторах
	protected List<MsgData> GetUsedSymbolsMsgData(int use_threshold)
	{		
		List<MsgData> result = new ArrayList<MsgData>();
		result.addAll( GetMsgDataForSymTable(consts, "константа", use_threshold) );
		result.addAll( GetMsgDataForSymTable(vars, "переменная", use_threshold) );
		return result;
	}
	
}
