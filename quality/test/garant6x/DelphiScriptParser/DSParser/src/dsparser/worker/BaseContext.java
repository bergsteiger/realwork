package dsparser.worker;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.EnumSet;
import java.util.List;



//
public abstract class BaseContext {
	// ����� ��������� ��������� ���� ��������������
	public enum IdType {
		CONST, VAR, METHOD, UNIT
	}
	
	// ��� ���������
	public enum MsgType {
		ERROR, WARNING, INFO
	}
	
	// ������ ��� ������ ���������, ����� �� �������� � ����� ���� ����
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

	// ������� �������� ��� ��������
	protected final SymTable consts;
	// ������� �������� ��� ����������
	protected final SymTable vars;
	
	// ��������� �� ����������� ������� ������������ ������������� ���������������
	protected final List<MsgData> analysis_messages; 
	
	// ���������������� ��������������, ��������� �������� ������ � �����
	private final static SymTable predefined_consts = new PredefinedSymTable("predefined_consts");
	private final static SymTable predefined_methods = new PredefinedSymTable("predefined_methods");
	
	// ��� ��������� (��� �������� ���������)
	protected final String context_name; 
	
	protected BaseContext(String name)
	{
		this.consts = new SymTable();
		this.vars = new SymTable();
		this.analysis_messages = new ArrayList<MsgData>();
		this.context_name = name;		
	}
	
	// ��������� ��������� ��� ����������� �������������
	private void StoreMessage(MsgType msgType, String text, Symbol symbol)
	{
		analysis_messages.add(new MsgData(msgType, text, symbol));
	}
	
	// ��������� �� ������ � ������������� ��������������
	protected void Error(String text, Symbol symbol)
	{	
		StoreMessage(MsgType.ERROR, text, symbol);
	}
	
	// ���������� � ������������� ��������������
	protected void Warning(String text, Symbol symbol)
	{	
		StoreMessage(MsgType.WARNING, text, symbol);
	}
	
	// ������ ������ ���������� � ���������� ������� ������������ ������������� ��������������
	protected List<MsgData> GetAnalysisMsgData()
	{
		return analysis_messages;
	}
	
	// ������������ ���������� ������ ������ � ���������� � ������� ������
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
	
	// ������ ������ ����� � ����������� � ���������� ����������� � ������������� ���������������
	public List<String> GetAnalysisMessages()
	{
		List<MsgData> msg_data = GetAnalysisMsgData();
		Collections.sort(msg_data);		
		return MsgDataToStrings( GetAnalysisMsgData() );		
	}
	
	// ������ ������ ����� � ����������� � ������������� ���������������
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
			
	// ���������� ������ �� ������� ��������� ��� null, ���� �� ������.
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
	
	// ������� ��������� ������ ��������� ����. 
	protected  abstract Symbol GetAvailableSymbol(
			String name,
			EnumSet<IdType> id_type);
	
	// ������� �������� �� ������ ������ � ������ ������� ��� �������������
	// �.�. ��� ������ ����, � ��� �� ���� ������ ��� �� ��� ���������� ������������.
	// ���� ������ � ������ ���������.
	protected boolean IsLocalIdAvailable(
			String name,
			Integer line,
			Integer pos,
			EnumSet<IdType> id_type)
	{			
		Symbol symbol = GetLocalSymbol(name, id_type);
		return (symbol != null) && ((symbol.line < line) || ((symbol.line == line) && (symbol.pos < pos)));
	}
	
	// ���������, �������� �� ��� ����� �������������. � ���� ��, �� ����� �������������� ��� ���� ����� ��������
	// �������� �� ������������� �������� ��-�� ���������� �������� ��� ������� (� �� �� ���������� �� �� ��������)
	protected void CheckIfAnyDeclared(String name, Integer line, Integer pos)
	{
		if (IsLocalIdAvailable(name, line, pos, EnumSet.of(IdType.CONST, IdType.VAR, IdType.METHOD)) )
		{
			Warning("���-�� ��� ��������� � ����� ������  ", new Symbol(name, line, pos));
		}
	}
		
	// ���������� �� ���������� ���������.
	public void ConstDeclared(String name, Integer line, Integer pos)
	{
		if (GetLocalSymbol(name, EnumSet.of(IdType.CONST)) != null)
		{
			Error("��������� ��� ���������", new Symbol(name, line, pos));
			return;
		}
		else CheckIfAnyDeclared(name, line, pos);	
		//
		consts.Add(name, line, pos);
	}
	
	// ���������� �� ���������� ����������.
	public void VarDeclared(String name, Integer line, Integer pos)
	{
		if (GetLocalSymbol(name, EnumSet.of(IdType.VAR)) != null)
		{
			Error("���������� ��� ���������", new Symbol(name, line, pos));
			return;
		}
		else CheckIfAnyDeclared(name, line, pos);	
		//
		vars.Add(name, line, pos);
	}
	
	// ���������� �� �������������� ��������������.
	// ��������� ��� ����� ��������� ��������.
	public void IdUsed(
			String name,
			Integer line,
			Integer pos,
			EnumSet<IdType> id_type)
	{		
		// ������� ���� ������ � ��������� ���������
		Symbol symbol = GetLocalSymbol(name, id_type);
		if (symbol != null)
		{
			// ���� ����� �� ��������� ��� �� �������� ������ ��� ������������
			if (! ((symbol.line < line) || ((symbol.line == line) && (symbol.pos < pos))))
				symbol = null;
		} else {
			// ���� �� ����� � ���������, �� ���� ������
			symbol = GetAvailableSymbol(name, id_type);						
		}
		//
		if (symbol != null)
			symbol.uses_count++;
		else	{			
			Error("����������� �������������", new Symbol(name, line, pos) );
		}
	}
	
	protected List<MsgData> GetMsgDataForSymTable(SymTable st, String id_type_name, int use_threshold)
	{		
		List<MsgData> result = new ArrayList<MsgData>();
		for (Symbol s : st.GetUsedSymbols(use_threshold))
			if (s.uses_count == 0)
				result.add(new MsgData(MsgType.WARNING, String.format("%s �� ������������", id_type_name), s));
			else
				result.add(new MsgData(MsgType.INFO, String.format("%s ������������ %d ���", id_type_name, s.uses_count), s));
		return result;
	}
	
	// ��������� � ���������� ������ ��� ��������� � �������������� ���������������
	protected List<MsgData> GetUsedSymbolsMsgData(int use_threshold)
	{		
		List<MsgData> result = new ArrayList<MsgData>();
		result.addAll( GetMsgDataForSymTable(consts, "���������", use_threshold) );
		result.addAll( GetMsgDataForSymTable(vars, "����������", use_threshold) );
		return result;
	}
	
}
