package dsparser.worker;

// это будет отдельный идентификатор (константа, переменна€, метод)
public class Symbol {
	public String name;		// им€, как оно представлено в исходном коде
	public Integer line;	// строка в которой объ€влен идентификатор
	public Integer pos;		// позици€, в которой объ€влен идентификатор
	public Integer uses_count = 0; // сколько раз его в коде использовали
	
	public Symbol(
			String name,
			Integer line,
			Integer pos)
	{
			this.line = line;
			this.name = name;
			this.pos = pos;
	}
}
