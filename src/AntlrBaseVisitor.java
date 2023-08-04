// Generated from D:/University/Computer/Term 4/Languages and Automata/Project/Antlr/src\Antlr.g4 by ANTLR 4.8
import org.antlr.v4.runtime.tree.AbstractParseTreeVisitor;

/**
 * This class provides an empty implementation of {@link AntlrVisitor},
 * which can be extended to create a visitor which only needs to handle a subset
 * of the available methods.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public class AntlrBaseVisitor<T> extends AbstractParseTreeVisitor<T> implements AntlrVisitor<T> {
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation returns the result of calling
	 * {@link #visitChildren} on {@code ctx}.</p>
	 */
	@Override public T visitStart(AntlrParser.StartContext ctx) { return visitChildren(ctx); }
}