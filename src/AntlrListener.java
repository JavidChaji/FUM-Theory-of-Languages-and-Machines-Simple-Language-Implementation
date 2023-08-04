// Generated from D:/University/Computer/Term 4/Languages and Automata/Project/Antlr/src\Antlr.g4 by ANTLR 4.8
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link AntlrParser}.
 */
public interface AntlrListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link AntlrParser#start}.
	 * @param ctx the parse tree
	 */
	void enterStart(AntlrParser.StartContext ctx);
	/**
	 * Exit a parse tree produced by {@link AntlrParser#start}.
	 * @param ctx the parse tree
	 */
	void exitStart(AntlrParser.StartContext ctx);
}